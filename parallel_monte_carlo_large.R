### TABLE n=50, sparse, nsim=100
library(parallel)
library(mfergm)
rm(list=ls())


#### monte carlo inputs
nplayers <- 500  # number of players
true_parameters <- c(-3,1,2,1) # true parameter vector
number_of_simulations <- 5 #100  # number of simulations
number_of_initializations <- 1 # number of times to re-start from random mu

### save estimation results in data.frame
results <-  data.frame(matrix(NA, ncol = 12, nrow = number_of_simulations))

### set seed
seed <- 1977

# set working directory for networks
setwd("/Users/Angelo/Dropbox/mfergm/programs/simulations/simulations_march2020_large")

# function for network simulations
generate_networks <- function(X, true_parameters, n,
                              ninit,
                              sim.seed = X){
  # simulate network
  network <- simulate.model4(true_parameters, n = nplayers,
                             nsims = 2,
                             ninit = number_of_initializations,
                             ergm = F, mfergm = F, mple = F, sim.seed = X)$sample[[1]]
  # save network in folder
  save(network, file = paste("network", X,".Rdata", sep = ""))
}


### simulations
# for a windows machine you can use the following code (painful)
cl <- makeCluster(5)
clusterEvalQ(cl, library(ergm))
clusterEvalQ(cl, library(network))
clusterEvalQ(cl, library(optimx))
clusterEvalQ(cl, library(rootSolve))
clusterEvalQ(cl, library(mfergm))
clusterExport(cl, c('generate_networks','results','true_parameters','nplayers', 'seed', 'number_of_simulations','number_of_initializations'))
result_list <- parLapply(cl, X=1:(number_of_simulations), function(X) generate_networks(X, true_parameters, n=nplayers , 
                                                                                         ninit = number_of_initializations,
                                                                                         sim.seed = X))
stopCluster(cl)



# function for parallel estimation
estimate_models <- function(X, true_parameters, n, ninit,
                            ergm = F, mfergm = T, mple = F){
  networktoload <- paste("network", X, ".Rdata", sep = "")
  load(networktoload)
  
  
  
  # estimate mcmle
  # estimate MPLE
  # estimate mean-field
  
  time_ergm <- NA
  time_mfergm <- NA 
  time_mple <- NA
  
  # observed statistics for the sample
    formula <- network ~ edges + nodematch("x") + kstar(2) + triangles
    tobs <- summary(formula)/(c((n^2)/2, (
      n^2)/2, (n^3)/2 , (n^3)/2 ))  
  
  names(tobs) <- c("edges", "x", "kstar2", "triangles")

  # initialize data.frame with estimation results
  estim.table<- data.frame(matrix(NA, nrow = 1, ncol = 12))
  names(estim.table) <- c("ergm", "ergm", "ergm", "ergm",
                          #"CD2013", "CD2013", 
                          "MF", "MF", "MF", "MF",
                          "mple", "mple", "mple", "mple")
  
  # estimate using ergm routines
  if (ergm == TRUE) {
      formula <- network ~ edges + nodematch("x") + kstar(2) + triangles

      start_time <- Sys.time()
      m1ergm <- ergm(formula, estimate = "MLE", 
                     control=control.ergm(
                       main.method = "Stochastic-Approximation",
                       MCMC.burnin=100000,
                       MCMC.interval=1000,
                       init = true_parameters*c(2,2,1/n,1/n ))
      )
      end_time <- Sys.time()
      time_ergm <- end_time - start_time 
      est.params <- m1ergm$coef
      estim.table[1:4] <- est.params*c(.5,.5,n,n)
  }
  
  

  # estimate with mfergm
  if (mfergm == TRUE) {
    library(optimx)

      pars <- true_parameters
      addpars <- list(n = n,tobs = tobs,x=get.vertex.attribute(network, "x"),ninit= ninit)

      start_time <- Sys.time()
      cd.est <- optimx(pars, fn = loglikmf.model4, 
                       method = "BFGS", 
                       control = list(fnscale = -1), addpars = addpars)
      end_time <- Sys.time()
      time_mfergm <- end_time - start_time 
      
      estim.table[5:8] <- c(cd.est[1:4])
      
  }
    
  
  
  # estimate using ergm routines
  if (mple == TRUE) {
      formula <- network ~ edges + nodematch("x") + kstar(2) + triangles
      start_time <- Sys.time()
      m1ergm <- ergm(formula, estimate = "MPLE",
                     control=control.ergm(
                       MCMC.burnin=100000,
                       MCMC.interval=1000,
                       init = true_parameters*c(2,2,1/n ,1/n))
      )
      end_time <- Sys.time()
      time_mple <- end_time - start_time 
      est.params <- m1ergm$coef
      estim.table[9:12] <- est.params*c(.5,.5,n,n)
  }
  
  data <- list(network,true_parameters,n, tobs, estim.table, time_ergm, time_mfergm, time_mple)
  names(data) <- c("sample", "params", "n", "stats0", "estimates", "time_ergm", "time_mfergm", "time_mple")
  save(data, file = paste("estimation", X, ".Rdata", sep = ""))
  
}

### estimation
# for a windows machine you can use the following code (painful)
cl <- makeCluster(5)
clusterEvalQ(cl, library(ergm))
clusterEvalQ(cl, library(network))
clusterEvalQ(cl, library(optimx))
clusterEvalQ(cl, library(rootSolve))
clusterEvalQ(cl, library(mfergm))
clusterExport(cl, c('estimate_models','results','true_parameters','nplayers', 'seed', 'number_of_simulations','number_of_initializations'))
result_list <- parLapply(cl, X=1:(number_of_simulations), function(X) estimate_models(X, true_parameters, n = nplayers , ninit = number_of_initializations))
stopCluster(cl)

######################








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
