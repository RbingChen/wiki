---
title: "numpy API 使用记录"
layout: page
date: 2018-10-25 16:54
---

[TOC]



## 一.特殊的数及相关函数

```python
1. 特殊的数

numpy.nan 表示 Nan (not a number )
numpy.inf 正无穷
numpy.PINF 正无穷 ,引用的是numpy.inf
numpy.NINF 负无穷

2.判断特殊的数的函数
numpy.isnan(x[,out])：返回x是否是个NaN，其中x可以是标量，可以是数组
#>>numpy.isfinite(x[, out])：返回x是否是个有限大小的数，其中x可以是标量，可以是数组
#>>numpy.isfinite(np.nan)返回False，因为NaN首先就不是一个数
numpy.isposinf(x[, out])：返回x是否是个正无穷大的数，其中x可以是标量，可以是数组
#numpy.isposinf(np.nan)返回False，因为NaN首先就不是一个数
numpy.isneginf(x[, out])：返回x是否是个负无穷大的数，其中x可以是标量，可以是数组
#>>numpy.isneginf(np.nan)  返回False，因为NaN首先就不是一个数
numpy.isinf(x[, out])：返回x是否是个无穷大的数，其中x可以是标量，可以是数组
#numpy.isinf(np.nan)返回False，因为NaN首先就不是一个数

3.替换函数
numpy.nan_to_num(x) 将数组x中的下列数字替换掉，返回替换掉之后的新数组
```



## 二.数组的拼接

```python
"""
numpy.concatenate((a1,a2,...,an),axis=0)  (a1,a2,...,an) 是带拼接的序列，axis表示延哪个拼接。
numpy.vstack((a1,a2)) 相当于 numpy.concatenate((a1,a2,...,an),axis=0)
numpy.hstack((a1,a2)) 相当于 numpy.concatenate((a1,a2,...,an),axis=1)

numpy.column_stack(tup)：类似于hstack，但是如果被拼接的数组是一维的，则将其形状修改为二维的(N,1)。
沿列方向拼接，增加列

numpy.c_对象的[]方法也可以用于按列连接数组。但是如果被拼接的数组是一维的，则将其形状修改为二维的(N,1)。
"""

```

## 三.Padding arrays

```python
>>> a = [[1, 2], [3, 4]]
>>> np.lib.pad(a, ((3, 2), (2, 3)), 'minimum') array([[1, 1, 1, 2, 1, 1, 1],
       [1, 1, 1, 2, 1, 1, 1],
       [1, 1, 1, 2, 1, 1, 1],
       [1, 1, 1, 2, 1, 1, 1],
       [3, 3, 3, 4, 3, 3, 3],
       [1, 1, 1, 2, 1, 1, 1],
       [1, 1, 1, 2, 1, 1, 1]])
"""
上面填充了3行，下面填充了量化。左边填充了2列，右边填充了3列
有顺序要求。
"""
```

