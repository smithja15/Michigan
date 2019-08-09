##########################################################################
###                                                                    ###
###     Michigan SGP analysis script for 2019                          ###
###                                                                    ###
##########################################################################

### Load packages

require(data.table)
require(SGP)

### Load Data

load("Data/Michigan_Data_LONG.Rdata")


### Load configurations

source("SGP_CONFIG/2019/MATHEMATICS.R")
source("SGP_CONFIG/2019/READING.R")
source("SGP_CONFIG/2019/SOCIAL_STUDIES.R")

Michigan.2018_2019.config <- list(MATHEMATICS.2018_2019.config, READING.2018_2019.config, SOCIAL_STUDIES.2018_2019.config)




#SGPstateData[["MI"]][["Achievement"]][["Knots_Boundaries"]] <- NULL
#SGPstateData[["MI"]][["SGP_Configuration"]][["max.sgp.target.years.forward"]] <- 1:7
#SGPstateData[["MI"]][["SGP_Configuration"]][["sgp.target.scale.scores.merge"]] <- "1_year_lagged_current"


### Step 1: prepareSGP

MStep.small<- readRDS("MStep2019_SGP.rds")
Michigan_SGP <- prepareSGP(MStep.small, state="MI")
#table(Michigan_SGP@Data$ACHIEVEMENT_LEVEL)
### Step 2: analyzeSGP

Michigan_SGP <- analyzeSGP(
		sgp_object=Michigan_SGP,
		sgp.percentiles=TRUE,
		sgp.projections=TRUE,
		sgp.projections.lagged=TRUE,
		sgp.percentiles.baseline=FALSE,
		sgp.projections.baseline=FALSE,
		sgp.projections.lagged.baseline=FALSE,
		simulate.sgps=TRUE,
		sgp.sqlite=TRUE,
		#parallel.config=list(BACKEND="PARALLEL", WORKERS=list(PERCENTILES=2,  PROJECTIONS=1, LAGGED_PROJECTIONS=1)),
		sgp.config= MICHIGAN.2018_2019.config,
		state="MI")
		#

### STEPS 3 & 4: combineSGP

	Michigan_SGP<-combineSGP(Michigan_SGP, state="MI",sgp.target.scale.scores=TRUE,
		parallel.config=list(BACKEND="PARALLEL", WORKERS=list(PERCENTILES=2,  PROJECTIONS=1, LAGGED_PROJECTIONS=1)),
		sgp.config= MICHIGAN.2018_2019.config)
	outputSGP(Michigan_SGP, state="MI",output.type="LONG_FINAL_YEAR_Data")
#
