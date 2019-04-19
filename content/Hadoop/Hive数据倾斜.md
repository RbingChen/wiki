---
title : "Hive数据倾斜"
layout : page
date : 2019-04-16 16:44
---

[TOC]

# 问题

数据倾斜一般发生在reduce阶段，主要是 `key的分布不均匀或者说某些key太集中`导致的，导致一些reduce执行时间很长。

1. Join操作

    a.小表Join大表，key过于集中。导致分发到某几个reduce上的数量远高于平均值。

    b. 大表join大表，分区判断的0值或者空值过多。导致这些空值都由同一个reduce处理，数据量超多。

2. group by。key的维度过小或者某些值数量过多。导致处理这些值的reduce非常耗时。

3. Count disticnt 。某些值数量过多。导致处理这些值的reduce非常耗时。

# 设置参数

1. 设置hive.map.aggr=true  

​       开启map端部分聚合功能，就是将key相同的归到一起，减少数据量，以减少进入reduce的数据量。

2. hive.groupby.skewindata=true      

3. 以下参数是设置reduce的：通过增加reduce数量或者减少reduce处理数据数量达到均衡每个 reduce数量量的目的。

```bash
hive.exec.reducers.bytes.per.reducer=1000000000  
hive.exec.reducers.max=999
mapred.reduce.tasks=-1
```



# 语句优化

空值问题：

1. join操作中可以去除空值
2. count distinct 单独对空值进行计数。

其实都不是很实用。。具体问题具体分析

 

 

 

 