## Author: Peter Byrd

## Set the working directory and load packages
setwd("/Users/pbyrd/Git/CaseStudy1")
library(plyr)
library(gdata)

## Read CSV input file
GDP <- read.csv("Data/getdata_data_GDP.csv", skip=3,header=TRUE)
Educ <- read.csv("Data/getdata_data_EDSTATS_Country.csv", header=TRUE)

##Check the data
head(GDP)
summary(GDP)
str(GDP)
head(Educ)
summary(Educ)
str(Educ)

## Clean and Format the data
Queens$SALE.PRICE.N <- as.numeric(gsub("[^[:digit:]]","", Queens$SALE.PRICE))

## make all variable names lower case
names(Queens) <- tolower(names(Queens)) 
str(Queens)

## Get rid of leading digits
Queens$gross.sqft <- as.numeric(gsub("[^[:digit:]]","", Queens$gross.square.feet))
Queens$land.sqft <- as.numeric(gsub("[^[:digit:]]","", Queens$land.square.feet))
Queens$year.built <- as.numeric(as.character(Queens$year.built))
str(Queens)

## exploration on sales price
attach(Queens)
hist(sale.price.n) # Something weird here
hist(sale.price.n[sale.price.n>0])
detach(Queens)

## histograms do not look right, keep actual sales only

Queens.sale <- Queens[Queens$sale.price.n!=0,]
plot(Queens.sale$gross.sqft,Queens.sale$sale.price.n)
plot(log10(Queens.sale$gross.sqft),log10(Queens.sale$sale.price.n))

## for simplicity, let's look at 1-, 2-, and 3-family homes
Queens.homes <- Queens.sale[which(grepl("FAMILY",Queens.sale$building.class.category)),]
dim(Queens.homes)
plot(log10(Queens.homes$gross.sqft),log10(Queens.homes$sale.price.n))
summary(Queens.homes[which(Queens.homes$sale.price.n<100000),])

## remove outliers that seem like they weren't actual sales
Queens.homes$outliers <- (log10(Queens.homes$sale.price.n) <=5) + 0
Queens.homes <- Queens.homes[which(Queens.homes$outliers==0),]
plot(log10(Queens.homes$gross.sqft),log10(Queens.homes$sale.price.n))
