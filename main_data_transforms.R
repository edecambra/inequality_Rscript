
library(foreign)
library(doBy)
library(ff)
library(ffbase)
setwd("C:/Users/Edward/Desktop/Research_Files/InequalityResearch") #desktop local drive


# To load the data into memory, uses compressed gzip file: main.csv.gz 
ptm <- proc.time()
c <- read.csv("main.csv.gz", nrows = 100000)  #Using a large nrow allows R the appropriate Class determination
class <- sapply(c, class)
class[grep("logical", class)] <- "factor"
class[grep("integer", class)] <- "factor"
class[grep("numeric", class)] <- "double"
main.ff <- read.csv.ffdf(file = "main.csv.gz", first.rows = 100000, colClasses = class)
proc.time() - ptm  #takes roughly 8 minutes to process, 

#Date Coding
main.ff$start_date <- with(main.ff, as.Date(start_date, "%d%b%Y"))
main.ff$end_date <- with(main.ff, as.Date(end_date, "%d%b%Y"))
main.ff$year <- with(main.ff, as.integer(format(start_date, "%Y")))
main.ff$fips <- with(main.ff, as.integer(fips))
agg <- ffdfdply(x = main.ff, 
                split = main.ff$fips,
                FUN = function(x){
                  require(doBy)
                  summaryBy(spend~year + fips, data = x, keep.names = T, FUN = sum, na.rm = T)
                  },
                BATCHBYTES = 10000, trace = T)
agg.tab <- as.data.frame(agg)                

agg.2 <- ffdfdply(x = main.ff, 
                split = main.ff$fips,
                FUN = function(x){
                  require(doBy)
                  summaryBy(spend~year, data = x, keep.names = T, FUN = sum, na.rm = T)
                },
                BATCHBYTES = 10000, trace = T)
agg.tab2 <- as.data.frame(agg)


state.codes <- read.csv(file = "statemastercodelist.csv")
state.codes <- data.frame(state.codes$state_frank, state.codes$fipsmil)
names(state.codes) <- c("state", "fips")
frank <- read.csv(file = "Frank_All_v96a.csv")
inflation <- read.csv(file = "inflation.csv")
extra.state <- read.csv("extra.state.csv")
vars <- c("usspend", "pop", "nom.spend", "nomGSP", "deflator", "emp.rate", "year", "fipsmil"  )
extra.state <- extra.state[,vars]
colnames(extra.state) <- c("usspend", "pop", "nom.spend", "nom.gsp", "deflator", "emp.rate", "year", "fips"  )

suppliment <- merge(frank, state.codes, by = "state", all = TRUE)
suppliment <- merge(suppliment, inflation, by = "year", all = TRUE)
suppliment <- merge(suppliment, extra.state, by = c("fips", "year"), all = TRUE)

data <- merge(agg.tab, suppliment, by = c("fips", "year"), all = TRUE)




