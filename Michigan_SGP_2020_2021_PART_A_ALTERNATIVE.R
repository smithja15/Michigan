######################################################################################
###                                                                                ###
###                Michigan COVID Skip-year SGP analyses for 2020-2021             ###
###                USING LONG DATA SUPPLIED BY MIDOE/DRC
###                                                                                ###
######################################################################################

### Load packages
require(data.table)
require(SGP)
require(SGPmatrices)

### Load data
load("Data/MStep_2021_w_Equated_Scores.Rdata")

### Add Baseline matrices to SGPstateData
SGPstateData <- addBaselineMatrices("MI", "2020_2021")
SGPstateData[["MI"]][["Assessment_Program_Information"]][["Assessment_Transition"]] <- NULL

### Read in SGP Configuration Scripts and Combine
source("SGP_CONFIG/2020_2021/PART_A/READING.R")
source("SGP_CONFIG/2020_2021/PART_A/MATHEMATICS.R")
source("SGP_CONFIG/2020_2021/PART_A/SOCIAL_STUDIES.R")

MI_2020_2021.config <- c(READING_2020_2021.config, MATHEMATICS_2020_2021.config, SOCIAL_STUDIES_2020_2021.config)

### Parameters
parallel.config <- list(BACKEND="PARALLEL", WORKERS=list(PERCENTILES=8, BASELINE_PERCENTILES=8, PROJECTIONS=8, LAGGED_PROJECTIONS=8, SGP_SCALE_SCORE_TARGETS=8))

######
###### STEP 1: CALCULATE COHORT REFERENCED SGPS
######

### TEMPORARILY MODIFY KNOTS & BOUNDARIES TO ACCOMODATE NON-EQUATED SCORES
SGPstateData[["MI"]][["Achievement"]][["Knots_Boundaries"]][["MATHEMATICS.2018_2019"]] <- SGPstateData[["MI"]][["Achievement"]][["Knots_Boundaries"]][["MATHEMATICS"]]
SGPstateData[["MI"]][["Achievement"]][["Knots_Boundaries"]][["READING.2018_2019"]] <- SGPstateData[["MI"]][["Achievement"]][["Knots_Boundaries"]][["READING"]]
SGPstateData[["MI"]][["Achievement"]][["Knots_Boundaries"]][["SOCIAL_STUDIES.2018_2019"]] <- SGPstateData[["MI"]][["Achievement"]][["Knots_Boundaries"]][["SOCIAL_STUDIES"]]
SGPstateData[["MI"]][["Achievement"]][["Knots_Boundaries"]][["MATHEMATICS"]][["boundaries_8"]] <- c( 1712.5, 1862.5)
SGPstateData[["MI"]][["Achievement"]][["Knots_Boundaries"]][["MATHEMATICS"]][["knots_8"]] <- c(1767, 1782, 1796, 1813)
SGPstateData[["MI"]][["Achievement"]][["Knots_Boundaries"]][["MATHEMATICS"]][["loss.hoss_8"]] <- c(1725, 1850)
SGPstateData[["MI"]][["Achievement"]][["Knots_Boundaries"]][["READING"]][["boundaries_8"]] <- c(1707.4, 1870.6)
SGPstateData[["MI"]][["Achievement"]][["Knots_Boundaries"]][["READING"]][["knots_8"]] <- c(1774, 1791, 1806, 1822)
SGPstateData[["MI"]][["Achievement"]][["Knots_Boundaries"]][["READING"]][["loss.hoss_8"]] <- c(1721, 1857)


###   Run abcSGP analysis for cohort referenced SGP
Michigan_SGP <- abcSGP(
        sgp_object = MStep_2021_w_Equated_Scores,
        state = "MI",
        steps = c("prepareSGP", "analyzeSGP", "combineSGP"),
        sgp.config = MI_2020_2021.config,
        sgp.percentiles = TRUE,
        sgp.projections = FALSE,
        sgp.projections.lagged = FALSE,
        sgp.percentiles.baseline = FALSE,
        sgp.projections.baseline = FALSE,
        sgp.projections.lagged.baseline = FALSE,
        save.intermediate.results = FALSE,
        parallel.config = parallel.config
)


######
###### STEP 2: CALCULATE BASELINE REFERENCED SGPS
######

### Setup knots and boundaries
SGPstateData[["MI"]][["Achievement"]][["Knots_Boundaries"]][["MATHEMATICS"]] <- SGPstateData[["MI"]][["Achievement"]][["Knots_Boundaries"]][["MATHEMATICS.2018_2019"]]
SGPstateData[["MI"]][["Achievement"]][["Knots_Boundaries"]][["READING"]] <- SGPstateData[["MI"]][["Achievement"]][["Knots_Boundaries"]][["READING.2018_2019"]]
SGPstateData[["MI"]][["Achievement"]][["Knots_Boundaries"]][["SOCIAL_STUDIES"]] <- SGPstateData[["MI"]][["Achievement"]][["Knots_Boundaries"]][["SOCIAL_STUDIES.2018_2019"]]

### Temporarily swap SCALE_SCORE_EQUATED with SCALE_SCORE to run baseline SGPs
setnames(Michigan_SGP@Data, c("SCALE_SCORE", "SCALE_SCORE_EQUATED"), c("SCALE_SCORE_EQUATED", "SCALE_SCORE"))

###   Run abcSGP analysis for baseline referenced SGP
Michigan_SGP <- abcSGP(
        sgp_object = Michigan_SGP,
        steps = c("prepareSGP", "analyzeSGP", "combineSGP"),
        sgp.config = MI_2020_2021.config,
        sgp.percentiles = FALSE,
        sgp.projections = FALSE,
        sgp.projections.lagged = FALSE,
        sgp.percentiles.baseline = TRUE,
        sgp.projections.baseline = FALSE,
        sgp.projections.lagged.baseline = FALSE,
        save.intermediate.results = FALSE,
        parallel.config = parallel.config
)


### Swap back SCALE_SCORE_EQUATED with SCALE_SCORE to run baseline SGPs
setnames(Michigan_SGP@Data, c("SCALE_SCORE_EQUATED", "SCALE_SCORE"), c("SCALE_SCORE", "SCALE_SCORE_EQUATED"))

### Copy SCALE_SCORE_PRIOR and SCALE_SCORE_PRIOR_STANDARDIZED to BASELINE counter parts
Michigan_SGP@Data[YEAR=="2020_2021", SCALE_SCORE_PRIOR_BASELINE:=SCALE_SCORE_PRIOR]
Michigan_SGP@Data[YEAR=="2020_2021", SCALE_SCORE_PRIOR_STANDARDIZED_BASELINE:=SCALE_SCORE_PRIOR_STANDARDIZED]


###   Save results
save(Michigan_SGP, file="Data/Michigan_SGP.Rdata")
