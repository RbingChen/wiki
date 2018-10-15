---
title: "Intro To Git"
layout: page
date: 2018-10-12 11:21
---

[TOC]



### 一 创建仓库

---



方法一：新建文件夹，然后使用 git init 命令

方法二：git clone 

```bash
 git@github.com:userName/xxx.git
```



### 二 添加和提交

---



<img src="/wiki/static/images/git图1.png" />

本地的git仓库维护三个 代码区域，1.工作目录，持有实际的文件。2.暂存区(Index)，类似于缓存区，临时保存改动。3. HEAD ，指向最后的提交结果。

```bash
在工作目录对文件进行了修改，那么需要提交到暂存区：
     git add <filename>  或者 全部提交  git add *
实际的修改：
     git commit -m "代码修改信息"
此时，代码已经修改到 HEAD 中，但是没有提交到remote 仓库
```

将代码提交到远端仓库

```bash
push：
	git push origin master  或者 git push origin  分支名
如果，没有clone现在的仓库，但想将本地仓库 连接到某个远程的服务器，可以使用如下：
    git remote add origin <server>
```



### 三 分支

---

 分支是用来将特性开发绝缘开来的。在你创建仓库的时候，*master* 是“默认的”分支。在其他分支上进行开发，完成后再将它们合并到主分支上。

<img src="/wiki/static/images/git图2.png" />

```bash
1. 创建分支 feature_x 并切换过去：
	git checkout -b feature_x
2. 切回主分支
	git checkout master
3. 再把主分支删掉
	git branch -d feaute_x
4. 把 分支 push 到远端仓库，不然不可被其他可见
    git push origin <branch>
```

 

### 四 更新和合并

---

```bash
1. 更新本地为最新改动：
	git pull
实际过程为，以现在所在工作目录进行更新获取(fetch)并合并(merge) 远端的改动。
2. 要合并其他分支到当前分支。
	git merge <branch>
```

分支合并时可能存在冲突(conflicts)，需要手动修改文件来解决冲突，修改完之后，使用 git add<filename>命令以标记合并成功。

```bash
合并之前使用如下命令预览差异：
	git diff <source_branch> <target_branch>
```

存在冲突的主要原因是，其他分支存在其他的更新（对某些文件的修改），但是本分支上并没有做出修改。如果是在远端和主分支进行 PR，在进行修改之前，**确保本地仓库是最新的版本**，以避免conflicts 的产生。

### 五 标签

---



   Git tag



### 六 替换本地改动

---



```bash
1. 操作失误的时候，可以使用如下命令来换掉本地的改动：
	git chekout --<filename>
 此命令会使用HEAD 中的最新内容替换掉你的工作目录中的文件。已添加到暂存区的改动以及新文件都不受影响
2.如果想丢弃本地所有的改动，可以到服务器上获取最新的版本历史，并将本地主分支指向其：
 	git fetch origion
 	git reset --hard origin/master
```



### 参考资料：

1.http://www.runoob.com/manual/git-guide/