---
title : "Deep Structured Semantic Models"
layout : page
date : 2019-06-10 14:20
---



information Retrieval：匹配的关键是把query和document映射到同一个语义空间。

出发点：解决query-docment 匹配问题，给定query，从海量doc中选取最可能点击的topK 个docment。
目标：把query 和doc  映射到同一个语义空间，同空间内使用距离公式等到两者的距离以衡量相似度。

问题：

​     1、余弦为什么能衡量相似度？

​     2. DSSm

# 研究现状

非监督学习： LSA（SVD）、TF-IDF、LDA、DAE 是，和  information retrieval的target 松耦合，建模点击，但是没有用到建模这个强信号量。

监督学习:BLTM、DPM。前者使用点击数据，采用最大似然建模，不能体现rank；后者不适合大规模运算。

 



# 参考文献

1. <https://www.cnblogs.com/wmx24/p/10157154.html>

  2.<http://www.wangqingbaidu.cn/article/dlp1516351259.html>