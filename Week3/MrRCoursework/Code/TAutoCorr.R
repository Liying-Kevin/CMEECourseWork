load("../data/KeyWestAnnualMeanTemperature.RData")

listWeather <-function(){
  x <-data.frame(ats[,1])
  names(x) <- "year"
  y <-data.frame(ats[,2])
  names(y) <- "temp"
  kendall <-cor(x,y, method = "kendall")
  pearson <-cor(x,y, method = "pearson")
  spearman <-cor(x,y, method = "spearman")
  print(pearson)
  return(TRUE)
}
  
sampleList <-function(){
  result <-ats[sample(nrow(ats)), ]
  data1 <- data.frame(result)
  xResult <-data.frame(data1[,1])
  names(xResult) <- "yearList"
  yResult <-data.frame(data1[,2])
  names(yResult) <- "templist"
  pearsonList <-cor(xResult,yResult, method = "pearson")
  print(pearsonList)
  return(data1)
}

listWeather()
sampleList()
#replicate(10000, sampleList())
