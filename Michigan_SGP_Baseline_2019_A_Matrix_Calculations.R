################################################################################
###                                                                          ###
###       Michigan Learning Loss Analyses -- Create Baseline Matrices         ###
###                                                                          ###
################################################################################

### Load necessary packages
require(SGP)

###   Load the results data from the 'official' 2019 SGP analyses
load("Data/Michigan_SGP_LONG_Data.Rdata")

###   Create a smaller subset of the LONG data to work with.
Michigan_Baseline_Data <- data.table::data.table(Michigan_SGP_LONG_Data[, c("VALID_CASE", "CONTENT_AREA", "YEAR", "ID", "GRADE", "SCALE_SCORE", "ACHIEVEMENT_LEVEL"),])

### Modify knots/boundaries in SGPstateData to use equated scale scores properly

SGPstateData[["MI"]][["Achievement"]][["Knots_Boundaries"]][["READING.2018_2019"]] <- NULL
SGPstateData[["MI"]][["Achievement"]][["Knots_Boundaries"]][["MATHEMATICS.2018_2019"]] <- NULL

### Put Grade 8 Reading/Mathematics scores on PSAT scale (2018_2019)
SGPstateData[["MI"]][["Assessment_Program_Information"]][["Assessment_Transition"]][["Year"]] <- "2018_2019"

data.for.equate <- Michigan_Baseline_Data[GRADE=="8" & CONTENT_AREA %in% c("MATHEMATICS", "READING")]

tmp.equate.linkages <- SGP:::equateSGP(
                                tmp.data=data.for.equate,
                                state="MI",
                                current.year="2018_2019",
                                equating.method=c("identity", "mean", "linear", "equipercentile"))

setkey(data.for.equate, VALID_CASE, CONTENT_AREA, YEAR, GRADE, SCALE_SCORE)

data.for.equate <- SGP:::convertScaleScore(data.for.equate, "2018_2019", tmp.equate.linkages, "OLD_TO_NEW", "equipercentile", "MI")
data.for.equate[YEAR %in% c("2015_2016", "2016_2017", "2017_2018"), SCALE_SCORE:=SCALE_SCORE_EQUATED_EQUIPERCENTILE_OLD_TO_NEW]
data.for.equate[,SCALE_SCORE_EQUATED_EQUIPERCENTILE_OLD_TO_NEW:=NULL]

Michigan_Baseline_Data <- rbindlist(list(data.for.equate, Michigan_Baseline_Data[!(GRADE=="8" & CONTENT_AREA %in% c("MATHEMATICS", "READING"))]))
setkey(Michigan_Baseline_Data, VALID_CASE, CONTENT_AREA, YEAR, ID)

###   Read in Baseline SGP Configuration Scripts and Combine
source("SGP_CONFIG/2019/BASELINE/Matrices/READING.R")
source("SGP_CONFIG/2019/BASELINE/Matrices/MATHEMATICS.R")
source("SGP_CONFIG/2019/BASELINE/Matrices/SOCIAL_STUDIES.R")

MI_BASELINE_CONFIG <- c(
	READING_BASELINE.config,
	MATHEMATICS_BASELINE.config
	SOCIAL_STUDIES_BASELINE.config
)

###
###   Create Baseline Matrices

Michigan_SGP <- prepareSGP(Michigan_Baseline_Data, create.additional.variables=FALSE)

MI_Baseline_Matrices <- baselineSGP(
				Michigan_SGP,
				sgp.baseline.config=MI_BASELINE_CONFIG,
				return.matrices.only=TRUE,
				calculate.baseline.sgps=FALSE,
				goodness.of.fit.print=FALSE,
				parallel.config = list(
					BACKEND="PARALLEL", WORKERS=list(TAUS=18))
)

###   Save results
save(MI_Baseline_Matrices, file="Data/MI_Baseline_Matrices.Rdata")
