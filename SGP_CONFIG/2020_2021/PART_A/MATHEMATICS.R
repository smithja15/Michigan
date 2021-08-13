#####
###   MATHEMATICS 2021 configurations (accounting for skipped year in 2020)
#####

MATHEMATICS_2020_2021.config <- list(
     MATHEMATICS.2020_2021 = list(
                 sgp.content.areas = c('MATHEMATICS', 'MATHEMATICS', 'MATHEMATICS'),
                 sgp.panel.years = c('2017_2018', '2018_2019', '2020_2021'),
                 sgp.grade.sequences = list(c('3', '5'), c('3', '4', '6'), c('4', '5', '7'), c('5', '6', '8'), c('6', '7', '9'), c('7', '8', '10'))),
                 #This sequence is not used operationally
    MATHEMATICS.2020_2021=list(
         			sgp.content.areas=c('MATHEMATICS', 'MATHEMATICS', 'MATHEMATICS'),
         			sgp.panel.years=c('2017_2018', '2018_2019', '2020_2021'),
         			sgp.grade.sequences=list(c('9', '10', '11')),
         			sgp.norm.group.preference=2),
         		#This is used operationally for grade 11
    MATHEMATICS_SAT.2020_2021=list(
         			sgp.content.areas=c('MATHEMATICS', 'MATHEMATICS', 'MATHEMATICS'),
         			sgp.panel.years=c('2016_2017', '2017_2018', '2020_2021'),
         			sgp.grade.sequences=list(c('7', '8', '11')),
         			sgp.norm.group.preference=1)
)
