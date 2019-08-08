---
title : "Hive函数使用备忘录"
layout : page
date : 2019-07-11 18:36
---



# 一 Json对象解析

```sql
 select get_json_object('{\"item_id\":\"-9999\"}','$.item_id') 
```

<https://www.cnblogs.com/xd502djj/p/6962040.html>