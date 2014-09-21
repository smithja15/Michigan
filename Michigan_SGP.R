######################################################################################
###
### Scripts for the calculation of SGPs for Michigan
###
######################################################################################

### Load SGP Package

require(SGP)


### Load data

load("Data/Michigan_Data_LONG.Rdata")


### Create Configurations

MICHIGAN.2012_2013.config <- list(
	MATHEMATICS.2012_2013.config=list(
                sgp.content.areas=c('MATHEMATICS', 'MATHEMATICS'),
                sgp.panel.years=c('2011_2012', '2012_2013'),
                sgp.grade.sequences=list(c('3', '4'), c('4', '5'), c('5', '6'), c('6', '7'), c('7', '8'))),
	MATHEMATICS.MME.2012_2013.config=list(
                sgp.content.areas=c('MATHEMATICS', 'MATHEMATICS'),
                sgp.panel.years=c('2009_2010', '2012_2013'),
                sgp.grade.sequences=list(c('8', 'EOCT'))),
	READING.2012_2013.config=list(
                sgp.content.areas=c('READING', 'READING'),
                sgp.panel.years=c('2011_2012', '2012_2013'),
                sgp.grade.sequences=list(c('3', '4'), c('4', '5'), c('5', '6'), c('6', '7'), c('7', '8'))),
	READING.MME.2012_2013.config=list(
                sgp.content.areas=c('READING', 'READING'),
                sgp.panel.years=c('2009_2010', '2012_2013'),
                sgp.grade.sequences=list(c('8', 'EOCT'))),
	WRITING.2012_2013.config=list(
                sgp.content.areas=c('WRITING', 'WRITING'),
                sgp.panel.years=c('2009_2010', '2012_2013'),
                sgp.grade.sequences=list(c('4', '7'))),
	WRITING.MME.2012_2013.config=list(
                sgp.content.areas=c('WRITING', 'WRITING'),
                sgp.panel.years=c('2008_2009', '2012_2013'),
                sgp.grade.sequences=list(c('7', 'EOCT'))),
	SCIENCE.2012_2013.config=list(
                sgp.content.areas=c('SCIENCE', 'SCIENCE'),
                sgp.panel.years=c('2009_2010', '2012_2013'),
                sgp.grade.sequences=list(c('5', '8'))),
	SCIENCE.MME.2012_2013.config=list(
                sgp.content.areas=c('SCIENCE', 'SCIENCE'),
                sgp.panel.years=c('2009_2010', '2012_2013'),
                sgp.grade.sequences=list(c('8', 'EOCT'))),
	SOCIAL_STUDIES.2012_2013.config=list(
                sgp.content.areas=c('SOCIAL_STUDIES', 'SOCIAL_STUDIES'),
                sgp.panel.years=c('2009_2010', '2012_2013'),
                sgp.grade.sequences=list(c('6', '9'))),
	SOCIAL_STUDIES.MME.2012_2013.config=list(
                sgp.content.areas=c('SOCIAL_STUDIES', 'SOCIAL_STUDIES'),
                sgp.panel.years=c('2010_2011', '2012_2013'),
                sgp.grade.sequences=list(c('9', 'EOCT'))),

MICHIGAN.2013_2014.config <- list(
	MATHEMATICS.2013_2014.config=list(
                sgp.content.areas=c('MATHEMATICS', 'MATHEMATICS'),
                sgp.panel.years=c('2012_2013', '2013_2014'),
                sgp.grade.sequences=list(c('3', '4'), c('4', '5'), c('5', '6'), c('6', '7'), c('7', '8'))),
	MATHEMATICS.MME.2013_2014.config=list(
                sgp.content.areas=c('MATHEMATICS', 'MATHEMATICS'),
                sgp.panel.years=c('2010_2011', '2013_2014'),
                sgp.grade.sequences=list(c('8', 'EOCT'))),
	READING.2013_2014.config=list(
                sgp.content.areas=c('READING', 'READING'),
                sgp.panel.years=c('2012_2013', '2013_2014'),
                sgp.grade.sequences=list(c('3', '4'), c('4', '5'), c('5', '6'), c('6', '7'), c('7', '8'))),
	READING.MME.2013_2014.config=list(
                sgp.content.areas=c('READING', 'READING'),
                sgp.panel.years=c('2010_2011', '2013_2014'),
                sgp.grade.sequences=list(c('8', 'EOCT'))),
	WRITING.2013_2014.config=list(
                sgp.content.areas=c('WRITING', 'WRITING'),
                sgp.panel.years=c('2010_2011', '2013_2014'),
                sgp.grade.sequences=list(c('4', '7'))),
	WRITING.MME.2013_2014.config=list(
                sgp.content.areas=c('WRITING', 'WRITING'),
                sgp.panel.years=c('2009_2010', '2013_2014'),
                sgp.grade.sequences=list(c('7', 'EOCT'))),
	SCIENCE.2013_2014.config=list(
                sgp.content.areas=c('SCIENCE', 'SCIENCE'),
                sgp.panel.years=c('2010_2011', '2013_2014'),
                sgp.grade.sequences=list(c('5', '8'))),
	SCIENCE.MME.2013_2014.config=list(
                sgp.content.areas=c('SCIENCE', 'SCIENCE'),
                sgp.panel.years=c('2010_2011', '2013_2014'),
                sgp.grade.sequences=list(c('8', 'EOCT'))),
	SOCIAL_STUDIES.2013_2014.config=list(
                sgp.content.areas=c('SOCIAL_STUDIES', 'SOCIAL_STUDIES'),
                sgp.panel.years=c('2010_2011', '2013_2014'),
                sgp.grade.sequences=list(c('6', '9'))),
	SOCIAL_STUDIES.MME.2013_2014.config=list(
                sgp.content.areas=c('SOCIAL_STUDIES', 'SOCIAL_STUDIES'),
                sgp.panel.years=c('2011_2012', '2013_2014'),
                sgp.grade.sequences=list(c('9', 'EOCT'))),

MICHIGAN.config <- c(MICHIGAN.2012_2013.config, MICHIGAN.2013_2014.config)


### Step 1: prepareSGP

Michigan_SGP <- prepareSGP(Michigan_Data_LONG)





