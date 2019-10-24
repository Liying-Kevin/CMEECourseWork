# This function calculates heights of trees given distance of each tree 
# from its base and angle to its top, using  the trigonometric formula 
#
# height = distance * tan(radians)
#
# ARGUMENTS
# degrees:   The angle of elevation of tree
# distance:  The distance from base of tree (e.g., meters)
#
# OUTPUT
# The heights of the tree, same units as "distance"
MyTree <- read.csv("../data/trees.csv")

TreeHeight <- function(degrees, distance){
  MyTree1 <- list(MyTree[,1])
  MyTree2 <- list(MyTree[,2])
  MyTree3 <- list(MyTree[,3])
  for (tuples1 in MyTree1){
    for (tuples2 in MyTree2){
      for (tuples3 in MyTree3){
        degrees <- tuples3
        distance <- tuples2
        radians <- degrees * pi / 180
        height <- distance * tan(radians)
        #print(paste("Tree height is:", height, " \n"))
        TreesHeight <- list(height)
      }
    }
  }
  
  return (height)
  
}
TreeHeight(x, y)
MyTrees <- data.frame(MyTree1, MyTree2, MyTree3, TreesHeight)
names(MyTrees) <- c("Species", "Distance.m", "Angle.degrees","Tree.Height.m")
write.csv(MyTrees, "../results/MyTreesHeight.csv")


