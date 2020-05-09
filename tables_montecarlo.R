## tables for paper

rm(list=ls())
setwd("/Users/Angelo/Dropbox/mfergm/programs/simulations/simulations_dec2019")

####################################################
true_parameters <- c(-3,2,1,3)
####################################################

# n=50
nplayers <- 50
montecarlo_file <- paste("table_n", nplayers, "_nsims500_pars_", 
                         true_parameters[1],"_", true_parameters[2],"_", 
                         true_parameters[3],"_", true_parameters[4],"_",
                         "2startriangles.RData", sep = "")
load(montecarlo_file)  
# make table to export in latex
table_results <- matrix(NA, ncol = 12, nrow = 2)
#table_results[1,2:13] <- colMeans(results)
for (i in 1:12) {
  table_results[1,i] <- median(results[,i], na.rm = T)
  table_results[2,i] <- mad(results[,i], na.rm = T)
  
}
colnames(table_results) <- c("MCMLE", "MCMLE", "MCMLE", "MCMLE", 
                             "MF", "MF", "MF", "MF", 
                             "MPLE", "MPLE", "MPLE", "MPLE")

rownames(table_results) <- c("median", "mad")

# latex table
### generate file name for table to be saved
tablename <- paste("table_n", nplayers, 
                   "_nsims500_pars_", true_parameters[1], "_", 
                   true_parameters[2], "_", true_parameters[3], 
                   "_", true_parameters[4], 
                   "_2startriangles.tex",sep="" )


sink(tablename)
library(xtable)
xtable(table_results, digits = 3, 
       caption = paste("true=(", 
                       true_parameters[1],",",  
                       true_parameters[2],",",  
                       true_parameters[3],",",  
                       true_parameters[4],"); n=", nplayers, sep=""))
sink()


# n=100
nplayers <- 100
montecarlo_file <- paste("table_n", nplayers, "_nsims500_pars_", 
                         true_parameters[1],"_", true_parameters[2],"_", 
                         true_parameters[3],"_", true_parameters[4],"_",
                         "2startriangles.RData", sep = "")
load(montecarlo_file)  
# make table to export in latex
table_results <- matrix(NA, ncol = 12, nrow = 2)
#table_results[1,2:13] <- colMeans(results)
for (i in 1:12) {
  table_results[1,i] <- median(results[,i], na.rm = T)
  table_results[2,i] <- mad(results[,i], na.rm = T)
  
}
colnames(table_results) <- c("MCMLE", "MCMLE", "MCMLE", "MCMLE", 
                             "MF", "MF", "MF", "MF", 
                             "MPLE", "MPLE", "MPLE", "MPLE")

rownames(table_results) <- c("median", "mad")

# latex table
### generate file name for table to be saved
tablename <- paste("table_n", nplayers, 
                   "_nsims500_pars_", true_parameters[1], "_", 
                   true_parameters[2], "_", true_parameters[3], 
                   "_", true_parameters[4], 
                   "_2startriangles.tex",sep="" )


sink(tablename)
library(xtable)
xtable(table_results, digits = 3, 
       caption = paste("true=(", 
                       true_parameters[1],",",  
                       true_parameters[2],",",  
                       true_parameters[3],",",  
                       true_parameters[4],"); n=", nplayers, sep=""))
sink()



# n=200
nplayers <- 200
montecarlo_file <- paste("table_n", nplayers, "_nsims500_pars_", 
                         true_parameters[1],"_", true_parameters[2],"_", 
                         true_parameters[3],"_", true_parameters[4],"_",
                         "2startriangles.RData", sep = "")
load(montecarlo_file)  
# make table to export in latex
table_results <- matrix(NA, ncol = 12, nrow = 2)
#table_results[1,2:13] <- colMeans(results)
for (i in 1:12) {
  table_results[1,i] <- median(results[,i], na.rm = T)
  table_results[2,i] <- mad(results[,i], na.rm = T)
  
}
colnames(table_results) <- c("MCMLE", "MCMLE", "MCMLE", "MCMLE", 
                             "MF", "MF", "MF", "MF", 
                             "MPLE", "MPLE", "MPLE", "MPLE")

rownames(table_results) <- c("median", "mad")

# latex table
### generate file name for table to be saved
tablename <- paste("table_n", nplayers, 
                   "_nsims500_pars_", true_parameters[1], "_", 
                   true_parameters[2], "_", true_parameters[3], 
                   "_", true_parameters[4], 
                   "_2startriangles.tex",sep="" )


sink(tablename)
library(xtable)
xtable(table_results, digits = 3, 
       caption = paste("true=(", 
                       true_parameters[1],",",  
                       true_parameters[2],",",  
                       true_parameters[3],",",  
                       true_parameters[4],"); n=", nplayers, sep=""))
sink()


# n=500
nplayers <- 500
montecarlo_file <- paste("table_n", nplayers, "_nsims500_pars_", 
                         true_parameters[1],"_", true_parameters[2],"_", 
                         true_parameters[3],"_", true_parameters[4],"_",
                         "2startriangles.RData", sep = "")
load(montecarlo_file)  
# make table to export in latex
table_results <- matrix(NA, ncol = 12, nrow = 2)
#table_results[1,2:13] <- colMeans(results)
for (i in 1:12) {
  table_results[1,i] <- median(results[,i], na.rm = T)
  table_results[2,i] <- mad(results[,i], na.rm = T)
  
}
colnames(table_results) <- c("MCMLE", "MCMLE", "MCMLE", "MCMLE", 
                             "MF", "MF", "MF", "MF", 
                             "MPLE", "MPLE", "MPLE", "MPLE")

rownames(table_results) <- c("median", "mad")

# latex table
### generate file name for table to be saved
tablename <- paste("table_n", nplayers, 
                   "_nsims500_pars_", true_parameters[1], "_", 
                   true_parameters[2], "_", true_parameters[3], 
                   "_", true_parameters[4], 
                   "_2startriangles.tex",sep="" )


sink(tablename)
library(xtable)
xtable(table_results, digits = 3, 
       caption = paste("true=(", 
                       true_parameters[1],",",  
                       true_parameters[2],",",  
                       true_parameters[3],",",  
                       true_parameters[4],"); n=", nplayers, sep=""))
sink()






#########################
# ESTIMATES WITH n=1000 networks
############################


rm(list=ls())
setwd("/Users/Angelo/Dropbox/mfergm/programs/simulations/simulations_march2020_large")

results <- data.frame(matrix(NA, ncol = 12, nrow = 500))

for (sim in 1:500){
  mc_file <- paste("estimation",sim,".Rdata", sep = "")
  load(mc_file)
  results[sim,] <- data$estimates
}  


table_results <- matrix(NA, ncol = 12, nrow = 2)
#table_results[1,2:13] <- colMeans(results)
for (i in 1:12) {
  table_results[1,i] <- median(results[,i], na.rm = T)
  table_results[2,i] <- mad(results[,i], na.rm = T)
  
}
colnames(table_results) <- c("MCMLE", "MCMLE", "MCMLE", "MCMLE", 
                             "MF", "MF", "MF", "MF", 
                             "MPLE", "MPLE", "MPLE", "MPLE")

rownames(table_results) <- c("median", "mad")

true_parameters <- data$params

# latex table
### generate file name for table to be saved
tablename <- paste("table_n", 1000, 
                   "_nsims500_pars_", true_parameters[1], "_", 
                   true_parameters[2], "_", true_parameters[3], 
                   "_", true_parameters[4], 
                   "_2startriangles.tex",sep="" )


sink(tablename)
library(xtable)
xtable(table_results, digits = 3, 
       caption = paste("true=(", 
                       true_parameters[1],",",  
                       true_parameters[2],",",  
                       true_parameters[3],",",  
                       true_parameters[4],"); n=", 1000, sep=""))
sink()






