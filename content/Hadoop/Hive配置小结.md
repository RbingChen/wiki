---
title : "Hive配置"
layout : page
date : 2019-04-16 16:44
---

[TOC]

在实际编程过程中，一般是面向Hive 进行编程，很少直接基于mapreduce框架去写代码。

# 一 map参数

```bash
mapreduce.map.memory.mb=4096# 设置map端内存

#任务数
mapred.map.tasks  =    # map任务个数，一般不起作用
mapred.job.map.capacity   # 最多同时运行map任务数

#压缩
mapred.compress.map.output#map的输出是否压缩
mapred.map.output.compression.codec#map的输出压缩方式
```



# 二 reduce 参数

```bash
#任务数#
mapred.reduce.tasks=  # reduce个数
mapred.job.reduce.capacity   # 最多同时运行reduce任务数
hive.exec.reducers.max=  #最大的reduce个数

#内存相关#
hive.exec.reducers.bytes.per.reducer=  #每个reduce处理数据大小
mapreduce.reduce.memory.mb=2304 # 设置reduce端内存

#压缩
mapred.output.compress#reduce的输出是否压缩
mapred.output.compression.codec #reduce的输出压缩方式

```



# 三 其他

## 3.1并行

```bash
hive.exec.parallel=true# 是否开启并行执行，默认false
hive.exec.parallel.thread.number=8#并行运算开启时，允许多少作业同时计算，默认是8
hive.exec.max.created.files=100000#一个mapreduce作业能创建的HDFS文件最大数，默认是100000；
```

## 3.2map数控制

```bash
set mapred.max.split.size=1024000000;#  -- 决定每个map处理的最大的文件大小，单位为B
set mapred.min.split.size.per.node=1024000000;#-- 节点中可以处理的最小的文件大小
set mapred.min.split.size.per.rack=1024000000;#-- 机架中可以处理的最小的文件大小
# 大小关系
mapred.max.split.size <= mapred.min.split.size.per.node <= mapred.min.split.size.per.rack
```

## 3.3 动态分区

```bash
#是否打开动态分区。默认值：false   
hive.exec.dynamic.partition  

#打开动态分区后，动态分区的模式，有 strict 和 nonstrict 两个值可选，strict 要求至少包含一个静态分区列，nonstrict 则无此要求。默认值：strict 
hive.exec.dynamic.partition.mode  
    
#所允许的最大的动态分区的个数默认值：1000   
hive.exec.max.dynamic.partitions  
  
#单个 reduce 结点所允许的最大的动态分区的个数。默认值：100     
hive.exec.max.dynamic.partitions.pernode

#默认的动态分区的名称，当动态分区列为''或者null时，使用此名称。''    '__HIVE_DEFAULT_PARTITION__'  
hive.exec.default.partition.name    
```

## 3.4 map到reduce参数

```bash
#每个任务合并后文件的大小，根据此大小确定 reducer 的个数，默认 256 M。默认值：256000000   
hive.merge.size.per.task  
#是否合并Map输出文件：默认值为真
hive.merge.mapfiles=true
#是否合并Reduce 端输出文件：默认值为假
hive.merge.mapredfiles=false

```

## 3.5优化参数

```bash
#是否优化数据倾斜的 Join，对于倾斜的 Join 会开启新的 Map/Reduce Job 处理。   默认值：false 
hive.optimize.skewjoin  

# 倾斜键数目阈值，超过此值则判定为一个倾斜的 Join 查询。   默认值： 1000000     
hive.skewjoin.key  
#处理数据倾斜的 Map Join 的 Map 数上限。   默认值： 10000     
hive.skewjoin.mapjoin.map.tasks  

#处理数据倾斜的 Map Join 的最小数据切分大小，以字节为单位，默认为32M。默认值：33554432 
hive.skewjoin.mapjoin.min.split  

#是否优化列剪枝。   默认值：true     
hive.optimize.cp   

#是否优化谓词下推。   默认值：true     
hive.optimize.ppd   

#是否优化 group by。   默认值：true     
hive.optimize.groupby  

#是否优化 bucket map join。   默认值：false  
hive.optimize.bucketmapjoin  

#是否在优化 bucket map join 时尝试使用强制 sorted merge bucketmap join。   默认值：false     
hive.optimize.bucketmapjoin.sortedmerge  

#是否优化 reduce 冗余。   默认值：true  
hive.optimize.reducededuplication  
  
```



## 3.6 MapJoin

```bash
set hive.auto.convert.join=true;
set hive.mapjoin.smalltable.filesize=25000000 #表文件的大小作为开启和关闭MapJoin的阈值。即25M

#Map Join 所处理的最大的行数。超过此行数，Map Join进程会异常退出。默认值：1000000  
hive.mapjoin.maxsize  

#MapJoinOperator后面跟随GroupByOperator时，内存的最大使用比例   默认值：0.55
hive.mapjoin.followby.gby.localtask.max.memory.usage  
  
#Map Join 的本地任务使用堆内存的最大比例  默认值：0.9  
hive.mapjoin.localtask.max.memory.usage  
   
#设置每多少行检测一次内存的大小，如果超过hive.mapjoin.localtask.max.memory.usage 则会异常退出，Map Join 失败。   默认值：100000   
hive.mapjoin.check.memory.rows 
```



# 四 参数设置避免数据倾斜

主要是空值reduce处理数据的大小或者个数。