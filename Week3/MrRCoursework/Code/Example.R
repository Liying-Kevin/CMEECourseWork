library(dplyr)
library(tidyr)
MyData123 <- as.matrix(read.csv("../data/PoundHillData.csv",header = F,  stringsAsFactors = F))
MyData123[MyData123 == ""] = 0
MyData123 <- t(MyData123) 
TempData123 <- as.data.frame(MyData[-1,],stringsAsFactors = F)
colnames(TempData123) <- MyData123[1,] # assign column names from original data


# Example <- gather(TempData123, species, count, -grade)
gather(TempData123, species, count,-c("Cultivation", "Block", "Plot", "Quadrat"))
