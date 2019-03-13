---
title : "python积累-collections"
layout : page
date : 2018-12-28 14:19
---

[TOC]



# 一 元组命名



```python
import collections

xy=collections.namedtuple('xy',['x','y'])
co=xy(10,20)
print(co.x,co.y)
>>(10,20)
print(xy)
>>xy(x=10,y=20)

```

