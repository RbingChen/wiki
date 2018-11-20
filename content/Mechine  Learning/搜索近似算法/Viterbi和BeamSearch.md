---
title : "viterbi 和Beam Search"
layout : page
date : 2018-11-17 18:33
---

[TOC]



# 一 Viterbi算法

  viterbi算法其实就是多步骤每步多选择模型的最优选择问题，其在**每一步的所有选择都保存了前续所有步骤到当前步骤当前选择的**最小总代价（或者最大价值）以及当前代价的情况下前继步骤的选择。依次计算完所有步骤后，通过回溯的方法找到最优选择路径。符合这个模型的都可以用viterbi算法解决。

可以参考：**HMM 的Viterbi解法**、算法导论中 **动态规划 的传送带**的例子。

**和穷举不一样**。假设有$s$层，每一层都有$n$个状态，穷举的话，要计算$n^s$个选择。如果是viterbi的话，只需计算第$j-1$层和第$j$层的计算，计算$n^2$次，总共$s$层，那么计算$sn^2$次。

# 二 Beam Search 

Beam Search 总是走前面topN最好的选择。每一层只保存topN最优的分支。Beam Width越大，得到最优解的概率越大，但相应的计算复杂度越大。

<img src="/wiki/static/images/BeamSearch.png" alt="BeamSearch图" />

# 三 对比

1.Viterbi 能够得到全局最优，BS不一定

2.Viterbi在解决HMM问题的时候，依赖于齐次性（只和前一个状态相关），如果前x个状态出现了某个值会使得选择当前状态的概率变大时，就不能这么做了（比如：在第k个状态出现值s时，第j个状态必然是值c，显然Viterbi不能生效)。BS的假设要求更低，因此也正是因为如此，BS不一定求得最优解。



相关链接：

1. [如何通俗地讲解viterbi算法](https://www.zhihu.com/question/20136144)
2. [Seq2Seq中的Beam Search](https://www.zhihu.com/question/54356960)

