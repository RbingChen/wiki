---
title : "attention"
layout : page
date : 2018-11-01 16:04
---

[TOC]

首先给一定典型的attention结构图。

<img src="/wiki/static/images/attention.png" alt="attention图" />

有如下定义：

<img src="/wiki/static/images/attention_equation_0.jpg" alt="attention计算" />

$h_t$是decode端 hidden state , $\overline{h}_s$是编码端hidden state

socre 有两种计算方法：

<img src="/wiki/static/images/attention_equation_1.jpg" alt="attention计算" />



# 一  attention 原理

attention 是什么？

  nlp中给定词，和不同词之间的隐含关系存在差异，cv中视觉中心点在时间上存在变化。

  Image: 大部分动物只关注视野的特定部分以获得准确的响应。

  

1. 局部和全局。考虑全局的事物或变量对局部的影响，但对于全局来说，全局的小部分对局部的影响是不同。


​       

​    <img src="/wiki/static/images/attention_equation_1.jpg" alt="翻译"/>

​       不使用attention时，$P(y_i|h_i,h_{i-1},...,h_1)$，lstm模型容易导致

​      对CNN而言，局部感受野。



   或者理解为源和目标的关系。

2. 如何衡量全局对局部的影响？

    首先思考全局的表达是什么？CNN而言，可以是浅层或深层的特征表达，lstm，对于时隙变换的集合。

    其次如何衡量，全局不同部分对局部的影响。



适用于什么问题？



为什么nlp的解码端使用lstm？

1. 写字的时候是有顺序的。前面的词的表达对后面的词的表达有影响。
2. nmt的时候，搜索算法。
3. 不用lstm的话，例如cnn，解码的时候，
4. attention

## attention

给定输入源和输出值的表达，使用一个函数来刻画输入源和输出值的关系。

​                       
$$
\alpha_{ts}=\frac{exp(score(h_t,\hat h_s))}{\sum_{\hat s}^Sexp(score(h_t,\hat h_s))}\\\\
c_t=\sum_s \alpha_{ts}\hat h_s\\\\
a_t=f(c_t,h_t)=tanh(W_c[c_t;h_t])
$$
$\alpha_{ts}$:attention weight

$c_t$:context vector

$a_t$:attention vector，

$a_t$用以连接softmax

$h_t$表示输出值，$\hat h_s$表示输入源

对于score 函数有如下几种：
$$
score(h_t,\hat h_s)=\begin{cases}h_t^T\hat h_s\\\\h_t^TW_a\hat h_s\\\\v_a^Ttanh(W_a[h_t;\hat h_s])\end{cases}
$$
对应为dot、general、concat形式。

dot

general

concat

对于输入源的形式可以是：

1. cnn 中不同cnn通道的输出作为输入源，也可以是输出矩阵的一列或一行。
2. rnn/lstm 中，输入源对应于每个时隙的输出。双向RNN中最后两层输出的concat。



为什么会work？

1. 由 attention vector可以知道，相当于增加的了更多的特征。
2. 引入浅层的信息，浅层更具有区分性，深层信息更有抽象性和一般性。



attention 分类：

1. hard - attention

    使用值。相关的则设成1。采用多项式分布。一般不用，不可微。

2. soft -attention

     使用概率值。

     考虑到效率。 global和local之分。

### Self-attention 



为啥叫self 呢？

   输入源和输出都是同一个。

**数学上的表达**。

attention vector ：
$$
Attention(Q,K,V)=softmax(\frac{QK^T}{\sqrt{d_k}})V
$$
Q，K，V的维度都是$[t , d_{model}]$,V的维度可以不一样, ，且在transformer中，Q和K是相同的。
$$
Q=\begin{bmatrix}q_{1,1}&q_{1,2}&\cdots&q_{1,t}\\\\q_{2,1}&q_{2,2}&\cdots&q_{2,t}\\\\ \vdots&\vdots&\ddots&\vdots\\\\q_{t,1}&q_{t,2}&\cdots&q_{t,t}\end{bmatrix}=\begin{bmatrix}q_1\\\\q_2\\\\..\\\\q_t\end{bmatrix}\ \ \ ,\ K=\begin{bmatrix}k_1\\\\k_2\\\\..\\\\k_t\end{bmatrix}
$$
那么：
$$
sofmax(\frac{QK^T}{\sqrt{d_k}})=softmax(\begin{bmatrix}q_1k_1&q_1k_2&\cdots&q_1k_t\\\\q_2k_1&q_2k_2&\cdots&q_2k_t\\\\ \vdots&\vdots&\ddots&\vdots\\\\q_tk_1&q_tk_2&\cdots&q_tk_t\end{bmatrix} /\sqrt{d_k})=A
$$
经过softmax之后的矩阵$A$,满足$A=A^T,q_ik_j=a_{i,j}$且维度为$[T,T]$，对任意列或者行的值求和等于1。该计算把所有输出的attention weight都计算了。$AV$得到是最后的context matrix。

**关于**：masked的引入，当前时隙无法获得未来时隙的内容。

例如：计算第1个时隙的attention weight。

有masked：

下三角矩阵
$$
a_{i,j}=\begin{cases}q_ik_j&i>=j\\\\-\infin&j>i\end{cases}
$$

```scala
a_i_j=0
for k <- 0 to T:
    if k<=i:
        a_i_j+=q_i_k * v_j_k
```



为什么 transformer取代lstm，cnn？

1. 更容易获得long-range(时间维度上更广) 的依赖。

     一般的lstm，当前时隙只依赖于前面的时隙，而不能依赖于后面的时隙。如果使用双向lstm才有可能。

2. cnn，单一卷积不能把输入和输出的所有位置联系起来。需要多个位置上连续的卷积。

3. 总的而言，省了计算量。

   反正，结果好，怎么说都是有道理的。

点对点的不是更好，为什么是计算向量之间的score？

   点对点，相当于1*1 的卷积。 向量是有特殊含义的。

# 二 attention分类







1. neural machine translation by jointly learning to align and translate

  作者认为encoder-decoder的方式，中间形成的是固定长度的向量，限制了翻译机结果的提升。因此提出一种方式能够自动搜索源句中与目标词的相关部分。



## 2.1基础的attention结构

### 1.hard attention 、soft attention

   Show, Attend and Tell: Neural Image Caption Generation with Visual Attention

### 2.global attention 、local attention

   Effective Approaches to Attention-based Neural Machine Translation

   neural machine translation by jointly learning to align and translate

​     

### 3.self-attention

​    attention is all you need

​    weighted transformer network for machine translation





## 2.2 组合的attention结构





# 三 应用

**适用于什么场景？**

图片解释，翻译，知识抽象

$$
a_1=V(空间和海洋)\cdot  V(space\  and\  oceans）
$$

$$
context= \hat a_1* V(空间和海洋)+....\\\\
$$


$$
\sigma([context,V(space\  and \ oceans)]) 输出 判断是否该翻译成space\ and \ oceans
$$

$$
score(h_t,\hat h_s)=\begin{cases}V_t H_s\\\\V_t^TW_a H_s\\\\Q_t^Ttanh(W_a[V_t;H_s])\end{cases}
$$

$$
\alpha_{ts}=\frac{exp(score(V_t,H_s))}{\sum_{\hat s}^Sexp(score(V_t,H_{\hat s}))}\\\\V
$$

$$
c_t=\sum_s \alpha_{ts}H_s\\\\
$$

$$
a_t=f(c_t,h_t)=softmax(tanh(W_c[c_t;h_t]))
$$

$$
\hat a_i=\frac{ a_i}{\sum_{j=1}^N a_j}
$$

$$
position\_encoding=\begin{bmatrix}sin(1/10000^{\frac{0}{512}})&cos(1/10000^{\frac{2}{512}})&\cdots &sin(1/10000^{\frac{1024}{512}})\\\\sin(2/10000^{\frac{0}{512}})&cos(2/10000^{\frac{2}{512}})&\cdots &sin(2/10000^{\frac{1024}{512}})\\\\ \vdots&\vdots&\ddots&\vdots\\\\sin(T/10000^{\frac{0}{512}})&cos(T/10000^{\frac{2}{512}})&\cdots &sin(T/10000^{\frac{1024}{512}})\end{bmatrix}
$$


$$
W=\begin{bmatrix}w_{1,1}&w_{1,2}&\cdots&w_{1,t}\\\\w_{2,1}&w_{2,2}&\cdots&w_{2,t}\\\\ \vdots&\vdots&\ddots&\vdots\\\\w_{t,1}&w_{t,2}&\cdots&w_{t,t}\end{bmatrix}
$$

$$
f=\frac{exp(q_ik_i)}{\sum_j^n exp(q_jk_j)}\\\\
\frac{\partial f }{\partial k_i}=\frac{q_i\sum_{j!=i}exp(q_jk_j)}{S^2}
$$



Self-attention : 替换 rnn 、cnn？

1. 解释上。
2. 结构上。

参考：

https://blog.csdn.net/xiewenbo/article/details/79382785

