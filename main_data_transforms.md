# Notes to Accompany main_data_transforms.R
========================================================


This is the readme file to document the transforms to the main data file of micro contracts, which shows how the aggregation and transformations were conducted prior to the analysis.  

You will need to get the data from my dropbox acc, 
The url is: https://www.dropbox.com/s/8nieffgdtoa3o2h/main.csv.gz
or in R:

```r
# Save the data from my Dropbox
download.file(url = "https://dl.dropboxusercontent.com/s/8nieffgdtoa3o2h/main.csv.gz?dl=1&token_hash=AAF6h_8ek1ftVN2DtEc5yANBg4yMJiMMdrpzxN3ikisgCg", 
    destfile = "main.csv.gz")
```

```
## Error: unsupported URL scheme
```



The main CSV file is compressed in gzip format.  Use Rtools to compress or decompress this via the following code. Note, the path is to where you have installed Rtools in your machine (windows only).

```r
# to compress csv file:
system("c:/Rtools/bin/gzip main.csv")  #note main refers to working Dir
# to decompress csv file:
system("c:/Rtools/bin/gzip -d main.csv.gz")
```


## Loading a Flat File using ff commands:

To manipulate this file in R, you cannot load it all into memory, the uncompressed data file is over 3gb and R quickly hogs the rest of your machine's ram.  the ff, and ffbase package allow for reading of this file in packets stored on your local drive.  

There are some quirks to this package though, and the classes of each variable had to be set to factors (if char or int) and double (if numeric) to allow the format to read them.  

## Processing the files

After resetting the classes of the flat file variables, they can be processed in chunks using ffdfdply() on chuncks of the file by state, then prossing summaryBy() to aggregate chuncks up to the state-year pairs.  

