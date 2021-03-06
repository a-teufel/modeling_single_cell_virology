
#' Title
#'
#' @param second_round_ABC_parameters
#' @param MOI
#' @param n_replicates
#' @param n_cores
#' @param min_time
#' @param max_time
#'
#' @return
#' @export
#'
#' @examples
trackmutants_ABC <-function(second_round_ABC_parameters, MOI, n_replicates, n_cores,min_time, max_time){
  #register how many cores are to be used when calling replicates
  #registerDoMC(n_cores)

  G_dist<-NULL
  G<-NULL


  low<-c(-5.9,-13,   -10.4, -6.8,-0.25,-10,      4.1,  11,  1,  0,  0, 0,0,0,0,0,0,0,0,0,0,0)
  high<-c(0.5, -5.1,   0.5,  0,   2.5, -0.8,   8,    17.5, 10,  0.95,.0001,1,1,1,1,1,1,1,1,1,1,1)

  min_time<-1
  max_time<-50

  min_shift<-0
  max_shift<-10

  min_var_time<-0
  max_var_time<-5

  min_var_shift<-0
  max_var_shift<-20

  low<-c(low,min_time,min_shift,min_var_time,min_var_shift)
  high<-c(high,max_time,max_shift,max_var_time,max_var_shift)



  savedParameters<-second_round_ABC_parameters #just being lazy cuz I didn't want to change all the value names in my code fix later
  dist<-NULL
  ANS<-NULL
  #simulate generaions
  for(i in 1:nrow(savedParameters)){
    print("new param list")
    print(i)
    param_list<-as.numeric(savedParameters[i,])
    print(param_list)

    for(h in 1:n_replicates){
      print("at h")
      print(h)

      print("makeing new param")
      param_temp<-c(0, 0, 0,  0,     0,   0,  0,   0,  0,  0)
      for(k in 1:11){
        try_newparam<-rnorm(1,mean=param_list[k],sd=param_list[k+11])
        #print(try_newparam)
        #while(try_newparam > high[k] || try_newparam < low[k]){
        #try_newparam<-rnorm(1,mean=param_list[k],sd=param_list[k+11])
        #}
        param_temp[k]<-try_newparam
      }


      ly_time<-rgamma(1,shape=param_list[23],rate=param_list[25])
      while ( ly_time < 0){
        #ly_time<-rnorm(1,mean=param_list[23],sd=param_list[25])
        ly_time<-rgamma(1,shape=param_list[23],rate=param_list[25])
      }


      lysis_time<-round( ly_time/.5, digits = 0)*.5
      print(lysis_time)

      sim_min_time<-0
      sim_max_time<-lysis_time
      print(param_list)
      ABC_gens<-0
      if(sim_max_time > 0){
        ABC_gens<-avetrack(param_temp,MOI, 0, sim_max_time)

      }
      print("done with loop")

      dist<-c(dist,ABC_gens)

    }#end Res2

  }

  return(dist)
}
