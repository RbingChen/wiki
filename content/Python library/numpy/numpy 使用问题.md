---
title: "numpy使用问题"
layout: page
date: 2018-10-24 19:36
---



## 1.数组创建

```python
#一个是 维度的使用不一样
a=np.random.randn(2,3)
a=np.zeros((2,3))

```



## 2.维度问题



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

