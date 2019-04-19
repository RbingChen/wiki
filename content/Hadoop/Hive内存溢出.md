---
title : "Hive内存溢出问题"
layout : page
date : 2019-04-16 16:44
---



# 一 mapreduce 

1. JVM Heap内存溢出：堆内存不足，抛出如下异常：

第一种：`java.lang.OutOfMemoryError`: `GC overhead limit exceeded`

第二种：`Error: Java heapspace`

第三种：`running beyondphysical memory limits.Current usage: 4.3 GB of 4.3 GBphysical memory used; 7.4 GB of 13.2 GB virtual memory used. Killing container`。

 这种情况下注意是map任务挂掉了还是reduce任务挂掉了，需要调整相应的map和reduce 参数。

```bash
Maper: 
set mapreduce.map.java.opts=-Xmx2048m(默认参数，表示jvm堆内存,注意是mapreduce不是mapred)
set mapreduce.map.memory.mb=2304(container的内存）

Reducer:
set mapreduce.reduce.java.opts=-=-Xmx2048m(默认参数，表示jvm堆内存)
set mapreduce.reduce.memory.mb=2304(container的内存)
#也可以增加reduce个数来达到减小每个reduce占用内存。没有直接控制map数的方法。
set hive.exec.reducers.max=1000或者set mapred.reduce.tasks=1000


注意：在yarn container模式下，map/reduce task是在container之中运行，因此mapreduce.map(reduce).memory.mb的值大小都大于mapreduce.map(reduce).java.opts值。
mapreduce.{map|reduce}.java.opts能够通过Xmx设置JVM最大的heap的使用，一般设置为0.75倍的memory.mb，为java code等预留些空间。
```



2. 栈内存溢出：java.lang.StackOverflowError

常会出现在SQL中（SQL语句中条件组合太多，被解析成为不断的递归调用），或MR代码中有递归调用。这种深度的递归调用在栈中方法调用链条太长导致的。出现这种错误一般说明程序写的有问题。

# 二 MRAppMaster 

如果作业的输入的数据很大，导致产生了大量的Mapper和Reducer数量，致使当前job的MRAppMaster的压力大，导致MRAppMaster内存不足，作业中会报出现了OOM信息

```bash
yarn.app.mapreduce.am.command-opts=-Xmx1024m(默认参数，表示jvm堆内存)
yarn.app.mapreduce.am.resource.mb=1536(container的内存)

#注意在Hive SQL ETL里面，采用如下方式设置：

set mapreduce.map.child.java.opts="-Xmx3072m"(注:-Xmx设置时一定要用引号，不加引号各种错误)
set mapreduce.map.memory.mb=3288
或
set mapreduce.reduce.child.java.opts="xxx"
set mapreduce.reduce.memory.mb=xxx
```

