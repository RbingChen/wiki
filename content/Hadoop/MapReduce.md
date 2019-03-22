---
title : "MapReduce framework"
layout : page
date : 2019-03-20 17:36
---

[TOC]



# 一 Overview

Hadoop Mapreduce 是一个软件框架，能在大集群上，以并行地方式高可靠、高容错的读写数据以及对大数据进行处理。

MapReduce job通常把输入数据切分成多个块以保证能够被map task并行处理。framework对map的输出进行排序，然后输入到reduce task上。一般地，任务的输入输出数据都存储在文件系统上。框架着重关注任务调度、任务监管以及重启失败任务。

典型场景下，计算节点和存储节点是相同。这能保证MapReduce 框架和 HDFS在同一个节点集上运行，这样的配置允许框架有效地在数据节点上调度任务，保证集群有较高的可用带宽。

MapReduce框架由一个 `RM(ResourceManager)`、每一个集群节点包含的一个`slave NM(NodeManager)`、每个应用的`MRAPPMaste`r构成。

`Hadoop job client` 向RM提交job ( jar或者其他的可执行文件 ) 和配置信息，RM主要的功能有：分发配置信息及程序给slave节点、调度并监管任务、给job-client提供状态及诊断信息。



# 二 Mapper

mapper把输入的key/value对转换成中间key/value对( 可以有0或者多对)。依据Job的InputFormat将输入切分成单个的InputSplit，每一个InputSplit对应一个map任务。Job通过`Job.setMapperClass(class)`运行mapper任务，框架调用`map（WrittableComparableWritable,Context)`方法对InputSplit中的kv对进行处理。此外，可以重载`cleanup(Context)`方法做一些清除操作。

程序可以使用`Counter`来反馈统计信息。

在给点输出值的可key时，所有的中间kv对会做聚合操作（由框架触发），然后再传递给`Reducer`做处理得到最终输出。可以使用`Job. setGroupingComparatorCalass(Class)`获取自定义`Comparator`以控制聚合操作。

`Mapper`的输出讲被排序并切分给每一个`Reducer`，每一个分区对应一个reduce 任务。通过使用继承`Partitioner`接口可以实现自定义的分区方式来控制哪些keys值由哪一个`reducer`处理。

程序通过`Job.setCombinerClass(Class)`方法指定`Combiner` 以对中间输出做局部聚合操作，从而缩减传递到`Reducer`的数据量。排序后的输出会简单的存储为`(key-len,key,vlaue-len,value)`的格式，也可以通过配置使用`CompressionCodec`模块来压缩中间输出值。



## Mapper 的数量？

注意Mapper的启动需要时间，因此合适的Mapper数量应该保证处理数据的时间应该大于启动的时间。一般地，有多少个Block，则将会有多少个Map（10TB的数据，128MB的块大小，那么将会有82k个map）。也可以使用`Configuration.set(MPJobConfig.NUM_MAPS,int)`来配置。



# 三 Reducer

进一步缩减kv对数。可以通过`Job.setNumReduceTasks(int)`来设置reduce的数量。

使用方法`Job.setReducerClass(Class)`来指定`Reducer`的执行程序。Reducer可以分为shuffle、sort、redcue三个阶段。

## shuffle

框架通过HTTP协议，从Mapper输出的相关分区中取数据给Reducer。因此，输入给Reducer的是排序后的Mapper输出。

## Sort

框架对Reducer的输入做聚合有相同key的kv对操作，shuffle和sort同时执行，也就是取数据的时候也做合并操作。

## Secondary Sort

略

## Reduce

在这个阶段，调用 `reduce(WritableComparable,Iterable<Writable>,Context)`方法处理聚合后的输入对`<key,(list of values)>`。最后将输出直接存储到文件系统上，可以通过`FileOutputFormat.setOutputPath (Job,Path)`来设置存储路径，框架不会对reduce的输出做排序。

## Reducer个数？

0.95 或者 1.75 乘以 节点数或者每个节点最大container数。

增加reduce格式会带来格外的消耗，但是能够是提高负载均衡，降低失败任务带来的损失。

## Partitioner

切分key值空间，和Reducer一一对应。默认使用`HashPartitioner`。 这个地方是发生数据倾斜的本质原因，**部分key对应的value值过多**。



