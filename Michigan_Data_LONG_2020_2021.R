##################################################################################################
###
### Script to take DRC/Jess Smith Data and add in equated Scale Score for Grade 8 pre-2018-2019
###
##################################################################################################

### Load packages
require(data.table)

### Load Data
Michigan_Data_LONG_2020_2021 <- as.data.table(readRDS("Data/Base_Files/MStep_2021.rds"))
Equipercentile_Lookup <- fread("Data/Linkages_2018_2019/Michigan_Scale_Score_Linkages_EQUIPERCENTILE_OLD_TO_NEW.txt", colClasses=c(rep("character", 3), rep("numeric", 2)))[GRADE=="8" & CONTENT_AREA %in% c("READING", "MATHEMATICS") & YEAR < "2018_2019"]

### Create SCALE_SCORE_EQUATED and merge 8th Grade equated scores
setkey(Michigan_Data_LONG_2020_2021, VALID_CASE, CONTENT_AREA, YEAR, GRADE, SCALE_SCORE)
Equipercentile_Lookup[,VALID_CASE:="VALID_CASE"]
setkey(Equipercentile_Lookup, VALID_CASE, CONTENT_AREA, YEAR, GRADE, SCALE_SCORE)
setnames(Equipercentile_Lookup, "SCALE_SCORE_EQUATED_EQUIPERCENTILE_OLD_TO_NEW", "SCALE_SCORE_EQUATED")
Michigan_Data_LONG_2020_2021 <- Equipercentile_Lookup[Michigan_Data_LONG_2020_2021]
Michigan_Data_LONG_2020_2021[!(GRADE=="8" & CONTENT_AREA %in% c("READING", "MATHEMATICS") & YEAR < "2018_2019"),SCALE_SCORE_EQUATED:=SCALE_SCORE]


### Save file
save(Michigan_Data_LONG_2020_2021, file="Data/Base_Files/MStep_2021_w_Equated_Scores.Rdata")
