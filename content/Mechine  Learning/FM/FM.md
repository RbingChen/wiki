---
title: "Factorization Machines"
layout: page
date: 2018-10-23 15:07
---



## 一 原理

​    Factorization Machine 提出的目的是解决二阶或者高阶项。

​    在二分类情况，假设如下：
$$
y=\frac{1}{1+exp(-f(x))}
$$
   对于大多问题，在给定损失函数的情况下，对$f(x)$的参数进行求解。

  一般地，考虑求解二次项：

  
$$
f(x)=w_0+\sum_iw_ix_i+\sum_i\sum_{j<i}w_{ij}x_ix_j
$$
   如果特征维数为$n$时，$f(x)$的参数数量总共为$1+n+\frac{n(n+1)}{2}$。在实际的工业场景，特征维度是很高的，因此会导  致求解速度很慢，而且只有少数的二阶项存在意义。

---



  FM提出对每一维度的特征存在一个 factor vector。

​       
$$
f(x)=w_0+\sum_iw_ix_i+\sum_i\sum_{j=i+1}<v_i,v_j>x_ix_j
$$
  假设factor vector 的维度是k，那么参数数量总共为$1+n+kn$

  
$$
\sum_i\sum_{j=i+1}<v_i,v_j>x_ix_j\\
=0.5(\sum_i\sum_{j=i}<v_i,v_j>x_ix_j-\sum_i<v_i,v_i>x_ix_i)\\
=0.5\sum_{f=1}^{k}[(\sum_{i=1}^nv_{i,f}x_i)^2-\sum_{i=1}^{n}v_{i,f}^2x_i^2]
$$
 导数形式为：
$$
\frac{\partial f(x)}{\partial \theta}=\begin{cases}1&if\ \  \theta\ \  is\ \ \  w_0\\ x_i&if\ \ \theta \ \ is\ \ w_i\\x_i\sum_{j=1}^nv_{j,f}x_j-v_{i,f}x_i^2&if\ \ \theta\ \ is \ \ v_{i,f}\end{cases}
$$

---

FFM 在FM上进行优化，指定field，出发点是不是所有的特征都应该存在交互或者交互的field应该不同。



## 二 求解





## 三 分析



参考资料：

1.Juan Y, Zhuang Y, Chin W, et al. Field-aware Factorization Machines for CTR Prediction[C]. conference on recommender systems, 2016: 43-50.

2.S Rendle,Factorization Machines,2010

https://tracholar.github.io/machine-learning/2017/03/10/factorization-machine.html