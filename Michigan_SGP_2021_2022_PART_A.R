#################################################################################
###                                                                           ###
###       Michigan -- Create 3-YEAR Pre-COVID Baseline Matrices 2016 to 2019  ###
###                                                                           ###
#################################################################################

### Load necessary packages
require(SGP)
require(data.table)

### Load the results data from the 'official' 2019 SGP analyses
load("Data/Michigan_SGP_LONG_Data.Rdata")

### Take data from pre-covid years (2018_2019 and prior)
Michigan_Baseline_Data <- Michigan_SGP_LONG_Data[YEAR <= "2018_2019"][, c("VALID_CASE", "CONTENT_AREA", "YEAR", "ID", "GRADE", "SCALE_SCORE", "ACHIEVEMENT_LEVEL"), with=FALSE] 

###   Read in Baseline SGP Configuration Scripts and Combine
source("SGP_CONFIG/2021_2022/BASELINE/Matrices/READING.R")
source("SGP_CONFIG/2021_2022/BASELINE/Matrices/MATHEMATICS.R")

MI_BASELINE_CONFIG <- c(
	READING_BASELINE.config,
	MATHEMATICS_BASELINE.config
)

###
###   Create Baseline Matrices

Michigan_SGP <- prepareSGP(Michigan_Baseline_Data, create.additional.variables=FALSE)

MI_Baseline_Matrices <- baselineSGP(
				Michigan_SGP,
				sgp.baseline.config=MI_BASELINE_CONFIG,
				return.matrices.only=TRUE,
				calculate.baseline.sgps=FALSE,
				goodness.of.fit.print=FALSE,
				parallel.config = list(
					BACKEND="PARALLEL", WORKERS=list(TAUS=18))
)

###   Save results
save(MI_Baseline_Matrices, file="Data/MI_Baseline_Matrices.Rdata")