################################################################################
###                                                                          ###
###          SGP STRAIGHT projections for skip year SGP analyses for 2021    ###
###                                                                          ###
################################################################################

###   Load packages
require(SGP)
require(SGPmatrices)

###   Load data
load("Data/Michigan_SGP.Rdata")

###   Load configurations
source("SGP_CONFIG/2020_2021/PART_B/READING.R")
source("SGP_CONFIG/2020_2021/PART_B/MATHEMATICS.R")

MI_2020_2021.config <- c(READING_2020_2021.config, MATHEMATICS_2020_2021.config)

### Parameters
parallel.config <- list(BACKEND="PARALLEL", WORKERS=list(PERCENTILES=4, BASELINE_PERCENTILES=4, PROJECTIONS=4, LAGGED_PROJECTIONS=4, SGP_SCALE_SCORE_TARGETS=4))

###   Add Baseline matrices to SGPstateData
SGPstateData <- addBaselineMatrices("MI", "2021")
SGPstateData[["MI"]][["SGP_Configuration"]][["sgp.target.scale.scores.merge"]] <- NULL
SGPstateData[["MI"]][["Assessment_Program_Information"]][["Assessment_Transition"]] <- NULL

#  Establish required meta-data for STRAIGHT projection sequences
SGPstateData[["MI"]][["SGP_Configuration"]][["grade.projection.sequence"]] <- list(
    READING_GRADE_3=c(3, 4, 5, 6, 7, 8, 9, 10, 11),
    READING_GRADE_4=c(3, 4, 5, 6, 7, 8, 9, 10, 11),
    READING_GRADE_5=c(3, 4, 5, 6, 7, 8, 9, 10, 11),
    READING_GRADE_6=c(3, 4, 5, 6, 7, 8, 9, 10, 11),
    READING_GRADE_7=c(3, 4, 5, 6, 7, 8, 9, 10, 11),
    READING_GRADE_8=c(3, 4, 5, 6, 7, 8, 9, 10, 11),
    READING_GRADE_9=c(3, 4, 5, 6, 7, 8, 9, 10, 11),
    READING_GRADE_10=c(3, 4, 5, 6, 7, 8, 9, 10, 11),
    READING_GRADE_11=c(3, 4, 5, 6, 7, 8, 9, 10, 11),
    MATHEMATICS_GRADE_3=c(3, 4, 5, 6, 7, 8, 9, 10, 11),
    MATHEMATICS_GRADE_4=c(3, 4, 5, 6, 7, 8, 9, 10, 11),
    MATHEMATICS_GRADE_5=c(3, 4, 5, 6, 7, 8, 9, 10, 11),
    MATHEMATICS_GRADE_6=c(3, 4, 5, 6, 7, 8, 9, 10, 11),
    MATHEMATICS_GRADE_7=c(3, 4, 5, 6, 7, 8, 9, 10, 11),
    MATHEMATICS_GRADE_8=c(3, 4, 5, 6, 7, 8, 9, 10, 11),
    MATHEMATICS_GRADE_9=c(3, 4, 5, 6, 7, 8, 9, 10, 11),
    MATHEMATICS_GRADE_10=c(3, 4, 5, 6, 7, 8, 9, 10, 11),
    MATHEMATICS_GRADE_11=c(3, 4, 5, 6, 7, 8, 9, 10, 11))
SGPstateData[["MI"]][["SGP_Configuration"]][["content_area.projection.sequence"]] <- list(
    READING_GRADE_3=rep("READING", 9),
    READING_GRADE_4=rep("READING", 9),
    READING_GRADE_5=rep("READING", 9),
    READING_GRADE_6=rep("READING", 9),
    READING_GRADE_7=rep("READING", 9),
    READING_GRADE_8=rep("READING", 9),
    READING_GRADE_9=rep("READING", 9),
    READING_GRADE_10=rep("READING", 9),
    READING_GRADE_11=rep("READING", 9),
    MATHEMATICS_GRADE_3=rep("MATHEMATICS", 9),
    MATHEMATICS_GRADE_4=rep("MATHEMATICS", 9),
    MATHEMATICS_GRADE_5=rep("MATHEMATICS", 9),
    MATHEMATICS_GRADE_6=rep("MATHEMATICS", 9),
    MATHEMATICS_GRADE_7=rep("MATHEMATICS", 9),
    MATHEMATICS_GRADE_8=rep("MATHEMATICS", 9),
    MATHEMATICS_GRADE_9=rep("MATHEMATICS", 9),
    MATHEMATICS_GRADE_10=rep("MATHEMATICS", 9),
    MATHEMATICS_GRADE_11=rep("MATHEMATICS", 9))
SGPstateData[["MI"]][["SGP_Configuration"]][["max.forward.projection.sequence"]] <- list(
    READING_GRADE_3=4,
    READING_GRADE_4=4,
    READING_GRADE_5=4,
    READING_GRADE_6=4,
    READING_GRADE_7=4,
    READING_GRADE_8=4,
    READING_GRADE_9=4,
    READING_GRADE_10=4,
    READING_GRADE_11=4,
    MATHEMATICS_GRADE_3=4,
    MATHEMATICS_GRADE_4=4,
    MATHEMATICS_GRADE_5=4,
    MATHEMATICS_GRADE_6=4,
    MATHEMATICS_GRADE_7=4,
    MATHEMATICS_GRADE_8=4,
    MATHEMATICS_GRADE_9=4,
    MATHEMATICS_GRADE_10=4,
    MATHEMATICS_GRADE_11=4)

###   Run analysis

Michigan_SGP <- abcSGP(
        Michigan_SGP,
        years = "2020_2021",
        steps=c("prepareSGP", "analyzeSGP", "combineSGP"),
        sgp.config=MI_2020_2021.config,
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
