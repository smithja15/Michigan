#####################################################################################
###                                                                               ###
###           SGP LAGGED projections for skip year SGP analyses for 2021-2022     ###
###                                                                               ###
#####################################################################################

###   Load packages
require(SGP)
require(SGPmatrices)
require(data.table)

###   Load data
load("Data/Michigan_SGP.Rdata")

###   Load configurations
source("SGP_CONFIG/2021_2022/PART_C/READING.R")
source("SGP_CONFIG/2021_2022/PART_C/MATHEMATICS.R")

MI_2021_2022.config <- c(READING_2021_2022.config, MATHEMATICS_2021_2022.config)

### Parameters
parallel.config <- list(BACKEND="PARALLEL", WORKERS=list(PERCENTILES=4, BASELINE_PERCENTILES=4, PROJECTIONS=4, LAGGED_PROJECTIONS=4, SGP_SCALE_SCORE_TARGETS=4))

###   Setup SGPstateData with baseline coefficient matrices grade specific projection sequences

###   Add Baseline matrices to SGPstateData and update SGPstateData
SGPstateData <- addBaselineMatrices("MI", "2021_2022")
SGPstateData[["MI"]][["Growth"]][["System_Type"]] <- "Baseline Referenced"
SGPstateData[["MI"]][["Assessment_Program_Information"]][["Assessment_Transition"]] <- NULL

#  Establish required meta-data for LAGGED projection sequences
SGPstateData[["MI"]][["SGP_Configuration"]][["grade.projection.sequence"]] <- list(
    READING_GRADE_3=c(3, 4, 5, 6, 7, 8, 9, 10, 11),
    READING_GRADE_4=c(3, 4, 5, 6, 7, 8, 9, 10, 11),
    READING_GRADE_5=c(3, 4, 5, 6, 7, 8, 9, 10, 11),
    READING_GRADE_6=c(3, 6, 7, 8, 9, 10, 11),
    READING_GRADE_7=c(3, 4, 7, 8, 9, 10, 11),
    READING_GRADE_8=c(3, 4, 5, 8, 9, 10, 11),
    READING_GRADE_9=c(3, 4, 5, 6, 9, 10, 11),
    READING_GRADE_10=c(3, 4, 5, 6, 7, 10, 11),
    READING_GRADE_11=c(3, 4, 5, 6, 7, 8, 11),
    READING_GRADE_8_to_11=c(3, 4, 5, 6, 7, 8, 11),
    MATHEMATICS_GRADE_3=c(3, 4, 5, 6, 7, 8, 9, 10, 11),
    MATHEMATICS_GRADE_4=c(3, 4, 5, 6, 7, 8, 9, 10, 11),
    MATHEMATICS_GRADE_5=c(3, 4, 5, 6, 7, 8, 9, 10, 11),
    MATHEMATICS_GRADE_6=c(3, 6, 7, 8, 9, 10, 11),
    MATHEMATICS_GRADE_7=c(3, 4, 7, 8, 9, 10, 11),
    MATHEMATICS_GRADE_8=c(3, 4, 5, 8, 9, 10, 11),
    MATHEMATICS_GRADE_9=c(3, 4, 5, 6, 9, 10, 11),
    MATHEMATICS_GRADE_10=c(3, 4, 5, 6, 7, 10, 11),
    MATHEMATICS_GRADE_11=c(3, 4, 5, 6, 7, 8, 11),
    MATHEMATICS_GRADE_8_to_11=c(3, 4, 5, 6, 7, 8, 11))
SGPstateData[["MI"]][["SGP_Configuration"]][["content_area.projection.sequence"]] <- list(
    READING_GRADE_3=rep("READING", 9),
    READING_GRADE_4=rep("READING", 9),
    READING_GRADE_5=rep("READING", 9),
    READING_GRADE_6=rep("READING", 7),
    READING_GRADE_7=rep("READING", 7),
    READING_GRADE_8=rep("READING", 7),
    READING_GRADE_9=rep("READING", 7),
    READING_GRADE_10=rep("READING", 7),
    READING_GRADE_11=rep("READING", 7),
    READING_GRADE_8_to_11=rep("READING", 7),
    MATHEMATICS_GRADE_3=rep("MATHEMATICS", 9),
    MATHEMATICS_GRADE_4=rep("MATHEMATICS", 9),
    MATHEMATICS_GRADE_5=rep("MATHEMATICS", 9),
    MATHEMATICS_GRADE_6=rep("MATHEMATICS", 7),
    MATHEMATICS_GRADE_7=rep("MATHEMATICS", 7),
    MATHEMATICS_GRADE_8=rep("MATHEMATICS", 7),
    MATHEMATICS_GRADE_9=rep("MATHEMATICS", 7),
    MATHEMATICS_GRADE_10=rep("MATHEMATICS", 7),
    MATHEMATICS_GRADE_11=rep("MATHEMATICS", 7),
    MATHEMATICS_GRADE_8_to_11=rep("MATHEMATICS", 7))
SGPstateData[["MI"]][["SGP_Configuration"]][["max.forward.projection.sequence"]] <- list(
    READING_GRADE_3=6,
    READING_GRADE_4=6,
    READING_GRADE_5=6,
    READING_GRADE_6=6,
    READING_GRADE_7=6,
    READING_GRADE_8=6,
    READING_GRADE_9=6,
    READING_GRADE_10=6,
    READING_GRADE_11=6,
    READING_GRADE_8_to_11=6,
    MATHEMATICS_GRADE_3=6,
    MATHEMATICS_GRADE_4=6,
    MATHEMATICS_GRADE_5=6,
    MATHEMATICS_GRADE_6=6,
    MATHEMATICS_GRADE_7=6,
    MATHEMATICS_GRADE_8=6,
    MATHEMATICS_GRADE_9=6,
    MATHEMATICS_GRADE_10=6,
    MATHEMATICS_GRADE_11=6,
    MATHEMATICS_GRADE_8_to_11=6)

SGPstateData[["MI"]][['SGP_Progression_Preference']] <- data.table(
	SGP_PROJECTION_GROUP = c("MATHEMATICS_GRADE_8_to_11", "READING_GRADE_8_to_11", "MATHEMATICS_11", "READING_11"),
	PREFERENCE = c(1, 1, 2, 2), key = "SGP_PROJECTION_GROUP")


### Run analysis
Michigan_SGP <- abcSGP(
        Michigan_SGP,
        years="2021_2022",
        steps=c("prepareSGP", "analyzeSGP", "combineSGP", "outputSGP"),
        sgp.config=MI_2021_2022.config,
        sgp.percentiles=FALSE,
        sgp.projections=FALSE,
        sgp.projections.lagged=FALSE,
        sgp.percentiles.baseline=FALSE,
        sgp.projections.baseline=FALSE,
        sgp.projections.lagged.baseline=TRUE,
        sgp.target.scale.scores=TRUE,
        parallel.config=parallel.config
)


###  Save results
save(Michigan_SGP, file="Data/Michigan_SGP.Rdata")
