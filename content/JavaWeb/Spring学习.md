---
title : "spring学习"
layout : page
date : 2019-06-14 10:20
---

[TOC]

服务化，给定统一入口。

# Spring介绍

`spring MVC`:Model+View+Controller。数据模型+视图+控制器。

M:Model类，用来和V做数据交互和通信

V:指视图页面，包含JSP、freeMaker、Velocity等。

C:控制器，Spring MVC 注解Controller的类。



## web程序

服务端main函数启动程序，启动对端口的监听。依据请求返回相应数据。



# Maven配置

踩坑记录：

~/.m2/settings.xml文件配置maven的库信息。

错误`Could not transfer artifact org.springframework.boot:spring-boot-starter-parent`。解决办法：增加镜像源。

```xml
<mirror>
      <id>mirrorId</id>
      <mirrorOf>central</mirrorOf>
      <name>Human Readable Name for this Mirror.</name>
      <url>http://central.maven.org/maven2/</url>
 </mirror>
```



# Spring Boot入门程序

Spring boot 可选择内嵌Tomcat、Jetty、Undertow，无需以war包的形式部署项目。提供基于http、ssh、telnet对运行时的项目进行监控。提倡使用java配置和注解配置组合，不需要XML配置。

## 配置

### Maven配置

pom.xml配置，`spring-boot-starter-parent`是一个特殊的starter，提供相关的默认依赖，使用之后，其他包依赖可以省去version标签。

```XML
<parent>
        <groupId>org.springframework.boot</groupId>
        <artifactId>spring-boot-starter-parent</artifactId>
        <version>2.1.4.RELEASE</version>
</parent>
```

web依赖：

```xml
  <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-web</artifactId>
  </dependency>
```

Spring boot编译插件：

```xml
 <build>
        <plugins>
            <plugin>
                <groupId>org.springframework.boot</groupId>
                <artifactId>spring-boot-maven-plugin</artifactId>
            </plugin>
        </plugins>
    </build>
```

### 常规属性配置

配置文件，`application.properties`或者`application.yml`。放置在`src/main/resources`或者`config`目录下。

## 启动代码

```java
@RestController
@SpringBootApplication
public class Application {
    @RequestMapping("/")  
    // 这个注解有点像是设置具体哪个链接做什么动作。对应 http://localhost:8080。 注意必须是唯一的。
    String index() {
        return "Hello,Spring boot";
    }

    public static void main(String[] args) {
        SpringApplication.run(Application.class, args);
    }
}
```

main方法作为项目启动的入口。



## 常用注解

### SpringBootApplication 

 核心注解，开启自动配置。组合了`Configuration`、`EnableAutoConfiguration`（ 让 Spring Boot根据类路径中的jar包依赖为当前项目进行自动配置 ）、 `ComponentScan`。



