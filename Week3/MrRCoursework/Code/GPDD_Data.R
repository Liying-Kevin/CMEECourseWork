install.packages("maps")
library(maps)
load("../data/GPDDFiltered.RData")
gpdds <-data.frame(gpdd)
map("world", fill = TRUE, col = rainbow(200),
    ylim = c(-60, 90), mar = c(0, 0, 0, 0))
title("world map")