library(foreign)
library(doBy)
library(ff)
library(ffbase)
library(plm)
#setwd("C:/Users/Edward/Desktop/Research_Files/InequalityResearch") #desktop local drive
#setwd("C:/Users/edecambr/Desktop/Research_Files/InequalityResearch")
#setwd("C:/Users/edecambr/Dropbox/Research_Files/InequalityResearch") #laptop
setwd("C:/Users/Edward/Dropbox/Research_Files/InequalityResearch") #desktop

## Setting the Data

data <- read.csv("inequalitydata.csv")
data1 <- data[data$year > 1965 & data$year < 2006 ,]
data1 <- pdata.frame(data1, index = c("state", "year"), row.names = T)



reg1 <- plm(top10~spend + nom.gsp + emp.rate, data = data1, model = "within", effect = "twoway", na.action = na.exclude)
summary(reg1)

reg.ln <- plm(ln(top10)~ ln(spend) + ln(nom.gsp) + ln(emp.rate), data = data1, model = "within", effect = "twoway", na.action = na.exclude)
reg.real <- plm(top10~ (spend/(inflation/100)) + (nom.gsp/(inflation/100)) + emp.rate, data = data1, model = "within", effect = "twoway", na.action = na.exclude)
reg.ln.real <- plm(ln(top10)~ ln(spend/(inflation/100)) + ln(nom.gsp/(inflation/100)) + ln(emp.rate), data = data1, model = "within", effect = "twoway", na.action = na.exclude)

reg2 <- plm(top10~nom.spend + nom.gsp + emp.rate + year, data = data1, model = "within", effect = "individual", na.action = na.exclude)
summary(reg2)

plot(data1$year, data1$spend, data = data1)
plot(data1$year, data1$nom.spend, data = data1)
?plot

temp <- data1[ , c("year", "state", "fips", "nom.spend", "spend")]
write.csv(temp, "temp.csv")
