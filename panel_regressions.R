
library(plm)
#setwd("C:/Users/Edward/Desktop/Research_Files/InequalityResearch") #desktop local drive
#setwd("C:/Users/edecambr/Desktop/Research_Files/InequalityResearch")
#setwd("C:/Users/edecambr/Dropbox/Research_Files/InequalityResearch") #laptop
setwd("C:/Users/Edward/Dropbox/Research_Files/InequalityResearch") #desktop

## Setting and sorting the Data
data <- read.csv("inequalitydata.csv")
data <- data[data$year > 1965 & data$year < 2012, ]
data <- data[data$fips >= 1 & data$fips <=57, ]
data <- data[is.na(data$fips) == FALSE, ] 
data <- data[is.na(data$year) == FALSE, ]
data <- data[order(data$fips, data$year), ]
data <- pdata.frame(data, index = c("state", "year"), row.names = T)

##adding deflated and per-capita variables
data$cpi.spend <- data$spend/(data$inflation/100)
data$deflator.spend <- data$spend/data$deflator
data$cpi.gsp <- data$nom.gsp/(data$inflation/100)
data$deflator.gsp <- data$nom.gsp/data$deflator

data$cpi.capita.spend <- (data$spend/(data$inflation/100))/data$pop
data$deflator.capita.spend <- (data$spend/data$deflator)/data$pop
data$cpi.capita.gsp <- (data$nom.gsp/(data$inflation/100))/data$pop
data$deflator.capita.gsp <- (data$nom.gsp/data$deflator)/data$pop

data$capita.spend <- data$spend/data$pop 
data$capita.gsp <-  data$nom.gsp/data$pop


##Aggregate regressions (non per capita)
### nominal data regressions
reg.base <- plm(top10~spend + nom.gsp + emp.rate, data = data, model = "within", effect = "twoway", na.action = na.omit)
summary(reg.base)
reg.log <- plm(log(top10)~ log(spend) + log(nom.gsp) + log(emp.rate), data = data, model = "within", effect = "twoway", na.action = na.omit)
summary(reg.log)
### aggregate CPI deflated regressions
reg.cpi <- plm(top10~ cpi.spend + cpi.gsp + emp.rate, data = data, model = "within", effect = "twoway", na.action = na.omit)
summary(reg.cpi)
reg.log.cpi <- plm(log(top10)~ log(cpi.spend) + log(cpi.gsp) + log(emp.rate), data = data, model = "within", effect = "twoway", na.action = na.omit)
summary(reg.log.cpi)
### GSP deflator adjusted regressions
reg.deflator <- plm(top10~ deflator.spend + deflator.gsp + emp.rate, data = data, model = "within", effect = "twoway", na.action = na.omit)
summary(reg.deflator)
reg.log.deflator <- plm(log(top10)~ log(deflator.spend) + log(deflator.gsp) + log(emp.rate), data = data, model = "within", effect = "twoway", na.action = na.omit)
summary(reg.log.deflator)


## Per Capita Regressions
### Nominal regressions
reg.capita.base <- plm(top10~capita.spend + capita.gsp + emp.rate, data = data, model = "within", effect = "twoway", na.action = na.omit)
summary(reg.capita.base)
reg.capita.log <- plm(log(top10)~ log(capita.spend) + log(capita.gsp) + log(emp.rate), data = data, model = "within", effect = "twoway", na.action = na.omit)
summary(reg.capita.log)
### Aggregate CPI deflated Regressions
reg.cpi.capita <- plm(top10~ cpi.capita.spend + cpi.capita.gsp + emp.rate, data = data, model = "within", effect = "twoway", na.action = na.omit)
summary(reg.cpi.capita)
reg.log.cpi.capita <- plm(log(top10)~ log(cpi.capita.spend) + log(cpi.capita.gsp) + log(emp.rate), data = data, model = "within", effect = "twoway", na.action = na.omit)
summary(reg.log.cpi.capita)
### GSP Deflator adjusted regressions
reg.deflator.capita <- plm(top10~ deflator.capita.spend + deflator.capita.gsp + emp.rate, data = data, model = "within", effect = "twoway", na.action = na.omit)
summary(reg.deflator.capita)
reg.log.deflator.capita <- plm(log(top10)~ log(deflator.capita.spend) + log(deflator.capita.gsp) + log(emp.rate), data = data, model = "within", effect = "twoway", na.action = na.omit)
summary(reg.log.deflator.capita)



plot(data$year, data$spend, data = data)
plot(data$year, data$nom.spend, data = data)
?plot

temp <- data[ , c("year", "state", "fips", "nom.spend", "spend")]
write.csv(temp, "temp.csv")
