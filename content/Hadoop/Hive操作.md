---
title : "Hive内部操作"
layout : page
date : 2019-04-16 16:44
---



# 一 Join

Hive中的Join可分为`Common Join`（Reduce阶段完成join）和`Map Join`（Map阶段完成join)

## 1.Common Join

```bash
如果不指定MapJoin或者不符合MapJoin的条件，那么Hive解析器会将Join操作转换成Common Join,即：在Reduce阶段完成join。整个过程包含Map、Shuffle、Reduce阶段。

#Map阶段
读取源表的数据，Map输出时候以Join on条件中的列为key，如果Join有多个关联键，则以这些关联键的组合作为key;
Map输出的value为join之后所关心的(select或者where中需要用到的)列；同时在value中还会包含表的Tag信息，用于标明此value对应哪个表；按照key进行排序

#Shuffle阶段
根据key的值进行hash,并将key/value按照hash值推送至不同的reduce中，这样确保两个表中相同的key位于同一个reduce中

#Reduce阶段
根据key的值完成join操作，期间通过Tag来识别不同表中的数据。
```



## 2.Map Join

```bash
1，什么是MapJoin?
MapJoin顾名思义，就是在Map阶段进行表之间的连接。而不需要进入到Reduce阶段才进行连接。这样就节省了在Shuffle阶段时要进行的大量数据传输。从而起到了优化作业的作用。

2，MapJoin的原理：
通常情况下，要连接的各个表里面的数据会分布在不同的Map中进行处理。即同一个Key对应的Value可能存在不同的Map中。这样就必须等到Reduce中去连接。
要使MapJoin能够顺利进行，那就必须满足这样的条件：除了一份表的数据分布在不同的Map中外，其他连接的表的数据必须在每个Map中有完整的拷贝。

3，MapJoin适用的场景：
通过上面分析你会发现，并不是所有的场景都适合用MapJoin. 它通常会用在如下的一些情景：在二个要连接的表中，有一个很大，有一个很小，这个小表可以存放在内存中而不影响性能。
把小表文件复制到每一个Map任务的本地，再让Map把文件读到内存中待用。

4，MapJoin的实现方法：

     1）在Map-Reduce的驱动程序中使用静态方法DistributedCache.addCacheFile()增加要拷贝的小表文件，。JobTracker在作业启动之前会获取这个URI列表，并将相应的文件拷贝到各个TaskTracker的本地磁盘上。
     2）在Map类的setup方法中使用DistributedCache.getLocalCacheFiles()方法获取文件目录，并使用标准的文件读写API读取相应的文件。
```



## 3.参数及应用

```bash
set hive.auto.convert.join=true;
set hive.mapjoin.smalltable.filesize=25000000 #表文件的大小作为开启和关闭MapJoin的阈值。即25M
```

mapjoin可以解决数据倾斜。