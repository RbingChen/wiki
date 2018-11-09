---
title : "PMML模型部署"
layout : page
date : 2018-11-02 10:19
---



## 一概念

PMML全称预言模型标记模型（Predictive Model Markup Language），以XML 为载体呈现数据挖掘模型。

### 1.头信息-header

```python
"""
http://dmg.org/pmml/v4-3/Header.html
"""
<Header>
		<Application name="JPMML-XGBoost" version="1.2.4"/>
		<Timestamp>2018-10-31T06:18:56Z</Timestamp>
</Header>
```



### 2.数据字典-DataDictionary



### 3.挖掘模式-Mining Schema



### 4.数据转换-Transformations



### 5.模型定义-Model Definition



### 6.平分结果-Score Result











参考资料

1.https://www.ibm.com/developerworks/cn/xml/x-1107xuj/index.html

2.官网定义http://dmg.org/pmml/v4-3/GeneralStructure.html

3.https://blog.csdn.net/c1481118216/article/details/78411200?locationNum=8&fps=1

4.https://tracholar.github.io/wiki/machine-learning/pmml.html

5.https://tracholar.github.io/wiki/pmml/intro.html