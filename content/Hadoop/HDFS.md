---
title : "HDFS"
layout : page
date : 2019-03-21 20:18
---

[TOC]



# 一 框架

<img src="/wiki/static/images/hdfs1.png"  width="300" height="300" alt="HDFS框架"/>

HDFS是一种master/slave 结构

**DataNode**：可以有很多，一般一个集群节点只有一个DataNode，DataNode管理它们所在节点的相关存储。文件可能被切分成一个或多个block，将被存储在一系列的DataNode上。DataNode负责文件的读写操作，也执行NameNode的block创建、删除和复制操作指令。

**NameNode：**HDFS集群只要一个NameNode，用于管理文件系统命名空间和客户端文件访问，NameNode可以执行文件操作如：打开、关闭、重命名、新建文件夹等，也决定了block到DataNode的映射。



HDFS的文件系统的命名对用户是可见的，用户可以存储数据。

## File system Namespace

   和普通的文件系统没啥区别，就是没有绝对路径，文件处于HDFS的命名空间上。

## Data Replication

大文件有一些列的block构成，block的备份保证了系统的容错性。block的大小可以设置。除了最后一个block其他的 block都是大小一样的。

备份数可以指定。

NameNode做任何操作的时候都会考虑到block的备份。其周期性的接收DataNode的HeartBeat、Blockreport。HearBeat表示DataNode的正在良好的运转，后者说明DataNode持有哪些Block。

<img src="/wiki/static/images/hdfs2.png"  width="300" height="300" alt="data"/>

**如何进行备份很重要**。

当处理处理数据是，HDFS将会选择离reader最近（网络传输上时间损耗）的备份。