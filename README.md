---
output:
  pdf_document: default
  html_document: default
---
# MeanFieldERGM
Replication files for Mele and Zhu (2020) - Approximate variational estimation for a model of network formation


## Description
This repository contains the code for replication of the Monte Carlo 
experiments in Mele and Zhu (2020). The code requires the package ```mfergm``` which can be installed from Github.


## Installation of package 
To install the package, please install ```devtools```.

```{r}
install.packages("devtools")
```

There are other packages that are needed for the estimation and other utilities. ```statnet``` allows for estimation of ERGMs using MC-MLE and MPLE methods. ```rootSolve``` is for solving equations. ```optimx``` is the basic optimization package.

```{r}
install.packages("statnet")
install.packages("rootSolve")
install.packages("optimx")
```

To install ```mfergm```, please run the following lines

```{r}
library(devtools)
install_github("meleangelo/mfergm")
```

## Monte Carlo code for estimation

The tables in the paper with Monte Carlo estimation exercises were obtained with the following code

