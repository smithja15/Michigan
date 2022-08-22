#############################################################################################
###                                                                                       ###
###            Skip-year SGP Configurations for 2018_2019 READING subjects            ###
###                                                                                       ###
#############################################################################################

READING.2018_2019.config <- list(
	READING.2018_2019 = list(
		sgp.content.areas=rep("READING", 3),
		sgp.panel.years=c("2016_2017", "2017_2018", "2018_2019"),
		sgp.grade.sequences=list(c("3", "4"), c("3", "4", "5"), c("4", "5", "6"), c("5", "6", "7"), c("6", "7", "8"), c("7", "8", "9")),
		sgp.norm.group.preference=1),
	READING_GRADE_10_11.2018_2019=list(
		sgp.content.areas=c('READING', 'READING', 'READING'),
		sgp.panel.years=c('2016_2017', '2017_2018', '2018_2019'),
		sgp.grade.sequences=list(c('8', '9', '10'),c('9', '10', '11')),
		sgp.norm.group.preference=1),
 	READING_GRADE_10_11.2018_2019=list(
		sgp.content.areas=c('READING', 'READING', 'READING'),
		sgp.panel.years=c('2015_2016', '2016_2017', '2018_2019'),
		sgp.grade.sequences=list(c('7', '8', '10'),c('8', '9', '11')),
		sgp.norm.group.preference=2,
		sgp.projection.baseline.grade.sequences="NO_PROJECTIONS"),
	READING_GRADE_10_11.2018_2019=list(
		sgp.content.areas=c('READING', 'READING', 'READING'),
		sgp.panel.years=c('2014_2015', '2015_2016', '2018_2019'),
		sgp.grade.sequences=list(c('7', '8', '11')),
		sgp.norm.group.preference=3,
		sgp.projection.baseline.grade.sequences="NO_PROJECTIONS")
)

READING.2018_2019_SKIP_YEAR.config <- list(
	READING.2018_2019 = list(
		sgp.content.areas=rep("READING", 3),
		sgp.panel.years=c("2015_2016", "2016_2017", "2018_2019"),
		sgp.grade.sequences=list(c("3", "5"), c("3", "4", "6"), c("4", "5", "7"), c("5", "6", "8"), c("6", "7", "9"), c("7", "8", "10"), c("8", "9", "11")))
)

READING.2018_2019_SKIP_2_YEAR.config <- list(
	READING.2018_2019 = list(
		sgp.content.areas=rep("READING", 3),
		sgp.panel.years=c("2014_2015", "2015_2016", "2018_2019"),
		sgp.grade.sequences=list(c("3", "6"), c("3", "4", "7"), c("4", "5", "8"), c("5", "6", "9"), c("6", "7", "10"), c("7", "8", "11")))
)
