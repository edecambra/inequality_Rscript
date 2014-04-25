###############################
### Data Notes          #######
### 10/15/2013             ####
### Contract Master Data Set ##
###############################

These notes will serve as the master note file for my contract level data set, which will chronicle what happened to the variables and note how each variable is defined. 

fy : This is  the fiscal year variable.  It denotes the fiscal year that the contracts was signed, and is the first variable in the 1966-1983 files, and in the 1984-2006 it is a monthly variable, cut to annual

spend : This is the signed contract amount, obligated when both the DoD and the contractor sign the deal.  For the period of 1966-1983 the files contain observations for contracts over 10,000 dollars, and for 1984-2006 it contains observations for contracts over 25,000.  For the newer files, 2007-2012, contain all DoD contract procurement.  Zero or negative spending observations are for modifications to previous contracts. Measured in dollar values.

contractor_code : This corresponds to the duns number system used by the Federal Procurement Data System and developed by Dun and Bradstreet. DUNS stands for data universal numbering system.  This numbering system exists from 1984 and later, including 2007 and newer also.  One caveat is the observations from fy1992-fy1996 contain a different contractor identification system. For the early period there is also an alternate coding system, listed and described later in this dataset as contractor_code_early.  A nine digit code

offers_rec : This variable applies only to the observations from fy1984 - 2012.  from FY1984-1996 this variable was 1 for only one offer received and 2 for more than 1, from FY1997-2012 it records the actual number of offers received.  Observations for FY1984 and into FY1985 are spotty, with much better coverage FY1986 and on

offers_sol : This variable records the numbers of contractors solicited from the government for the observations from FY1984-2006.  It is 1 for one contractor solicited and 2 for more than one.  Observations for FY1984 and into FY1985 are spotty, with much better coverage FY1986 and on

numb_of_emps : This varaible applies only to the observations from fy2007 - 2012.  It is a measure of the size of the signed contractor, and measures the number of employees at the firm. Integer value.

annual_rev : This variable applies only to the observation from fy2007 - 2012.  It is a measure of the size of the signed contractor, measuring the annual revenue for that firm.  Measured in dollars.

woman_owned : This is a string variable containing a Y for woman owned, N for not woman owned, and U for unobserved.  This variable is measured from fy1984 - 2012.

start_date : This is a Stata proprietary coded number variable to identify a specific date and allow for Stata "date" functions.  It is capturing the original signed date of the contract, providing the date of knowledge of the contract award, capturing the timing impact. Pre 1984 this is was originally a monthly variable in the raw file, after it was the actual date

end_date : This is a Stata proprietary coded number variable to identify a specific date and allow for Stata "date" functions. The variable is capturing the completion date of the contract, as expected or scheduled based on the original signed contract. Pre 1984 this is was originally a monthly variable in the raw file, after it was the actual date.  Also this data does not exist for FY1983-1988 in the data, also from 1989-1993, this data is spotty.

fips : This is the Federal Information Processing Standards codes for U.S. states.  This is a 2 digit number to identify the U.S. state, from 1 - 56 and non-consecutive.  Can be found at the census.gov or usgs.gov 

prod_serv_code : This is a 4 digit code used by the DoD to broadly categorize what the contracted product or service.  This records the principal category that the product or service applies to.  If multiple categories apply to the procurement then the category that accounts for the majority of the allocated dollars will be listed here.  Maintained by the FPDS-NG, with PDF documentation.  Some of the observations for earlier years (1983 and earlier) that begin with a letter are unlisted here. 

multi_year_contract : This is a string variable containing a Y or N for whether or not the associated contract is for a multi year or single fiscal year.  The majority of contracts are individual years, as is the preference of the DoD and stipulated in U.S. code/law for procurement guidelines. For the period of 1984 - ..., this coding was 1-yes 2-no and recoded to merge with the later years.

extent_compete : This variable contains numbers 0-4.  1-full and open; 2-not available for comp; 3-follown-on comp; 4-non-competed, and 0-missing or N/A.  The early period (66-83) contains observations from extent_comp_early, which perviously was defined as a number from 1-5; 3 and 4 were combined into 3 here, and 5 was moved to 4 here.  84-87 is 99.9 percent missing observations for this var. 88 and on had data of A-D and in that order corresponds to our variables now: 1-A, 2-B, 3-C, 4-D.  For the new set, 2007-2012, 1-A full and open comp; 2-B not competed; 3-D full and open comp after exclusion of sources, 4-C not competed; E - follow on to competed action; F - competed under SAP; G - not competed under SAP; 
 
sic_code : This variable exists for the SIC industry codes, which is a 4 digit number describing the industrial category that the product/service belongs to.  This variable runs from FY1989 - 2000

naics_code : This variable is only available for the observations for fy2001-2012. This is the NAICS code for the product listed, acrynom for North American Indsutry Classification System, and used to categorize the product/service contracted by its industrial classification. 

county_fips : This is a 3 digit variable corresponding to the specific county that the contract is performed in. In the 3 digit form it is rather meaningless on its own, and must be coupled with the 2 digit fips state code listed above. Often they are coupled into one to form a single 5 digit code, with the state fips first, then the county fips.

st : This is the 2 digit alpha state code used by the USPS, and commonly accepted as abbreviations of the U.S. states.  Abbreviations are used to conserve memory space, as the data file is already over 2gb

primary_latitude : This is the averaged latitude coordinate.  It represents the average of various point observations  in the same county for other populated places in the same fips and county_fips code.  Should represent a rough averaged center for the area, although this is rough approximation. Obtained in conjunction with the original fips codes from census.gov or usgs.gov

primary_longitude : This is the averaged longitude coordinate. It represents the average of various point observations  in the same county for other populated places in the same fips and county_fips code.  Should represent a rough averaged center for the area, although this is rough approximation.  Obtained in conjunction with the original fips codes from census.gov or usgs.gov

statecodeold : This corresponds to the original coding structure that I have applied to the states, in order to perform loop commands over states.  This inverts deleware and D.C compared with the early state code structure provided in the files from SIAD, for fy1966 - 1983, and is for integer values consecutive 1 - 51.  The coding structures are listed in the statemastercodelist.csv or xlsx

bus_size_emp : This is a single digit alpha, string variable.  It corresponds to the employment size and begins in fy1994-2012, and described as the size of small business on earlier forms. Also this variable was imputed for fy2007-2012 from numb_of_emps variable, and originally was combined with bus_size_rev for fy1991-2006 into one variable listed as bus_size. A  <=50; B >50 and <=100; C >100 and <=250; D > 250 and <=500; E > 500 and <= 750; F > 750 and <=1000; G > 1000.

bus_size_rev : This is a single digit alpha, string variable.  It corresponds to the average annual revenue for the contractor and begins in fy1994-2012, and described as the size of small business on earlier forms.  Also this variable was imputed for fy2007-2012 from annual_rev variable, and originally was combined with bus_size_emp for fy1991-2006 into one variable listed as bus_size. M <=1000000; N >1000000 and <=2000000; P > 2000000 and <=3500000; R > 3500000 and <=5000000; S >5000000 and <=10000000; T >10000000 and <= 17000000; U >17000000.

vet_owned : This is an alpha string variable, of one digit.  It runs from fy2001-2012, and has values of: A-Veteran owned, service disabled; B-veteran owned, not service disabled; and for fy2007-2012 N-non veteran owned business.

ethnic : This is an alpha string variable, of one digit.  It runs from fy1989-2012.  Values are: A - Asian-Indian American; B - Asian-pacific American; C - Black American; D - Hispanic American; E - Native American; F - Other SDB certified/determined by SBA; Z - no representation. 

type6678 : This is the first variable defining business size, from fy1966-1978. The values are: A - Large Business, no SB solicited; B - Large Bus, SB sol but no bid; C - Large bus, SB bid was not lowest; D - Large Bus, SB bid not accepted for other reason; J - Small Business

type7983 : This is the second variable defining business size and type, from fy1979-1983. The values are: A - Large Business, no SB solicited; B - Large Bus, SB sol but no bid; C - Large bus, SB bid was not lowest; D - Large Bus, SB bid not accepted for other reason; J - Small Business; M - Historically Black College; N - Non-profit hospital; P - other non-profit; L - work outside U.S. by U.S. firm; R - foreign firm for domestic work.

type8488 : This is the third variable defining business size and type, from fy1984-1988, and contains alpha numeric values. The values are: 1 - Large Business; 2 - small business; A - other educational; B - Non profit hospital; Z - other non-profit; C - non-profit, blind/handicap listed firm; D - non-profit, blind/handicap not listed firm; 4 - work outside the US by US firm; 3 - foreign firm for domestic work.

type8900 : This is the forth variable defining business size and type, from fy1989-2000, all alpha, single digit observations. The values are: C - Large Bus, no SB solicited; B - small business; A - SDB; N - HBC or U; P - Other Educational Institution; F - non-profit hospital; Z - other non-profit; D - non-profit handicap/blind; M - work outside the U.S. by domestic firm; L - Foreign Firm for domestic work.
 
type0106 : This is the fifth and last variable defining business size and type, for fy2001-2006 and extended to include fy2007-2012, all alpha, single digit observations. The values are: C - Large Bus, no SB solicited; B - small business; A - SDB; T - HBC or U; V - Other Educational Institution; F - non-profit hospital; Z - other non-profit; D - non-profit handicap/blind; M - work outside the U.S. by domestic firm; L - Foreign Firm for domestic work.  
 
weapon_code : This variable is the the definition of whether each contract was allocated to a weapon system or not.  For the early period of 1966 - 1983, the information was derived from the former variable weapon_code_early and contained 0 for non-weapon funding and the weapon system code for weapons.  For the later period 1984 - 2006, information came from the previous variable weapon_code_late and the data contained 1000, 2000, 3000 and 4000 for non-weapon contracts and the weapon code for appropriate weapons.  

contractor_code_early : This is the original contractor ID code applied to fy1966-1983.  It is fully numeric and contains a list of contractors names for associated IDs in the supplemental files. 

contractor_code_late_9396 : These are the contractor ID codes for the four fiscal years of fy1993-1996 for which there are discrepancies and they do not follow the DUNS numbering system, again there are names for associated contractor IDs in the supplemental files. 

con_order :  This variable is not re-coded to be one homogeneous variable for the entire panel, but append for all the years in their original coding.  Therefore care must be taken to not compare this as a time series variable without the proper corrections as described below, or compare these variables within their own FY. In 1966-1983 this variable corresponds to item 14, kind of procurement action: 1 - initial letter contract; 2 - definitive contract superseding letter contract; 3 - definitive contract (including notice of award); 4 - order under contract; 5 - provisioning order (only 1966-1972); 6 - modification, additional work; 7 - modification, funding action; 8 - modification - change order; 9 - modification, termination ro cancellation.  For fy1984- fy 2006 the codes are as follows: 1 - initial letter contract, 2 - definitive contract superseding letter order, 3 - definitive contract, 4 - order under DoD BOA, 5 - order under DoD contract, 6 - Order under GSA federal supply schedule, 7 - Action with another agency's contract, 8 - action with another federal agency/ order from procurement list (1998 on), 9 - small purchase procedure;  modification: A - additional work (new agreement), B - Additional Work (other), C - funding action, D - change order, E - termination for default, F - termination for convenience, G - cancellation, H - exercise of an option, J - definitization of a letter contract.  For FY2007-2012 the following codes apply: DCA - definitive contract; DO - delivery order; IDC - indifinite delivery contract; PO - purchase order. 

con_type : This variable is not re-coded to be one homogeneous variable for the entire panel, but append for all the years in their original coding.  Therefore care must be taken to not compare this as a time series variable without the proper corrections as described below, or compare these variables within their own FY.  In the 1966-1983 files, this corresponds to type of contract item 20. Fixed price redetermination: A - type A, B - type E, C - other, J - firm fixed price, K - fixed price escalation;  Fixed price incentive: L - with performance incentive, M - without performance incentive, R - cost plus award fee, S - cost contract, T - cost sharing, U - cost plus fixed fee;  Cost plus incentive fee: V - with performance incentive, W - without performance incentive, Y - Time and materials, Z - Labor hour.  For the FY1984 - 2012  we have the following: A - fixed price redetermination, type A; B - fixed price redetermination, type B (ended in FY1989, merged with A, in FY2007 brought back as B - fixed price level of effort); J - firm fixed price; K - fixed price economic price adjustment; L - fixed price incentive(w/ Perf. Incentive); M - fixed price incentive (w/o perf. incentive, ended in FY1989 and merged with L, in FY2001 brought back as M - fixed price award fee); R - cost plus award fee; S - cost contract; T - cost sharing; U - cost plus fixed fee; V - CPIF (w/ perf. incentive, stands for cost-plus-incentive-fee); W - CPIF (w/o perf. incentive, ended FY1989, merged with V); Y - time and materials; Z - labor hour.  Also for FY2007-2012 we add to the FY1984-2012 points the following codes: 1 - order dependend (IDV only); 2 - combination (two or more); 3 - other (none of the above); NO - not reported.

con_finance : This variable denotes the type of financing obtained for the contract, from FY1989 on and is a single digit alpha value.  The coding is as follows for progress payments (PP) and advanced payments (AP): A - FAR 52.232-16, or DFARS 52.232-7007 (FY1989-1992 for this second DFARS part); B - DFARS 252.232-7004 and -7003  for FY1993-2000; C - Percentage of completion PP; D - unusual PP or AP; E - Comercial Financing; F - Performanced-based financing; Z - not applicable. Also for FY1984-1988 contains numerical observations 1-5 and I am not sure if these are valid as the DD350 form for these years contains no information on financing.  For FY2007-2012 the following codes apply: A - FAR 52.232-16 progress payments; C - percentage of completion PP; D - unusual PP or AP; Z - NA;  It is essentially the same. as FY1997 - 2006. 

mod_code : This is a data point for FY1997-2006 and single digit alpha value.  The data points are as follows: A - additional work (new agreement); B - Additional Work (other); C - Funding Action; D - change order; E - termination for default; F - termination for convenience; G - cancellation; H - exercise of an option; J - definitization of a letter contract.  Also this corresponds to the combined points for con_order variables of FY1984-1996.  For FY2007-2012 the letters correspond to the following:  A - F is the same as above; G - exercise an option; H - definitization letter contract; J - novation agreement; K - close out; L - definitization change order; M - other admin action; N - legal contract cancellation; P - representation of non-novated merg; R - representation; T - Transfer action; V - vendor duns change; W - vendor address change. 

cost_price_data : This is an observation confirming whether or not the contract has provided certified cost or pricing data for the determination of the contract award.  from FY1984-1988 the observations are as follows: 1 - obtained; 2 - not obtained; 3 - waived.  Also from FY1989-2012 the data is as follows: Y - obtained; N - not obtained; W - waived.

*******************************************************
*******************************************************
**  Updates to the latest round of new ID variables  **
**  Listed in current regressions  2/26/2014         **
*******************************************************
*******************************************************   

To revamp some notes for the lates round of factor_id variables coded in the last regressions in stata we have the following updated notes to make:

prod_id : This variable was coded using a collapse by prod_code, sorted then a _n variable was added to produce a sequential method for the analysis of var decomp loop coding to work easier.  It runs from 1-738 and can be replicated by taking main.dta, running code [ collapse (cound) spend, by(prod_code) ] then [ gen prod_id = _n ]. The numbering is somewhat trivial in the regression analysis

extent_compete : 1 - Full, open competition
				 2 - Not available for comp.
				 3 - Follow on competition
				 4 - Not competed

offer_factor :   0 - Zero offers received
				 1 - One offer received
				 2 - More than one offer received

fin_factor : 	 1 - A, Progress Payments PP
				 2 - B, .... Unclear, and insignificant in reg, some payment coding
				 3 - C, Percentage of Completion PP
				 4 - D, Unusual PP or AP
				 5 - E, Commercial Financing
				 6 - F, Performance Based Financing
				 7 - Z, Not Applicapble 
 
type_factor : 	 1 - A, Fixed price redetermination
				 2 - B, Fixed price redetermination
				 3 - C, Fixed price redetermination
				 4 - K, Fixed price escalation
				 5 - L, Fixed price with performance incentive
				 6 - M, Fixed price incentive without performance incentive/ FP award fee
				 7 - J	Firm, Fixed Price   (Why did I put it in 7th place...?) 
				 8 - R, Cost plus award fee
				 9 - S, Cost contract	
				 10	- T, Cost sharing
				 11	- U, Cost plus fixed fee 
				 12	- V, Cost plus incentive fee w/performance incentive
				 13	- W, Cost plus incentive fee w/o performance incentive
				 14	- Y, Time and materials
				 15	- Z, Labor hour
				 
multi_year_contract : 1 is yes, 0 is no, and counts for contracts that originate as multi year contracts, not option extensions

weapon_code : Contains 1 for is weapon code, 0 for no weapon 

last_month : this is a 1 for the last month in the fiscal year, september for the regs used here, but coded for pre 1976

log_dur : This is the natural log of the duration of the contract in months, or: ln( mofd(end_date) - mofd(start_date))