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
parallel.config <- list(BACKEND="PARALLEL", WORKERS=list(PERCENTILES=4, BASELINE_PERCENTILES=4, PROJECTIONS=4, LAGGED_PROJECTIONS=4, SGP_SCALE_SCORE_TARGETS=4))

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


### Copy SCALE_SCORE_PRIOR and SCALE_SCORE_PRIOR_STANDARDIZED to BASELINE counter parts

Michigan_SGP@Data[YEAR=="2020_2021", SCALE_SCORE_PRIOR_BASELINE:=SCALE_SCORE_PRIOR]
Michigan_SGP@Data[YEAR=="2020_2021", SCALE_SCORE_PRIOR_STANDARDIZED_BASELINE:=SCALE_SCORE_PRIOR_STANDARDIZED]


###   Save results
save(Michigan_SGP, file="Data/Michigan_SGP.Rdata")
