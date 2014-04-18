
#library(plm)
#library(lattice)
#library(tikzDevice)
library(ggplot2)
library(foreign)
library(doBy)
library(moments)
library(ff)
library(ffbase)
library(data.table)
setwd("C:/Users/Edward/Desktop/Research_Files/InequalityResearch") #desktop local drive

#to compress csv file:
#system("c:/Rtools/bin/gzip main.csv")   #note main refers to working Dir
#to decompress csv file:
#system("c:/Rtools/bin/gzip -d main.csv.gz")

# Save the data from my Dropbox
#download.file(url ="", destfile = "main.csv.gz")

# To load the data into memory, uses compressed csv file
ptm <- proc.time()
c <- read.csv("main.csv.gz", nrows = 100000)  #Using a large nrow allows R the appropriate Class determination
class <- sapply(c, class)
class[grep("logical", class)] <- "factor"
class[grep("integer", class)] <- "factor"
class[grep("numeric", class)] <- "double"
main.ff <- read.csv.ffdf(file = "main.csv.gz", first.rows = 100000, colClasses = class)
proc.time() - ptm



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







