# Runs the stochastic (with gaussian fluctuations) Ricker Eqn .

rm(list=ls())#delete all variable

stochrick<-function(p0=runif(1000,.5,1.5),r=1.2,K=1,sigma=0.2,numyears=100)
{
  #initialize
  N<-matrix(NA,numyears,length(p0))
  N[1,]<-p0
  
  for (pop in 1:length(p0)) #loop through the populations
  {
    for (yr in 2:numyears) #for each pop, loop through the years
    {
      N[yr,pop]<-N[yr-1,pop]*exp(r*(1-N[yr-1,pop]/K)+rnorm(1,0,sigma))
    }
  }
 return(N)

}



stochrickvect<-function(p0=runif(1000,0.5,1.5),r=1.2,K=1,numyears=100,sigma=0.2)
{
  #initialize
  N<-matrix(NA,numyears,length(p0))
  N[1,]<-p0
  sapply(2:numyears, function(yr) {
    sapply(1:length(p0), function(pop) {
      N[yr,pop]<-N[yr-1,pop]*exp(r*(1-N[yr-1,pop]/K)+rnorm(1,0,sigma))
    })
  })
  return(N)
}


(stochrick())
(stochrickvect())
print(system.time(stochrick()))
print(system.time(stochrickvect()))




# Now write another function called stochrickvect that vectorizes the above 
# to the extent possible, with improved performance: 

# print("Vectorized Stochastic Ricker takes:")
# print(system.time(res2<-stochrickvect()))

