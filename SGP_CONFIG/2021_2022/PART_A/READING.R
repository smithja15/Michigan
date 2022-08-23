#############################################################################################
###                                                                                       ###
###            SGP Configurations for 2021_2022 READING subjects                      ###
###                                                                                       ###
#############################################################################################

READING.2021_2022.config <- list(
	READING.2021_2022 = list(
		sgp.content.areas=rep("READING", 2),
		sgp.panel.years=c("2020_2021", "2021_2022"),
		sgp.grade.sequences=list(c("3", "4"), c("4", "5"), c("5", "6"), c("6", "7"), c("7", "8"), c("8", "9"), c("9", "10"), c("10", "11")),
		sgp.norm.group.preference=1),
	READING_GRADE_11.2021_2022=list(
		sgp.content.areas=c('READING', 'READING', 'READING'),
		sgp.panel.years=c('2017_2018', '2018_2019', '2021_2022'),
		sgp.grade.sequences=list(c('7', '8', '11')),
		sgp.norm.group.preference=2)
)

READING.2021_2022_SKIP_2_YEAR.config <- list(
	READING.2021_2022 = list(
		sgp.content.areas=rep("READING", 3),
		sgp.panel.years=c("2017_2018", "2018_2019", "2021_2022"),
		sgp.grade.sequences=list(c("3", "6"), c("3", "4", "7"), c("4", "5", "8"), c("5", "6", "9"), c("6", "7", "10"), c("7", "8", "11")))
)
