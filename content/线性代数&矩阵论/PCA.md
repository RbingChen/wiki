---
title : "PCA"
layout : page
date : 2019-03-28 14:01
---

[TOC]



# 一 原理

有$n$维的向量$x_1,x_2,...x_m \in R^n$，使用$k$个$n$维度的向量$v_i,..,v_k \in R^n$来表示$x_m$，即:
$$
x_m \approx \sum_j^k a_{mj}v_j
$$
与`线性回归`：
$$
y_i \approx \sum_j^k w_j x_{ij}
$$
以新的基底来表示向量，得到向量的新坐标。

1. 尽可能让新坐标分开，不重叠。方差大。
2. 空间距离小。

尽可能保留有意义的信息，意义是相对的，则必须有基准，特征向量便是可选的。

`为什么是特征向量呢？`

 能直观的分析，忽略旋转等其他信息，而关注一个矩阵在哪个方向能产生最大的效果。如果使用其他向量，不能很好的选取topK，达到降维的目的。



# 二 实现



https://blog.csdn.net/hjq376247328/article/details/80640544

https://www.cnblogs.com/jerrylead/archive/2011/04/18/2020209.html