################################################################################
###                                                                          ###
###             SGP Configurations for Spring 2019 READING                   ###
###                                                                          ###
################################################################################

READING.2018_2019.config <- list(
			READING.2018_2019=list(
                sgp.content.areas=c('READING', 'READING', 'READING'),
                sgp.panel.years=c('2016_2017', '2017_2018', '2018_2019'),
                sgp.grade.sequences=list(c(3),c('3', '4'), c('3', '4', '5'), c('4', '5', '6'), c('5', '6', '7'))),
			READING_PSAT_8.2018_2019=list(
               	sgp.content.areas=c('READING', 'READING', 'READING_PSAT'),
               	sgp.panel.years=c('2016_2017', '2017_2018', '2018_2019'),
               	sgp.grade.sequences=list(c('6', '7', '8'))),
	       		sgp.projection.grade.sequences=as.list("NO_PROJECTIONS"),
			READING_SAT.2018_2019=list(
               sgp.content.areas=c('READING', 'READING', 'READING_SAT'),
               sgp.panel.years=c('2014_2015', '2015_2016', '2018_2019'),
               sgp.grade.sequences=list(c('7', '8', '11'))),
			   sgp.projection.grade.sequences=as.list("NO_PROJECTIONS"))
