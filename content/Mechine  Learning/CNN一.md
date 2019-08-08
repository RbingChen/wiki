---
title : "卷积神经网络的理解"
layout : page
date : 2019-02-18 13:36
---



[TOC]

# 一 问题研究

## 数据增强

- Color Jittering：对颜色的数据增强：图像亮度、饱和度、对比度变化（此处对色彩抖动的理解不知是否得当）；
- PCA  Jittering：首先按照RGB三个颜色通道计算均值和标准差，再在整个训练集上计算协方差矩阵，进行特征分解，得到特征向量和特征值，用来做PCA Jittering；
- Random Scale：尺度变换；
- Random Crop：采用随机图像差值方式，对图像进行裁剪、缩放；包括Scale Jittering方法（VGG及ResNet模型使用）或者尺度和长宽比增强变换；
- Horizontal/Vertical Flip：水平/垂直翻转；
- Shift：平移变换；
- Rotation/Reflection：旋转/仿射变换；
- Noise：高斯噪声、模糊处理；



## CNN 具有平移不变性

不变性的定义：

数据增强 是不是 要避免 做平移操作，因为平移不变性导致的？所以常见一些旋转操作。



平移不变性就是说假如有个给目标提特征的网络，在一个图片里，某个目标在左下角提出来的特征和在右上角提出来的特征是一样的。原因是卷积核提特征是在整个图上滑窗。

在尺度上没有不变性是因为卷积核没有尺度变化，旋转同理，卷积核提特征的时候也不旋转

Pooling操作能部分缓解旋转问题和尺度问题。因为旋转角度小的话，池化后就没有区别了。当然旋转大了池化后也有区别，所以叫部分缓解 

参考：

1. https://github.com/vdumoulin/conv_arithmetic
2. A guide to convolution arithmetic for deep learning
3. https://mp.weixin.qq.com/s/Olliwe3ux77H4Vlsn4IrCw
4. [卷积神经网络为什么具有平移不变性？](https://zhangting2020.github.io/2018/05/30/Transform-Invariance/)
5. [data augmentation 几种方法总结](https://www.cnblogs.com/zhonghuasong/p/7256498.html)
6. [数据增强-知乎](https://zhuanlan.zhihu.com/p/41679153)
7. [既然cnn对图像具有平移不变性，那么利用 图像平移（shift）进行数据增强来训练cnn会有效果吗？-知乎](https://www.zhihu.com/question/301522740)