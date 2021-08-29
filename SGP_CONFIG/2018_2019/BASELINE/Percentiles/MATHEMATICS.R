#############################################################################################
###                                                                                       ###
###            Skip-year SGP Configurations for 2018_2019 MATHEMATICS subjects            ###
###                                                                                       ###
#############################################################################################

MATHEMATICS.2018_2019.config <- list(
################## When/If 2015_2016 MATHEMATICS data available, use these configurations
#	MATHEMATICS.2018_2019 = list(
#		sgp.content.areas=rep("MATHEMATICS", 3),
#		sgp.panel.years=c("2015_2016", "2016_2017", "2018_2019"),
#		sgp.grade.sequences=list(c("3", "5"), c("3", "4", "6"), c("4", "5", "7"), c("5", "6", "8"), c("6", "7", "9"), c("7", "8", "10"), c("8", "9", "11")))
	MATHEMATICS.2018_2019 = list(
		sgp.content.areas=rep("MATHEMATICS", 2),
		sgp.panel.years=c("2016_2017", "2018_2019"),
		sgp.grade.sequences=list(c("3", "5"), c("4", "6"), c("5", "7"), c("6", "8"), c("7", "9"), c("8", "10"), c("9", "11")),
		sgp.norm.group.preference=1),
	MATHEMATICS.2018_2019 = list(
		sgp.content.areas=rep("MATHEMATICS", 2),
		sgp.panel.years=c("2015_2016", "2018_2019"),
		sgp.grade.sequences=list(c("8", "11")),
		sgp.norm.group.preference=2)
)
