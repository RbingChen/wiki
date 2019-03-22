---
title : "Yarn"
layout : page
date : 2019-03-21 20:18
---



[TOC]

# 一 框架

<img src="/wiki/static/images/yarn1.png"  width="300" height="300" alt="yarn框架"/>

Yarn的最基本的思想是:资源管理 和 任务调度/监管相分离。因此产生了全局的ResourceManger（RM）和每个应用独有的ApplicationMaster（AM）这两个概念。应用可以指的是单一的job或者连串的jobs。

**ResourceManager**:管理系统中每个应用的资源分配和仲裁，由**Scheduler**和**ApplicationMange**r构成。

Scheduler，如其名仅仅就是一个调度器，负责为运行中的应用资源分配，不对应用的进行监管或者状态跟踪，不确保对失败任务的重启。Scheduler基于每个应用的资源需求执行调度函数。提供可插入的策略，确保在不同的队列、应用中划分集群资源。如： [CapacityScheduler](http://hadoop.apache.org/docs/stable/hadoop-yarn/hadoop-yarn-site/CapacityScheduler.html)， [FairScheduler](http://hadoop.apache.org/docs/stable/hadoop-yarn/hadoop-yarn-site/FairScheduler.html)。

ApplicationManager:负责job提交的接受，协调AM container（AM 的container比较特殊，是特定的）地执行，确保AM container失败后的重启动。

**NodeManager**:每一个集群节点的代理，监管节点上资源（cpu，硬盘，内存，网络。container可以认为是资源的集合体）的使用情况，并向RM报告。

**ApplicationMaster**：负责协调来自RM的资源containers，监管并跟踪container的状态。

**Container**:抽象的概念，包含如下内容：内存，cpu，硬盘，网络资源等等。

<img src="/wiki/static/images/yarn2.png" width="300" height="300" alt="yarn框架"/>

Yarn通过 [ReservationSystem](http://hadoop.apache.org/docs/stable/hadoop-yarn/hadoop-yarn-site/ReservationSystem.html)系统可以实现资源保留，利于重要任务的执行。

讨论下各个组件的关系：

1. container不对NM进行报告，NM监控的是节点的资源；container向其所属的AM报告。NM向RM报告资源情况。因此RM根绝NM对整体资源的报告，协调AM下container资源分配。
2. MapReduce程序在哪执行？在container内执行。

# 参考链接

1.[https://www.ibm.com/developerworks/cn/data/library/bd-hadoopyarn/index.html](https://www.ibm.com/developerworks/cn/data/library/bd-hadoopyarn/index.html)

2.[http://hadoop.apache.org/docs/stable/hadoop-yarn/hadoop-yarn-site/YARN.html](http://hadoop.apache.org/docs/stable/hadoop-yarn/hadoop-yarn-site/YARN.html)