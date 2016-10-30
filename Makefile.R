## Author: Peter Byrd
## Makefile

setwd("/Users/pbyrd/Git/CaseStudy1")
source ("LoadData.R")
source ("CleanData.R")
source ("AnalyzeData.R")

deletedvalues       # shows the number of observations with NA that were deleted

match[1]            # shows the number of country IDs that matched between the two datasets

gdp_combined[13,]   # shows the 13th country in the list of ascending sorted GDP rank

avgrank_oecd                # shows the average GDP rank of High Income: OECD countries
avgrank_noecd               # shows the average GDP rank of High Income: non OECD countries

table(gdp_combined$gdpgroup,gdp_combined$incomegroup)  # table of GDP group by Income Group
