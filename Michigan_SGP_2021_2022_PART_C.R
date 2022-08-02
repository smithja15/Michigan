################################################################################
###                                                                          ###
###                Michigan SGP analyses for 2022                             ###
###                                                                          ###
################################################################################

###   Load packages
require(SGP)
require(SGPmatrices)

###   Load data
load("Data/Michigan_SGP.Rdata")
load("Data/Michigan_Data_LONG_2022.Rdata")

###   Add Baseline matrices to SGPstateData
SGPstateData <- addBaselineMatrices("MI", "2022")
SGPstateData[["MI"]][["Assessment_Program_Information"]][["Assessment_Transition"]] <- NULL

###   Read in SGP Configuration Scripts and Combine
source("SGP_CONFIG/2021_2022/PART_C/ELA.R")
source("SGP_CONFIG/2021_2022/PART_C/MATHEMATICS.R")

MI_CONFIG <- c(ELA_2022.config, MATHEMATICS_2022.config)

### Parameters
parallel.config <- list(BACKEND="PARALLEL", WORKERS=list(PERCENTILES=4, BASELINE_PERCENTILES=4, PROJECTIONS=4, LAGGED_PROJECTIONS=4, SGP_SCALE_SCORE_TARGETS=4))

#####
###   Run updateSGP analysis
#####

Michigan_SGP <- updateSGP(
        what_sgp_object = Michigan_SGP,
        with_sgp_data_LONG = Michigan_Data_LONG_2022,
        steps = c("prepareSGP", "analyzeSGP", "combineSGP"),
        sgp.config = MI_CONFIG,
        sgp.percentiles = TRUE,
        sgp.projections = TRUE,
        sgp.projections.lagged = TRUE,
        sgp.percentiles.baseline = TRUE,
        sgp.projections.baseline = TRUE,
        sgp.projections.lagged.baseline = TRUE,
        save.intermediate.results = FALSE,
        parallel.config = parallel.config
)


###   Save results
save(Michigan_SGP, file="Data/Michigan_SGP.Rdata")
