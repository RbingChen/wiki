---
title: "使用simiki 进行wiki搭建"
layout: page
date: 2018-10-12 11:21
---

[TOC]



### 一 Simiki

---

​       [simiki](http://simiki.org/zh-docs/)是一个简单好用的Wiki框架。使用[Markdown](https://daringfireball.net/projects/markdown/)书写Wiki, 生成静态HTML页面。Wiki源文件按**目录分类**存放, 方便管理维护。



### 二 搭建过程

#### 1.github上相关仓库的申请

```
 申请  username.github.io 和 wiki 仓库
```

#### 2. Simiki 安装

```bash
mac下 使用 sudo pip install simiki 安装 simiki
```

#### 3.初始化

```bash
1. 仓库初始化
	git clone git@github.com:GithubUserName/wiki.git
	git checkout -b gh-pages
2. 如果不存在master分支，则切换并新建master分支，否则只需要切换即可
   切换: git checkout master 
   切换并创建：git checkout -b master
```

#### 4.部署及提交

 这里用下我[mentor](https://tracholar.github.io/wiki/web/simiki.html)的脚本。

 在wiki下新建文件 deploy.sh ,内容如下：

```bash
if [ "$1" = "-i" ]
then
    mkdir output
    cd output
    git clone -b gh-pages git@github.com:tracholar/wiki.git ./
    cd ..
    exit 0
elif [ "$1" = "" ]
then
    echo deploy [Option]
    echo "       -i 初始化"
    echo "       message  提交到github并发布，提交信息为mesage"
    exit 0
else
    git add . --all
    git commit -am "$1"
    git pull origin master
    git push origin master

    simiki g
    cd output
    mkdir src
    cp ../src/*.html src/
    cp ../src/*/*.html src/
    git add . --all
    git commit -am "$1"
    git pull origin gh-pages
    git push origin gh-pages
    cd ..
fi
```

**命令**

```bash
1. 使用 sh deploy.sh -i 初始，只需要初始化一次。
2. 使用 sh deplot.sh "message" 提交到github。可以通过username.github.io/wiki 来看效果
```

#### 5 本地预览

因为github对国内不友好，为了方便可以现在本地预览效果。

使用终端进入wiki目录下，输入如下命令：

```bash
simiki g
simiki p 
```

此时可以在浏览器 通过 127.0.0.1：8000 来观看效果。