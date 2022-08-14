######################################################################################
###                                                                                ###
###                Michigan COVID Skip-year SGP analyses for 2020-2021             ###
###                                                                                ###
######################################################################################

###   Load packages
require(SGP)
require(SGPmatrices)

###   Load data
load("Data/Michigan_SGP.Rdata")
load("Data/Michigan_Data_LONG_2020_2021.Rdata")

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
###   Run updateSGP analysis
#####

Michigan_SGP <- updateSGP(
        what_sgp_object = Michigan_SGP,
        with_sgp_data_LONG = Michigan_Data_LONG_2021,
        steps = c("prepareSGP", "analyzeSGP", "combineSGP"),
        sgp.config = MI_2020_2021.config,
        sgp.percentiles = TRUE,
        sgp.projections = FALSE,
        sgp.projections.lagged = FALSE,
        sgp.percentiles.baseline = TRUE,
        sgp.projections.baseline = FALSE,
        sgp.projections.lagged.baseline = FALSE,
        save.intermediate.results = FALSE,
        parallel.config = parallel.config
)


###   Save results
#save(Michigan_SGP, file="Data/Michigan_SGP.Rdata")
