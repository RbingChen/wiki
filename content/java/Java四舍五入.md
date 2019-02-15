---
title: "java四舍五入"
layout: page
date : 2019-01-11 11:05
---



```java
import java.math.BigDecimal;
import java.math.RoundingMode;
import java.text.DecimalFormat;
import java.text.NumberFormat;
```



```java
public static double formatDouble(double d) {
        return (double)Math.round(d*100)/100;
    }
```



```java
 public static double formatDouble(double d) {   
        // 如果不需要四舍五入，可以使用RoundingMode.DOWN
        BigDecimal bg = new BigDecimal(d).setScale(2, RoundingMode.UP);       
        return bg.doubleValue();
    }
```



```java
public static String formatDouble(double d) {
        return String.format("%.2f", d);
    }
```



```java
public static String formatDouble(double d) {
        DecimalFormat df = new DecimalFormat("#.00");
        return df.format(d);
    }
```

