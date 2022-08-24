########################################################################################
###                                                                                  ###
###                Michigan COVID Skip-2-year & Consecutive-year                     ###
###                SGP analyses for 2021-2022                                        ###
###                                                                                  ###
########################################################################################

###   Load packages
require(SGP)
require(SGPmatrices)

###   Load data
load("Data/Michigan_SGP.Rdata")
load("Data/Michigan_Data_LONG_2021_2022.Rdata")

###   Add Baseline matrices to SGPstateData
SGPstateData <- addBaselineMatrices("MI", "2021_2022")
SGPstateData[["MI"]][["Assessment_Program_Information"]][["Assessment_Transition"]] <- NULL

###   Read in SGP Configuration Scripts and Combine
source("SGP_CONFIG/2021_2022/PART_A/READING.R")
source("SGP_CONFIG/2021_2022/PART_A/MATHEMATICS.R")
source("SGP_CONFIG/2021_2022/PART_A/SOCIAL_STUDIES.R")

MI_2021_2022_Consecutive_Year_Config <- c(
	READING.2021_2022.config,
	MATHEMATICS.2021_2022.config,
        SOCIAL_STUDIES.2021_2022.config
)

MI_2021_2022_SKIP_2_YEAR_Config <- c(
	READING.2021_2022_SKIP_2_YEAR.config,
	MATHEMATICS.2021_2022_SKIP_2_YEAR.config,
	SOCIAL_STUDIES.2021_2022_SKIP_2_YEAR.config
)

### Parameters
parallel.config <- list(BACKEND="PARALLEL", WORKERS=list(PERCENTILES=4, BASELINE_PERCENTILES=4, PROJECTIONS=4, LAGGED_PROJECTIONS=4, SGP_SCALE_SCORE_TARGETS=4))

#####
###   Run BASELINE SGP analysis for SKIP_2_YEAR (two-year skip) 
###   create new Michigan_SGP object with historical data
#####

Michigan_SGP <- updateSGP(
        what_sgp_object = Michigan_SGP,
        with_sgp_data_LONG = Michigan_Data_LONG_2021_2022,
        steps = c("prepareSGP", "analyzeSGP", "combineSGP"),
        sgp.config = MI_2021_2022_SKIP_2_YEAR_Config,
        sgp.percentiles = TRUE,
        sgp.projections = FALSE,
        sgp.projections.lagged = FALSE,
        sgp.percentiles.baseline = TRUE,  # Skip 2 year SGPs for 2022 comparisons
        sgp.projections.baseline = FALSE, # Calculated in next step
        sgp.projections.lagged.baseline = FALSE, # Calculated in last step
        save.intermediate.results = FALSE,
        parallel.config = parallel.config
)

### Rename variables and data.tables appending SKIP_2_YEAR to names
from.variable.names.sgp <- c("SGP", "SGP_ORDER_1", "SGP_ORDER_1_STANDARD_ERROR", "SGP_ORDER_2", "SGP_ORDER_2_STANDARD_ERROR", "SGP_LEVEL", "SGP_NORM_GROUP", "SGP_STANDARD_ERROR")
to.variable.names.sgp <- paste(c("SGP", "SGP_ORDER_1", "SGP_ORDER_1_STANDARD_ERROR", "SGP_ORDER_2", "SGP_ORDER_2_STANDARD_ERROR", "SGP_LEVEL", "SGP_NORM_GROUP", "SGP_STANDARD_ERROR"), "SKIP_2_YEAR", sep="_")
from.variable.names.sgp.baseline <- c("SGP_BASELINE", "SGP_BASELINE_ORDER_1", "SGP_BASELINE_ORDER_1_STANDARD_ERROR", "SGP_BASELINE_ORDER_2", "SGP_BASELINE_ORDER_2_STANDARD_ERROR", "SGP_LEVEL_BASELINE", "SGP_NORM_GROUP_BASELINE", "SGP_BASELINE_STANDARD_ERROR")
to.variable.names.sgp.baseline <- paste(c("SGP_BASELINE", "SGP_BASELINE_ORDER_1", "SGP_BASELINE_ORDER_1_STANDARD_ERROR", "SGP_BASELINE_ORDER_2", "SGP_BASELINE_ORDER_2_STANDARD_ERROR", "SGP_LEVEL_BASELINE", "SGP_NORM_GROUP_BASELINE", "SGP_BASELINE_STANDARD_ERROR"), "SKIP_2_YEAR", sep="_")
Michigan_SGP@Data[YEAR=="2021_2022", (to.variable.names.sgp):=.SD, .SDcols=from.variable.names.sgp]
Michigan_SGP@Data[YEAR=="2021_2022", (to.variable.names.sgp.baseline):=.SD, .SDcols=from.variable.names.sgp.baseline]

sgps.2021_2022.baseline <- grep(".2021_2022.BASELINE", names(Michigan_SGP@SGP[["SGPercentiles"]]))
sgps.2021_2022 <- setdiff(grep(".2021_2022", names(Michigan_SGP@SGP[["SGPercentiles"]])), sgps.2021_2022.baseline) 
names(Michigan_SGP@SGP[["SGPercentiles"]])[sgps.2021_2022.baseline] <- gsub(".2021_2022.BASELINE", ".2021_2022.BASELINE.SKIP_2_YEAR", names(Michigan_SGP@SGP[["SGPercentiles"]])[sgps.2021_2022.baseline])
names(Michigan_SGP@SGP[["SGPercentiles"]])[sgps.2021_2022] <- gsub(".2021_2022", ".2021_2022.SKIP_2_YEAR", names(Michigan_SGP@SGP[["SGPercentiles"]])[sgps.2021_2022])

#####
###   Run BASELINE SGP analysis for consecutive year
###   create new Michigan_SGP object with historical data
#####

Michigan_SGP <- abcSGP(
        sgp_object = Michigan_SGP,
        steps = c("prepareSGP", "analyzeSGP", "combineSGP", "outputSGP"),
        sgp.config = MI_2021_2022_Consecutive_Year_Config,
        sgp.percentiles = TRUE,
        sgp.projections = FALSE,
        sgp.projections.lagged = FALSE,
        sgp.percentiles.baseline = TRUE,  #  Consecutive year SGPs for 2021 comparisons
        sgp.projections.baseline = FALSE, # 
        sgp.projections.lagged.baseline = FALSE,
        save.intermediate.results = FALSE,
        parallel.config = parallel.config
)

###   Save results
save(Michigan_SGP, file="Data/Michigan_SGP.Rdata")
