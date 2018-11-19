---
title: "python核心技术编程笔记"
layout: page
date: 2018-11-14 11:19
---

[TOC]

温故而知新。

# 第一章 





# 第二章 快速入门





# 第三章 Python基础

## 1.特殊符号

```python
# 注释
\ 表示继续上一行
```

## 2.关键字

```python
几个不熟悉的关键字
with assert del  exec yield 
```

## 3.内存管理

```
引用计数、循环引用垃圾收集器(处理至少两个对象的互相引用)
del 语句
```



# 第四章 Python对象

## 1.基础

Python 对象三个特性：

身份：每个对象有唯一的标识的自己的值，可以通过内建函数id()来获得。

类型：对象的类型决定对象可以保存的类型值。type() 来查看。

值： 具体的数据项

```python
>>> id(a)
4444827080
>>> type(a)
<type 'str'>
>>>type(type(a)) #所有类型的对象都是type
<type 'type'>
>>>type(a).__name__
'str'
```

对象的属性：函数和方法。

## 2.类型

```python
"""
标准类型： Integer、Boolean、Long integer、Float、Complex number、String、Tuple、Dictionary
其他：type类型、None(Null对象)、文件、集合、函数、模块、类
内部类型：代码、帧、跟踪记录、切片、省略、Xrange
```



```python
判断对象是否相同
a is b 或者 id(a)==id(b)
```

## 3.内建函数

```python
cmp(obj1,obj2) 
"""
repr(obj) 、`obj`  、str(obj)  返回字符串.三者大部分情况下没有区别。
通常有 repr==eval(repr(obj)),而str不行，str面向输出，repr面向python
"""
type(obj)
```



```python
type()  isinstance()
import types
>>dir(types)#可以看到所有的类型
```

## 4.类型工厂

```
int() long()  float()  complext()  str()  unicode()  basestring()
list() tuple() type()
dict() bool()  set() frozenset() object() classmethod()  staticmethod()  super()
property() file()
```



## 5.标准类型的分类

```python
"""
1. 以存储模型为标准的类型分类。 是否能够容纳多个值。
   标量/原子类型：数值 字符串。 
   容器类型： 列表、元组、字典

2.以 更新模型为标准。
   可变类型： 列表、字典
   不可变类型：数字、字符串、元组
>>> i=0
>>> id(i)
140583729413952
>>> i=i+1
>>> id(i)
140583729413928
3. 访问类型。
 直接访问： 数字
 顺序访问：字符串、列表、元组
 映射访问：字典
```

```python
"""
对象缓存问题。 认为整数在小于某个值时，进行缓存。而浮点数，用的不多，所以不缓存。
"""
>>> a=10 >>> b=10 >>> c=100 >>> d=100 >>> e=10.0
>>> f=10.0 
>>> a is b
True
>>> c is d
True
>>> e is f
False
>>> b=11
>>> a is b
False
>>> g=101 >>> k=101
>>> g is k
True
>>> g=11111111  >>> k=11111111
>>> g is k
False

```

# 第五章 数字

```python
from __future__ import divison
>>1/2
0.5
```

``` python
进制转换
hex() oct() chr() ord() unichr()

round(float,ndig=1) #保存ndig小数点的位数
```



# 第六章序列

序列，元组，字符串

共同：切片。正向切片、反向切片。 元素访问。



## 1.一些函数

```python
enumerate() 返回 index 和 item
reversed()
sorted(iter,func=None,key=None,reverse=False)
>>>sorted(map.item(),key=lambda x:x[0])

zip([it0,it1,it3...]) #一起遍历
```

```python
#字符串删除
>>> str1="abcdefg"
>>> str1=str1[:1]+str1[2:]
>>> str1
'acdefg'
```

<img src="/wiki/static/images/PythonString函数.png" alt="String函数" />

<img src="/wiki/static/images/PythonString函数2.png" alt="String函数" />

## 2.字符串

### 2.1字符串编解码

```python
"""
前缀 u 用来修饰 Unicode
str() chr()  用 unicode() unichar()代替
decode()   encode()

open打开文件只能写入str类型,不管字符串是什么编码方式
codes.open(file,权限,编码类型) #'utf-8' 'gbk'
```

Codes 模块：定义了文本跟二进制的转换方式。

### 2.2字符串的一些库

```
base64   Base 16、32、64 编解码库
codes    解码器注册和基类
hashlib  多种不同安全哈希算法和信息摘要算法的APi
StringIO 字符串缓冲对象
```

##  3 列表

### 3.1 列表内建函数

```python
list.append()
list.count()
list.extend(Seq)# 把序列内容加入Seq中去
list.index(obj,i,j)
list.insert(index,obj)
list.pop(index=-1)#默认最后一个
list.remove(obj) 
list.reverse()
list.sort(func=NOne,key=None,reverse=False)
```

## 4.元组

元组是不可变对象。如果更新，则需要改变值。

和数组很像。







# 第七章映射和集合



# 第八章 循环和条件

# 1.else 和 pass

```python
pass 语句，表示，啥也不干。

if statement:
    pass

def func:
    pass
```



```
else 在while和for中使用。

for i in range(10)：
    do ...
else:
	do ..
```

## 2.迭代器

序列：

```python
>>> str1=["ab","cd","ef"]
>>> k=iter(str1)
>>> k.next
>>> k.next()
'ab'
>>> k.next()
'cd'
```

集合：

```python
# Dict.iterkeys()、Dict.itervalues()、Dict.iteritems()
# Dict.has_key()=> key in Dict
>>> dic={"acb":1,"ds":2}
>>> for key in dic:
...     print(key,dic[key])
... 
('acb', 1)
('ds', 2)
>>> t=dic.iterkeys()
>>> t.next()
'acb'
>>> t1=dic.itervalues()
>>> t1.next()
1
>>> t1=dic.iteritems()
>>> t1.next()
('acb', 1)
>>> tt=iter(dic)
>>> tt.next()
'acb'
```

文件：

```python
文件对象的生成会自动调用readline()方法。
>> fid=open("abc.txt")
>> for line in myFile:
       print(line)
```

如何创建：

```python
iter(obj)
iter(func,sentinel)
```

## 3.列表解析

```python
[expr for iter_var in iterable if cond_expr]
"""
[ [x for x in range(s)] for s in range(4)]
[for x in list]
[(x,y) for x in list1 for y in list2]
```

## 4.生成器

和列表解析很相似，基本语法相同，但是不创建真正的数字列表，返回一个生成器。计算一个条目之后，把该条目yield（产生）出来。生成器表达式使用了延迟计算（lazy evaluation），节省了内存。

```python
(expr for iter_val in iterable if cond_expr)
"""
 g = (x * x for x in range(10))
 >>next(g)
 >>0
""" 
generator保存的是算法，每次调用next(g)，就计算出g的下一个元素的值，直到计算到最后一个元素，没有更多的元素时，抛出StopIteration的错误。
 def fib(max):
    n, a, b = 0, 0, 1
    while n < max:
        yield b
        a, b = b, a + b
        n = n + 1
    return 'done'
如果有 yield 关键字，则构成generator。
```

## 5 itertools 模块



# 第九章 IO



# 第十章 异常



# 第十一章 函数式



# 第十二章 模块





# 第十三章 面向对象编程





# 第十四章 执行环境



# 第十五章 正则