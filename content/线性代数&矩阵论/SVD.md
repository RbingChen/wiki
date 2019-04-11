---
title : "SVD"
layout : page
date : 2019-04-03 16:11
---

[TOC]



# 一 原理

对于任何非满秩矩阵有 $A_{mn}=U_{mm}S_{mn}V^T_{nn}$，且必须有$UU^T=I,VV^T$。

证明：
$$
AA^T=(USV^T)(USV)^T=USS^TU^T\\\\
A^TA=(USV^T)^T(USV)=V^TSS^TV
$$
[实对称矩阵可对角化](https://www.zhihu.com/question/38801697)。矩阵$S$由 $AA^T$的特征值构成。



SVD 可以看成是把一个标准正交基底经过拉伸、旋转变换到另外一个标准正交基。

# 二 优化

通常SVD 可能是十分巨大，因此需要进行优化求解

## Randomized  SVD

有正交矩阵$Q$，则：
$$
A=QQ^TA=QB
$$
对$B$进行奇异值分解$B=U\Sigma S^T$，$B$是$k*n,k<<m$，$Q$的选择很重要。

那么 
$$
A=QU\Sigma S^T=(QU)\Sigma  S^T
$$
因为$(QU)(QU)^T=I$，所以$QU$是正交矩阵。参考[1，2]。

## Incremental   SVD

现在使用的数据是$A=U \Sigma V^T$，有新数据$B$。
$$
[A\ \ \ B]=[U\ \ \ \hat B] \begin{bmatrix}\Sigma& U^TB\\\\0&\hat B^TB \end{bmatrix}\begin{bmatrix}V^T& 0\\\\0&I\end{bmatrix}
$$
令$R=\begin{bmatrix}\Sigma& U^TB\\\\0&\hat B^TB \end{bmatrix}$，$R=\hat U \hat \Sigma \hat V^T$，则有：
$$
[A\ \ \ B]=([U\ \ \ \hat B]\hat U )\ \hat \Sigma \ \ (\hat V^T \begin{bmatrix}V^T& 0\\\\0&I\end{bmatrix})
$$
对$[U\Sigma \ \ B]$进行QR分解得到$\hat B , R$。参考[3]

## 并行SVD



# 三 应用



# 四 推荐系统中的SVD

## SVD++

处理缺失值~

<img src="/wiki/static/images/svd1.png" alt="svd" />







# 五 与PCA的关系

1. SVD 的分解取topK分量就是PCA，$U\Sigma$得到的是新的表征，$V$有点像是聚类中心。
2. 可以把$V$向量当做背景或者公共特点，原始向量减去$V$向量的组合，得到原始向量的不同点。

# 参考文献

1.Finding structure with randomness: Stochastic algorithms for constructing  approximate matrix decompositions  Halko, et al., 2009 http://arxiv.org/abs/arXiv:0909.4061

2.A randomized algorithm for the decomposition of matrices  Per-Gunnar Martinsson, Vladimir Rokhlin and Mark Tygert

3.Incremental Learning for Robust Visual Tracking

4.http://www.ams.org/publicoutreach/feature-column/fcarc-svd

5[协同过滤算法的几篇文章PFM/svd/ svd++]http://www.voidcn.com/article/p-pbnedsxn-bbh.html