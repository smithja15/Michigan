##########################################################################
###                                                                    ###
###     Michigan SGP analysis script for 2019                          ###
###                                                                    ###
##########################################################################

### Load packages

require(data.table)
require(SGP)

### Load Data

load("Data/Michigan_Data_LONG_2019.Rdata")


### Load configurations

source("SGP_CONFIG/2019/MATHEMATICS.R")
source("SGP_CONFIG/2019/READING.R")
source("SGP_CONFIG/2019/SOCIAL_STUDIES.R")

Michigan.2018_2019.config <- c(MATHEMATICS.2018_2019.config, READING.2018_2019.config, SOCIAL_STUDIES.2018_2019.config)

### Include number of projection years to be included in output
SGPstateData[["MI"]][["SGP_Configuration"]][["max.sgp.target.years.forward"]] <- 1:7
SGPstateData[["MI"]][["SGP_Configuration"]][["sgp.target.scale.scores.merge"]] <- "1_year_lagged_current"

### Run abcSGP

Michigan_SGP <- abcSGP(
		sgp_object=Michigan_Data_LONG_2019,
		steps=c("prepareSGP", "analyzeSGP", "combineSGP", "outputSGP"),
		sgp.percentiles=TRUE,
		sgp.projections=TRUE,
		sgp.projections.lagged=TRUE,
		sgp.percentiles.baseline=FALSE,
		sgp.projections.baseline=FALSE,
		sgp.projections.lagged.baseline=FALSE,
		simulate.sgps=TRUE,
		sgp.sqlite=TRUE,
		parallel.config=list(BACKEND="PARALLEL", WORKERS=list(PERCENTILES=4,  PROJECTIONS=4, LAGGED_PROJECTIONS=4)),
		sgp.config= Michigan.2018_2019.config)


## Save results

save(Michigan_SGP, file="Data/Michigan_SGP.Rdata")
