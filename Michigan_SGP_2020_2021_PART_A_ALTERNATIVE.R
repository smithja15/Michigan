######################################################################################
###                                                                                ###
###                Michigan COVID Skip-year SGP analyses for 2020-2021             ###
###                                                                                ###
######################################################################################

###   Load packages
require(data.table)
require(SGP)
require(SGPmatrices)

###   Load data
Michigan_Data_LONG <- load("Data/MStep_2021_w_Equated_Scores.Rdata")

###   Add Baseline matrices to SGPstateData
SGPstateData <- addBaselineMatrices("MI", "2020_2021")
SGPstateData[["MI"]][["Assessment_Program_Information"]][["Assessment_Transition"]] <- NULL

###   Read in SGP Configuration Scripts and Combine
source("SGP_CONFIG/2020_2021/PART_A/READING.R")
source("SGP_CONFIG/2020_2021/PART_A/MATHEMATICS.R")
source("SGP_CONFIG/2020_2021/PART_A/SOCIAL_STUDIES.R")

MI_2020_2021.config <- c(READING_2020_2021.config, MATHEMATICS_2020_2021.config, SOCIAL_STUDIES_2020_2021.config)

### Parameters
parallel.config <- list(BACKEND="PARALLEL", WORKERS=list(PERCENTILES=8, BASELINE_PERCENTILES=8, PROJECTIONS=8, LAGGED_PROJECTIONS=8, SGP_SCALE_SCORE_TARGETS=8))

#####
###   Run abcSGP analysis for cohort referenced SGP
#####

Michigan_SGP <- abcSGP(
        sgp_object = Michigan_Data_LONG,
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


#####
###   Run abcSGP analysis for cohort referenced SGP
#####

#Temporarily swap SCALE_SCORE_EQUATED with SCALE_SCORE to run baseline SGPs
setnames(Michigan_SGP@Data, c("SCALE_SCORE", "SCALE_SCORE_EQUATED"), c("SCALE_SCORE_EQUATED", "SCALE_SCORE"))

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


#Swap back SCALE_SCORE_EQUATED with SCALE_SCORE to run baseline SGPs
setnames(Michigan_SGP@Data, c("SCALE_SCORE_EQUATED", "SCALE_SCORE"), c("SCALE_SCORE", "SCALE_SCORE_EQUATED"))


### Copy SCALE_SCORE_PRIOR and SCALE_SCORE_PRIOR_STANDARDIZED to BASELINE counter parts

Michigan_SGP@Data[YEAR=="2020_2021", SCALE_SCORE_PRIOR_BASELINE:=SCALE_SCORE_PRIOR]
Michigan_SGP@Data[YEAR=="2020_2021", SCALE_SCORE_PRIOR_STANDARDIZED_BASELINE:=SCALE_SCORE_PRIOR_STANDARDIZED]


###   Save results
save(Michigan_SGP, file="Data/Michigan_SGP.Rdata")
