---
title : "1. Overview"
layout : page
date : 2018-12-05
---

[TOC]



# 一 Graphs  and  Sessions

**TensorFlow separates definition of computations  from their execution**

​												—"操作定义和执行是分开"

第一步：aseemble a graph

第二步：use a session  to execute operations in the  graph

<img src="/wiki/static/images/tf_graph.png" alt="graph图" />



# 二 tensor 定义

```python
 0-d tensor : scalar、number
 1-d tensor : vector 
 2-d tensor : matrix
 ........
```

```python
Nodes: operators, variables, and constants ，节点是操作、变量、常数
Edges: tensors ，边是张量
Tensors are data.
TensorFlow = tensor + flow = data + flow  
```

创建session，在session中执行图，并得到（fetch）相关值

```python
"""
sess=tf.Session()
print(sess.run(a))
sess.close()
"""
或者 with 取代Session的关闭操作。
"""
with tf.Session() as sess:
     print(sess.run(a))
"""
```

多个值的返回

```python
a,b=sess.run([a,b])
#tf.Session.run(fetches,feed_dict=None,options=None,run_metadata=None)
```



# 三 几个例子

## 1.常数存储在节点中

```python
c=np.random.randn()
d=np.random.randn()
print(" c :  ",c,"  d  :",d)
cd=tf.add(c,d)
with tf.Session()  as  sess:

      print("c + d = ",sess.run(cd))
      c=np.random.randn()
      d=np.random.randn()
      print(" c :  ",c,"  d  :",d)
      print("c + d = ",sess.run(cd))

result:
(' c :  ', 0.719425201469747, '  d  :', 1.2240380122046652)
('c + d = ', 1.9434632)
(' c :  ', 0.7712514317966279, '  d  :', -0.0561853883799071)
('c + d = ', 1.9434632)
```

正常，认为 c+d 更新了，那么d的值应该会变。但是实际graph 中，节点(nodes)已经存储了c,d( contants)的值，用来做计算。

## 2.惰性计算