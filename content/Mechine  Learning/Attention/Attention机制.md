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

    1. 局部和全局。考虑全局的事物或变量对局部的影响，但对于全局来说，全局的小部分对局部的影响是不同。

       

       <img src="/wiki/static/images/attention_equation_1.jpg" alt="翻译"/>

        不使用attention时，$P(y_i|h_i,h_{i-1},...,h_1)$，lstm模型容易导致

        对CNN而言，局部感受野。

    2. 如何衡量全局对局部的影响？

        首先思考全局的表达是什么？CNN而言，可以是浅层或深层的特征表达，lstm，对于时隙变换的集合。

        其次如何衡量，全局不同部分对局部的影响。



适用于什么问题？



为什么nlp的解码端使用lstm？

1. 写字的时候是有顺序的。前面的词的表达对后面的词的表达有影响。
2. nmt的时候，搜索算法。
3. 不用lstm的话，例如cnn，解码的时候，
4. attention

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



参考：

https://blog.csdn.net/xiewenbo/article/details/79382785

