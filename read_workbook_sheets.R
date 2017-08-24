##############################################
# Code author: Erin Stearns
# Code objective: Importing excel workbook and each individual sheet
# Date: 8.24.17
# Special notes: need to have Java installed on computer, same bit as R version(32-bit is default version available for download)
#############################################

rm(list = ls()) 

# ----------------------------------------------- set args -------------------------------------------
my_lib <- ("C:/Users/ErinS/OneDrive - Logic20 20 Inc/Documents/R/win-library/3.4")
data_dir <- 'C:/Users/ErinS/Desktop/'
workbook_name <- 'test.xlsx'

# ----------------------------------------------- set up environment -------------------------------------------
.libPaths(my_lib)
pacman::p_load(data.table, dplyr,plyr,XLConnect)
# ----------------------------------------------- load data -------------------------------------------
pizza <- loadWorkbook(paste0(data_dir, workbook_name))

sheet_names <- getSheets(pizza)
names(sheet_names) <- sheet_names

sheet_list <- lapply(sheet_names, function(.sheet){
  readWorksheet(object=pizza, .sheet)})



