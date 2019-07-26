---
title : "推荐系统之embedding"
layout : page
date : 2019-05-18 17:20
---

[TOC]

Embedding可以看成是一种降维技术。和传统的降维技术相比有啥区别呢？=> 能够发挥大语料的作用。

怎么使用SVD来做序列的Embedding？=>对于一个Item，计算在所有序列上窗口w内，出行其他的item的计数，构成矩阵。

Embedding，通过共现性，学习item潜在隐义。NLP中：语义、句法等。Airbnb：风格、主题。

Graph Embedding有3个方向：

1. Factorization methods。

      Distributed large-scale natural graph factorization.2013 ,WWW.

      MDS、IsoMap、Laplacina eigenmap.

2. Deep learning methods。

     Deep neural networks for learning graph representations . 2016, AAAI.

     Structural deep network embedding . 2016,KDD.

     Transnet: Translation-based network representation learning for social relation extraction. 2017,IJCAI

3. Random Walk based techniques。

   metapath2vec: Scalable representation learning for heterogeneous networks.2017,KDD

   Node2vec: Scalable feature learning for networks .2016,KDD

   Deepwalk: Online learning of social representations.2014,KDD

   

#### [2014微软-Item2Vec]: Neural Item Embedding for Collaborative Filtering 

提出了Item2vec，并和SVD做了实验对比。

1. Item2vec的算法原理是什么？如何构造数据？如何训练及参数更新？最后得到什么？怎么做协同过滤？

​        item set 内的item对构成正样本。使用负采样的方式训练，得到向量。

2. 如何做的对比？

​    做歌手音乐流派测试，随机选择top k个歌手，看ta是否和他的近邻的标签是否一致，一致则分类准确，基于Item2vec的方法准确率更高。论文中提高，这个方法可以用来做标签校正。

3. 解决了什么问题？优势是什么？

​      传统Item-based CF基于用户-item-用户的隐式链接，需要user信息，而Item2Vec CF 使用item间的关系，可以不需要用户信息，直接学习item间关系。更利于 exploration、discovery，增加些非同质化的内容。

4. 对不同频次的item,在采样概率上有处理。



#### [2018阿里]：Billion-scale Commodity Embedding for E-commerce Recommendation in Alibaba

有向图。

使用用户的历史行为构建Item Graph，然后使用算法学得Graph中每个Item的Embedding向量。

`论文要解决的问题是`：`引入Side information，改进Graph Embedding框架，缓解数据稀疏及冷启动问题`。

`Side information`: category、brand、price....。比如：新上一款索尼 微单，有了品牌和类别信息，可以便捷的推荐给浏览过 相关品牌和类别的用户，如果只使用item信息，没有浏览，将没有Graph边。稀疏数据的问题，使用了品牌信息，粒度更大，数据将不会过于稀疏。

**为什么使用向量召回**？

和传统的CF方法相比：原有方法只考虑了item共现性（co-occurrence)，忽略了时序、序列上的信息。对于item序列的使用，不能使用用户历史所有的记录，一是因为数据量过大，二是兴趣潜在变化。因此一般使用 session内的item 序列。阿里经验上使用的时间窗是`1H`。



**图构建和Embedding求解**：如果session内，两个item接连出现，则第一个item存在一条指向第二个item的有向边。**权重等于频次**。序列列构建，采用random walk，节点转移概率为归一化的频次。由item Embedding和side information Embedding加权得到最终的Embedding向量。一种做法是等权重加权，另一种做法是算法自动学习权重。

**数据清洗**：1. 停留时间小于1秒的item。2. 过于活跃的用户，直接去除。3. 商品可能存在更新，用户点击了一次之后，再次点击的时候，可能发生了改变，这种情况也去除用户的数据。

<img src="/wiki/static/images/GraphEmbedding1.png"  alt="GE"/>



**结果验证**：亚马逊数据集，验证下AUC。线上AB Test。可视化足球、乒乓球、羽毛球类的item，PCA降维后看分布。发现item所属的商家对最后Embedding贡献最大。

**item冷启动**：使用side information Embedding 的均值作为新商品的Embedding向量。



#### [2014]DeepWalk: Online Learning of Social Representations 

无向图

1. 针对什么场景？研究了什么问题？用了什么方法？得到什么结论？ 

针对网络节点的表征学习，提出了DeepWalk方法。采用连续向量对节点进行编码表示。语言模型和非监督学习方法的推广使用。对于多标签的分类任务，基于本文提出的DeepWalk方法，F1得分比其他方法搞了10%。

2. 关于长尾分布（power law distribution)的处理？



3. 序列如何生成？权重怎么构建？转移概率？

​       对每一个节点，都采样$\lambda$次，转移概率使用均匀分布，序列长度可设置。

4. 论文实验结果

      先吹一波比其他方法好，主要使用F1得分。关于参数上的实验 skip-gram 窗口大小、$\lambda$大小、采样的序列长度。

   和其他方法相比：只使用局部信息；在图领域引入无监督的表示学习。

   <img src="/wiki/static/images/GraphEmbedding1.png"  alt="DeepWalk"/>

考虑四个要素：1. Adaptability。适应性。对新样本不需要全部重新训练。2.Community aware。距离计算，相当于实际网络中的用户相似性。3.Low dimensional。低纬度数据**泛化能力更强**，收敛和推断更快。4. Continuous。连续空间的表达，提供更平滑的分类边界。社交网络中需要对用户进行分类。



#### [2015MSRA]LINE: Large-scale Information Network Embedding 

[LINE源码](https://github.com/tangjianpku/LINE)

1. 针对什么场景？研究了什么问题？用了什么方法？得到什么结论？ 

针对大规模网络，提出 LINE算法解决节点低维表征的方法。适用于有向、无向、带权等图网络；目标函数能保留局部和全局的结构信息；Edge-Sampling算法，改善学习和推断的效率。

 经典方法MDS、IsoMap、Laplacian eigenmap等，计算时间复杂度过高。

2. first-order proximity 

#### [2001谱聚类]Laplacian eigenmaps and spectral techniques for embedding and clustering



#### [2016Node2vec]node2vec: Scalable Feature Learning for Networks 

1. 针对什么场景？研究了什么问题？用了什么方法？得到什么结论？ 

   现有方法没有很好的处理 连接模式的多样性。

   

2. 一些应用？？

 Link prediction： 社交网络中的预测用户对哪些用户感兴趣、蛋白质网络中预测蛋白质的功能（分类标签）



3. 结构性特点。

   不仅学习近邻关系，也学习角色（结构上都是中心点）的相似性。