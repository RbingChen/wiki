---
title: "Deep Neural Networks for YouTuBe Recommendations"
layout: page
date: 2018-10-12 15:43
---

[TOC]



### 一 问题

1. 规模性。大规模的数据。
2. 时效性。存在大量的新上传的视频。trade-off exploration/exploitation。
3. 鲁棒性，抗噪性。由于用户历史数据的稀疏的数据性、不可观测的外部因子的多样化导致用户行为很难预测。此外，很难获得用户ground truth 的用户满意度，只能得到 noisy implicit feedback signals（我是这么理解，数据相对是不干净的，采集到的用户看视频数据不是完全是用户真实目的的表现，反馈的数据包括隐含噪声）。视频内容属性数据难以结构化（没有很好定义）表达....

---



### 二 论文概览

  结构框架如下：

<img src="/wiki/static/images/DnnYouTubeRsj结构图.png" alt="模型结构" style="width:700px;margin-right:20px;"/>



#### 1. candidate generation

​ 使用用户历史数据作为candidate  genertion network(候选集生成网络，CGN)的输入，从海量视频中选择出一些视频作为候选集。GGN使用协同过滤来获得广泛个性化。   

#### 2. ranking

 在给定目标函数下，ranking Network使用大量关于用户和视频的特征作为输入，得到相应视频的得分。

 线下采用多种评价指标：precision、recall、ranking loss ….来指导模型迭代

 但最终算法的有效性由线上A/B Test 的效果来确定，线上采用**点击率、观看时间**等指标来衡量用户的参与度。

#### 3.总结

一些小点。因为存在其他的候选集来源，使得两个网络不能一起处理；文章中在候选集生成中提到high precision，在排序阶段提到，high recall。

> The candidate generation network takes events from the user’s YouTube activity history as input and retrieves a small subset (hundreds) of videos from a large corpus. These candidates are intended to be generally relevant to the user with **high precision**. 
>
> Presenting a few “best” recommendations in a list requires a fine-level representation to distinguish relative importance among candidates with **high recall**. 

个人理解，候选集阶段，更关注精度指标，主要原因在于海量数据，候选集大小(受限于系统效率等)给定情况下，追求精度；排序阶段，此时，视频数少，应该展示视频以满足用户的需求。

---



### 三  Candidate Generation

​       采用浅层的神经网络来模拟Matrix Factorization方法，可以看成是 Factorization techniques 在非线性上的推广。

#### 1.Recommendation  as classification     

$$
P(w_t=i|U,C)=\frac{e^v_iu}{\sum_je^{v_ju}}
$$

$u$是由Context和用户信息构成的embedding，$v_j$表示候选视频的embedding。可以使用一个函数对用户历史信息和上下文信息进行转换得到embeding向量$u$，在使用softmax时，该向量对于区分视频是很有效的。

**训练数据**，直接数据：使用YouTube反馈机制(点赞、不喜欢、产品问卷等)；间接数据：认为用户看完一个视频，就可以作为正例(个人理解，全部看完的视频，可信度更高，置信度更大，更能代表真正的用户行为，使用没看完的视频可能带来负面效果)

**采样**: 使用重要性采样（看到很多博客说是 negative sample，引文中提到是确实是 importance sample，个人理解为importance sample。sample negative classes  和negative sample 是不同，一个是对负样本采样，一个是负采样）。



#### 2.Model Architecture



#### 3.Heterogeneous Signals



#### 4.Label and Context Selection

  "Taylor  Swift" 的例子，重复提供上次用户搜索的内容得到效果较差。

​    这是因为训练，网络学习到了这个规律，所以会偏向预测这case一个很大的规律，但实际上用户想看到新颖的东西，所以需要 Exploration。

Exploration-only: 仅探索，机会平均。Exploitation-only： 仅利用，当前最优。





 T*P 相当于 是一个期望时间。

​       神经网络依赖于特征，只是其对特征表现力比较强。

​       神经网络需要标准化。