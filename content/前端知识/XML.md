---
title: "XML 入门"
layout: page
date: 2018-11-02 11:09
---

[TOC]



## 一 简介

XML：被设计用来传输和存储数据

HTML：被设计用来显示数据

> XML：可扩展标记语言（Extensible Markup Language)，设计宗旨是传输数据，而不是显示数据，标签没有被预定义，需要自行定义标签。具有自我描述性。

如下：John 给 George的便签

```xml
<?xml version="1.0" encoding="ISO-8859-1"?>
<note>
<to>George</to>
<from>John</from>
<heading>Reminder</heading>
<body>Don't forget the meeting!</body>
</note>
```

```python
"""
<to> <from> 标签是用户自定义的，因为xml没有预定义这些标签。
HTML中的标签是预定义的，HTML文档只使用在HTML标准中定义过得标签(如<p>、<h1>....)
"""
"""
第一行声明 XML 的版本 (1.0) 和所使用的编码 (ISO-8859-1 = Latin-1/西欧字符集)。
下一行描述文档的根元素
接下来描述四个子元素to、from、heading、body
最后一行以 </note> 结尾
"""
```

### XML 文档形成一种树结构

XML 文档必须包含*根元素*。该元素是所有其他元素的父元素。

XML 文档中的元素形成了一棵文档树。这棵树从根部开始，并扩展到树的最底端。

所有元素均可拥有子元素：

```xml
<root>
  <child>
    <subchild>.....</subchild>
  </child>
</root>
```



## 二 语法

1.所有标签都必须有关闭标签

```xml
错 ：<p> this is begin 
对：<p> this is begin  </p>
```

2.大小写敏感

3.嵌套正确

4.必须有根元素

5.属性值必须加引号

```xml
<note date=08/08/2008>   ==>   <note date="08/08/2008">
<to>George</to>
<from>John</from>
</note> 
```

6.实体引用

```xml
<message>if salary < 1000 then</message>
salary < 1000 的小于号 会导致解析出错，所有需要替换
<message>if salary &lt; 1000 then</message> 
&lt;	<	小于
&gt;	>	大于
&amp;	&	和号
&apos;	'	单引号
&quot;	"	引号
```

7. 注释

   ```xml
   <!-- this is a comment -- >
   ```

8. 空格保留

## 三 基本概念

### 1.元素

是指从（且包括） 开始标签直到（且包括）结束标签的部分

```xml
<p .... </p> 是一个元素，中间省略号是各种其他元素或文本的混合
```

### 2.属性

xml可以在**开始标签**中包含属性，类似于HTML。

```xml
<img src="computer.gif">   ===  "src" 属性提供有关 <img> 元素的额外信息。
```



## 四 其他 

### 1自闭合

```python
<Header>
		<Application name="JPMML-XGBoost" version="1.2.4"/>
		<Timestamp>2018-10-31T06:18:56Z</Timestamp>
</Header>
"""
<Application  /> 自闭合
"""
```

参考：

http://www.w3school.com.cn/xml/index.asp