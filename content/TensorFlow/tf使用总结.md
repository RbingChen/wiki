---
title : "TensorFlow使用总结一"
layout : page
date : 2019-02-20 14:01
---



# 一 mnist 数据



```python
from tensorflow.examples.tutorials.mnist import input_data
data=input_data.read_data_sets(datapath,one_hot=True)
"""
 对 数据进行处理
 卷积网络的情况下需要转换为二维的数据
"""
batch_imgs,y = data.train.next_batch(batch_size)
		
batch_imgs = np.reshape(batch_imgs, (batch_size, size, size, channel)) 
		
    
```



```python
from tensorflow.examples.tutorials.mnist import input_data
import numpy as np

prefix="./data"
class mnist():
    def __init__(self, flag='conv', is_tanh = False):
        datapath = prefix + 'mnist'
        self.X_dim = 784 # for mlp
        self.z_dim = 100
        self.y_dim = 10
        self.size = 28 # for conv
        self.channel = 1 # for conv
        self.data = input_data.read_data_sets(datapath, one_hot=True)
        self.flag = flag
        self.is_tanh = is_tanh

    def __call__(self,batch_size):
        batch_imgs,y = self.data.train.next_batch(batch_size)
        if self.flag == 'conv':
            batch_imgs = np.reshape(batch_imgs, (batch_size, self.size, self.size, self.channel))
        if self.is_tanh:
            batch_imgs = batch_imgs*2 - 1
        return batch_imgs, y
    
"""
  使用 data[batch_size]进行数据调用
"""

```

