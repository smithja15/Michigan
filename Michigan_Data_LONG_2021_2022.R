##################################################################################################
###
### Script to take DRC/Jess Smith Data and prepare 2021-2022 for SGP analysis 
###
##################################################################################################

### Load packages
require(data.table)

### Load Data
load("Data/Base_Files/MStep2122.Rdata")
Michigan_Data_LONG_2021_2022 <- dat2122

### Just a little tidying up
Michigan_Data_LONG_2021_2022[,ID:=as.character((ID))]
Michigan_Data_LONG_2021_2022[,GRADE:=as.character((GRADE))]
Michigan_Data_LONG_2021_2022[,SCALE_SCORE:=as.numeric((SCALE_SCORE))]

### Save file
save(Michigan_Data_LONG_2021_2022, file="Data/Michigan_Data_LONG_2021_2022.Rdata")
