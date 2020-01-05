# CMEE 2019 HPC excercises R code HPC run code proforma

rm(list=ls()) 
graphics.off()
source("jrosinde_HPC_2019_main.R")
#iter <- as.numeric(Sys.getenv("PBS_ARRAY_INDEX"))
#set.seed(iter)
#for (i in 1:100) {
  
 # iter <- sample(100,1,replace = FALSE)
  if (0<iter && iter<=25 ) 
    { size = 500
  } else if(25<iter && iter<=50) 
    { size = 1000
  }else if(50<iter&& iter<=75) 
    { size = 2500
  }else if(75<iter && iter<=100) 
    { size = 5000
  }
  
  name <- paste("my_test_file",iter,sep = "-")
  output_file_name <- paste(name,"rda",sep = ".")
  cluster_run(speciation_rate = 0.002048, size, wall_time=11.5*60, interval_rich=1, interval_oct=size/10 , burn_in_generations=8*size, output_file_name) 
#}
