---
title : "flink入门"
layout : page
date : 2019-08-05 13:36
---



# 基本概念

依据数据源的类型（有界或无界源，就是本地存储数据和实时流数据的区别），可以编写批处理程序（DataSet API）或流程序（DataStream API)。

流程序中的 `StreamingExecutionEnvironment `和`DataStream `API。本质上是`DataSet`中的概念完全相同，只需替换为`ExecutionEnvironment`和`DataSet`。



# 编写程序

Flink程序第一步是创建一个`StreamExecutionEnvironment`或者`ExecutionEnviroment`。用于设置执行参数并创建从外部系统读取的源。

```java
//java
StreamExecutionEnvironment env = StreamExecutionEnvironment.getExecutionEnvironment();
//scala
val env = ExecutionEnvironment.getExecutionEnvironment  
```

# 活动时间

## 概览

chui