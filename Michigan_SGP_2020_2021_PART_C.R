#####################################################################################
###                                                                               ###
###           SGP LAGGED projections for skip year SGP analyses for 2020-2021     ###
###                                                                               ###
#####################################################################################

###   Load packages
require(SGP)
require(SGPmatrices)

###   Load data
load("Data/Michigan_SGP.Rdata")

###   Load configurations
source("SGP_CONFIG/2020_2021/PART_C/READING.R")
source("SGP_CONFIG/2020_2021/PART_C/MATHEMATICS.R")

MI_2020_2021.config <- c(READING_2020_2021.config, MATHEMATICS_2020_2021.config)

### Parameters
parallel.config <- list(BACKEND="PARALLEL", WORKERS=list(PERCENTILES=4, BASELINE_PERCENTILES=4, PROJECTIONS=4, LAGGED_PROJECTIONS=4, SGP_SCALE_SCORE_TARGETS=4))

###   Setup SGPstateData with baseline coefficient matrices grade specific projection sequences

###   Add Baseline matrices to SGPstateData and update SGPstateData
SGPstateData <- addBaselineMatrices("MI", "2020_2021")
SGPstateData[["MI"]][["Growth"]][["System_Type"]] <- "Baseline Referenced"
SGPstateData[["MI"]][["Assessment_Program_Information"]][["Assessment_Transition"]] <- NULL

#  Establish required meta-data for LAGGED projection sequences
SGPstateData[["MI"]][["SGP_Configuration"]][["grade.projection.sequence"]] <- list(
    READING_GRADE_3=c(3, 4, 5, 6, 7, 8, 9, 10, 11),
    READING_GRADE_4=c(3, 4, 5, 6, 7, 8, 9, 10, 11),
    READING_GRADE_5=c(3, 5, 6, 7, 8, 9, 10, 11),
    READING_GRADE_6=c(3, 4, 6, 7, 8, 9, 10, 11),
    READING_GRADE_7=c(3, 4, 5, 7, 8, 9, 10, 11),
    READING_GRADE_8=c(3, 4, 5, 6, 8, 9, 10, 11),
    READING_GRADE_9=c(3, 4, 5, 6, 7, 9, 10, 11),
    READING_GRADE_10=c(3, 4, 5, 6, 7, 8, 10, 11),
    READING_GRADE_11=c(3, 4, 5, 6, 7, 8, 9, 11),
    READING_GRADE_8_to_11=c(3, 4, 5, 6, 7, 8, 11),
    MATHEMATICS_GRADE_3=c(3, 4, 5, 6, 7, 8, 9, 10, 11),
    MATHEMATICS_GRADE_4=c(3, 4, 5, 6, 7, 8, 9, 10, 11),
    MATHEMATICS_GRADE_5=c(3, 5, 6, 7, 8, 9, 10, 11),
    MATHEMATICS_GRADE_6=c(3, 4, 6, 7, 8, 9, 10, 11),
    MATHEMATICS_GRADE_7=c(3, 4, 5, 7, 8, 9, 10, 11),
    MATHEMATICS_GRADE_8=c(3, 4, 5, 6, 8, 9, 10, 11),
    MATHEMATICS_GRADE_9=c(3, 4, 5, 6, 7, 9, 10, 11),
    MATHEMATICS_GRADE_10=c(3, 4, 5, 6, 7, 8, 10, 11),
    MATHEMATICS_GRADE_11=c(3, 4, 5, 6, 7, 8, 9, 11),
    MATHEMATICS_GRADE_8_to_11=c(3, 4, 5, 6, 7, 8, 11))
SGPstateData[["MI"]][["SGP_Configuration"]][["content_area.projection.sequence"]] <- list(
    READING_GRADE_3=rep("READING", 9),
    READING_GRADE_4=rep("READING", 9),
    READING_GRADE_5=rep("READING", 8),
    READING_GRADE_6=rep("READING", 8),
    READING_GRADE_7=rep("READING", 8),
    READING_GRADE_8=rep("READING", 8),
    READING_GRADE_9=rep("READING", 8),
    READING_GRADE_10=rep("READING", 8),
    READING_GRADE_11=rep("READING", 8),
    READING_GRADE_8_to_11=rep("READING", 7),
    MATHEMATICS_GRADE_3=rep("MATHEMATICS", 9),
    MATHEMATICS_GRADE_4=rep("MATHEMATICS", 9),
    MATHEMATICS_GRADE_5=rep("MATHEMATICS", 8),
    MATHEMATICS_GRADE_6=rep("MATHEMATICS", 8),
    MATHEMATICS_GRADE_7=rep("MATHEMATICS", 8),
    MATHEMATICS_GRADE_8=rep("MATHEMATICS", 8),
    MATHEMATICS_GRADE_9=rep("MATHEMATICS", 8),
    MATHEMATICS_GRADE_10=rep("MATHEMATICS", 8),
    MATHEMATICS_GRADE_11=rep("MATHEMATICS", 8),
    MATHEMATICS_GRADE_8_to_11=rep("MATHEMATICS", 7))
SGPstateData[["MI"]][["SGP_Configuration"]][["max.forward.projection.sequence"]] <- list(
    READING_GRADE_3=7,
    READING_GRADE_4=7,
    READING_GRADE_5=7,
    READING_GRADE_6=7,
    READING_GRADE_7=7,
    READING_GRADE_8=7,
    READING_GRADE_9=7,
    READING_GRADE_10=7,
    READING_GRADE_11=7,
    READING_GRADE_8_to_11=7,
    MATHEMATICS_GRADE_3=7,
    MATHEMATICS_GRADE_4=7,
    MATHEMATICS_GRADE_5=7,
    MATHEMATICS_GRADE_6=7,
    MATHEMATICS_GRADE_7=7,
    MATHEMATICS_GRADE_8=7,
    MATHEMATICS_GRADE_9=7,
    MATHEMATICS_GRADE_10=7,
    MATHEMATICS_GRADE_11=7,
    MATHEMATICS_GRADE_8_to_11=7)

SGPstateData[["MI"]][['SGP_Progression_Preference']] <- data.table(
	SGP_PROJECTION_GROUP = c("MATHEMATICS_8_to_11", "READING_8_to_11", "MATHEMATICS_11", "READING_11"),
	PREFERENCE = c(1, 1, 2, 2), key = "SGP_PROJECTION_GROUP")


### Run analysis
Michigan_SGP <- abcSGP(
        Michigan_SGP,
        steps=c("prepareSGP", "analyzeSGP", "combineSGP", "outputSGP"),
        sgp.config=MI_2020_2021.config,
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
