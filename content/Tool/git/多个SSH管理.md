---
title: "多个SSH 管理"
layout: page
date: 2018-10-12 11:21
---

[TOC]



## 一 目的

---

​       公司使用的git和github的，对应不同邮箱，并且公开的权限不同，因此需要并存两个的对应ssh公钥，一个用于公司，一个用于github



## 二 解决

生成两个公钥，并在声明两个公钥分别用于哪个网站的代码提交。

```bash
ssh-keygen -t rsa -C "xxxx@126.com"
```

在**生成的过程中注意，会提示输出公钥的文件名**，一般可以用 id_rsa_xxx 来命名。然后生成第二公钥。

```bash
配置文件，指定网站对于的公钥。
1. cd ~/.ssh
2. vi config
3. 在config中输入如下：
# git 
    Host git.company.com
        HostName git.company.com  
        PreferredAuthentications publickey
        IdentityFile ~/.ssh/id_rsa_company
        User xxxx
    
# github
    Host github.com
        HostName github.com
        PreferredAuthentications publickey
        IdentityFile ~/.ssh/id_rsa_github
        User xxxx
        
4.ssh key list 添加 rsa
>>ssh-add ~/.ssh/id_rsa_github
>>ssh-add ~/.ssh/id_rsa

5.在对应网站的ssh key填写栏 中把 id_rsa_xxx.pub 中内容复制过去。github的在 settings里面
6. 使用 ssh -T -v git@github.com  或 ssh -T -v git@git.company.com 来检验是否可访问 
     如果有问题，-v 会打印相关信息，一般是config配置问题，或者是网络受限。
```

## 三其他

如果出现如下错误，

```bash
git@github.com: Permission denied (publickey).
fatal: Could not read from remote repository.

Please make sure you have the correct access rights
and the repository exists.
git@github.com: Permission denied (publickey).
fatal: Could not read from remote repository.
```

并且 ssh -T -v git@github.com的结果如下（GitHub does not provide shell access，这个可以忽略)：

```bash
You've successfully authenticated, but GitHub does not provide shell access.
debug1: channel 0: free: client-session, nchannels 1
Transferred: sent 2644, received 1768 bytes, in 0.6 seconds
```

可以再使用如下命令：

```bash
>>ssh-add ~/.ssh/id_rsa_github
>>ssh-add ~/.ssh/id_rsa
```

