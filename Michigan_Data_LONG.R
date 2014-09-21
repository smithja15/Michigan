######################################################################################
###
### R script for creations of Michigan LONG data file
###
######################################################################################

### Load Packages

require(data.table)


### Load raw data files

MEAP_2012_2013_SGP <- fread("Data/Base_Files/MEAP_2012_13_SGP.txt", sep="|", colClasses=rep("character", 6))
MEAP_2013_2014_SGP <- fread("Data/Base_Files/MEAP_2013_14_SGP.txt", sep="|", colClasses=rep("character", 6))
MME_2012_2013_SGP <- fread("Data/Base_Files/MME_2012_13_SGP.txt", sep="|", colClasses=rep("character", 6))
MME_2013_2014_SGP <- fread("Data/Base_Files/MME_2013_14_SGP.txt", sep="|", colClasses=rep("character", 6))


### Tidy up data

MME_2012_2013_SGP[,GRADE:="EOCT"]
MME_2012_2013_SGP[,SCALE_SCORE:=as.numeric(SCALE_SCORE)]
MME_2013_2014_SGP[,GRADE:="EOCT"]
MME_2013_2014_SGP[,SCALE_SCORE:=as.numeric(SCALE_SCORE)]
MEAP_2012_2013_SGP[,GRADE:=as.character(as.numeric(GRADE))]
MEAP_2012_2013_SGP[,SCALE_SCORE:=as.numeric(SCALE_SCORE)]
MEAP_2013_2014_SGP[,SCALE_SCORE:=as.numeric(SCALE_SCORE)]


### Stack data up:

Michigan_Data_LONG <- rbindlist(list(MEAP_2012_2013_SGP, MEAP_2013_2014_SGP, MME_2012_2013_SGP, MME_2013_2014_SGP))
setnames(Michigan_Data_LONG, 1, "ID")


### Deal with duplicates

setkey(Michigan_Data_LONG, VALID_CASE, CONTENT_AREA, YEAR, ID, GRADE, SCALE_SCORE)
setkey(Michigan_Data_LONG, VALID_CASE, CONTENT_AREA, YEAR, ID)
Michigan_Data_LONG[which(duplicated(Michigan_Data_LONG))-1, VALID_CASE:="INVALID_CASE"]

### Save results

save(Michigan_Data_LONG, file="Data/Michigan_Data_LONG.Rdata")
