---
title : "git备忘录"
layout : page
date : 2018-12-04 19:11
---



# 一 fork别人的代码怎么进行更新

1. 删库重新fork。

2. 当需要你进行代码提交的时。

   ```bash
   git remote add abc git@github.com:xxx/xxx.git
   git pull abc master
   ```

   

# 二 强制覆盖本地代码，即使修改了

```bash
git fetch --all
git reset --hard origin/master
```

