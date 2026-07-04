---
sidebar_position: 39
draft: true
---

# R 语言 - 软件包



R包是R函数，编码和样本数据的集合。 它们存储在R环境中的名为“`library`”的目录下。 默认情况下，R在安装过程中安装一组软件包。当需要某些特定的目的时，也可根据需要添加更多的包。 当我们启动R控制台时，默认情况下只有默认软件包可用。 已经安装的其他软件包必须明确加载才能被要使用的R程序使用。

R语言中提供的所有软件包均列在[R软件包](http://cran.r-project.org/web/packages/available_packages_by_name.html)中。

以下是用于检查，验证和使用R包的命令列表。

## 检查可用的R包

获取包含R包的库位置：

```r showLineNumbers
.libPaths()
R
```

当我们执行上述代码时，会产生以下结果 - 

```shell
[1] "D:/Program Files/R/R-3.4.1/library"
Shell
```

> 注： 它可能会根据您的个人电脑的本地设置而有所不同。

## 获取所有安装的软件包列表

```r showLineNumbers
library()
R
```

当我们执行上述代码时，会产生以下结果 - 

```shell
图书馆‘D:/Program Files/R/R-3.4.1/library’里有个程辑包：

base                   The R Base Package
boot                   Bootstrap Functions (Originally by Angelo
                       Canty for S)
class                  Functions for Classification
cluster                "Finding Groups in Data": Cluster Analysis
                       Extended Rousseeuw et al.
codetools              Code Analysis Tools for R
compiler               The R Compiler Package
datasets               The R Datasets Package
foreign                Read Data Stored by 'Minitab', 'S', 'SAS',
                       'SPSS', 'Stata', 'Systat', 'Weka', 'dBase',
                       ...
graphics               The R Graphics Package
grDevices              The R Graphics Devices and Support for
                       Colours and Fonts
grid                   The Grid Graphics Package
KernSmooth             Functions for Kernel Smoothing Supporting
                       Wand & Jones (1995)
lattice                Trellis Graphics for R
MASS                   Support Functions and Datasets for Venables
                       and Ripley's MASS
Matrix                 Sparse and Dense Matrix Classes and Methods
methods                Formal Methods and Classes
mgcv                   Mixed GAM Computation Vehicle with
                       GCV/AIC/REML Smoothness Estimation
nlme                   Linear and Nonlinear Mixed Effects Models
nnet                   Feed-Forward Neural Networks and Multinomial
                       Log-Linear Models
parallel               Support for Parallel computation in R
rpart                  Recursive Partitioning and Regression Trees
spatial                Functions for Kriging and Point Pattern
                       Analysis
splines                Regression Spline Functions and Classes
stats                  The R Stats Package
stats4                 Statistical Functions using S4 Classes
survival               Survival Analysis
tcltk                  Tcl/Tk Interface
tools                  Tools for Package Development
translations           The R Translations Package
utils                  The R Utils Package
Shell
```

> 注： 它可能会根据您的个人电脑的本地设置而有所不同。

获取当前在R环境中加载的所有包

```r showLineNumbers
search()
R
```

当我们执行上述代码时，会产生以下结果 - 

```shell
[1] ".GlobalEnv"        "package:stats"     "package:graphics" 
[4] "package:grDevices" "package:utils"     "package:datasets" 
[7] "package:methods"   "Autoloads"         "package:base"
Shell
```

> 注： 它可能会根据您的个人电脑的本地设置而有所不同。

## 安装新软件包

有两种方法来添加新的R包。 一个是从CRAN目录直接安装，另一个是将软件包下载到本地系统并手动安装。

**从CRAN直接安装**

以下命令直接从CRAN网页获取包，并将包安装在R环境中。 可能会提示您选择最近的镜像。 选择适合您所在位置的一个。

```r showLineNumbers
#install.packages("Package Name")

# Install the package named "XML".
install.packages("XML")
R
```

**手动安装包**
转到链接[R包下载](http://cran.r-project.org/web/packages/available_packages_by_name.html)需要的包。 将软件包作为`.zip`文件保存在本地系统的合适位置。

现在，您可以运行以下命令在R环境中安装此软件包。

```r showLineNumbers
install.packages(file_name_with_path, repos = NULL, type = "source")

# Install the package named "XML"
install.packages("E:/XML_3.98-1.3.zip", repos = NULL, type = "source")
R
```

## 加载包到库

在代码中可以使用包之前，必须将其加载到当前的R环境中。还需要加载先前已安装但在当前环境中不可用的软件包。

使用以下命令加载程序包 -

```r showLineNumbers
library("package Name", lib.loc = "path to library")

# Load the package named "XML"
install.packages("D:/XML_3.98-1.3.zip", repos = NULL, type = "source")
```



