---
title : "Neural Machine Translation"
layout : page
date : 2018-11-16 16:48
---



[TOC]

## 一概念

使用Seq2Seq方法进行机器翻译：NMT（Neural Machine Translation）。



## 二 训练

<img src="/wiki/static/images/NMT训练图.png" alt="NMT训练图" />

1.注意图中$|V|$代表语料的大小，也就是训练集中词的多少，中文中是不是字（可能是词）。

2.encoder和decoder的隐藏层之间不一定要有连接。可以是encoder端输出一组概率值给decoder即可。

3.<s>表示终止符号。

## 三 推断

<img src="/wiki/static/images/NMT推断图.png" alt="NMT推断图" />

1. 输入待翻译的句子，编码段输出一组值，和训练时并没有区别。

2. 注意解码，是按一个一个字进行解码的。解码后字作为下个要解码一个词的输入。

     
   $$
   y_1 = arg max\ \ P(y_1|h_e)
   $$
   

## 四 相关资料

1.[Google NMT Tutorial](https://github.com/tensorflow/nmt)

2.

