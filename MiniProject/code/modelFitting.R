#library(dplyr)
library(repr)
library(ggplot2)
library(nls.multstart)
options(repr.plot.width=4, repr.plot.height=4) # Change default plot size; not necessary if you are using Rstudio
require("minpack.lm")
#set work path
setwd("../MiniProject/code/")

#read data as dataframe
startingPoint <- data.frame(startingPoint <- read.csv(file = '../data/LIST.csv')
)
data <- data.frame(data <- read.csv(file = '../data/data.csv')
)

#close all plot
dev.off()
count <- 1
startingPoint$AIC_gompertz <- 0
startingPoint$AIC_logistic <- 0
startingPoint$AIC_baranyi <- 0
startingPoint$AIC_buchanan <-0
startingPoint$BIC_gompertz <- 0
startingPoint$BIC_logistic <- 0
startingPoint$BIC_baranyi <- 0
startingPoint$BIC_buchanan <-0

#for loop to read data
for (i in 1:nrow(startingPoint)) {
  AIC <-data.frame()
  BIC <-data.frame()
  ID1 <- subset(startingPoint,startingPoint$ID==startingPoint$ID[i])
  DF <- subset(data,data$ID==unique(data$ID)[i])
  #ggplot(DF, aes(x = Time, y = LogPopBio)) + geom_point() 
  
#Calculation formula  
  logistic_model <- function(t, rmax, Nmax, N0){ # The classic logistic equation
    return(N0 * Nmax * exp(rmax * t)/(Nmax + N0 * (exp(rmax * t) - 1)))
  }
  
  gompertz_model <- function(t, rmax, A, tlag){ # Modified gompertz growth model (Zwietering 1990)
    return(A* exp(-exp(rmax * exp(1) * (tlag - t)/A + 1)))
  }
  
  baranyi_model <- function(t, rmax, N0, tlag,Nmax){  # Baranyi model (Baranyi 1993)
    return(N0 + rmax * (t+(1/rmax) * log((exp(-1 * rmax * t)+(1/(-1+exp(rmax * tlag))))/(1+(1/(-1+exp(rmax * tlag))))))-log(1+(exp(rmax * (t+(1/rmax) * log((exp(-1 * rmax * t)+(1/(-1+exp(rmax * tlag))))/(1+(1/(-1+exp(rmax * tlag)))))))-1/exp(Nmax-N0)))
)
  }
  
  buchanan_model <- function(t, rmax, Nmax, N0, tlag){ # Buchanan model - three phase logistic (Buchanan 1997)
    return(N0 + (t >= tlag) * (t <= (tlag + (Nmax - N0) * log(10)/rmax)) * rmax * (t - tlag)/log(10) + (t >= tlag) * (t > (tlag + (Nmax - N0) * log(10)/rmax)) * (Nmax - N0))
  }
  
  
  
#get parameter, that be used in model fitting
  N0 <- ID1$N0
  NMax <- ID1$NMAX
  Rmax <- ID1$RMAX
  A <-ID1$A
  Tlag <- DF$Time[which.max(diff(diff(DF$PopBio)))]
  timepoints <- DF$Time
  
#fit the logistic model(using try-error to catch error)    
  fit_logistic <- try(nlsLM(LogPopBio ~ logistic_model(t = Time, rmax, Nmax, N0), DF,
                        list(rmax=Rmax, N0 = N0, Nmax = NMax)))
  if('try-error' %in% class(fit_logistic)){
    print("error")
    logistic_points <- rep(0,nrow(DF))
    df1 <- data.frame(timepoints, logistic_points)
    df1$model <- "Logistic"
    names(df1) <- c("Time", "LogPopBio", "model")
    AIC_logistic <- 0
    BIC_logistic <- 0
  }else{
    summary(fit_logistic)
    logistic_points <- logistic_model(t = timepoints, rmax = coef(fit_logistic)["rmax"], Nmax = coef(fit_logistic)["Nmax"], N0 = coef(fit_logistic)["N0"])
    df1 <- data.frame(timepoints, logistic_points)
    df1$model <- "Logistic"
    names(df1) <- c("Time", "LogPopBio", "model")
    AIC_logistic <-AIC(fit_logistic)
    BIC_logistic <-BIC(fit_logistic)
  }
  
#fit the gompertz model(using try-error to catch error)  
  fit_gompertz <- try(nlsLM(LogPopBio ~ gompertz_model(t = Time, rmax, A, tlag), DF,
                            list(tlag=Tlag, rmax=Rmax, A=A )))  
  if('try-error' %in% class(fit_gompertz)){
    print("error")
    gompertz_points <- rep(0,nrow(DF))
    df2 <- data.frame(timepoints, gompertz_points)
    df2$model <- "Gompertz"
    names(df2) <- c("Time", "LogPopBio", "model")
    AIC_gompertz <- 0
    BIC_gompertz <- 0
  }else{
    summary(fit_gompertz)
    gompertz_points <- gompertz_model(t = timepoints, rmax = coef(fit_gompertz)["rmax"], tlag = coef(fit_gompertz)["tlag"],A = coef(fit_gompertz)["A"])
    df2 <- data.frame(timepoints, gompertz_points)
    df2$model <- "Gompertz"
    names(df2) <- c("Time", "LogPopBio", "model")
    AIC_gompertz <- AIC(fit_gompertz)
    BIC_gompertz <- BIC(fit_gompertz)
  }
  
#fit the baranyi model(using try-error to catch error)  
  fit_baranyi <- try(nlsLM(LogPopBio ~ baranyi_model(t = Time, rmax, N0, tlag, Nmax), DF,
                           list(tlag=Tlag, rmax = Rmax, N0 = N0, Nmax = NMax)))
  if('try-error' %in% class(fit_baranyi)){
    print("error")
    baranyi_points <- rep(0,nrow(DF))
    df3 <- data.frame(timepoints, baranyi_points)
    df3$model <- "Baranyi"
    names(df3) <- c("Time", "LogPopBio", "model")
    AIC_baranyi <- 0
    BIC_baranyi <- 0
  }else{
    summary(fit_baranyi)
    baranyi_points <- baranyi_model(t = timepoints, rmax = coef(fit_baranyi)["rmax"], Nmax = coef(fit_baranyi)["Nmax"], N0 = coef(fit_baranyi)["N0"], tlag = coef(fit_baranyi)["tlag"])
    df3 <- data.frame(timepoints, baranyi_points)
    df3$model <- "Baranyi"
    names(df3) <- c("Time", "LogPopBio", "model")
    AIC_baranyi <- AIC(fit_baranyi)
    BIC_baranyi <- BIC(fit_baranyi)
  }
  
#fit the buchanan model(using try-error to catch error)  
  fit_buchanan <- try(nlsLM(LogPopBio ~ buchanan_model(t = Time, rmax, Nmax, N0, tlag), DF,
                            list(tlag=Tlag, rmax=Rmax, N0 = N0, Nmax = NMax)))
  if('try-error' %in% class(fit_buchanan)){
    print("error")
    buchanan_points <- rep(0,nrow(DF))
    df4 <- data.frame(timepoints, buchanan_points)
    df4$model <- "Buchanan"
    names(df4) <- c("Time", "LogPopBio", "model")
    AIC_buchanan <- 0
    BIC_buchanan <- 0
  }else{
    summary(fit_buchanan)
    buchanan_points <- buchanan_model(t = timepoints, rmax = coef(fit_buchanan)["rmax"], Nmax = coef(fit_buchanan)["Nmax"], N0 = coef(fit_buchanan)["N0"], tlag = coef(fit_buchanan)["tlag"])
    df4 <- data.frame(timepoints, buchanan_points)
    df4$model <- "Buchanan"
    names(df4) <- c("Time", "LogPopBio", "model")
    AIC_buchanan <- AIC(fit_buchanan)
    BIC_buchanan <- AIC(fit_buchanan)
  }
  
  model_frame <- rbind(df1, df2, df3, df4)

#generate plot by ggplot2  
  g1<- ggplot(DF, aes(x = Time, y = LogPopBio)) +
    geom_point(size = 3) +
    geom_line(data = model_frame, aes(x = Time, y = LogPopBio, col = model), size = 1) +
    theme_bw(base_size = 16) + # make the background white
    theme(aspect.ratio=1)+ # make the plot square 
    labs(x = "Time", y = "log(PopBio)")
  #print(g1)
  
#save plot
  ggsave(g1,file=paste("../result/",count,".pdf",sep="")) 
  count <- count+1
  
#insert AIC and BIC in data
  AIC <-data.frame(AIC_logistic,AIC_baranyi,AIC_buchanan,AIC_gompertz)
  BIC <-data.frame(BIC_logistic,BIC_baranyi,BIC_buchanan,BIC_gompertz)
  startingPoint$AIC_gompertz[i] <- AIC$AIC_gompertz
  startingPoint$AIC_logistic[i] <- AIC$AIC_logistic
  startingPoint$AIC_baranyi[i] <- AIC$AIC_baranyi
  startingPoint$AIC_buchanan[i] <-AIC$AIC_buchanan
  startingPoint$BIC_gompertz[i] <- BIC$BIC_gompertz
  startingPoint$BIC_logistic[i] <- BIC$BIC_logistic
  startingPoint$BIC_baranyi[i] <- BIC$BIC_baranyi
  startingPoint$BIC_buchanan[i] <-BIC$BIC_buchanan
  
}

#save data to csv.file
write.csv(startingPoint,file="../result/finalData.csv")








                           


