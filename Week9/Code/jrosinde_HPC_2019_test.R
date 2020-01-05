# CMEE 2019 HPC excercises R code HPC run code proforma

rm(list=ls()) # good practice 
source("jrosinde_HPC_2019_main.R")
# it should take a faction of a second to source your file
# if it takes longer you're using the main file to do actual simulations
# it should be used only for defining functions that will be useful for your cluster run and which will be marked automatically

# do what you like here to test your functions (this won't be marked)
# for example
species_richness(c(1,4,4,5,1,6,1))
init_community_max(7)
init_community_min(4)
choose_two(4)
neutral_step(c(10,5,13))
neutral_generation(c(10,5,13,12,14))
neutral_time_series (community = init_community_max(7) , duration = 20) 
question_8()
neutral_step_speciation(c(10,5,13),speciation_rate = 0.2) 
neutral_generation_speciation(c(10,5,13,12,14),speciation_rate = 0.2) 
neutral_time_series_speciation(community = init_community_max(7),duration = 20,speciation_rate = 0.1)
question_12()
species_abundance(c(1,1,1)) 
sum_vect(c(1,3),c(1,0,5,2))
octaves(c(100,64,63,5,4,3,2,2,1,1,1,1)) 
question_16()
cluster_run(speciation_rate = 0.1, size=100, wall_time=1, interval_rich=1, interval_oct=10, burn_in_generations=200, output_file_name="my_test_file_1.rda") 
process_cluster_results()
chaos_game()
plot(0,0,xlim = c(0,8),ylim = c(-2,5),main = "turtle", xlab = " ",ylab = " ", "l")
turtle(start_position = c(0,0), direction = pi/2, length = 3)
elbow(start_position = c(0,0),direction = pi/2, length = 3)
spiral(start_position = c(0,0),direction = pi/2, length = 3)
draw_spiral()
draw_tree()
draw_fern()
draw_fern2()

# you may also like to use this file for playing around and debugging
# but please make sure it's all tidied up by the time it's made its way into the main.R file or other files.
