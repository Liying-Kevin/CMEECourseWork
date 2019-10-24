library(lattice)

MyDF <- read.csv("../data/EcolArchives-E089-51-D1.csv")

predatorMass <- as.data.frame(MyDF$Predator.mass)
preyMass <- as.data.frame(MyDF$Prey.mass)
sizeOfRatio <- preyMass/predatorMass

predatorMassMeans <- apply(log(predatorMass), 2, mean)
preyMassMeans <- apply(log(preyMass), 2, mean)
predatorMassMedian <- apply(log(predatorMass), 2, median)
preyMassMedian <- apply(log(preyMass), 2, median)
sizeOfRatioMeans <- apply(log(sizeOfRatio), 2, mean)
sizeOfRatioMedian <- apply(log(sizeOfRatio), 2, median)
Means <- c(predatorMassMeans,preyMassMeans,sizeOfRatioMeans)
Midian <- c(predatorMassMedian,preyMassMedian,sizeOfRatioMedian)
MeanMedian <- data.frame(Means,Midian)
rownames(MeanMedian) <- c("Predator.mass","Prey.mass","size of tatio")
write.csv(MeanMedian, "../results/PP_Results.csv")


pdf("../results/Pred_Lattice.pdf", 11.7, 8.3) 
densityplot(~log(Predator.mass) | Type.of.feeding.interaction, data=MyDF)
pdf("../results/Prey_Lattice.pdf",11.7, 8.3) 
densityplot(~log(Prey.mass) | Type.of.feeding.interaction, data=MyDF)
pdf("../results/SizeRatio_Lattice.pdf", 11.7, 8.3) 
densityplot(~log(preyMass/predatorMass) | Type.of.feeding.interaction, data=MyDF)
graphics.off(); #you can also use dev.off()
