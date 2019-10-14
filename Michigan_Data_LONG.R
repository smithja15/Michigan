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
Michigan_Data_LONG_P1 <- MStep.small
load("Data/Base_Files/PSAT2019_SGP_v2.RData")
Michigan_Data_LONG_P2 <- MStep.small


### Clean up CSEM variable in P2

Michigan_Data_LONG_P2[,CSEM:=as.character(CSEM)]
Michigan_Data_LONG_P2[CSEM=="NULL",CSEM:=NA]
Michigan_Data_LONG_P2[,CSEM:=as.numeric(CSEM)]


### rbind data, tidy up and remove duplicates



Michigan_Data_LONG <- rbindlist(list(Michigan_Data_LONG_P1, Michigan_Data_LONG_P2))

Michigan_Data_LONG[,CONTENT_AREA:=as.character(CONTENT_AREA)]
Michigan_Data_LONG[CONTENT_AREA=="English Language Arts", CONTENT_AREA:="READING"]
Michigan_Data_LONG[CONTENT_AREA=="Mathematics", CONTENT_AREA:="MATHEMATICS"]
Michigan_Data_LONG[CONTENT_AREA=="Social Studies", CONTENT_AREA:="SOCIAL_STUDIES"]
Michigan_Data_LONG[,YEAR:=as.character(YEAR)]
Michigan_Data_LONG[,YEAR:=gsub("-", "_", YEAR)]
Michigan_Data_LONG[,ID:=as.character(ID)]
Michigan_Data_LONG[,GRADE:=as.character(GRADE)]
Michigan_Data_LONG[,SCALE_SCORE:=as.numeric(SCALE_SCORE)]
Michigan_Data_LONG[,VALID_CASE:=as.character(VALID_CASE)]

setkey(Michigan_Data_LONG, VALID_CASE, CONTENT_AREA, YEAR, GRADE, ID, SCALE_SCORE)
Michigan_Data_LONG <- Michigan_Data_LONG[which(duplicated(Michigan_Data_LONG, by=key(Michigan_Data_LONG)))-1, VALID_CASE:="INVALID_CASE"]
Michigan_Data_LONG <- Michigan_Data_LONG[VALID_CASE=="VALID_CASE"]

Michigan_Data_LONG[GRADE %in% c("9", "10", "11"), TESTING_PROGRAM:="COLLEGE BOARD"]
Michigan_Data_LONG[GRADE=="8" & YEAR=="2018_2019", TESTING_PROGRAM:="COLLEGE BOARD"]
Michigan_Data_LONG[is.na(TESTING_PROGRAM), TESTING_PROGRAM:="MSTEP"]


### Setkey

setkey(Michigan_Data_LONG, VALID_CASE, CONTENT_AREA, YEAR, GRADE, ID)


### Create Knots/Boundaries for PSAT/SAT content areas for embedding in SGPstateData

#MI_tmp_knots_boundaries <- SGP:::createKnotsBoundaries(MI_tmp_knots_boundaries)


### Save Results

save(Michigan_Data_LONG, file="Data/Michigan_Data_LONG.Rdata")
