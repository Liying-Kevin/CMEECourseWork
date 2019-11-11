north <- read.csv("../data/killer_whale_North.csv", header=F)
south <- read.csv("../data/killer_whale_South.csv", header=F)

vector1 <- c()
for (i in 1:ncol(north)){
  if(length(unique(north[,i])) == 2){
    #print(i)
    vector1 <- c(vector1,i)
  }
}

northChange<-north[vector1]

sumDiffer <-c()
for (i in 1:nrow(northChange)){
  for (j in 1:nrow(northChange)){
    differ <- (northChange[i,] - northChange[j,])
    differ <- sum(abs(differ))
    sumDiffer <- c(sumDiffer,differ)
    sumDiffers <- sum(sumDiffer)
  }
}
tajima <- (sumDiffers / nrow(northChange)/ (nrow(northChange)-1))
Ne <- (tajima / (4 * 10^{-8}))
S <- ncol(northChange)/sum(1/seq(1,19))



vector2 <- c()
for (i in 1:ncol(south)){
  if(length(unique(south[,i])) == 2){
    #print(i)
    vector2 <- c(vector2,i)
  }
}
southChange<-south[vector2]

sumDiffer1 <-c()
for (i in 1:nrow(southChange)){
  for (j in 1:nrow(southChange)){
    differ1 <- (southChange[i,] - southChange[j,])
    differ1 <- sum(abs(differ1))
    sumDiffer1 <- c(sumDiffer1,differ1)
    sumDiffers1 <- sum(sumDiffer1)
  }
}
tajima1 <- (sumDiffers1 / nrow(southChange)/ (nrow(southChange)-1))
Ne1 <- (tajima1 / (4 * 10^{-8}))
S1 <- ncol(southChange)/sum(1/seq(1,19))

abcd <- colSums(northChange)
erty <- table(abcd)
plot(erty)
