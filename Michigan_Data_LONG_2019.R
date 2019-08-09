##########################################################################
###                                                                    ###
###     Michigan Data prep script using DRC data for up to 2019        ###
###                                                                    ###
##########################################################################

### Load packages

require(data.table)
require(SGP)

### Load Data

load("Data/Base_Files/MStep2019_SGP.RData")
Michigan_Data_LONG_2019 <- MStep.small


### Tidy up data

Michigan_Data_LONG_2019[,CONTENT_AREA:=as.character(CONTENT_AREA)]
Michigan_Data_LONG_2019[,YEAR:=as.character(YEAR)]
Michigan_Data_LONG_2019[,ID:=as.character(ID)]
Michigan_Data_LONG_2019[,GRADE:=as.character(GRADE)]
Michigan_Data_LONG_2019[,SCALE_SCORE:=as.numeric(SCALE_SCORE)]
Michigan_Data_LONG_2019[,VALID_CASE:=as.character(VALID_CASE)]

Michigan_Data_LONG_2019[YEAR=="2018_2019" & GRADE=="8" & CONTENT_AREA=="READING", CONTENT_AREA:="READING_PSAT_8"]
Michigan_Data_LONG_2019[YEAR=="2018_2019" & GRADE=="8" & CONTENT_AREA=="MATHEMATICS", CONTENT_AREA:="MATHEMATICS_PSAT_8"]
Michigan_Data_LONG_2019[YEAR=="2018_2019" & GRADE=="11" & CONTENT_AREA=="READING", CONTENT_AREA:="READING_SAT_11"]
Michigan_Data_LONG_2019[YEAR=="2018_2019" & GRADE=="11" & CONTENT_AREA=="MATHEMATICS", CONTENT_AREA:="MATHEMATICS_SAT_11"]

### Setkey

setkey(Michigan_Data_LONG_2019, VALID_CASE, CONTENT_AREA, YEAR, ID)


### Create Knots/Boundaries for PSAT/SAT content areas for embedding in SGPstateData

#MI_tmp_knots_boundaries <- SGP:::createKnotsBoundaries(MI_tmp_knots_boundaries)


### Save Results

save(Michigan_Data_LONG_2019, file="Data/Michigan_Data_LONG_2019.Rdata")
