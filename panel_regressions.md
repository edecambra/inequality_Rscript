# Panel Regression Documents
========================================================
This article is to serve as a readme file for the panel_regressions.R script in this directory.  These scripts import the data generated from main_data_transforms.R, and perform subsequent estimations used in the analysis in the document on inequality and military spending. 

Lines 9-15 load the data, and subset it into the relevant timespan of 1966-2011.  This time span captures the extended inequality index through 2011, and combines this with the beginning of complete and relevant observatios for military spending in 1966.  It also removes "NA"s from the dataset, which are largely artifacts from the aggregation process and include individual contracts that are lacking the necessary identification codes. 

Lines 18-29 generate deflated and per capita variables to be quickly deployed in the latter regressions.  This allows for clear and direct coding of the model estimations. Note that the CPI prices and the GSP deflator prices exist in different timespans.  CPI is an aggregate price index that coveres the entire span used here (1966-2011).  The GSP deflator exists from 1977 and onward

Lines 33-65 contain the model estimations.  These models are all labled for which subset and transformation of data they are applying.  These models are used in both levels and logs, to narrow down the ultimate specification to be highlighted in the paper.  

