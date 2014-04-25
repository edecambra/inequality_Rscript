
library(foreign)
library(ff)
library(ffbase)
#setwd("C:/Users/Edward/Desktop/Research_Files/InequalityResearch") #desktop local drive
#setwd("C:/Users/edecambr/Desktop/Research_Files/InequalityResearch")
#setwd("C:/Users/edecambr/Dropbox/Research_Files/InequalityResearch") #laptop
setwd("C:/Users/Edward/Dropbox/Research_Files/InequalityResearch") #desktop


## To load the data into memory, uses compressed gzip file: main.csv.gz 
## Loading a Flat File using ff commands
ptm <- proc.time()
c <- read.csv("main.csv.gz", nrows = 100000)  #Using a large nrow allows R the appropriate Class determination

class <- sapply(c, class)
class[grep("logical", class)] <- "factor"
class[grep("integer", class)] <- "factor"
class[grep("numeric", class)] <- "double"
main.ff <- read.csv.ffdf(file = "main.csv.gz", first.rows = 100000, colClasses = class)
proc.time() - ptm  #takes roughly 8 minutes to process, 

## Processing the Files
main.ff$start_date <- with(main.ff, as.Date(start_date, "%d%b%Y"))
main.ff$year <- with(main.ff, as.factor(format(start_date, "%Y")))
main.ff$fips <- with(main.ff, as.factor(fips))
#main.ff$KeyColumn <- ikey(main.ff[c("fips", "year")])
main.ff<- main.ff[fforder(main.ff$fips, main.ff$year), ]

#agg.func <- function(x){
 # agg.df <- tapply(x$spend, list(x$fips, x$year), FUN = sum)
#}

system.time(agg <- ffdfdply(x = main.ff, 
                split = main.ff$year,
                FUN = function(x){
                  aggregate(spend~fips + year, data = x, FUN = sum, na.rm = T)
                },
                BATCHBYTES = 10000, trace = T))
agg.tab <- as.data.frame(agg)                


## Supplimental Data
state.codes <- read.csv(file = "statemastercodelist.csv.gz")
state.codes <- data.frame(state.codes$state_frank, state.codes$fipsmil)
names(state.codes) <- c("state", "fips")
frank <- read.csv(file = "Frank_All_v96a.csv")
inflation <- read.csv(file = "inflation.csv.gz")
extra.state <- read.csv("extra.state.csv.gz")
vars <- c("usspend", "pop", "nom.spend", "nomGSP", "deflator", "emp.rate", "year", "fipsmil"  )
extra.state <- extra.state[,vars]
colnames(extra.state) <- c("usspend", "pop", "nom.spend", "nom.gsp", "deflator", "emp.rate", "year", "fips"  )

suppliment <- merge(frank, state.codes, by = "state", all = TRUE)
suppliment <- merge(suppliment, inflation, by = "year", all = TRUE)
suppliment <- merge(suppliment, extra.state, by = c("fips", "year"), all = TRUE)

data <- merge(agg.tab, suppliment, by = c("fips", "year"), all = TRUE)
write.csv(data, file="inequalitydata.csv")


