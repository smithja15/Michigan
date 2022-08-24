###########################################################################
###                                                                     ###
###     SGP STRAIGHT projections for skip year SGP analyses for 2022    ###
###                                                                     ###
###########################################################################

###   Load packages
require(SGP)
require(SGPmatrices)
require(data.table)

###   Load data
load("Data/Michigan_SGP.Rdata")

###   Load configurations
source("SGP_CONFIG/2021_2022/PART_B/READING.R")
source("SGP_CONFIG/2021_2022/PART_B/MATHEMATICS.R")

MI_2021_2022.config <- c(READING_2021_2022.config, MATHEMATICS_2021_2022.config)

### Parameters
parallel.config <- list(BACKEND="PARALLEL", WORKERS=list(PERCENTILES=8, BASELINE_PERCENTILES=8, PROJECTIONS=8, LAGGED_PROJECTIONS=8, SGP_SCALE_SCORE_TARGETS=8))

###   Add Baseline matrices to SGPstateData
SGPstateData <- addBaselineMatrices("MI", "2021")
SGPstateData[["MI"]][["SGP_Configuration"]][["sgp.target.scale.scores.merge"]] <- NULL ### WAIT UNTIL AFTER PART C TO MERGE
SGPstateData[["MI"]][["Assessment_Program_Information"]][["Assessment_Transition"]] <- NULL

#  Establish required meta-data for STRAIGHT projection sequences
SGPstateData[["MI"]][["SGP_Configuration"]][["grade.projection.sequence"]] <- list(
    READING=c(3, 4, 5, 6, 7, 8, 9, 10, 11),
    READING_GRADE_8_to_11=c(3, 4, 5, 6, 7, 8, 11),
    MATHEMATICS=c(3, 4, 5, 6, 7, 8, 9, 10, 11),
    MATHEMATICS_GRADE_8_to_11=c(3, 4, 5, 6, 7, 8, 11))
SGPstateData[["MI"]][["SGP_Configuration"]][["content_area.projection.sequence"]] <- list(
    READING=rep("READING", 9),
    READING_GRADE_8_to_11=rep("READING", 7),
    MATHEMATICS=rep("MATHEMATICS", 9),
    MATHEMATICS_GRADE_8_to_11=rep("MATHEMATICS", 7))
SGPstateData[["MI"]][["SGP_Configuration"]][["max.forward.projection.sequence"]] <- list(
    READING=7,
    READING_GRADE_8_to_11=7,
    MATHEMATICS=7,
    MATHEMATICS_GRADE_8_to_11=7)

SGPstateData[["MI"]][['SGP_Progression_Preference']] <- data.table(
	SGP_PROJECTION_GROUP = c("MATHEMATICS_8_to_11", "READING_8_to_11", "MATHEMATICS", "READING"),
	PREFERENCE = c(1, 1, 2, 2), key = "SGP_PROJECTION_GROUP")

###   Run analysis
Michigan_SGP <- abcSGP(
        Michigan_SGP,
        years = "2021_2022",
        steps=c("prepareSGP", "analyzeSGP", "combineSGP"),
        sgp.config=MI_2021_2022.config,
        sgp.percentiles=FALSE,
        sgp.projections=FALSE,
        sgp.projections.lagged=FALSE,
        sgp.percentiles.baseline=FALSE,
        sgp.projections.baseline=TRUE,
        sgp.projections.lagged.baseline=FALSE,
        sgp.target.scale.scores=TRUE,
        parallel.config=parallel.config
)

###   Save results
save(Michigan_SGP, file="Data/Michigan_SGP.Rdata")
