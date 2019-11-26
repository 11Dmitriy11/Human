library(phangorn)
library(dplyr)
modern_people <-  c('JQ247408.1', 'KX459697.1','KT819263.1','KY934476.1', 'JF343123.1',   'KY496869.1',      
'KY077676.1',      'KP340170.1',     'KU521494.1',   'KU521491.1',      'KY303770.1',    'JN084084.1',
'HM453712.1',    'HM448049.1',   'KU508374.1',    'KY934478.1',  'JF837819.1',  'KX440315.1',  'JN419195.1',  
'KT698008.1',  'HQ189135.1',  'HM804485.1','HQ914447.1', 'KX440262.1', 'KX440275.1', 'KM986608.1',  
'KY348642.1', 'GU590993.1', 'KY369152.2',  'KM986616.1','KP172434.1', 'JF499899.1', 'HQ259121.1', 'KU521454.1',   
'KT698006.1','KY686210.1',  'KP172432.1',  'KY686209.1',   'JN084079.1',  'KM986625.1',  'KP017255.1',  
'JF811749.1', 'KR135883.1',  'KR135861.1',   'FJ713601.1')
  neandertal <- c('KX198087.1',   'KX198086.1',  'KX198085.1',  'KX198084.1', 'KX198088.1')
  altai <-  c('FN673705.1',   'FR695060.1', 'KT780370.1')
dat <- read.phyDat("/home/dmitrii/Projects/Humans/align.txt", format="fasta")
data <- dist.ml(dat, model = "F81", exclude = "none")
data <- as.matrix(data)
data <- data.frame(col=colnames(data)[col(data)], row=rownames(data)[row(data)], dist=c(data))
data <- data[data$dist != 0,]
data <- mutate(data, years = dist / 0.000000025)
data <- mutate(data, branch = case_when(col %in% modern_people ~ 'modern',
                                     col %in% neandertal ~ 'neand',
                                     col %in% altai ~ 'altai',
                              TRUE ~ 'Low'))
data <- mutate(data, branch1 = case_when(row %in% modern_people ~ 'modern',
                                                   row %in% neandertal ~ 'neand',
                                                  row %in% altai ~ 'altai',
                                                  TRUE ~ 'Low'))
###################### counting eva age###############################
print('counting eva age:')
mean(as.vector(unlist(as.list(data[(data$col == 'FJ713601.1') & (data$branch == 'modern') & 
                                     (data$branch1 == 'modern'),]['years']))))          

###################### counting neandertal age########################
print('counting neandertal age:')
x<- lapply(neandertal, function(x)   mean(as.vector(unlist(as.list(data[(data$col ==x) & (data$branch1 != 'neand') & 
                                                              (data$branch != 'altai') & (data$branch1 != 'altai') ,]['years']))))   )       
unlist(x)
###################### counting altai age#############################
print('counting altai age:')
y <- lapply(altai, function(x)   mean(as.vector(unlist(as.list(data[(data$col ==x) & (data$branch1 != 'altai') ,]['years']))))   )   
unlist(y)                                          
###################### find nearest     #############################
z <- lapply(modern_people, function(x) data[data$years == min(data[(data$col == x) & (data$branch == 'modern') & 
                                                                        (data$branch1 == 'modern'),]['years']), ] ) 
   
          
          
