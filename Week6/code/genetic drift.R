data1 <- read.csv("../data/western_banded_gecko.csv", header=F, colClasses = rep('character', 20000), stringsAsFactors = F)
data2 <- read.csv("../data/bent-toed_gecko.csv", header=F, colClasses = rep('character', 20000), stringsAsFactors = F)
data3 <- read.csv("../data/leopard_gecko.csv", header=F, colClasses = rep('character', 20000), stringsAsFactors = F)


######calculate data1 & data2
j = 0
k = 0
for (i in 1:ncol(data1)){
  if(length(unique(data1[,i])) == 1 & length(unique(data2[,i])) == 1){
      j <- j+1
  }
  if((data1[1,i]) != (data2[1,i])){
    k <- k+1
  }
}
result1 <- k / j

######calculate data1 & data3
j = 0
k = 0
for (i in 1:ncol(data1)){
  if(length(unique(data1[,i])) == 1 & length(unique(data3[,i])) == 1){
    j <- j+1
  }
  if((data1[1,i]) != (data3[1,i])){
    k <- k+1
  }
}
result2 <- k / j

######calculate data2 & data3
j = 0
k = 0
for (i in 1:ncol(data2)){
  if(length(unique(data2[,i])) == 1 & length(unique(data3[,i])) == 1){
    j <- j+1
  }
  if((data2[1,i]) != (data3[1,i])){
    k <- k+1
  }
}
result3 <- k / j

print(result1)
print(result2)
print(result3)




