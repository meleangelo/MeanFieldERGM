---
output:
  html_document: default
  pdf_document: default
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

The tables in the paper with Monte Carlo estimation exercises were obtained with the following code:  

***Small networks*** with $n<500$ use: [parallel_monte_carlo.R](parallel_monte_carlo.R)  
This code simulates many networks and estimate the parameters. This is all done in parallel but the output for each network is not saved. The final output with all the simulations is saved.   

***Larger networks*** with $n\geq 500$ use: [parallel_monte_carlo_large.R](parallel_monte_carlo_large.R)  
This code works as the previous one. However, since it takes significantly longer to simulate networks and estimate the models, it saves each network and output of estimation. 


***NOTE:*** There is no difference in methods of estimation of simulation between the two codes. One can use the second one also for small networks. The only difference is in how the code handles the simulation output. 

***NOTE:*** the simulations may run for long time. Estimation with $n=1000$ running on a Windows machine with 40 cores takes about 1 day.


