---
title : "PCA"
layout : page
date : 2019-03-28 14:01
---

[TOC]



# 一 原理

有$n$维的向量$x_1,x_2,...x_M \in R^n$，使用$k$个$n$维度的向量$v_i,..,v_k \in R^n$来表示$x_m$，即:
$$
x_m \approx \sum_j^k u_{mj}v_j
$$
与`线性回归`：
$$
y_i \approx \sum_j^k w_j x_{ij}
$$
以新的基底来表示向量，得到向量的新坐标。

1. 尽可能让新坐标分开，不重叠。方差大。
2. 空间距离小，损失最小。

## 最大方差

有均值 $\hat{x} =\frac{1}{M}\sum_{m=1}^M x_m$，假设$u_1^Tu_1=1$，这个条件对结果没有映射，更关注于$u_1$的方向。可得映射后的方差为：
$$
\frac{1}{M}\sum_{m=1}^M\{u_1^Tx_m-u_1^T\hat{x}\}^2=u_1^TSu_1
$$
其中协方差$S=\frac{1}{M}\sum_{m=1}^M(x_m-\hat{x})(x_m-\hat{x})^T$。由拉格朗日乘子法有$u_1^TSu_1-\lambda_1(1-u_1^Tu_1)$，得到
$$
Su_1=\lambda_1u_1
$$
要方差最大，则$\lambda_1$必须是最大的特征值（$u_1^TSu_1=\lambda_1u_1^Tu_1=\lambda_1$）。如果有多个$u$向量(向量之间相互正交)，可得如下表达式：
$$
\frac{1}{M}\sum_{m=1}^M(\sum_{i=1}^{k}\{u_i^Tx_m-u_i^T\hat{x}\})^2
$$
如果$x$已经中心化$x_m^{New}=x_m-\hat x$了，有$\hat x^{New}=0$，上等式为$\frac{1}{M}\sum_{m=1}^M(\sum_{i=1}^{k}u_i^Tx_m)^2$，可以看成是单个单个的$u$的求解过程。

## 最小损失

对于$D$向量，其可以至多$D$个线性无关的$D$维向量表示(满秩)，即$x_m = \sum_{i=1}^Dz_{mi}u_i$，$z_{mi}=u_i^Tx_m$为了达到降维的目的，只使用$k$个向量来表示，那么必须保证损失最小：
$$
\frac{1}{M}\sum_{m=1}^M(\sum_{i=1}^Dz_{mi}u_i-\sum_{i=1}^kz_{mi}u_i)^2\\\\
=\frac{1}{M}\sum_{m=1}^M(\sum_{i=k+1}^Du_i^Tx_mu_i)^2
$$
发现和最大方差的推导结果是一样的。

## 误差

如果取k个最大特征值，那么损失为$J=\sum_{i=k+1}^D \lambda_i$。

## 思考

`为什么是特征向量呢？`

PCA 可以认为是用的新的基底来表示向量，怎么直观地理解最后的基底是特征向量构成的。特征向量方向只有模的大小变化，而且是效果明显的，其他向量方向包含了旋转等。模的大小变化更小。

忽略旋转等其他信息，而关注一个矩阵在哪个方向能产生最大的效果。



# 二 实现

看了下sklearn源码，简化了下实现，主要是使用SVD分解进行的:

```python
#coding:utf-8
from scipy import linalg
from sklearn.utils import check_array
import numpy as np
from sklearn.utils.extmath import  svd_flip
from sklearn.utils.validation import check_is_fitted

class my_pca():
    def __init__(self,n_components=None):

       self.copy=True
       self.n_components=n_components

    def fit(self,X):
        self.fit_(X)
        return self
    def fit_(self,X):
        X = check_array(X, dtype=[np.float64, np.float32], ensure_2d=True,
                        copy=self.copy)
        self.mean_ = np.mean(X, axis=0)
        X -= self.mean_
        U, S, V = linalg.svd(X, full_matrices=False)
        components_ = V
        self.components_ = components_[:self.n_components]
        return U, S, V

    def transform(self, X):

        check_is_fitted(self, ['mean_', 'components_'], all_or_any=all)
        X = check_array(X)
        if self.mean_ is not None:
            X = X - self.mean_
        X_transformed = np.dot(X, self.components_.T)
        return X_transformed

    def inverse_transform(self, X):
        return np.dot(X, self.components_) + self.mean
```

例子：

```python
#coding:utf-8
import matplotlib.pyplot as plt
from sklearn import datasets
from sklearn.decomposition import PCA, IncrementalPCA
from pca_demo import my_pca
import numpy as np

iris=datasets.load_iris()
X=iris.data
y=iris.target
target_names=iris.target_names

#pca=PCA(n_components=2)
pca=my_pca(n_components=2)
X_r=pca.fit(X).transform(X)
plt.figure()
colors = ['navy', 'turquoise', 'darkorange']
lw = 2
print(X_r.shape)
print(X.shape)
for color, i, target_name in zip(colors, [0, 1, 2], target_names):
    plt.scatter(X_r[y == i, 0], X_r[y == i, 1], color=color, alpha=.8, lw=lw,
                label=target_name)
plt.legend(loc='best', shadow=False, scatterpoints=1)
plt.title('PCA of IRIS dataset')
plt.show()

X_i=pca.inverse_transform(X_r)
print(" init : ",X[0,:])
print(" inve : ",X_i[0,:])
```



<img src="/wiki/static/images/pca1.jpeg" alt="pca" />

# 三 应用

1. 数据可视化
2. 压缩数据
3. 去噪声

https://blog.csdn.net/hjq376247328/article/details/80640544

https://www.cnblogs.com/jerrylead/archive/2011/04/18/2020209.html