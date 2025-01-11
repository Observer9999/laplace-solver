# laplace-solver
微分方程快速算法大作业
代码结构说明
一，solver1
solver1是实现积分方程方法的函数，接口为solver1(node,g,n)，其中node为多边形区域的顶点，按照逆时针方向排列，g为边界函数值，n为每条边的离散点数。

其内调用GLnodes，outer\_normal，isinside三个子函数。
1，GLnodes
GLnodes是生成高斯勒让德节点的函数，接口为GLnodes(n,a,b)，其中n为节点数量，a和b是区间端点。
2，outer\_normal
outer\_normal是根据node返回每条边的单位外法向量的函数，接口为outer\_normal(node),其中node为多边形区域的顶点。
3，isinside
isinside是判断给定点x是否位于由node所定义的多边形区域中的函数，并且对于凹多边形仍然成立，接口为isinside(node,x)。

二，solver2
solver2是实现有理函数逼近方法的函数接口为solver2(node,g,n,tol)，其中node为多边形区域的顶点，按照逆时针方向排列，g为边界函数值，n为每个角的聚集极点数，tol是求解最小二乘时的容差上限。

其内调用GLnodes，dire\_generator，polar\_generator，isinside四个子函数。
1，GLnodes
GLnodes是生成高斯勒让德节点的函数，接口为GLnodes(n,a,b)，其中n为节点数量，a和b是区间端点。
2，dire\_generator
dire\_generator是根据输入点生成角平分线方向的函数，接口为dire\_generator(x,y,z)，生成角y处的角平分线。
3，polar\_generator
polar\_generator是生成多边形节点node外聚集极点的函数，接口为polar\_generator(node,N,sigma)，其中node为多边形区域的顶点，N为每个角处极点的个数，sigma是极点间距的伸缩尺度。
4，isinside
isinside是判断给定点x是否位于由node所定义的多边形区域中的函数，并且对于凹多边形仍然成立，接口为isinside(node,x)。
