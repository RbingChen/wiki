---
title : "chapter10-变分推断"
layout : page
date : 2019-05-12 10:44
---

[TOC]



# 一 近似求解

$$
P(z,x)=p(z)p(x|z)
$$

目的：近似求解$p(z|x)$。得到后验分布则能进行推断，类似于MAP。

## 1.MCMC

基于Markov chain的特性，采样得到样本，使用这样些样本去近似概率。



## 2.Variational inference

$$
q^*(z)= arg\ min_{q(z)}\ \ KL(q(z)||p(z|x))
$$

通过优化手段直接近似概率，把推断问题转化成优化问题。优化的方式求解解析解。



对比：

1. VI求解快，适用于大数据下的快速求解；MCMC适用于小数据下，以计算量换精度的求解。MCMC需要更多的计算量以保证更准确的近似概率；VI能充分利用典型的优化方法及分布优化手段，但是不能保证精度。

# 二 变分推断

为什么？怎么做？如何求解？怎么推断？

对函数的形式进行限制从而减小求解的复杂度。

## 1.Mean-field family 



## 2.Coordinate ascent variational inference



## 3.Stochastic variational inference 



参考文献

1.[知乎-变分推断的解释](https://www.zhihu.com/question/31032863)

2.[Variational Inference: A Review for Statisticians](https%3A//arxiv.org/abs/1601.00670)

3.[[1206.7051\] Stochastic Variational Inference](https%3A//arxiv.org/abs/1206.7051)

