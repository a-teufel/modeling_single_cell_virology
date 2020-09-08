#An example of how to use the package spire. This example is designed to be capable of running on a personal computer for the purpose of illustrating how a user calls functions and the types of input data the functions take

library(dplyr)
library(Rcpp)
library(foreach)
library(fBasics)
library(doMC)
library(sicegar)
library(spire)
library(DEoptim)
library(doSNOW)
library(R.utils)
library(compiler)
library(doParallel)
#most of these deal with parallel computing, how your machine runs parallel code depends on your OS. You do not need all of these. This package was developed on a linux system, though the parallel feature should work on other systems.


#example of how to run GA
MOI<-.45 #MIO the experiments were performed at
n_iterations<-10 # number of generations to run the GA
n_replicates<-1 # how many replicates of each simulation to run
min_time<-3 #  bounds on how many hours to simulates
max_time<-24
pop_size<-5 #population size of 100 is actually used, here it is set to 5 just to demonstrate functionality without having to wait. 
n_cores<-1 #number of cores to be used, again set to low value here to demonstrate functionality

precent_error<-1 # if you want to throw out members that score really poorly this can be set to a small number 
initialpop<-NULL #if a previous run is used to start a new one you can feed in an old population, this feature is not used. 

#example input data
max<-c(2.5, 4, 2, 0.3, 3.5)
slope<-c(0.9, 3, 0.7, 0.25, 2.5)
midpoint<-c(7 , 5,  7.5 , 6.5, 11)
lysis<-c(19, 24 ,17 ,16, 15)

temp<-first_round_GA(max,slope,midpoint,lysis,MOI,pop_size,n_iterations,n_replicates,min_time,max_time,initialpop,n_cores,precent_error,0)

#To run the ABC, take the last population from the GA
dat<-temp$member$pop

n_saves<-10 #number of times the ABC should save parameter sets before returning. 
#set score cut off for if the ABC should accept the parameter set, again set high to demonstrate functionality
mean_d=5

temp2<-trueABC(as.matrix(dat),max, slope, midpoint, lysis,  MOI, n_saves, n_replicates, n_cores, mean_d, precent_error,0)
