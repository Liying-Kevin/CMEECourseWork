#!/bin/bash 
#PBS -l walltime=12:00:00 
#PBS -l select=1:ncpus=1:mem=1gb 
module load anaconda3/personal 
echo "R is about to run" 
cp $HOME/liying/jrosinde_HPC_2019_main.R
R --vanilla < $HOME/liying/jrosinde_HPC_2019_cluster.R
cp *.rda $HOME/liying
echo "R has finished running" 
# this is a comment at the end of the file