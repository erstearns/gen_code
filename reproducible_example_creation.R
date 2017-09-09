###################################
# code author: e. stearns
# code objective: creating a reprodicible code example for stack overflow help
# date: 9/5/2017
###################################

library(data.table)

# ------------------------------------------------ data creation ------------------------------------------
# ---- Population dataset
population <- data.table(matrix(ncol = 101, nrow = 101))
colnames(population) <- as.character(seq(from=1, to=101, by=1))
set.seed(51)
for (n in 1:ncol(population)){
  population[,(paste0(n)):=(abs(rnorm(101,mean = 0,sd = 1))*1000)]
}
population[,year:=seq(from=2000, to=2100, by=1)]
population[,country:='Narnia']
population <- population[,c(103,102,1:101),with=F]

# ---- Burden dataset
burden <- data.table(country = rep('Narnia', times=101),
                     year=seq(from=2000, to=2100, by=1)
                     )
burdcolnames <- c('1-4 years', '5-9 years', '10-14 years', '15-19 years', '20-24 years', '25-29 years', '30-34 years',
                  '35-39 years', '40-44 years', '45-49 years', '50-54 years', '55-59 years', '60-64 years', 
                  '65-69 years', '70-74 years', '75-79 years', '80+ years')
set.seed(102)
for (i in 1:length(burdcolnames)){
  burden[,burdcolnames[i]:=(abs(rnorm(101,mean = 0,sd = 1))*100)]
}

# ------------------------------------------------ population data manipulation ----------------------------

#creating groups in population data
population$ages1_4 <- apply(population[,c(2:6)],1,sum)
population$ages5_9 <- apply(population[,c(7:11)],1,sum)
population$ages10_14 <- apply(population[,c(12:16)],1,sum)
population$ages15_19 <- apply(population[,c(17:21)],1,sum)
population$ages20_24 <- apply(population[,c(22:26)],1,sum)
population$ages25_29 <- apply(population[,c(27:31)],1,sum)
population$ages30_34 <- apply(population[,c(32:36)],1,sum)
population$ages35_39 <- apply(population[,c(37:41)],1,sum)
population$ages40_44 <- apply(population[,c(42:46)],1,sum)
population$ages45_49 <- apply(population[,c(47:51)],1,sum)
population$ages50_54 <- apply(population[,c(52:56)],1,sum)
population$ages55_59 <- apply(population[,c(57:61)],1,sum)
population$ages60_64 <- apply(population[,c(62:66)],1,sum)
population$ages65_69 <- apply(population[,c(67:71)],1,sum)
population$ages70_74 <- apply(population[,c(72:76)],1,sum)
population$ages75_79 <- apply(population[,c(77:81)],1,sum)
population$ages80_up <- apply(population[,c(82:86)],1,sum)

#creating proportions for each age
# for 2-4
population[,p_1:=population$`1`/ages1_4]
population[,p_2:=population$`2` /ages1_4]
population[,p_3:=population$`3`/ages1_4]
population[,p_4:=population$`4`/ages1_4]

# for 5-9
population[,p_5:=population$`5`/ages5_9]
population[,p_6:=population$`6`/ages5_9]
population[,p_7:=population$`7`/ages5_9]
population[,p_8:=population$`8`/ages5_9]
population[,p_9:=population$`9`/ages5_9]

# for 10-14
population[,p_10:=population$`10`/ages10_14]
population[,p_11:=population$`11`/ages10_14]
population[,p_12:=population$`12`/ages10_14]
population[,p_13:=population$`13`/ages10_14]
population[,p_14:=population$`14`/ages10_14]

# for 15-19
population[,p_15:=population$`15`/ages15_19]
population[,p_16:=population$`16`/ages15_19]
population[,p_17:=population$`17`/ages15_19]
population[,p_18:=population$`18`/ages15_19]
population[,p_19:=population$`19`/ages15_19]

# for 20-24
population[,p_20:=population$`20`/ages20_24]
population[,p_21:=population$`21`/ages20_24]
population[,p_22:=population$`22`/ages20_24]
population[,p_23:=population$`23`/ages20_24]
population[,p_24:=population$`24`/ages20_24]

# for 25-29
population[,p_25:=population$`25`/ages25_29]
population[,p_26:=population$`26`/ages25_29]
population[,p_27:=population$`27`/ages25_29]
population[,p_28:=population$`28`/ages25_29]
population[,p_29:=population$`29`/ages25_29]

# for 30-34
population[,p_30:=population$`30`/ages30_34]
population[,p_31:=population$`31`/ages30_34]
population[,p_32:=population$`32`/ages30_34]
population[,p_33:=population$`33`/ages30_34]
population[,p_34:=population$`34`/ages30_34]

# for 35-39
population[,p_35:=population$`35`/ages35_39]
population[,p_36:=population$`36`/ages35_39]
population[,p_37:=population$`37`/ages35_39]
population[,p_38:=population$`38`/ages35_39]
population[,p_39:=population$`39`/ages35_39]

# for 40-44
population[,p_40:=population$`40`/ages40_44]
population[,p_41:=population$`41`/ages40_44]
population[,p_42:=population$`42`/ages40_44]
population[,p_43:=population$`43`/ages40_44]
population[,p_44:=population$`44`/ages40_44]

# for 45-49
population[,p_45:=population$`45`/ages45_49]
population[,p_46:=population$`46`/ages45_49]
population[,p_47:=population$`47`/ages45_49]
population[,p_48:=population$`48`/ages45_49]
population[,p_49:=population$`49`/ages45_49]

# for 50-54
population[,p_50:=population$`50`/ages50_54]
population[,p_51:=population$`51`/ages50_54]
population[,p_52:=population$`52`/ages50_54]
population[,p_53:=population$`53`/ages50_54]
population[,p_54:=population$`54`/ages50_54]

# for 55-59
population[,p_55:=population$`55`/ages55_59]
population[,p_56:=population$`56`/ages55_59]
population[,p_57:=population$`57`/ages55_59]
population[,p_58:=population$`58`/ages55_59]
population[,p_59:=population$`59`/ages55_59]

# for 60-64
population[,p_60:=population$`60`/ages60_64]
population[,p_61:=population$`61`/ages60_64]
population[,p_62:=population$`62`/ages60_64]
population[,p_63:=population$`63`/ages60_64]
population[,p_64:=population$`64`/ages60_64]

# for 65-69
population[,p_65:=population$`65`/ages65_69]
population[,p_66:=population$`66`/ages65_69]
population[,p_67:=population$`67`/ages65_69]
population[,p_68:=population$`68`/ages65_69]
population[,p_69:=population$`69`/ages65_69]

# for 70-74
population[,p_70:=population$`70`/ages70_74]
population[,p_71:=population$`71`/ages70_74]
population[,p_72:=population$`72`/ages70_74]
population[,p_73:=population$`73`/ages70_74]
population[,p_74:=population$`74`/ages70_74]

# for 75-79
population[,p_75:=population$`75`/ages75_79]
population[,p_76:=population$`76`/ages75_79]
population[,p_77:=population$`77`/ages75_79]
population[,p_78:=population$`78`/ages75_79]
population[,p_79:=population$`79`/ages75_79]

# for 80+
population[,p_80:=population$`80`/ages80_up]
population[,p_81:=population$`81`/ages80_up]
population[,p_82:=population$`82`/ages80_up]
population[,p_83:=population$`83`/ages80_up]
population[,p_84:=population$`84`/ages80_up]
population[,p_85:=population$`85`/ages80_up]
population[,p_86:=population$`86`/ages80_up]
population[,p_87:=population$`87`/ages80_up]
population[,p_88:=population$`88`/ages80_up]
population[,p_89:=population$`89`/ages80_up]
population[,p_90:=population$`90`/ages80_up]
population[,p_91:=population$`91`/ages80_up]
population[,p_92:=population$`92`/ages80_up]
population[,p_93:=population$`93`/ages80_up]
population[,p_94:=population$`94`/ages80_up]
population[,p_95:=population$`95`/ages80_up]
population[,p_96:=population$`96`/ages80_up]
population[,p_97:=population$`97`/ages80_up]
population[,p_98:=population$`98`/ages80_up]
population[,p_99:=population$`99`/ages80_up]
population[,p_100:=population$`100`/ages80_up]
population[,p_101:=population$`101`/ages80_up]

#subset to p_xxx relevent cols
p_age<- population[,c(1:2,121:221),with=FALSE]

# ------------------------------------------------ make annual age burden dataset --------------------------------------

# merge datasets
burd_pop <- merge(burden, p_age, by = c('country', 'year'))

#for 0-4
burd_pop[,age_0:=lt1]
burd_pop[,age_1:=(p_1*burd_pop$`1-4 years`)]
burd_pop[,age_2:=(p_2*burd_pop$`1-4 years`)]
burd_pop[,age_3:=(p_3*burd_pop$`1-4 years`)]
burd_pop[,age_4:=(p_4*burd_pop$`1-4 years`)]

# for 5-9
burd_pop[,age_5:=p_5*burd_pop$`5-9 years`]
burd_pop[,age_6:=p_6*burd_pop$`5-9 years`]
burd_pop[,age_7:=p_7*burd_pop$`5-9 years`]
burd_pop[,age_8:=p_8*burd_pop$`5-9 years`]
burd_pop[,age_9:=p_9*burd_pop$`5-9 years`]

# for 10-14
burd_pop[,age_10:=p_10*burd_pop$`10-14 years`]
burd_pop[,age_11:=p_11*burd_pop$`10-14 years`]
burd_pop[,age_12:=p_12*burd_pop$`10-14 years`]
burd_pop[,age_13:=p_13*burd_pop$`10-14 years`]
burd_pop[,age_14:=p_14*burd_pop$`10-14 years`]

# for 15-19
burd_pop[,age_15:=p_15*burd_pop$`15-19 years`]
burd_pop[,age_16:=p_16*burd_pop$`15-19 years`]
burd_pop[,age_17:=p_17*burd_pop$`15-19 years`]
burd_pop[,age_18:=p_18*burd_pop$`15-19 years`]
burd_pop[,age_19:=p_19*burd_pop$`15-19 years`]

# for 20-24
burd_pop[,age_20:=p_20*burd_pop$`20-24 years`]
burd_pop[,age_21:=p_21*burd_pop$`20-24 years`]
burd_pop[,age_22:=p_22*burd_pop$`20-24 years`]
burd_pop[,age_23:=p_23*burd_pop$`20-24 years`]
burd_pop[,age_24:=p_24*burd_pop$`20-24 years`]

# for 25-29
burd_pop[,age_25:=p_25*burd_pop$`25-29 years`]
burd_pop[,age_26:=p_26*burd_pop$`25-29 years`]
burd_pop[,age_27:=p_27*burd_pop$`25-29 years`]
burd_pop[,age_28:=p_28*burd_pop$`25-29 years`]
burd_pop[,age_29:=p_29*burd_pop$`25-29 years`]

# for 30-34
burd_pop[,age_30:=p_30*burd_pop$`30-34 years`]
burd_pop[,age_31:=p_31*burd_pop$`30-34 years`]
burd_pop[,age_32:=p_32*burd_pop$`30-34 years`]
burd_pop[,age_33:=p_33*burd_pop$`30-34 years`]
burd_pop[,age_34:=p_34*burd_pop$`30-34 years`]

# for 35-39
burd_pop[,age_35:=p_35*burd_pop$`35-39 years`]
burd_pop[,age_36:=p_36*burd_pop$`35-39 years`]
burd_pop[,age_37:=p_37*burd_pop$`35-39 years`]
burd_pop[,age_38:=p_38*burd_pop$`35-39 years`]
burd_pop[,age_39:=p_39*burd_pop$`35-39 years`]

# for 40-44
burd_pop[,age_40:=p_40*burd_pop$`40-44 years`]
burd_pop[,age_41:=p_41*burd_pop$`40-44 years`]
burd_pop[,age_42:=p_42*burd_pop$`40-44 years`]
burd_pop[,age_43:=p_43*burd_pop$`40-44 years`]
burd_pop[,age_44:=p_44*burd_pop$`40-44 years`]

# for 45-49
burd_pop[,age_45:=p_45*burd_pop$`45-49 years`]
burd_pop[,age_46:=p_46*burd_pop$`45-49 years`]
burd_pop[,age_47:=p_47*burd_pop$`45-49 years`]
burd_pop[,age_48:=p_48*burd_pop$`45-49 years`]
burd_pop[,age_49:=p_49*burd_pop$`45-49 years`]

# for 50-54
burd_pop[,age_50:=p_50*burd_pop$`50-54 years`]
burd_pop[,age_51:=p_51*burd_pop$`50-54 years`]
burd_pop[,age_52:=p_52*burd_pop$`50-54 years`]
burd_pop[,age_53:=p_53*burd_pop$`50-54 years`]
burd_pop[,age_54:=p_54*burd_pop$`50-54 years`]

# for 55-59
burd_pop[,age_55:=p_55*burd_pop$`55-59 years`]
burd_pop[,age_56:=p_56*burd_pop$`55-59 years`]
burd_pop[,age_57:=p_57*burd_pop$`55-59 years`]
burd_pop[,age_58:=p_58*burd_pop$`55-59 years`]
burd_pop[,age_59:=p_59*burd_pop$`55-59 years`]

# for 60-64
burd_pop[,age_60:=p_60*burd_pop$`60-64 years`]
burd_pop[,age_61:=p_61*burd_pop$`60-64 years`]
burd_pop[,age_62:=p_62*burd_pop$`60-64 years`]
burd_pop[,age_63:=p_63*burd_pop$`60-64 years`]
burd_pop[,age_64:=p_64*burd_pop$`60-64 years`]

# for 65-69
burd_pop[,age_65:=p_65*burd_pop$`65-69 years`]
burd_pop[,age_66:=p_66*burd_pop$`65-69 years`]
burd_pop[,age_67:=p_67*burd_pop$`65-69 years`]
burd_pop[,age_68:=p_68*burd_pop$`65-69 years`]
burd_pop[,age_69:=p_69*burd_pop$`65-69 years`]

# for 70-74
burd_pop[,age_70:=p_70*burd_pop$`70-74 years`]
burd_pop[,age_71:=p_71*burd_pop$`70-74 years`]
burd_pop[,age_72:=p_72*burd_pop$`70-74 years`]
burd_pop[,age_73:=p_73*burd_pop$`70-74 years`]
burd_pop[,age_74:=p_74*burd_pop$`70-74 years`]

# for 75-79
burd_pop[,age_75:=p_75*burd_pop$`75-79 years`]
burd_pop[,age_76:=p_76*burd_pop$`75-79 years`]
burd_pop[,age_77:=p_77*burd_pop$`75-79 years`]
burd_pop[,age_78:=p_78*burd_pop$`75-79 years`]
burd_pop[,age_79:=p_79*burd_pop$`75-79 years`]

# for 80+
burd_pop[,age_80:=p_80*burd_pop$`80+ years`]
burd_pop[,age_81:=p_81*burd_pop$`80+ years`]
burd_pop[,age_82:=p_82*burd_pop$`80+ years`]
burd_pop[,age_83:=p_83*burd_pop$`80+ years`]
burd_pop[,age_84:=p_84*burd_pop$`80+ years`]
burd_pop[,age_85:=p_85*burd_pop$`80+ years`]
burd_pop[,age_86:=p_86*burd_pop$`80+ years`]
burd_pop[,age_87:=p_87*burd_pop$`80+ years`]
burd_pop[,age_88:=p_88*burd_pop$`80+ years`]
burd_pop[,age_89:=p_89*burd_pop$`80+ years`]
burd_pop[,age_90:=p_90*burd_pop$`80+ years`]
burd_pop[,age_91:=p_91*burd_pop$`80+ years`]
burd_pop[,age_92:=p_92*burd_pop$`80+ years`]
burd_pop[,age_93:=p_93*burd_pop$`80+ years`]
burd_pop[,age_94:=p_94*burd_pop$`80+ years`]
burd_pop[,age_95:=p_95*burd_pop$`80+ years`]
burd_pop[,age_96:=p_96*burd_pop$`80+ years`]
burd_pop[,age_97:=p_97*burd_pop$`80+ years`]
burd_pop[,age_98:=p_98*burd_pop$`80+ years`]
burd_pop[,age_99:=p_99*burd_pop$`80+ years`]
burd_pop[,age_100:=p_100*burd_pop$`80+ years`]
burd_pop[,age_101:=p_101*burd_pop$`80+ years`]

# ------------------------------------------------ desired final format --------------------------------------


final_format <- burd_pop[,c(1:2, 121:221),with=FALSE]


# ------------------------------------------------ dcast issue --------------------------------
test1 <- dcast(rd14, gates_country + ihme_country +iso3_code + year + cause ~ age + measure)

test2 <- dcast(v_1, gates_country + ihme_country +iso3_code + year + cause ~ measure, value.var = c("lt1",
                                                                                                    "age_1", 
                                                                                                    "age_2_4",
                                                                                                    "gt5"))


