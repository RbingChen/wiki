---
title : "chapter1-综述"
layout : page
date : 2019-04-12 10:44
---

[TOC]



# 一 曲线拟合问题

目的： 在现有数据集上，当给定任意新的$x$，给出相应预测值$y$。

优化：erro function，最小化。

模型选择：对比模型选择合适数量的参数个数。

`over-fitting`的概念：在训练数据上表现优异，在待预测数据上表现很差。训练数据越多，能够避免over-fitting。

`模型复杂度的衡量`：参数少的模型所在空间是参数多的模型空间的子空间。参数的数量不是最合适的衡量模型复杂度的指标。第三章，会有介绍？贝叶斯方法依据数据集大小自适应调整参数个数。

`正则化`：限制参数大小。 weight decay。

测试集：留出一部分数据作为测试，但是存在数据浪费，因此需要更精妙的算法来解决。

# 二 概率论

`概率密度函数`: 函数值大于0；积分为1。

`复合函数`：$x=g(y)$，$p_y(y)=p_x(x)|\frac{dx}{dy}|$。可以在$(x,x+\delta x)$或者为$(g^{-1}(x),g^{-1}(x)+\delta x)$，转化为$y$的区间：$(y,y+\delta y)$。则$p_x(x)\delta x \approx p_y(y)\delta y$。

`部分期望`：$E_x[f(x,y)]=\sum_x p(x,y)f(x,y)$，换成积分，将得到的是关于y的函数。

`条件期望`：$E_x[f(|y)]=\sum_x p(x|y)f(x)$

# 三 贝叶斯

考虑曲线拟合问题，给定数据集$D$，求解最优参数$w$。

`后验概率`：$p(w|D)$，现有数据下，参数的分布概率。

`先验概率`:$p(w)$，是一个概率分布，和数据集无关，人对某个问题的先有认知。

`似然函数`:$p(D|w)$，无论是频率学派还是贝叶斯学派，似然函数都是核心。

**贝叶斯 vs 频率学**：

1. 主要区别定在于贝叶斯认为参数$w$服从某个概率分布，而频率学派认为$w$是固定值。
2. 频率学派使用最大似然，$max\ \ p(D|w)$。求解参数使得数据集出现的概率最大。一般地，使用最大似然函数的`负对数`作为erro function。最小误差和最大似然等效。
3. 频率学派怼贝叶斯学派，先验分布的选择不科学，只是觉得选这个先验好计算。第二章就知道了。因此，这也衍生出 `noninformative prior`。差的先验搞不好就翻车了。注意了，什么交叉验证，都是频率学派的技术，这些技术一定程度上缓解了拟合不好的问题。

**Why 贝叶斯？**

千年不变的例子，抛硬币，很不巧，抛了5次，全是正面，频率学派认为正面概率是1，但是贝叶斯学派不是。

个人觉得都是胡扯，在大数据量的情况下，不可能发生这种事，这决定了贝叶斯学派在工业界上用得不多。不过，在小样本的情况下，贝叶斯学派可能更work，主要体现在先验知识对问题的校正。话说，现在的强化学习，走小样本路线。

**贝叶斯有啥用呢**

variational Bayes、expectation propagation、一些 采样方法。

# 四 概率建模

上一部分提到的似然函数、先验概率、后验概率如何得到。

`有偏、无偏`的问题？ 参数少且数据量大时，有偏影响可以忽略。但是对于参数很多的情况，即使数据量大，这也会是一个严重的问题。`有偏是over-fitting根源所在`。

引入概率分布：对于任意给定输入$x_n$，真实值$y_n$服从服从均值为$f(x_n,w)$的高斯分布:

$p(y_n|x_n,w,\beta)=N(y_n|f(x_n,w),\beta^{-1})$

**为什么这么假设**？

   实质上是对误差进行了假设，任务误差服从高斯分布（很常理的假设)。另一种说法是加了`噪声带`，保证真实值能够被（预测值+噪声）的区间覆盖。

**推导问题**

1.参数无先验的情况下:
$$
ln\ p(Y|w)=-\frac{\beta}{2}\sum_n\{f(x_n,w)-y_n\}^2+\frac{N}{2}ln \beta+const
$$
使用最大似然(MLE)求解，得到的最终项和平方误差最小是等效。

2.参数有先验的情况下，$p(w|\alpha)=N(w|0,\alpha ^{-1}I)$，$p(w|Y,X,\alpha,\beta) \propto  p(Y|X,w,\beta)p(w|\alpha)$:
$$
ln\ p(Y|w)=-\frac{\beta}{2}\sum_n\{f(x_n,w)-y_n\}^2+\frac{N}{2}ln \beta+\frac{\alpha}{2}w^Tw+const
$$
使用最大后验求解(MAP)，多了一个正则项。参数如果服从拉普拉斯分布，推导得到L1正则。

**more 贝叶斯**

`点估计`和`分布估计`。MLE 和MAP都是点估计。而贝叶斯估计是分布估计。但是，前者是估计参数，而后者是估计预测值。如下对于待预测的$x$，得到预测值的$y$的分布：
$$
p(y|x,X,Y)=\int p(y|x,w)p(w|X,Y,\alpha,\beta)dw
$$

上等式是一个高斯分布（第三章可知）。

# 五 模型选择、维度灾难

交叉验证、留一法，分析了一堆缺点。然而工业界数据还是很多，有足够的数据来做验证集，能够良好评估模型的泛化性能。

其他方法：

`Akaike information criterion`：$logp(D|w)-M$，M是可调节参数个数。

Bayesian information criterion，第四章介绍。



维度灾难[1，2]定义：**给定数据集的情况下**（很多资料都不特定说明这个条件，如果数据集无限，有个毛的维度灾难），过了某个特征维度临界点，如果还持续的增加特征会导致分类器的性能会下降。

在**数据量一定的情况**下，特征维度越大，空间内数据会越`稀疏`，越容易得到分类平面把样本很好切分开，但是维度过大，模型的泛化性变差，即过拟合。。

使用非线性分类器(NN、决策树、knn等)时，（训练集上）分类效果好，但泛化性差，易过拟合，因此要控制特征维度；朴素贝叶斯、线性分类器，泛化性好，不易过拟合，因此特征维度可以适当更高。——不是很理解。。。

`overfitting occurs both when estimating relatively few parameters in a highly dimensional space, and when estimating a lot of parameters in a lower dimensional space`

​    高维空间，只有少数参数也会过拟合，例如：决策树。低纬空间，参数多会过拟合，显然地。而一般的维度灾难描述的是，特征维度越来越高，参数维度越来越高，由于数据量不变而使数据在空间过于稀疏导致模型过拟合。

总结：1.理论上数据无限，则不会发生维度灾难；2. 维度增加，训练样本数需要指数增加。





# 参考文献

1.[<https://zhuanlan.zhihu.com/p/27488363>](https://zhuanlan.zhihu.com/p/27488363)

2.[<http://www.visiondummy.com/2014/04/curse-dimensionality-affect-classification/>](http://www.visiondummy.com/2014/04/curse-dimensionality-affect-classification/)