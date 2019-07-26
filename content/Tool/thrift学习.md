---
title : "thrift-Tutorial"
layout : page
date : 2019-06-12 16:20
---

[TOC]



# 一 thrift文件定义

## tutorial文件定义

```bash
/**
 * The first thing to know about are types. The available types in Thrift are:
 *
 *  bool        Boolean, one byte
 *  i8 (byte)   Signed 8-bit integer
 *  i16         Signed 16-bit integer
 *  i32         Signed 32-bit integer
 *  i64         Signed 64-bit integer
 *  double      64-bit floating point value
 *  string      String
 *  binary      Blob (byte array)
 *  map<t1,t2>  Map from one type to another
 *  list<t1>    Ordered list of one type
 *  set<t1>     Set of unique elements of one type
 *
 * Did you also notice that Thrift supports C style comments?
 */

包含其他文件
include "shared.thrift"

打包路径：
namespace java tutorial

typedef i32 MyInteger

 可以定义常数、用 Complex types and structs are specified using JSON notation.
const i32 INT32CONSTANT = 9853
const map<string,string> MAPCONSTANT = {'hello':'world', 'goodnight':'moon'}

枚举：32bit 的整数，值可选，默认1。
enum Operation {
  ADD = 1,
  SUBTRACT = 2,
  MULTIPLY = 3,
  DIVIDE = 4
}

 结构体：可以用来定义复杂结构，每一个域有 整数标识、类型、变量名、可选的默认值。
struct Work {
  1: i32 num1 = 0,
  2: i32 num2,
  3: Operation op,
  4: optional string comment,
}

#Structs can also be exceptions, if they are nasty.
exception InvalidOperation {
  1: i32 whatOp,
  2: string why
}

/**
 * Ahh, now onto the cool part, defining a service. Services just need a name
 * and can optionally inherit from another service using the extends keyword.
 */
service Calculator extends shared.SharedService {

  /**
   * A method definition looks like C code. It has a return type, arguments,
   * and optionally a list of exceptions that it may throw. Note that argument
   * lists and exception lists are specified using the exact same syntax as
   * field lists in struct or exception definitions.
   */

   void ping(),
   i32 add(1:i32 num1, 2:i32 num2),

   i32 calculate(1:i32 logid, 2:Work w) throws (1:InvalidOperation ouch),
  
   oneway void zip()

}
```

## shared 文件定义

```bash
namespace java shared
struct SharedStruct {
  1: i32 key
  2: string value
}
service SharedService {
  SharedStruct getStruct(1: i32 key)
}
```

