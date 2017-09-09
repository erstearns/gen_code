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



# --------- making efficacy matrix code production dynamic
#be sure to define: age_bins, start_per, end_per
scenarios <- c('wcv', 'pcv20', 'pcv10_15')

#create an empty matrix
for (s in scenarios){
    num_cols <- (age_bins + 3)
    num_rows <- (((end_per - start_per) + 1) * num_countries)

    eff <- data.table(matrix(ncol = num_cols, nrow = num_rows))

    # - Setting column names
    cols1 <- c('scenario', 'country', 'year')

    #create age colnames
    ages <- c()
    for(i in (seq(0,100,by=1))){
      age <- paste0('age_', i)
      ages <- c(ages,age)
    }
    all_cols <- c(cols1, ages)

    #rename columns
    colnames(eff) <- all_cols

    #make sure age cols are numeric
    eff[,(ages):= lapply(.SD, as.numeric), .SDcols=ages]

    #label rows with country names
    ctrs <- c(unique(bd2$iso3_code))
    compl_country_vec <- sort(rep(ctrs,((end_per - start_per) + 1)))
    eff[,country:=compl_country_vec]

    #label rows with years
    years <- seq(from=start_per, to=end_per, by=1)
    compl_years_vec <- (rep(years,num_countries))
    eff[,year:=compl_years_vec]

    #label rows with scenario
    scenario_name <- s
    compl_scen_vec <- rep(scenario_name,num_rows)
    eff[,scenario:=compl_scen_vec]

    eff1 <- copy(eff)

    for (c in (ctrs)){
      for (y in (years)){
        for (a in (seq(0,100,by=1))){
            #establishing years of coverage by product
            ifelse(s=='wcv',
              (pcv_range <- seq((pi1[iso3_code == c,]$pcv10),(pi1[iso3_code == c,]$wcv - 1), by=1)
              newprod_range <- seq((pi1[iso3_code == c,]$wcv),end_per, by=1)),
                    ifelse(s=='pcv20',
                    (pcv_range <- seq((pi1[iso3_code == c,]$pcv10),(pi1[iso3_code == c,]$pcv20 - 1), by=1)
                    newprod_range <- seq((pi1[iso3_code == c,]$pcv20),end_per, by=1)),
                    (pcv_range <- seq((pi1[iso3_code == c,]$pcv10), end_per, by=1))
                            ))
            #setting year
            year_fori <- y

            #setting age for iteration
            age <- a
            age_col <- paste0('age_',a)

            ifelse(s=='wcv',
                     (efficacy_u5 <- 0.95
                      efficacy_5o <- 0.95),
                    ifelse(s=='pcv20',
                             (efficacy_u5 <- 0.83
                              efficacy_5o <- 0.63),
                            ))
            pcv10_u5_eff <- 0.6
            pcv10_5o_eff <- 0.4

            #setting efficacy based on country, age and year
            if(s == ('wcv'|'pcv20'),
            ifelse((a < 5 & year_fori %in% pcv_range), eff1[country==c & year==year_fori,(age_col):=pcv10_u5_eff],
                   ifelse((a < 5 & year_fori %in% newprod_range), eff1[country==c & year==year_fori,(age_col):=efficacy_u5],
                          ifelse((a >= 5 & year_fori %in% pcv_range), eff1[country==c & year==year_fori,(age_col):=pcv10_5o_eff],
                                 ifelse((a >= 5 & year_fori %in% newprod_range), eff1[country==c & year==year_fori,(age_col):=efficacy_5o], 0
                               )))),
            ifelse((a < 5 & year_fori %in% pcv_range), eff003[country==c & year==year_fori,(age_col):=pcv10_u5_eff],
            ifelse((a >= 5 & year_fori %in% pcv_range), eff003[country==c & year==year_fori,(age_col):=pcv10_5o_eff], NA
                              ))
                )

           write.csv(eff1,file=paste0(data_dir, s,'_efficacy_scenario.csv'))

        }
      }
    }
}
