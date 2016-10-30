## Author: Peter Byrd
## Analyze the data

## How many of the IDs matched
match=dim(gdp_combined)
match[1]          # shows the number of IDs that matched

## Sort the data in ascending order by gdp; what is the 13th country?
gdp_combined <- gdp_combined[order(gdp_combined$gdp),]
gdp_combined[13,]

## Average GDP rankings for High Income:OECD and High Income:nonOECD groups?
avgrank_oecd <- mean(gdp_combined$gdprank[gdp_combined$incomegroup=="High income: OECD"])
avgrank_noecd <-mean(gdp_combined$gdprank[gdp_combined$incomegroup=="High income: nonOECD"])
avgrank_oecd      # High Income: OECD countries
avgrank_noecd     # High Income: non OECD countries


## Plot the data using ggplot
ggplot(gdp_combined,aes(gdp_combined$countrycode,gdp_combined$gdp))+geom_point(aes(col=incomegroup))+xlab("\n Country")+ylab("Gross Domestic Product ($M)\n")+theme_light()

# Cut the GDP ranking into five groups and make a table of income group vs gdprank
gdp_combined$gdpgroup<-cut(gdp_combined$gdprank,breaks=c(-0.5,38.5,76.5,114.5,152.5,190.5),labels=c("High GDP","Med-High GDP","Medium GDP","Med-Low GDP","Low GDP"))
table(gdp_combined$gdpgroup,gdp_combined$incomegroup)
