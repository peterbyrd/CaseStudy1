## Author: Peter Byrd
## Clean the data

## Create a subset of the gdp data with only the columns we want
gdp_new <- gdp
gdp_new <- gdp_new[,-c(3,6,7,8,9,10)]    # remove columns with no data

## Create a subset of the edu data with only the columns we want
edu_new <- edu
edu_new <- edu_new[,c(1,3)]              # keep only the columns we need for our analysis

## Rename variables
gdp_new <- plyr::rename(x=gdp_new,
                        replace = c("X"="countrycode","X.1"="gdprank","X.3"="countryname",
                                    "X.4"="gdp"))
edu_new <- plyr::rename(x=edu_new,
                        replace = c("CountryCode"="countrycode","Income.Group"="incomegroup"))

## Modify variable types
gdp_new$gdp <- as.numeric(gsub("[^[:digit:]]","",gdp_new$gdp))
gdp_new$gdprank <- as.numeric(gsub("[^[:digit:]]","",gdp_new$gdprank))

## Merge the data by country shortcode
gdp_combined <- merge(gdp_new,edu_new, by="countrycode",all=TRUE)

## Remove missing values and unwanted data from merged data
temp1 <- dim(gdp_combined)
gdp_combined <- subset(x=gdp_combined,!is.na(gdp)) #remove observations without GDP data
gdp_combined <- subset(x=gdp_combined,!is.na(gdprank) & !is.na(incomegroup)) #remove observations not in ranking
temp2 <- dim(gdp_combined)
deletedvalues <- temp1[1]-temp2[1]
deletedvalues    # this is the number of observations with NA that were deleted

## Check the final clean data
# head(gdp_combined)
# str(gdp_combined)
# summary(gdp_combined)
