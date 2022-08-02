#########################################################################################
###                                                                                   ###
###      READING BASELINE matrix configurations (sequential and skip-year)            ###
###                                                                                   ###
#########################################################################################

READING_BASELINE.config <- list(
	list(
		sgp.baseline.content.areas=rep("READING", 2),
		sgp.baseline.panel.years=c("2015_2016", "2018_2019"),
		sgp.baseline.grade.sequences=c("3", "6"),
		sgp.baseline.grade.sequences.lags=3),
	list(
		sgp.baseline.content.areas=rep("READING", 2),
		sgp.baseline.panel.years=c("2015_2016", "2018_2019"),
		sgp.baseline.grade.sequences=c("4", "7"),
		sgp.baseline.grade.sequences.lags=3),
	list(
		sgp.baseline.content.areas=rep("READING", 3),
		sgp.baseline.panel.years=c("2014_2015", "2015_2016", "2018_2019"),
		sgp.baseline.grade.sequences=c("3", "4", "7"),
		sgp.baseline.grade.sequences.lags=c(1,3)),
	list(
		sgp.baseline.content.areas=rep("READING", 2),
		sgp.baseline.panel.years=c("2015_2016", "2018_2019"),
		sgp.baseline.grade.sequences=c("5", "8"),
		sgp.baseline.grade.sequences.lags=3),
	list(
		sgp.baseline.content.areas=rep("READING", 3),
		sgp.baseline.panel.years=c("2014_2015", "2015_2016", "2018_2019"),
		sgp.baseline.grade.sequences=c("4", "5", "8"),
		sgp.baseline.grade.sequences.lags=c(1,3)),
	list(
		sgp.baseline.content.areas=rep("READING", 2),
		sgp.baseline.panel.years=c("2015_2016", "2018_2019"),
		sgp.baseline.grade.sequences=c("6", "9"),
		sgp.baseline.grade.sequences.lags=3),
	list(
		sgp.baseline.content.areas=rep("READING", 3),
		sgp.baseline.panel.years=c("2014_2015", "2015_2016", "2018_2019"),
		sgp.baseline.grade.sequences=c("5", "6", "9"),
		sgp.baseline.grade.sequences.lags=c(1,3)),
	list(
		sgp.baseline.content.areas=rep("READING", 2),
		sgp.baseline.panel.years=c("2015_2016", "2018_2019"),
		sgp.baseline.grade.sequences=c("7", "10"),
		sgp.baseline.grade.sequences.lags=3),
	list(
		sgp.baseline.content.areas=rep("READING", 3),
		sgp.baseline.panel.years=c("2014_2015", "2015_2016", "2018_2019"),
		sgp.baseline.grade.sequences=c("6", "7", "10"),
		sgp.baseline.grade.sequences.lags=c(1,3))
)
