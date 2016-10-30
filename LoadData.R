## Author: Peter Byrd
## Load the data

## Set the working directory and load packages
setwd("/Users/pbyrd/Git/CaseStudy1")
library(plyr)
library(dplyr)
library(ggplot2)

## Read CSV input file
gdp <- read.csv("Data/getdata_data_GDP.csv", skip=4,header=TRUE)
edu <- read.csv("Data/getdata_data_EDSTATS_Country.csv", header=TRUE)