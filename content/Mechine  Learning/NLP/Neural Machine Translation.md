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

3.\<s\>表示终止符号。

**一开始我纳闷为啥输出也参与训练，看完推断的机制就明白了**。

## 三 推断

<img src="/wiki/static/images/NMT推断图.png" alt="NMT推断图" />

1. 输入待翻译的句子，编码段输出一组值，和训练时并没有区别。

2. 注意解码，是按一个一个字进行解码的。解码后字作为下个要解码一个词的输入。

     
   $$
   p(y_1|h_e)\\\\
   p(y_2|h_1,h_e)\\\\
   ....\\\\
   p(y_n|y_{n-1},...,y_1,h_e)
   $$
   如上面数学公式，第一个字只是由encoder段的输出的编码决定，后续的字的翻译由前面的字决定。也就是输出端会接一个softmax，得到在语料上的概率分布。对于选取哪个词有相应的优化方案，

   a. 使用最大概率的那个词作为翻译的决定,并用于下个词的推断，即greedy search。

   b. **Beam Search**(集束搜索)，选取最大的N个（beam width，集束宽，值为1时，和greedy search没有区别)概率的词进入下一个字的推断。

   ```python
   借用下别人的回答。
   """
   beam search只在test的时候需要。训练的时候知道正确答案，并不需要再进行这个搜索。
   test的时候，假设词表大小为3，内容为a，b，c。beam size是2。
   decoder解码的时候：
   1.生成第1个词的时候，选择概率最大的2个词，假设为a,c,那么当前序列就是a,c
   2.生成第2个词的时候，我们将当前序列a和c，分别与词表中的所有词进行组合，得到新的6个序列aa ab ac ca cb cc,然后从其中选择2个得分最高的，作为当前序列，假如为aa cb
   3. 后面会不断重复这个过程，直到遇到结束符为止。最终输出2个得分最高的序列
   ```

   使用Beam Search足够了，全局最优搜索空间太大，且效果并没有很大的提升。

   [viterbi](./搜索近似算法 /Viterbi和BeamSearch.md)（wiki中有viterbi和BS的对比)是全局最优。

其他：attention

<img src="/wiki/static/images/attention.png" alt="attenion图" />

## 四 相关资料

1.[Google NMT Tutorial](https://github.com/tensorflow/nmt)

2.[seq2seq中的beam search算法过程](https://www.zhihu.com/question/54356960)

3.[Seq2seq中的beam search](https://www.zhihu.com/question/54356960)

4.[Google NMT tutorial翻译](https://blog.csdn.net/yc1203968305/article/details/79182494)

