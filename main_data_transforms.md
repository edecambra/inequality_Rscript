# Notes to Accompany main_data_transforms.R
========================================================


This is the readme file to document the transforms to the main data file of micro contracts, which shows how the aggregation and transformations were conducted prior to the analysis of.  The Headings correspond to their respecitve blocks of code in main_data_transforms.R script.   

You will need to get the micro level military data from my dropbox acc, 
The url is: https://www.dropbox.com/s/8nieffgdtoa3o2h/main.csv.gz
or in R:

```r
# Save the data from my Dropbox
download.file(url = "https://dl.dropboxusercontent.com/s/8nieffgdtoa3o2h/main.csv.gz?dl=1&token_hash=AAF6h_8ek1ftVN2DtEc5yANBg4yMJiMMdrpzxN3ikisgCg", 
    destfile = "main.csv.gz", mode = "wb")
```

```
## Error: unsupported URL scheme
```


The main CSV file is compressed in gzip format.  Use Rtools to compress or decompress this via the following code. Note, the path is to where you have installed Rtools in your machine (windows only, of course). Use these commands on any of the .gz file extensions analagously if desired, but R reads the compressed files directly so this step is optional. 

```r
# to compress csv file:
system("c:/Rtools/bin/gzip main.csv")  #note main refers to working Dir
# to decompress csv file:
system("c:/Rtools/bin/gzip -d main.csv.gz")
```


## Loading a Flat File using ff commands:
To manipulate this file in R, you cannot load it all into memory, the uncompressed data file is over 3gb and R quickly hogs the rest of your machine's ram.  the ff, and ffbase package allow for reading of this file in packets stored on your local drive.  

There are some quirks to this package though, and the classes of each variable had to be set to factors (if char or int) and double (if numeric) to allow the format to read them.  

Also using the ff package enables you to keep the native data in memory, and access micro contract statistics on the fly without consuming all of your computer's resources

For example, my machine (i7 quad core, 64 bit R v2.15.2, with 16 gb ram) loads the file into memory using read.csv.ffdf() in roughly 517.85 sec (~8min), and aggregates by state-year pairs in 256.13 sec (~4min).  

## Processing the files
After resetting the classes of the flat file variables, they can be processed in chunks using ffdfdply() on chuncks of the file by state, then prossing summaryBy() to aggregate chuncks up to the state-year pairs.  

## Supplimental Data
Finally we couple the aggregated military spending state-year data points with data outside of the form DD 350.  Here we use the following data sources.

The Inequality file is constructed by Mark Frank, with information on his site here: http://www.shsu.edu/eco_mwf/inequality.html, and I am using the six measures, main data file.  

```r
# Save the data from my Dropbox
download.file(url = "http://www.shsu.edu/eco_mwf/Frank_All_v96a.csv", destfile = "Frank_All_v96a.csv", 
    mode = "w")
```

Supplimental files are located here:
https://www.dropbox.com/s/cskwo3cbqbynfwx/statemastercodelist.csv.gz for each file's state id coding, 
https://www.dropbox.com/s/nx4nleq4ux4xlnw/inflation.csv.gz for annyal CPI inflation measures, and 
https://www.dropbox.com/sh/d28kx8p4agd9rn8/L1PHM_iMWq for various state indicators like GSP, population, employment etc. 

in R

```r
download.file(url = "https://dl.dropboxusercontent.com/s/cskwo3cbqbynfwx/statemastercodelist.csv.gz?dl=1&token_hash=AAEv-bUzZvdLgIHvUfr0kJCXogBgbqOD5R3ROi93_ov-mg", 
    destfile = "statemastercodelist.csv.gz", mode = "wb")
```

```
## Error: unsupported URL scheme
```

```r
download.file(url = "https://dl.dropboxusercontent.com/s/nx4nleq4ux4xlnw/inflation.csv.gz?dl=1&token_hash=AAFFs3xzBd0XY9ju4hBagnQFPurYt7O-N5Y2DTh9uN19Fw", 
    destfile = "inflation.csv.gz", mode = "wb")
```

```
## Error: unsupported URL scheme
```

```r
download.file(url = "https://dl.dropboxusercontent.com/s/ojbpcqktswkhdhz/extra.state.CSV.gz?dl=1&token_hash=AAG1vhkz9maBbZZq72lMNJsxpojDNlExTvdVjEpUnxSpFg", 
    destfile = "extra.state.csv.gz", mode = "wb")
```

```
## Error: unsupported URL scheme
```


These data sources are used in the program script, and together with the main data file used initially, the program yields an aggregate data source object called data, and writes the csv table to file
