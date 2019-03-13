---
title : "随机数相关"
layout : page
date : 2019-02-22 15:23
---



[TOC]

# 一 seed

种子相同得到的随机数相同。 

```python
    seed = 547
    np.random.seed(seed)
    np.random.shuffle(X)
    np.random.seed(seed)
    np.random.shuffle(y)
    # 重排得到 训练集和测试集，不需要 合并X，y 进行重排。
```

在一些特征场合，可以固定seed 来调程序。