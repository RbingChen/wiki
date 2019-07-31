---
title : "图神经网络-GNN"
layout : page
date : 2019-07-30 17:20
---



[TOC]



# 前置

Network Embedding： 把网络结点表示成低维向量，是一个非监督学习的过程。主要有 矩阵分解、Random Walk、基于DNN的三种方法。



# Graph Convolution Network

两种方法：

`spectral-based`: 基于谱的方法。从图信号处理的角度定义图卷积。

`spatial-based`：基于空间的方法。图卷积可以看成从近邻结点聚合特征信息。

Pool：分解图成为高层子结构。==》认为图是子结构的组合？

## Spectral-based GCN

无向图：使用标准化的图拉普拉斯矩阵来表示。

why 用图拉普拉斯矩阵？





# 理解

本质上是message passing，考虑如何aggregate  info。

# 有用链接

1. https://github.com/RbingChen/GNNPapers

  2.[如何理解 Graph Convolutional Network（GCN）？](https://www.zhihu.com/question/54504471/answer/332657604)