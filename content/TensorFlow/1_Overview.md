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



# 四 Graph

## 1.图的一部分指定到特定的cpu或者gpu上运行

```python
with tf.device("./gpu:2"):
	a=tf.constant(10,name="a")
	b=tf.constant(102,name="b")
	c=tf.add(a,b)
# 创建一个会话，并把 log_device_placement 设置为True
sess=tf.Session(config=tf.ConfigProto(log_device_placement=True))
print(sess.run(c))
```

问题：GPU怎么命名的？单机上cpu的名字是什么？

## 2.多个Graph

如果Graph 为一个时，采用默认的graph。注意以下问题：

- 需要多个Session来运行多个Graph，并且每个Graph会尽可能使用默认分配的资源

- 不要在图之间的数据传输，否则将不会以并行方式运行

```python
g1=tf.get_default_graph()
g2=tf.Graph()
#默认图
with g1.as_default():
    a=tf.Contant(3)
#创建的图
with g2.as_default():
    b=tf.Contant(3)
```

图的运行：

```python
g2=tf.Graph()
with g2.as_default():
    b=tf.Contant(3)
sess=tf.Session(graph=g2)
print(sess.run(b))
```

需要在Session中指定具体的图。

## 3.Grpah



<img src="/wiki/static/images/whyGraph.png" alt="graph图" />



目前主流的机器学习方法都可以用图来表述。

其次并行化及可微分。



# 五 tensorBoard

```python
writer=tf.summary.FileWriter('path',tf.get_default_graph())
with tf.Session() as sess:
   #writer=tf.summary.FileWriter('path',sess.graph())
```

对会话的图进行存储；对默认图进行存储。

在终端下使用，tensorboard --logdir="path"  --port  6006  ，查看图。

