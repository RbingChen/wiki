---
title : "rpc入门"
layout : page
date : 2019-06-12 16:20
---

[TOC]



# 一 Thrift

## 安装

直接安装

```bash
brew install  thrift 
# 需要依据提示设置一些环境变量
```

使用官网的源码包安装问题会比较多。`<http://thrift.apache.org/tutorial/>`

```bash
1. Bison version 2.5 or higher must be installed on the system。
# 这个问题可以通过  brew install  Bison 解决
2. fatal error: 'boost/tokenizer.hpp' file not found #include <boost/tokenizer.hpp>
#  安装低版本的 thrif 可以解决。如 0.9.2 版本
```

## 基础知识

RPC作用：`抽象底层调用，封装模板化，屏蔽通讯细节`。

### RPC概念

RPC, 远程过程调用（Remote Procedure Call，RPC）是一个计算机通信协议，该协议允许运行于一台计算机的程序程调用另一台计算机的上的程序。通俗讲，RPC通过把网络通讯抽象为远程的过程调用，**调用远程的过程就像调用本地的子程序一样方便，从而屏蔽了通讯复杂性，使开发人员可以无需关注网络编程的细节**，将更多的时间和精力放在业务逻辑本身的实现上，提高工作效率。

RPC本质上是一种 Inter-process communication（IPC）——进程间通信的形式。常见的进程间通信方式如管道、共享内存是同一台物理机上的两个进程间的通信，而RPC就是两个在不同物理机上的进程之间的通信。概括的说，RPC就是在一台机器上调用另一台机器上的方法，这种调用在远程机器上对代码的执行就像在本机上对代码的执行一样，只是迁移了一个执行环境而已。

RPC是一种C/S架构的服务模型，server端提供接口供client调用，client端向server端发送数据，server端接收client端的数据进行相关计算并将结果返回给client端。

## RPC工具

RPC 工具大都使用 接口描述语言（IDL，interface description language）来提供跨平台的服务调用。



# 二 服务端程序

## 服务请求处理接口



```java
class HelloServiceImpl implements Hello.Iface {} // 实现了Iface 接口 //请求处理类。
Hello.Processor tprocessor = new Hello.Processor<Hello.Iface>(new HelloServiceImpl());
```

## 服务器启动

```java
TServerSocket serverTransport = new TServerSocket(9898); // 设置端口
TServer.Args tArgs = new TServer.Args(serverTransport);// 设置服务器参数
tArgs.protocolFactory(new TBinaryProtocol.Factory());// 设置输入输出流协议
TServer server = new TSimpleServer(tArgs.processor(tprocessor)); // 新建服务器
server.serve();// 启动服务器
```



# 三 客户端程序

```java
TTransport transport = new TSocket("localhost", 9898, 30000);# 端口号和协议要与服务端一致
TProtocol protocol = new TBinaryProtocol(transport);
Hello.Client client = new Hello.Client(protocol); // 得到客户端程序
transport.open();// 打开服务
System.out.println(client.helloString("yes!"));
       // 调用注册的方法。 发送信息、并接受客户端返回内容
```



# 四 总结与理解

RPC：可以理解为 执行一个方法，响应发生在远端，并返回相应接口。类比`hope`

写一个thrift 程序，需要做什么：

1. 服务器端实现一个类来处理接口请求。
2. 服务器端启动端口监听。
3. 客户端启动，并发送请求。

注意点：客户端和服务器端接口和协议要保持一致。

# 参考文献

1.[Thrift RPC详解](http://zheming.wang/blog/2014/08/28/94D1F945-40EC-45E4-ABAF-3B32DFFE4043/)

2.[RPC详解](https://waylau.com/remote-procedure-calls/)