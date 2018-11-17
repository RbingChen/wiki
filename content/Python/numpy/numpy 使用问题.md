---
title: "numpy使用问题"
layout: page
date: 2018-10-24 19:36
---

[TOC]



## 1.数组创建

```python
#一个是 维度的使用不一样
a=np.random.randn(2,3)
a=np.zeros((2,3))

```



## 2.维度问题

在使用concatenate() 、vstack()、hstack()时，需要保持维度一致。

```python
 # (4,)  和  (4,1) 区别 是什么
 >>> t=np.linspace(1,3,num=4)
>>> t.shape
(4,)
>>> t[:,np.newaxis]
array([[1.        ],
       [1.66666667],
       [2.33333333],
       [3.        ]])
>>> t[:,np.newaxis].shape
(4, 1)
```



## 3.np.dot  vdot  inner outer matmul multiply和*

向量乘法、点乘、内积、外积、对应元素相乘

```python
>>a=np.array([1,2,3])
>>a.shape
>>> b=np.array([[1,2,3]])
>>> c=np.array([[1],[2],[3]])
>>> a.shape,b.shape,c.shape
((3,), (1, 3), (3, 1))
```

如上面的例子。

```python
np.dot(x,y)
"""
如果x和y是一维的向量，那么计算内积。
如果有一个是二维的向量，那么按照2 矩阵乘法处理，此时需要满足，x必须是2维的，且x.shape[1]=y.shape[0]
"""
>>> np.dot(a,b)
Traceback (most recent call last):
  File "<stdin>", line 1, in <module>
ValueError: shapes (3,) and (1,3) not aligned: 3 (dim 0) != 1 (dim 0)
        
>>> np.dot(a,c)
array([14])
#矩阵乘法
>>> np.dot(b,c)
array([[14]])
# 矩阵乘法
>>> np.dot(c,b)
array([[1, 2, 3],
       [2, 4, 6],
       [3, 6, 9]])

>>> np.dot(b,a)
array([14])


```

```python
"""
* 如果两者的维度一模一样，则，相当于一一对应的乘法；否则很复杂。
满足交换律。
用 * 请慎重。
基本等同于 multiply
"""
>>> a*b   # b*a
array([[1, 4, 9]])
>>> a*c   #c*a
array([[1, 2, 3],
       [2, 4, 6],
       [3, 6, 9]])
>>> b*c   #c*b
array([[1, 2, 3],
       [2, 4, 6],
       [3, 6, 9]])
>>> b*b
array([[1, 4, 9]])
>>> c*c
array([[1],
       [4],
       [9]])
```

```python
"""
vdot 计算dot product 。可以处理多维情况，复数。不能做矩阵乘法
保证元素个数相同即可。先把向量展成1-D的向量再进行计算。
inner : 不能处理复数的情况
"""
>>> np.vdot(a,b),np.vdot(a,c),np.vdot(c,b),np.vdot(b,c)
(14, 14, 14, 14)

```

```python
"""
  matmul 矩阵乘法。
  如果 第一个参数或者第二参数是 1-D,会自动处理成2-D的。
"""

```

   

```python
"""
outer  和 数学定义的外积不一样。
result[i][j]=a[i]*b[j] 。扩充维数。
"""
```

