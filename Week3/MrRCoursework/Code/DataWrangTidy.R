library(dplyr)
library(tidyr)
MyData <- as.matrix(read.csv("../data/PoundHillData.csv",header = F,  stringsAsFactors = F))
MyMetaData <- read.csv("../data/PoundHillMetaData.csv",header = T,  sep=";", stringsAsFactors = F)
MyData[MyData == ""] = 0
MyData <- t(MyData) 
TempData <- as.data.frame(MyData)
colnames(TempData) <- MyData[1,] # assign column names from original data
rownames(TempData) <- NULL
mydata1<-tidyr::gather(TempData,"Species","Count",-c("Cultivation", "Block", "Plot", "Quadrat"))
mydata1[, "Cultivation"] <- as.factor(mydata1[, "Cultivation"])
mydata1[, "Block"] <- as.factor(mydata1[, "Block"])
mydata1[, "Plot"] <- as.factor(mydata1[, "Plot"])
mydata1[, "Quadrat"] <- as.factor(mydata1[, "Quadrat"])
mydata1[, "Count"] <- as.integer(mydata1[, "Count"])
