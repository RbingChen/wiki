---
title: "Deep Neural Networks for YouTuBe Recommendations"
layout: page
date: 2018-10-12 15:43
---

[TOC]



## 一 问题

1. 规模性。大规模的数据。
2. 时效性。存在大量的新上传的视频。trade-off exploration/exploitation。
3. 鲁棒性，抗噪性。由于用户历史数据的稀疏的数据性、不可观测的外部因子的多样化导致用户行为很难预测。此外，很难获得用户ground truth 的用户满意度，只能得到 noisy implicit feedback signals（我是这么理解，数据相对是不干净的，采集到的用户看视频数据不是完全是用户真实目的的表现，反馈的数据包括隐含噪声）。视频内容属性数据难以结构化（没有很好定义）表达....

---



## 二 论文概览

  结构框架如下：

<img src="/wiki/static/images/DnnYouTubeRsj结构图.png" alt="模型结构" style="width: 270px;margin: auto;display: block;float: left;"/>









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



## 三  Candidate Generation

​       采用浅层的神经网络来模拟Matrix Factorization方法，可以看成是 Factorization techniques 在非线性上的推广。

### 1.Recommendation  as classification     

$$
P(w_t=i|U,C)=\frac{e^{v_iu}}{\sum_je^{v_ju}}
$$

$u$是由Context和用户信息构成的embedding，$v_j$表示候选视频的embedding。可以使用一个函数对用户历史信息和上下文信息进行转换得到embeding向量$u$，在使用softmax时，该向量对于区分视频是很有效的。

**训练数据**，直接数据：使用YouTube反馈机制(点赞、不喜欢、产品问卷等)；间接数据：认为用户看完一个视频，就可以作为正例(个人理解，全部看完的视频，可信度更高，置信度更大，更能代表真正的用户行为，使用没看完的视频可能带来负面效果)

**采样**: 使用重要性采样（看到很多博客说是 negative sample，引文中提到是确实是 importance sample，个人理解为importance sample。sample negative classes  和negative sample 是不同，一个是对负样本采样，一个是负采样）。使用logloss 计算梯度$-y_ilog(p_i)=-log{\frac {e^{- t(x_i)} } {\sum_j^N e^{-t(x_j)}}}=t(x_i)-log({\sum_j^N e^{-t(x_j)}})$：
$$
f^{\prime}(\theta)=\nabla_\theta{logloss}\\
f^{\prime}(\theta)=\nabla_\theta{t(x_i)}-\sum{p(x_j)\nabla_\theta{t(x_j)}}
$$
可以在概率$p$分布下采样得到样本，来估计$\sum{p(x_j)\nabla_\theta{t(x_j)}}$，即$\frac{1}{m}\sum_{j=1}^m\nabla_\theta{t(x_j)}$，因为视频数较多，计算概率$p$很耗时。因此考虑使用其他方式来计算。

考虑importance sample。

  
$$
E_p[\nabla_\theta(t(x))]=\sum_xp(x)\nabla_\theta(t(x))=\sum_x\frac{p(x)}{q(x}q(x)\nabla_\theta(t(x))=E_q[\frac{p(x)}{q(x}q(x)\nabla_\theta(t(x))]
$$
那么在$q(x)$分布下进行采样得到$\frac{1}{m}\sum_{j=1}^{m}\frac{p(y_j)}{q(y_j}\nabla_\theta(t(y_j))$。使用$w(x)=\frac{e^{-t(x)}}{q(x)}$作为新的权重避免$p(x)$的计算，且$W=\sum_x w(x)$。

​       <img src="/wiki/static/images/DnnYouTuBe 采样图.png">

**得分计算**:

​	 采样用最近邻查找。计算$v_ju$ 相当于计算点乘，即$|v_j||u|cos\theta$，那么在 空间上只要两者相近，可以认为近似乘积最大( 如果标准化数据，就是最大，因为模型是1，只有夹角趋向于0就行)。类似于kd树，采用近似的方法进行求解。

### 2.Model Architecture

用户观看历史被映射成了长度相等的向量。

问题：如果一个用户有很多历史观看呢？ 类似于词向量，是不是就是 说 连续三个视频，采用3-gram的话，就是预测 最后一个视频的ID。

### 3.Heterogeneous Signals

DNN作为matrix  factorization 的一般化，能很容易的往模型增加任意的连续或者离散特征。

观看历史：采用unigram 和 bigram 去做embedding

demographic features： 人口统计学特征。个人理解：是人群的特征，比如:学生群体比较容易做什么，可以作为特征。这类特征能够一定程度上解决新用户推荐的问题。

用户的地理信息和设备信息：embedded

用户的普通特征: 年龄、性别等..直接被加入

**“Example Age"**

机器学习系统通过学习历史行为以预测未来。但视频的流行度是高度动态，但是推荐系统提供corpus是多项式分布的，讲反应在训练窗口内几周的平均观看可能性。为了纠正这个问题，把训练样本的age作为一个特征进行训练，但是在线上时，这个特征会被设置为0.

 偏向预测新视频。新视频天生的容易被观看，因此要解决这个问题，类似搜索排序，排在前面的链接，天然容易被点击。下图表示的某个视频被观看的概率随时间的变化图（不知道empirical 怎么算的，baseline是没有加age特征的情况)：

<img src="/wiki/static/images/DnnYouTuBe视频age问题.png">



### 4.Label and Context Selection

 如果用户通过其他方式观看视频，立即响应的collaborative filtering。

另一个，对于每一个用户产生一定样本，保证每个用户的数据对loss有贡献，防止高活跃用户主导loss。

  "Taylor  Swift" 的例子，重复提供上次用户搜索的内容得到效果较差。这是因为训练，网络学习到了这个规律，所以会偏向预测这case一个很大的规律，但实际上用户想看到新颖的东西，所以需要 Exploration。

Exploration-only: 仅探索，机会平均。Exploitation-only： 仅利用，当前最优。

然后扯了一堆样本选择，呵呵了。不能存在信息泄露。**特征生成时间要小于预测时刻。**



## 四 Ranking

Ranking:对于具体的用户使用impression data 以按某种标准对预测值进行打分。Ranking把不同的来源的候选集统一起来了。

尽管NN减轻了特征工程的负担，原始数据不能够很好的作用于网络

### 1.特征

和Candidate 阶段相比，由于视频数很少，可以有很多特征来描述用户和视频之间的联系或关系。

类别特征：Embedding 

连续特征：标准化。采用分位点的方式标准化（接近哪个分位点这标准化为该分位点，如中位数，则标准化为0.5）。此外，一些数学变化，如：开根号、平方....



 T*P 相当于 是一个期望时间。

​       神经网络依赖于特征，只是其对特征表现力比较强。

​       神经网络需要标准化。