###################################################
# code author: erin stearns
# code objective: a code space to optimize code
# date: 9/5/2017
###################################################
rm(list = ls())

# ----------------------------------------------- set args ----------------------------------------------------
# ---- library location
my_lib <- ("C:/Users/ErinS/OneDrive - Logic20 20 Inc/Documents/R/win-library/3.4")

# ---- modified data file path
savedata_dir <- "C:/Users/ErinS/OneDrive - Logic20 20 Inc/bmgf/pneumo/data/modified_data/"
# ----------------------------------------------- set up environment -------------------------------------------
.libPaths(my_lib)
pacman::p_load(data.table, magrittr, stringr, reshape2, ggplot2, readbulk,
               dplyr, Amelia, plyr, xts, doBy, forecast)
# ------------------------------------------------ load data ---------------------------------------------------
df <- fread(paste0(savedata_dir,'un_pop_1990_2100_by_age&by_cohort.csv'),stringsAsFactors = F)
df <- df[,-c('V1')]

# ----------------------------------------------- creating pop dataset that creates proportions within bins for each age -----
cols2bgrouped <- all2[,c(11:106)]
