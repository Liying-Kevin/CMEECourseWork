turtle <- read.csv("../data/turtle.csv", header=F, colClasses = rep('numeric', 2000), stringsAsFactors = F)
turtleGenotypes <- read.csv("../data/turtle.genotypes.csv", header=F, colClasses = rep('numeric', 2000), stringsAsFactors = F)

############A

turtle <- as.matrix(turtle)
distance<- dist(turtle)
tree <- hclust(distance)
plot(tree)
############C

turtleGenotypesA<-turtleGenotypes[1:10,]
turtleGenotypesB<-turtleGenotypes[11:20,]
turtleGenotypesC<-turtleGenotypes[21:30,]
turtleGenotypesD<-turtleGenotypes[31:40,]
#location A & B
compareLocation <- function(location1,location2){
  fA1 <- as.matrix((apply(location1, 2, sum))/nrow(location1))
  fA2 <- as.matrix((apply(location2, 2, sum))/nrow(location2))
  FST <- rep(NA, length(fA1))
    for(i in 1 : length(FST)){
      HS <- (fA1[i]*(1-fA1[i])+fA2[i]*(1-fA2[i]))/2
      HT <- 2 * ( (fA1[i] + fA2[i]) / 2 ) * (1 - ((fA1[i] + fA2[i]) / 2) )
      FST[i] <- (HT - HS)/ HT
    }
  return(FST)
}

A_B <- compareLocation(turtleGenotypesA,turtleGenotypesB)
A_C <- compareLocation(turtleGenotypesA,turtleGenotypesC)
A_D <- compareLocation(turtleGenotypesA,turtleGenotypesD)
B_C <- compareLocation(turtleGenotypesB,turtleGenotypesC)
B_D <- compareLocation(turtleGenotypesB,turtleGenotypesD)
C_D <- compareLocation(turtleGenotypesC,turtleGenotypesD)

C_D1 <- mean(C_D, na.rm=T)

