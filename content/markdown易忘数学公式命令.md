---
title: "markdown 数学公式"
layout: page
date: 2018-11-01 18:15
---



## 一 矩阵

```bash
\begin{matrix}
1&2&3\\
4&5&6\\
7&8&9\\
\end{matrix}\tag{1}
```

显示如下
$$
\begin{matrix}
1&2&3\\
4&5&6\\
7&8&9\\
\end{matrix}\tag{1}
$$
matrix 是没有括号的，bmatrix是[], Bmatrix 是{},smallmatrix是()

```bash
\begin{bmatrix}
1&2$3\\
4&5&6\\
7&8&9\\
\end{bmatrix}
```

$$
\begin{bmatrix}
1&2&3\\
4&5&6\\
7&8&9\\
\end{bmatrix}
$$

```
 增加分割线
 \left[
    \begin{array}{cc|c}
      1 & 2 & 3 \\
      4 & 5 & 6
    \end{array}
\right] \tag{7}
```

$$
\left[
    \begin{array}{cc|c}
      1 & 2 & 3 \\
      4 & 5 & 6
    \end{array}
\right] \tag{7}
$$

```bash
省略号
\left[
\begin{matrix}
 1      & 2      & \cdots & 4      \\
 7      & 6      & \cdots & 5      \\
 \vdots & \vdots & \ddots & \vdots \\
 8      & 9      & \cdots & 0      \\
\end{matrix}
\right]
```

$$
\left[
\begin{matrix}
 1      & 2      & \cdots & 4      \\
 7      & 6      & \cdots & 5      \\
 \vdots & \vdots & \ddots & \vdots \\
 8      & 9      & \cdots & 0      \\
\end{matrix}
\right]
$$
https://blog.csdn.net/qq_37656398/article/details/79308997