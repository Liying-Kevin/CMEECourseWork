# CMEE 2019 HPC excercises R code main proforma
# you don't HAVE to use this but it will be very helpful.  If you opt to write everything yourself from scratch please ensure you use EXACTLY the same function and parameter names and beware that you may loose marks if it doesn't work properly because of not using the proforma.

name <- "liying huang"
preferred_name <- "kevin"
email <- "liying.huang19@imperial.ac.uk"
username <- "lh1019"
personal_speciation_rate <- 0.002 # will be assigned to each person individually in class and should be between 0.002 and 0.007

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
choose_two <- function(max_value){
  a <- sample(max_value,2,replace = FALSE)
  return(a)
}

# Question 5
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
    ChooseOne <- sample(x=a,size=1,replace = FALSE)
      for (i in 1:ChooseOne) {
        community <- neutral_step(community)
      }
  return(community)
}

# Question 7
neutral_time_series <- function(community,duration)  {
  speciesRichnessInit <- species_richness(community)
  for (i in 1:duration) {
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
  plot(b,a,type = "l",xlab = "duration")
  #dev.off()
  # clear any existing graphs and plot your graph within the R window
  return("The system will balance if you wait long enough")
}

# Question 9
neutral_step_speciation <- function(community,speciation_rate)  {
  n <-runif(1,min = 0,max = 1)
  if(n>speciation_rate){
    community <- neutral_step(community)
  }
  else{
    a <- sample(length(community),1,replace = FALSE)
    blist <- setdiff(x=1:10000,y=c(community))
    b <- sample(blist,1,replace = FALSE)
    community[a[1]] <- b
  }
  return(community)
}

# Question 10
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

# Question 11
neutral_time_series_speciation <- function(community,speciation_rate,duration)  {
  speciesRichnessInit <- species_richness(community)
  for (i in 1:duration) {
    community <- neutral_generation_speciation(community,speciation_rate)
    speciesRichnessNext <- species_richness(community)
    speciesRichnessInit <- c(speciesRichnessInit,speciesRichnessNext)
  }
  return(speciesRichnessInit)
}

# Question 12
question_12 <- function()  {
  a <-neutral_time_series_speciation(community = init_community_max(100),duration = 200,speciation_rate = 0.1)
  b <- 1:201
  c <-neutral_time_series_speciation (community = init_community_min(100) , duration = 200, speciation_rate = 0.1) 
  plot(b,a,type = "l",xlab = "duration",col = "red")
  lines(b,c,col = "blue")
  #dev.off()
  return("The system will has large change if you wait long enough")
}

# Question 13
species_abundance <- function(community)  {
  b <- sort(table(community),decreasing = TRUE)
  b <- as.data.frame(b)
  c <- b[,2]
  return(c)
}

# Question 14
octaves <- function(abundance_vector) {
  abundance_vector <- sort(abundance_vector,decreasing = FALSE)
  n <- floor(log2(abundance_vector))+1
  b <- tabulate(n)
  return(b)
  }


# Question 15
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
  for (i in 1:200) {
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
  barplot(octaveAdverge,col = "red")
  
  return("type your written answer here")
}

# Question 17
cluster_run <- function(speciation_rate, size, wall_time, interval_rich, interval_oct, burn_in_generations, output_file_name)  {
  time0 = proc.time()[3]
  community <- init_community_min(size)
  speciesRichnessList <- c()
  octavelist <- list()
  while (wall_time*60>as.numeric(proc.time()[3]-time0)) {
    for (i in 1:burn_in_generations) {
      communitys <- neutral_generation_speciation(community,speciation_rate)
      if (i%%interval_rich ==0) {
        speciesRichness <- species_richness(communitys)
        speciesRichnessList <- c(speciesRichnessList,speciesRichness)
      }
      if (i%%interval_oct ==0) {
        abundance <- species_abundance(community = communitys)
        octave <- octaves(abundance_vector = abundance)
        octavelist[len(octavelist)+1] <- octave
      }
    }
  }

}


# Questions 18 and 19 involve writing code elsewhere to run your simulations on the cluster

# Question 20 
process_cluster_results <- function()  {
  # clear any existing graphs and plot your graph within the R window
  combined_results <- list() #create your list output here to return
  return(combined_results)
}

# Question 21
question_21 <- function()  {
  return("type your written answer here")
}

# Question 22
question_22 <- function()  {
  return("type your written answer here")
}

# Question 23
chaos_game <- function()  {
  # clear any existing graphs and plot your graph within the R window
  return("type your written answer here")
}

# Question 24
turtle <- function(start_position, direction, length)  {

  return() # you should return your endpoint here.
}

# Question 25
elbow <- function(start_position, direction, length)  {
  
}

# Question 26
spiral <- function(start_position, direction, length)  {
  return("type your written answer here")
}

# Question 27
draw_spiral <- function()  {
  # clear any existing graphs and plot your graph within the R window
  
}

# Question 28
tree <- function(start_position, direction, length)  {
  
}
draw_tree <- function()  {
  # clear any existing graphs and plot your graph within the R window
}

# Question 29
fern <- function(start_position, direction, length)  {
  
}
draw_fern <- function()  {
  # clear any existing graphs and plot your graph within the R window
}

# Question 30
fern2 <- function(start_position, direction, length)  {
  
}
draw_fern2 <- function()  {
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


