# CMEE 2019 HPC excercises R code main proforma
# you don't HAVE to use this but it will be very helpful.  If you opt to write everything yourself from scratch please ensure you use EXACTLY the same function and parameter names and beware that you may loose marks if it doesn't work properly because of not using the proforma.

name <- "liying huang"
preferred_name <- "kevin"
email <- "liying.huang19@imperial.ac.uk"
username <- "lh1019"
personal_speciation_rate <- 0.002048 # will be assigned to each person individually in class and should be between 0.002 and 0.007

# Question 1
species_richness <- function(community){
  return(length(unique(community)))
}

# Question 2
init_community_max <- function(size){
  x <- c(seq(length.out = size))
 return(x)
}

# Question 3
init_community_min <- function(size){
  x <- seq(from = 1, to = 1, length.out = size)
  return(x)
}

# Question 4
#sample method to get 2 random number
choose_two <- function(max_value){
  a <- sample(max_value,2,replace = FALSE)
  return(a)
}

# Question 5
#use random number to replace original number
neutral_step <- function(community){
  b <- length(community)
  a <- choose_two(b)
  community[a[1]] <- community[a[2]]
  return(community)
}

# Question 6

neutral_generation <- function(community){
    a1 <- ceiling(length(community) %/% 2)
    a2 <- floor(length(community) %/% 2)
    a <- c(a1,a2)
    ChooseOne <- sample(x=a,size=1,replace = FALSE)#choose random number
      for (i in 1:ChooseOne) {
        community <- neutral_step(community)#replace 
      }
  return(community)
}

# Question 7
neutral_time_series <- function(community,duration)  {
  speciesRichnessInit <- species_richness(community)#get the species richness 
  for (i in 1:duration) {#for loop to simulated generation
  community <- neutral_generation(community)
  speciesRichnessNext <- species_richness(community)
  speciesRichnessInit <- c(speciesRichnessInit,speciesRichnessNext)
  }
  return(speciesRichnessInit)
}

# Question 8
question_8 <- function() {
  a <-neutral_time_series (community = init_community_max(100) , duration = 200) 
  b <- 1:201
  plot(b,a,type = "l",xlab = "duration")# draw plot
  graphics.off()
  # clear any existing graphs and plot your graph within the R window
  return("The system will balance if you wait long enough")
}

# Question 9
neutral_step_speciation <- function(community,speciation_rate)  {
  n <-runif(1,min = 0,max = 1)#get the random number
  if(n>speciation_rate){
    community <- neutral_step(community)
  }
  else{
    a <- sample(length(community),1,replace = FALSE)#random pick original number to replace another number
    blist <- setdiff(x=1:10000,y=c(community))# get the new list that number from 1 to 10000 but remove the numbers in the community list
    b <- sample(blist,1,replace = FALSE)
    community[a[1]] <- b
  }
  return(community)
}

# Question 10 #same as question 6
neutral_generation_speciation <- function(community,speciation_rate)  {
  a1 <- ceiling(length(community) %/% 2)
  a2 <- floor(length(community) %/% 2)
  a <- c(a1,a2)
  ChooseOne <- sample(x=a,size=1,replace = FALSE)
  for (i in 1:ChooseOne) {
    community <- neutral_step_speciation(community,speciation_rate)
  }
  return(community)
}

# Question 11 #same as question 7
neutral_time_series_speciation <- function(community,speciation_rate,duration)  {
  speciesRichnessInit <- species_richness(community)
  for (i in 1:duration) {
    community <- neutral_generation_speciation(community,speciation_rate)
    speciesRichnessNext <- species_richness(community)
    speciesRichnessInit <- c(speciesRichnessInit,speciesRichnessNext)
  }
  return(speciesRichnessInit)
}

# Question 12 #same as question 8
question_12 <- function()  {
  a <-neutral_time_series_speciation(community = init_community_max(100),duration = 200,speciation_rate = 0.1)
  b <- 1:201
  c <-neutral_time_series_speciation (community = init_community_min(100) , duration = 200, speciation_rate = 0.1) 
  plot(b,a,type = "l",xlab = "duration",col = "red")
  lines(b,c,col = "blue")
  graphics.off() #close the plot
  return("The system will has large change if you wait long enough")
}

# Question 13
species_abundance <- function(community)  {
  b <- sort(table(community),decreasing = TRUE) #Get the number of times the number appears and sort by max to min
  b <- as.data.frame(b)
  if(length(unique(community)) != 1){
    c <- b[,2]
    
  }
  else{
    c <- b[,1]
  }

  return(c)
}

# Question 14
octaves <- function(abundance_vector) {
  abundance_vector <- sort(abundance_vector,decreasing = FALSE) #sort 
  n <- floor(log2(abundance_vector))+1 #floor takes a single numeric argument x and returns a numeric vector containing the largest integers not greater than the corresponding elements of x.
  b <- tabulate(n)
  return(b)
  }


# Question 15 # get the sum of 2 vector
sum_vect <- function(x, y) {
  if(length(x) != length(y)){
    a <- abs(length(x) - length(y))
    for (i in 1:a) {
      i=0
      if(length(x)<length(y)){
        x <- c(x,i)
      }
      else{
        y <- c(y,i)
      }
    }
  }
  sum <- x+y
  return(sum)
}

# Question 16 
question_16 <- function()  {
  octavelist <- c()
  for (i in 1:200) { #simulate 200 generation
    communitys <- neutral_generation_speciation(community = init_community_max(100),speciation_rate = 0.1)
  }
  abundance <- species_abundance(community = communitys)
  octave <- octaves(abundance_vector = abundance)
  octavelist <- sum_vect(octavelist,octave)
  for (i in 1:2000) {
    communitys <- neutral_generation_speciation(community = communitys,speciation_rate = 0.1)
    if (i%%20 == 0) {
      abundance <- species_abundance(community = communitys)
      octave <- octaves(abundance_vector = abundance)
      octavelist <- sum_vect(octavelist,octave)
    }
  }
  octaveAdverge <- octavelist/101
  barplot(octaveAdverge,col = "red") #drow plot
  
  return("type your written answer here")
}

# Question 17 
cluster_run <- function(speciation_rate, size, wall_time, interval_rich, interval_oct, burn_in_generations, output_file_name)  {
  time0 = proc.time()[3] # get the system time
  community <- init_community_min(size)
  speciesRichnessTuple <- c()
  octaveTupleList <- list() #create new list to store octave

  countOctave = 1
  countRichness = 1
  while (wall_time*60>as.numeric(proc.time()[3]-time0)) { #when process time less then set time then run project
    for (i in 1:burn_in_generations) {
      communitys <- neutral_generation_speciation(community,speciation_rate)
      if (i%%interval_rich ==0) {
        speciesRichness <- species_richness(communitys)
        speciesRichnessTuple <- c(speciesRichnessTuple,speciesRichness)

      }
      if (i%%interval_oct ==0) {
        octaveTuple <- c()
        abundance <- species_abundance(community = communitys)
        octave <- octaves(abundance_vector = abundance)
        octaveTupleList[[countOctave]] <- octave
        countOctave <- countOctave +1
      }
    }
  }
  time <- proc.time()[3]-time0
  save(community,time,speciation_rate,size,wall_time,interval_rich,interval_oct,burn_in_generations,speciesRichnessTuple,octaveTupleList,file =output_file_name)
  #store all object to file
  return("This execute is finished")
}


# Questions 18 and 19 involve writing code elsewhere to run your simulations on the cluster

# Question 20 
process_cluster_results <- function()  { 
  load("~/CMEECourseWork/Week9/Code/my_test_file-1.rda") #read all .rda file
  graphics.off()
  # clear any existing graphs and plot your graph within the R window
  octavelist <- c()
  if (size == 500) {
    for (i in 1:length(octaveTupleList)) {
      octave <- octaveTupleList[[i]]
      octavelist <- sum_vect(octavelist,octave)
    }
    octaveAdverge1 <- octavelist/length(octaveTupleList)
    barplot(octaveAdverge1,col = "red")
  }
  else if (size == 1000) {
    for (i in 1:length(octaveTupleList)) {
      octave <- octaveTupleList[[i]]
      octavelist <- sum_vect(octavelist,octave)
    }
    octaveAdverge2 <- octavelist/length(octaveTupleList)
    barplot(octaveAdverge2,col = "blue")
  }
  else if (size == 2500) {
    for (i in 1:length(octaveTupleList)) {
      octave <- octaveTupleList[[i]]
      octavelist <- sum_vect(octavelist,octave)
    }
    octaveAdverge3 <- octavelist/length(octaveTupleList)
    barplot(octaveAdverge3,col = "green")
  }
  else if (size == 5000) {
    for (i in 1:length(octaveTupleList)) {
      octave <- octaveTupleList[[i]]
      octavelist <- sum_vect(octavelist,octave)
    }
    octaveAdverge4 <- octavelist/length(octaveTupleList)
    barplot(octaveAdverge4,col = "grey")
  }
  
  
  combined_results <- list() #create your list output here to return
  combined_results[[1]] <- octaveAdverge1
  combined_results[[2]] <- octaveAdverge2
  combined_results[[3]] <- octaveAdverge3
  combined_results[[4]] <- octaveAdverge4
  
  return(combined_results)
}

# Question 21
question_21 <- function()  {
  fractalList1 <- list()
  fractalList1[[1]] <- log(8)/log(3)
  fractalList1[[2]] <- "this object has 8 size and 3 length"
  return(fractalList1)
}

# Question 22
question_22 <- function()  {
  fractalList2 <- list()
  fractalList2[[1]] <- log(20)/log(3)
  fractalList2[[2]] <- "this object has 20 size and 3 length"
  return(fractalList2)
}

# Question 23
chaos_game <- function()  {
  # clear any existing graphs and plot your graph within the R window
  graphics.off()
  a <- c(0,3,4)
  b <- c(0,4,1)
  x <- 0
  y <-0
  plot(x,y,pch=20,xlim = c(0,4),ylim = c(0,4),xlab = " ",ylab = " ",main = "chaos_game",cex = 0.8,col = "red")
  for (i in 1:5000) {
    point <- sample(3,1,FALSE)
    x<-(a[point]+x)/2
    y<-(b[point]+y)/2
    points(x,y,cex=0.8,col="blue",pch=19)
  }

  return("it will become a Sierpinski	gasket")
}

# Question 24
turtle <- function(start_position, direction, length)  {
  end_position<- c()
  end_position[1] <- (start_position[1]+length*cos(direction))
  end_position[2] <- (start_position[2]+length*sin(direction))
  segments(start_position[1],start_position[2],end_position[1],end_position[2])
  return(end_position) # you should return your endpoint here.
}

# Question 25
elbow <- function(start_position, direction, length)  {
  start_position <- turtle(start_position,direction,length)
  start_position <- turtle(start_position,direction - pi/4,length*0.95)
  return(start_position)
}

# Question 26
spiral <- function(start_position, direction, length)  {
  start_position <- turtle(start_position,direction,length)
  threshold <- 0.02
  if (length >= threshold) {
    start_position <- spiral(start_position,direction - pi/4,length*0.95)
  }
  return("this project will show the error:c stack usage 7971920 is too close to the limit,because I have done many recursive, the length is too small.But if I set the threshold of length, it will solve this problem.")
}

# Question 27
draw_spiral <- function()  {
  graphics.off()
  # clear any existing graphs and plot your graph within the R window
  plot(0,0,xlim = c(0,8),ylim = c(-2,5),main = "turtle","l")
  spiral(start_position = c(0,0),direction = pi/2, length = 3)
}

# Question 28
tree <- function(start_position, direction, length)  {
  start_position <- turtle(start_position,direction,length)
  threshold <- 0.02
  if (length >= threshold) {
    tree(start_position,direction - pi/4,length*0.65)
    tree(start_position,direction + pi/4,length*0.65)
    }
}
draw_tree <- function()  {
  graphics.off()
  plot(0,0,xlim = c(-10,10),ylim = c(0,10),main = "tree",xlab = " ", ylab =  " ", "l")
  tree(c(0,0),pi/2,3)
  # clear any existing graphs and plot your graph within the R window
}

# Question 29
fern <- function(start_position, direction, length)  {
  start_position <- turtle(start_position,direction,length)
  threshold <- 0.02
  if (length >= threshold) {
    fern(start_position,direction + pi/4,length*0.38)
    fern(start_position,direction,length*0.87)
  }
}
draw_fern <- function()  {
  graphics.off()
  plot(0,0,xlim = c(-10,0),ylim = c(0,25),main = "fern",xlab = " ", ylab =  " ", "l")
  fern(c(0,0),pi/2,3)
  # clear any existing graphs and plot your graph within the R window
}

# Question 30
fern2 <- function(start_position, direction, length, dir)  {
  start_position <- turtle(start_position,direction,length)
  threshold <- 0.02
  if (length >= threshold) {
      fern2(start_position,direction + dir*pi/4,length*0.38,dir)
      fern2(start_position,direction,length*0.87,-dir)
  }
}
draw_fern2 <- function()  {
  graphics.off()
  plot(0,0,xlim = c(-10,10),ylim = c(0,25),main = "fern2",xlab = " ", ylab =  " ", "l")
  fern2(c(0,0),pi/2,3,1)
  # clear any existing graphs and plot your graph within the R window
}

# Challenge questions - these are optional, substantially harder, and a maximum of 16% is available for doing them.  

# Challenge question A
Challenge_A <- function() {
  # clear any existing graphs and plot your graph within the R window
}

# Challenge question B
Challenge_B <- function() {
  # clear any existing graphs and plot your graph within the R window
}

# Challenge question C
Challenge_C <- function() {
  # clear any existing graphs and plot your graph within the R window
}

# Challenge question D
Challenge_D <- function() {
  # clear any existing graphs and plot your graph within the R window
  return("type your written answer here")
}

# Challenge question E
Challenge_E <- function() {
  # clear any existing graphs and plot your graph within the R window
  return("type your written answer here")
}

# Challenge question F
Challenge_F <- function() {
  # clear any existing graphs and plot your graph within the R window
  return("type your written answer here")
}

# Challenge question G should be written in a separate file that has no dependencies on any functions here.


