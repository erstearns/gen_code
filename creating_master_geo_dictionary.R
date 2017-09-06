##############################################
# Code author: Erin Stearns
# Code objective: Creating a comprehensive geo-dictionary to translate codes
# Date: 8.30.2017
#############################################

rm(list = ls()) 

# ----------------------------------------------- set args -------------------------------------------
# ---- library location
my_lib <- ("C:/Users/ErinS/OneDrive - Logic20 20 Inc/Documents/R/win-library/3.4")

# ---- data file path
data_dir <- "C:/Users/ErinS/OneDrive - Logic20 20 Inc/reference_data/"

# ---- ref data file path
refdata_dir <- "C:/Users/ErinS/OneDrive - Logic20 20 Inc/bmfg/data/ref_data/"

# ---- data file
df <- 'iso3_gaul_uni_country_codes.csv'

# ---- country scope
cs <- 'pneumo_country_scope.csv'

# ----------------------------------------------- set up environment -------------------------------------------
.libPaths(my_lib)
pacman::p_load(data.table, magrittr, stringr, reshape2, ggplot2, readbulk, 
               dplyr, Amelia, plyr, xts, doBy, forecast)

# ------------------------------------------------ load data ---------------------------------------------------
# ----Standard geo-code data ----
df1 <- fread(file=paste0(data_dir,df),stringsAsFactors = F)

# ---- Pneumo countries of interest (coi) list from Lola ----
coi <- fread(file=paste0(refdata_dir, cs),stringsAsFactors = F)

# ------------------------------------------------ merge data --------------------------------------------------
#join the two and keep all -- see where mismatched and reconcile

# ---- merge tables to get full list
geo_dict <- merge(df1, coi, by.x = 'ISO3', by.y = 'iso3_code',all=T)

#1 row no match -- Palestine, no GAUL code
rogue <- geo_dict[!is.na(gates_country)& is.na(`Short name`),]

geo_dict1 <- geo_dict[!is.na(gates_country)& is.na(`Short name`), ISO2:='PS']

#write.csv(geo_dict1, file=(paste0(refdata_dir, 'full_geo_dict_w_pneumo_countries.csv')))

#subset to pneumo countries only
geop <- geod[!is.na(gates_country),]

#re-order to what anna said
order <- fread(paste0(refdata_dir, 'pneumo_scope_order.csv'),stringsAsFactors = F)

geop1 <- left_join(order, geop)

write.csv(geop1, file=(paste0(refdata_dir, 'geo_dict_pneumo_countries_ordered.csv')))
