#########################################################################################
###                                                                                   ###
###            Skip-year SGP Configurations for 2018_2019 READING subjects            ###
###                                                                                   ###
#########################################################################################

READING.2018_2019.config <- list(
################## When/If 2015_2016 READING data available, use these configurations
#	READING.2018_2019 = list(
#		sgp.content.areas=rep("READING", 3),
#		sgp.panel.years=c("2015_2016", "2016_2017", "2018_2019"),
#		sgp.grade.sequences=list(c("3", "5"), c("3", "4", "6"), c("4", "5", "7"), c("5", "6", "8"), c("6", "7", "9"), c("7", "8", "10"), c("8", "9", "11")))
	READING.2018_2019 = list(
		sgp.content.areas=rep("READING", 2),
		sgp.panel.years=c("2016_2017", "2018_2019"),
		sgp.grade.sequences=list(c("3", "5"), c("4", "6"), c("5", "7"), c("6", "8"), c("7", "9"), c("8", "10"), c("9", "11")),
		sgp.norm.grooup.preference=1),
	READING.2018_2019 = list(
		sgp.content.areas=rep("READING", 2),
		sgp.panel.years=c("2015_2016", "2018_2019"),
		sgp.grade.sequences=list(c("8", "11")),
		sgp.norm.grooup.preference=2)
)
