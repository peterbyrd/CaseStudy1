## Author: Peter Byrd

## Set the working directory and load packages
setwd("/Users/pbyrd/Git/CaseStudy1")
library(plyr)
library(dplyr)
#library(gdata)
library(ggplot2)

## Read CSV input file
gdp <- read.csv("Data/getdata_data_GDP.csv", skip=4,header=TRUE)
edu <- read.csv("Data/getdata_data_EDSTATS_Country.csv", header=TRUE)

## Create a subset of the gdp data with only the columns we want
gdp_new <- gdp
gdp_new <- gdp_new[,-c(3,6,7,8,9,10)]    # remove columns with no data
gdp_new <- gdp_new[1:190,]               # remove the tail of NA values

## Create a subset of the edu data with only the columns we want
edu_new <- edu
edu_new <- edu_new[,c(1:3)]              # keep only the columns we need for our analysis

## Rename variables
gdp_new <- plyr::rename(x=gdp_new,
                        replace = c("X"="countrycode","X.1"="gdprank","X.3"="countryname",
                                    "X.4"="gdp"))
edu_new <- plyr::rename(x=edu_new,
                        replace = c("CountryCode"="countrycode","Long.Name"="countryname","Income.Group"="incomegroup"))

## Modify variable types
gdp_new$gdp <- as.numeric(gsub("[^[:digit:]]","",gdp_new$gdp))
gdp_new$gdprank <- as.numeric(gsub("[^[:digit:]]","",gdp_new$gdprank))

## Check the countrycode for each dataset before merging
#table(gdp_new$countrycode)
#table(edu_new$countrycode)

## Merge the data by country shortname
gdp_combined <- merge(gdp_new, edu_new, by.x="countrycode", by.y="countrycode")

## Remove missing values and unwanted data
#gdp_new <- subset(x=gdp_new,!is.na(rank))
#gdp_new <- subset(x=gdp_new,!is.na(gdp))

## Remove the duplicative country names and rename the country name variable
gdp_combined <- gdp_combined[,-c(5)]
gdp_combined <- plyr::rename(x=gdp_combined,
                        replace = c("countryname.x"="countryname"))

## Check the data
head(gdp_combined)
str(gdp_combined)
summary(gdp_combined)

## (1) How many of the IDs matched
dim(gdp_combined)              # shows the number of IDs that matched

## (2) Sort the data in ascending order by gdp; what is the 13th country?
gdp_combined <- gdp_combined[order(gdp_combined$gdp),]
gdp_combined[13,]

## (3) Average GDP rankings for High Income:OECD and High Income:nonOECD groups?


## (4) Plot the data using ggplot
ggplot(data=gdp_combined,aes(x=gdp_combined$countrycode,y=gdp_combined$gdp))+geom_point()+xlab("\n Country")+ylab("Gross Domestic Product ($M)\n")+theme_light()

# (5) Cut the GDP ranking into five groups and make a table of income group vs gdprank
attach(gdp_combined)
gdp_combined$gdpgroup[gdprank < 39] <- 1
gdp_combined$gdpgroup[gdprank > 38 & gdprank < 77] <- 2
gdp_combined$gdpgroup[gdprank > 76 & gdprank < 115] <- 3
gdp_combined$gdpgroup[gdprank > 114 & gdprank < 153] <- 4
gdp_combined$gdpgroup[gdprank > 152] <- 5
table(gdpgroup,incomegroup)
