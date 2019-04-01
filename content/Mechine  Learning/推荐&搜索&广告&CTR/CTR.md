---
title : "CTR 模型"
layout : page
Date : 2018-12-21 19:36
---

[TOC]

为什么用embedding？

1. mlp过拟合。
2. 参数少更容易找个一个优解。

FFM 是FM 的特例。

限制了解空间。



# 一 wide&deep

<img src="wiki/static/images/widedeep.png"  alt="wide&deep"/>



Joint train:联合训练。
$$
P(Y|X)=\sigma(w_{wide}^T[X,\phi(X)]+w_{deep}^Ta^{l_f}+b)
$$
Memorization：学习历史数据上隐含于item间、特征间的相关性。依据用户历史行为进行学习，预测得到item和用户过去行为相关性较强。

generalization：相关度存在传递性，探索及学习历史数据很少或者不出现的组合特征。和memorization相比，更能提供多样化的item。当user-item间的联系是稀少且高阶的，deep模型容易过于泛化（over-generalize)而推荐相关度更小的item。

Joint training 和ensemble：对于ensemble来说，模型的训练是相互独立进行，单个模型需要足够大（特征够多）以获取很好的性能以保证融合后，总体准确率有提升；Joint training则是互相弥补，对特征要求低。



deep模型：更少的特征工程，且能学习到不可观测的特征组合。需要wide模型（使用低纬的交叉特征）补充相关性的学习，且可解释性强。deep存在过泛化问题。

wide模型：通过特征交叉以”记忆“特征间的相关性，有较好的解释性；需要deep模型，学习一些不可观测的潜在的相关性（不可观测的相关性，一般是指人，难以通俗解释的现象）。



wide模型，加入一些低维的交叉特征，通过训练学到一些相关性(特征之间的，item之间的，user-item之间的），存在不足，相关性是存在于历史中，而没有足够的随时间的变化性(时效性问题，推荐问题，用户不喜欢总是推荐相同的东西)。deep模型，学习用户和item之间存在稀疏且高阶的关系(由于高阶关系的存在，对低阶关系的学习将更难)，但是容易过拟合，带来相应的优势，能够推荐相关性更少的item，丰富推荐。

# 二 FNN

论文：Deep Learning over Multi-field Categorical Data 

基于树的方法需要精细的特征处理；浅层网络无法表达更复杂的模式；DNN可以充分探索可能存在特征组合。 

在第一层使用了FM，后续使用了全连接层。

对比一般情况下的FM，是对于一个值来说，而这里，是对于一个one-hot后的向量而言。

# 二 DeepFM



<img src="wiki/static/images/ctr_deepfm.png"  alt="deepfm"/>

基于w&d 的思想，把FM和DNN 融合起来了，与FNN相比，FNN只考虑了高阶交叉，且使用pre-train



# 三 PNN

直接使用DNN，特征数目过大。必须使用embedding层。使用embedding层，相当于对one-hot进行了压缩。



[https://zhuanlan.zhihu.com/p/53231955](https://zhuanlan.zhihu.com/p/53231955)

[https://zhuanlan.zhihu.com/p/35465875](https://zhuanlan.zhihu.com/p/35465875)