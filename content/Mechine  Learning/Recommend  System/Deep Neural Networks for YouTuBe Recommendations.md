---
title: "Deep Neural Networks for YouTuBe Recommendations"
layout: page
date: 2018-10-12 15:43
---



### 一 问题

1. 规模性。大规模的数据。
2. 时效性。存在大量的新上传的视频。trade-off exploration/exploitation。
3. 鲁棒性，抗噪性。由于用户历史数据的稀疏的数据性、不可观测的外部因子的多样化导致用户行为很难预测。此外，很难获得用户ground truth 的用户满意度，只能得到 noisy implicit feedback signals（我是这么理解，数据相对是不干净的，采集到的用户看视频数据不是完全是用户真实目的的表现，反馈的数据包括隐含噪声）。视频内容属性数据难以结构化（没有很好定义）表达....

### 二 论文概览

  结构框架如下：![结构图](./结构图.png)



1. candidate generation

​          通过用户的历史活动记录进行召回。使用协同过滤扩展候选集。

2. ranking

​         对召回的候选集进行排序，得到“best”的视频展示给用户。

 线下采用多种评价指标：precision、recall、ranking loss ….来指导模型迭代

 但最终算法的有效性由线上A/B Test 的效果来确定，线上采用**点击率、观看时间**等指标来衡量用户的参与度。



### 三 召回

​       采用浅层的神经网络来模拟Matrix Factorization方法，可以看成是 Factorization techniques 在非线性上的推广。

#### 1.recommendation  as classification

​     

​    做了采样，并对结果做近似求解topN

​      

#### 2.model Architecture



#### 3.Heterogeneous Signals



#### 4.Label and Context Selection

  "Taylor  Swift" 的例子，重复提供上次用户搜索的内容得到效果较差。

​    这是因为训练，网络学习到了这个规律，所以会偏向预测这case一个很大的规律，但实际上用户想看到新颖的东西，所以需要 Exploration。

Exploration-only: 仅探索，机会平均。Exploitation-only： 仅利用，当前最优。





 T*P 相当于 是一个期望时间。

​       神经网络依赖于特征，只是其对特征表现力比较强。

​       神经网络需要标准化。