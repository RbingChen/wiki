---
title : "Hive基础"
layout : page
date : 2019-02-11 18:36
---

[TOC]



# 一 Hive 是什么

[https://cwiki.apache.org/confluence/display/Hive/Home](https://cwiki.apache.org/confluence/display/Hive/Home)

是一种可以读写、管理分布式存储数据并支持SQL语句的工具。

有以下特点：

1.通过sql能够容易对数据进行获取、分析....

2.可以支持各种结构化的数据类型

3.可以直接访问 HDFS、HBase

4.执行引擎：Tez、Spark、MapReduce

5.调度：LLAP、YARN、Slider

提供标准的SQL函数，通过UDF、UDAF、UDTF进行函数扩展。

数据存储类型：文本文件(CSV,TSV)、Parquet、ORC....

另个组件，HCatelog ：支持Hadoop的表存储及管理工具，保证用户只能用Pig、MapReduce等工具。

WebHCat：提供支持运行Hadoop MapReduce、Pig、Hive的服务，支持HTTP接口。



HDFS 和HBase 区别？

一个是文件系统，一个是数据存储系统。HBase是建立在HDFS之上的数据库。