#################################################################################
###                                                                           ###
###   Michigan Learning Loss Analyses -- 2019 Baseline Growth Percentiles     ###
###                                                                           ###
#################################################################################

###   Load packages
require(SGP)
require(data.table)

###   Load data
load("Data/Michigan_SGP.Rdata")

### Test for BASELINE related variable in LONG data and NULL out if they exist
if (length(tmp.names <- grep("BASELINE|SS", names(Michigan_SGP@Data))) > 0) {
		Michigan_SGP@Data[,eval(tmp.names):=NULL]
}

### NULL out OLD Goodness of Fit plots that throw error due to old grob versions
Michigan_SGP@SGP$Goodness_of_Fit <- NULL

###   Add baseline matrices to SGPstateData
SGPstateData <- SGPmatrices::addBaselineMatrices("MI", "2020_2021")

### Parameters
parallel.config <- list(BACKEND="PARALLEL", WORKERS=list(PERCENTILES=12, BASELINE_PERCENTILES=12, PROJECTIONS=12, LAGGED_PROJECTIONS=12, SGP_SCALE_SCORE_TARGETS=12))

### NULL out assessment transition in 2019 (since already dealth with)
SGPstateData[["MI"]][["Assessment_Program_Information"]][["Assessment_Transition"]] <- NULL
SGPstateData[["MI"]][["Assessment_Program_Information"]][["Scale_Change"]] <- NULL

###   Read in BASELINE percentiles configuration scripts and combine
source("SGP_CONFIG/2018_2019/BASELINE/Percentiles/READING.R")
source("SGP_CONFIG/2018_2019/BASELINE/Percentiles/MATHEMATICS.R")
source("SGP_CONFIG/2018_2019/BASELINE/Percentiles/SOCIAL_STUDIES.R")

MI_2018_2019_Baseline_Config <- c(
	READING.2018_2019.config,
	MATHEMATICS.2018_2019.config,
        SOCIAL_STUDIES.2018_2019.config,
        SOCIAL_STUDIES.2017_2018.config
)

MI_2018_2019_Baseline_Config_SKIP_2_YEAR <- c(
	READING.2018_2019_SKIP_2_YEAR.config,
	MATHEMATICS.2018_2019_SKIP_2_YEAR.config,
	SOCIAL_STUDIES.2018_2019_SKIP_2_YEAR.config,
	SOCIAL_STUDIES.2017_2018_SKIP_2_YEAR.config
)

SGPstateData[["MI"]][["Assessment_Program_Information"]][["CSEM"]] <- NULL

#####
###   Run BASELINE SGP analysis for SKIP_2_YEAR (two-year skip) 
###   create new Michigan_SGP object with historical data
#####

Michigan_SGP <- abcSGP(
        sgp_object = Michigan_SGP,
        steps = c("prepareSGP", "analyzeSGP", "combineSGP"),
        sgp.config = MI_2018_2019_Baseline_Config_SKIP_2_YEAR,
        sgp.percentiles = FALSE,
        sgp.projections = FALSE,
        sgp.projections.lagged = FALSE,
        sgp.percentiles.baseline = TRUE,  #  Skip 2 year SGPs for 2022 comparisons
        sgp.projections.baseline = FALSE, #  Calculated in last step
        sgp.projections.lagged.baseline = FALSE,
        save.intermediate.results = FALSE,
        parallel.config = parallel.config
)

baseline.names <- grep("BASELINE", names(Michigan_SGP@Data), value = TRUE)
setnames(Michigan_SGP@Data, baseline.names, paste0(baseline.names, "_SKIP_2_YEAR"))

sgps.2017_2018 <- grep(".2017_2018.BASELINE", names(Michigan_SGP@SGP[["SGPercentiles"]]))
sgps.2018_2019 <- grep(".2018_2019.BASELINE", names(Michigan_SGP@SGP[["SGPercentiles"]]))
names(Michigan_SGP@SGP[["SGPercentiles"]])[sgps.2017_2018] <- gsub(".2017_2018.BASELINE", ".2017_2018.BASELINE.SKIP_2_YEAR", names(Michigan_SGP@SGP[["SGPercentiles"]])[sgps.2017_2018])
names(Michigan_SGP@SGP[["SGPercentiles"]])[sgps.2018_2019] <- gsub(".2018_2019.BASELINE", ".2018_2019.BASELINE.SKIP_2_YEAR", names(Michigan_SGP@SGP[["SGPercentiles"]])[sgps.2018_2019])

#####
###   Run BASELINE SGP analysis for SKIP_YEAR (one-year skip) 
###   create new Michigan_SGP object with historical data
#####

Michigan_SGP <- abcSGP(
        sgp_object = Michigan_SGP,
        steps = c("prepareSGP", "analyzeSGP", "combineSGP"),
        sgp.config = MI_2018_2019_Baseline_Config_SKIP_YEAR,
        sgp.percentiles = FALSE,
        sgp.projections = FALSE,
        sgp.projections.lagged = FALSE,
        sgp.percentiles.baseline = TRUE,  #  Skip year SGPs for 2021 comparisons
        sgp.projections.baseline = FALSE, #  Calculated in last step
        sgp.projections.lagged.baseline = FALSE,
        save.intermediate.results = FALSE,
        parallel.config = parallel.config 
)

baseline.names <- setdiff(grep("BASELINE", names(Michigan_SGP@Data), value = TRUE), grep("SKIP_2_YEAR", names(Michigan_SGP@Data), value = TRUE))
setnames(Michigan_SGP@Data, baseline.names, paste0(baseline.names, "_SKIP_YEAR"))

sgps.2018_2019 <- grep(".2018_2019.BASELINE", names(Michigan_SGP@SGP[["SGPercentiles"]]))
names(Michigan_SGP@SGP[["SGPercentiles"]])[sgps.2018_2019] <- gsub(".2018_2019.BASELINE", ".2018_2019.BASELINE.SKIP_YEAR", names(Michigan_SGP@SGP[["SGPercentiles"]])[sgps.2018_2019])

#####
###   Run BASELINE SGP analysis for consecutive year
###   create new Michigan_SGP object with historical data
#####

Michigan_SGP <- abcSGP(
        sgp_object = Michigan_SGP,
        steps = c("prepareSGP", "analyzeSGP", "combineSGP", "outputSGP"),
        sgp.config = MI_2018_2019_Baseline_Config,
        sgp.percentiles = FALSE,
        sgp.projections = FALSE,
        sgp.projections.lagged = FALSE,
        sgp.percentiles.baseline = TRUE,  #  Consecutive year SGPs for 2021 comparisons
        sgp.projections.baseline = TRUE, # 
        sgp.projections.lagged.baseline = TRUE,
        save.intermediate.results = FALSE,
        parallel.config = parallel.config
)



###   Save results
#save(Michigan_SGP, file="Data/Michigan_SGP.Rdata")
