## Author: Peter Byrd
## Makefile

setwd("/Users/pbyrd/Git/CaseStudy1")
source ("LoadData.R")
source ("CleanData.R")
source ("AnalyzeData.R")

# Show the number of observations with NA that were deleted
deletedvalues

# (1) Show the number of country IDs that matched between the two datasets
match[1]  

# (2) Show the 13th country in the list of ascending sorted GDP rank
gdp_combined[13,] 

# (3) Show the average GDP rank of High Income: OECD and nonOECD countries
avgrank_oecd      # High Income: OECD countries
avgrank_noecd     # High Income: non OECD countries

# (4) Plot the data using ggplot
ggplot(gdp_combined,aes(gdp_combined$countrycode,gdp_combined$gdp))+geom_point(aes(col=incomegroup))+xlab("\n Country")+ylab("Gross Domestic Product ($M)\n")+theme_light()

# (5) Create a table of GDP group by Income Group
table(gdp_combined$gdpgroup,gdp_combined$incomegroup)
