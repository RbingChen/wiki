---
title: "descion tree"
layout: page
date: 2018-10-18 10:51
---

[TOC]



# 一 定义



> ESL 中定义：Tree-based methods partition the feature space into a set of rectangles, and then fit a simple model (like a constant) in each one. 
>
> 统计学习方法中定义：一种描述对实例进行分类的树形结构。由节点和有向边构成，结构有内部节点(internal node) 和 叶节点(leaf node)构成。内部结点表示一个特征或属性，叶节点表示输出。

个人理解：

1. 决策树是规则的结构表示，决策树从root 节点到根节点，是一连串if-then 规则构成。可以认为，决策树很好的把规则组织起来了，并且能够通过一定方式去选取规则( 即选取 if-then 的判断条件)。

   ​     和人为规则对比，人无法直接去计算复杂的规则，深度10的树，可能包含$2^9=512$ 条规则，人是难以去完成并加以很好的组织这些规则的。

2. 规则本身上是对空间的划分，而且是在同一属性上进行规则的选取。

   ​      例如：gini 系数计算的时候，是分别在每一个特征进行系数计算，同一个特征上的度量(数值含义）是一致的，因此决策树模型的特征不需要归一化。而对于LR模型来说，是通过特征乘以系数再相加来计算结果，训练过程中，特征存在影响，在某种程度上，需要进行归一化。

3. 可以把决策树看成判别模型，$P(Y|x_1,x_2,x_3,....,x_n)$。给定具体的属性值，得到相应输出。

问题：

1. 前面几层的节点分错的情况下，对下面几层的影响很大。尤其是离散化的特征。

2. 决策树是在已知空间对划分，难以推断到未知空间。

   例如： 训练集$y\in [a,b]$,那么，决策树预测的结果只能在这个范围内。线性回归，通过组合特征可以拓展到范围外。。



# 二 训练

决策树的训练，是规则的选取的过程，即特征选取。

**首先思考什么样的特征是好的？** 

极端情况下，一次性能把类分好。事实上，数据难以一次性被分好，那么，按照这个思想，在当前节点，应该选取一个特征，该特征能够比较清晰的划分数据(通俗来说，就是分完之后，节点上大部分是多数类，极少部分是其他类)，有方差、gini、信息增益等来量化。专业术语impurity 用来表示分类清晰、纯度。

## 1.Gini impurity

$$
I_G(p)=1-\sum_i^k{p_k}
$$

​          基尼系数，本来是用于衡量描述收入贫富差距的指标。趋近于0时越相等，趋近于1时表示极度不相等。财富的基尼系数计算:

​       
$$
G=\frac {\sum_{i=1}^n\sum_{j=1}^n|x_i-x_j|}{2n\sum_{i=1}^nx_i}\\
G=\frac{1}{2a}\int \int p(x)p(y)|x-y|dxdy\\
a=\int xp(x)dx
$$
计算Gini系数时候，要大样本且某个值很大时，系数才会趋向于1：
$$
x_i\to + \infty,x_i>>x_{j\neq i}\\
G \approx \frac{(2n-2)x_i}{2nx_i}\approx1
$$
分类中的Gini系数：
$$
I_G(p)=\sum_i p_i\sum_{j\neq i}p_j=\sum_ip_i(1-p_i)=1-\sum{p_i^2}
$$
这个系数要等于1 也得是很极端的情况（类别很多时）。

## 2.Information Gain



## 3.Variance reduction



# 三 优缺点

**优点：**

1. Simple to understand and interpret

   ​     可理解性可解释性强

2. Able to handle both numerical and categorical data

   ​     可以同时处理数值和离散数据

3. Requires little data preparation

   ​    其他技术经常需要数据的标准化

4. User a white box model

   ​    可以理解可视化，可理解性强~NN难以理解。

5. Possible to validate a model using statistical tests

      容易验证模型的有效性

6. Non-statistical approach that makes no assumptions of the training data or prediction residuals

      对训练数据或者预测残差，没有做假设性猜想。

7. Performs well with large datasets

8. Mirrors human decision making more closely than other approaches

   ​    类似人类的行为或者决定

9. Robust against co-linearity

   ​    能很好地处理共线性

10. In built feature selection

    ​    自带特征选择

11. Decision trees can approximate any Boolean function 



**缺点**：

1. **决策树十分不鲁棒(non-robust**)。训练集上很小改变可能导致树结构的较大的变化进而影响最后的预测结果。

    RF  弥补这个缺点。

2. 特征选择过程是一个NP-C问题。现在构建决策树的方法都是基于启发式的算法，例如：贪心算法，每个节点都是局部最优，不能确保做到全局最优。

3. 容易过拟合。剪枝(pruning)。

4. For data including categorical variables with different numbers of levels，information gain in decision trees  is biased in favor of attributes with more levels。

5. **缺少典型数据。如果训练数据中没有包含所具有的代表性的数据，导致某一类数据无法很好的匹配。？？**

     **都有代表性了，学习个毛了？？？**



**其他：**

​    NN全局最优；GBM 局部贪心最优，层级最优。



1. https://en.wikipedia.org/wiki/Decision_tree_learning

  2.https://blog.csdn.net/keepreder/article/details/47168383