##############################################
# Code author: Erin Stearns
# Code objective: Importing excel workbook and each individual sheet
# Date: 8.24.17
#############################################

rm(list = ls()) 

# ----------------------------------------------- set up environment -------------------------------------------
my_lib <- ("C:/Users/ErinS/OneDrive - Logic20 20 Inc/Documents/R/win-library/3.4")
.libPaths(my_lib)
pacman::p_load(fields, data.table, magrittr, stringr, reshape2, ggplot2, readbulk, 
               dplyr, Amelia, plyr, rgdal, raster,  seegSDM, seegMBG, sp, rgeos, maptools, rgeos, rgdal)
