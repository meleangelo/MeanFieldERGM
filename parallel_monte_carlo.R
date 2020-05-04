### TABLE n=50, sparse, nsim=100
library(parallel)
library(mfergm)
rm(list=ls())


#### monte carlo inputs
nplayers <- 1000  # number of players
true_parameters <- c(-3,1,2,1) # true parameter vector
number_of_simulations <- 2 #100  # number of simulations
number_of_initializations <- 1 # number of times to re-start from random mu

### save estimation results in data.frame
results <-  data.frame(matrix(NA, ncol = 12, nrow = number_of_simulations))

### set seed
seed <- 1977


# function for monte carlo
mfergm_monte_carlo <- function(X, true_parameters, n , 
                               ninit,
                               ergm = TRUE, mfergm = TRUE, mple = TRUE, 
                               sim.seed = X){
  
  result <-  data.frame(matrix(NA, ncol = 12, nrow = 2))
  result <- simulate.model4(true_parameters, n = nplayers, 
                             nsims = 2, 
                             ninit = number_of_initializations,
                             ergm = TRUE, mfergm = TRUE, mple = TRUE, 
                             sim.seed = X)$estimates
}
### simulations
# for a windows machine you can use the following code (painful)
cl <- makeCluster(2)
clusterEvalQ(cl, library(ergm))
clusterEvalQ(cl, library(network))
clusterEvalQ(cl, library(optimx))
clusterEvalQ(cl, library(rootSolve))
clusterEvalQ(cl, library(mfergm))
clusterExport(cl, c('mfergm_monte_carlo','results','true_parameters','nplayers', 'seed', 'number_of_simulations','number_of_initializations'))
result_list <- parLapply(cl, X=1:(number_of_simulations), function(X) mfergm_monte_carlo(X, true_parameters, n , 
                                                                        ninit,
                                                                        ergm = TRUE, mfergm = TRUE, mple = TRUE, 
                                                                        sim.seed = X))
stopCluster(cl)


# collect results in table
for (X in 1:(number_of_simulations)){
  results[(2*X-1):(2*X),] <- result_list[[X]]
}


# make table to export in latex
table_results <- matrix(NA, ncol = 12, nrow = 5)
#table_results[1,2:13] <- colMeans(results)
for (i in 1:12) {
  table_results[1,i] <- mean(results[,i], na.rm = T)
  table_results[2,i] <- median(results[,i], na.rm = T)
  table_results[3,i] <- sd(results[,i], na.rm = T)
  table_results[4,i] <- quantile(results[,i], 0.05, na.rm=T)
  table_results[5,i] <- quantile(results[,i], 0.95, na.rm=T)
}
colnames(table_results) <- c("MCMLE", "MCMLE", "MCMLE", "MCMLE", 
                             "MF", "MF", "MF", "MF", 
                             "MPLE", "MPLE", "MPLE", "MPLE")

rownames(table_results) <- c("mean", "median", "se", "0.05", "0.95")

# latex table
### generate file name for table to be saved
tablename <- paste("table_n", nplayers, 
                   "_nsims", number_of_simulations, 
                   "_pars_", true_parameters[1], "_", 
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


### generate file name for data to be saved
filename <- paste("table_n", nplayers, 
                  "_nsims", number_of_simulations, 
                  "_pars_", true_parameters[1], "_", 
                  true_parameters[2], "_", true_parameters[3],  
                  "_", true_parameters[4], 
                  "_2startriangles.RData",sep="" )

# save simulation results data for later
save.image(file = filename)
