## Author: Peter Byrd

## Set the working directory and load packages
setwd("/Users/pbyrd/Git/CaseStudy1")
library(plyr)
library(gdata)

## Read CSV input file
GDP <- read.csv("getdata_data_GDP.csv", skip=3,header=TRUE)
Educ <- read.csv("getdata_data_EDSTATS_Country.csv", header=TRUE)

##Check the data
head(GDP)
summary(GDP)
str(GDP)
head(Educ)
summary(Educ)
str(Educ)
