##############################
# 
# 3) Of the four types of sources indicated by the type (point, nonpoint, 
#    onroad, nonroad) variable, which of these four sources have seen decreases 
#    in emissions from 1999-2008 for Baltimore City? Which have seen increases 
#    in emissions from 1999-2008? Use the ggplot2 plotting system to make a 
#    plot answer this question.
# 
##############################

## Read RDS files.  This will take a while ( 30 to 45 seconds) so only read if
## the table doesn't exist.
if(!exists("NEI")){
        NEI <- readRDS("Data/summarySCC_PM25.rds")
}
if(!exists("SCC")){
        SCC <- readRDS("Data/Source_Classification_Code.rds")
}

library(ggplot2)

## Subset data for Baltimore City
BaltimoreNEI <- subset(NEI, fips == "24510")

## The total PM2.5 emission from all sources in Baltimore City
## for each of the years 1999, 2002, 2005, and 2008
TotalEmissionsByYear <- aggregate(Emissions ~ (year + type), data = BaltimoreNEI, FUN = "sum")

## Create .png file for the plot
png("plot3.png", width=680, height=480, units = "px")

## Create plots of data we are interested in
g <- ggplot(TotalEmissionsByYear, aes(year, Emissions, color = type))
g <- g + geom_line() +
        xlab("Year") +
        ylab("Total PM2.5 Emissions") +
        ggtitle('Total Emissions in Baltimore City, Maryland (fips == "24510") from 1999 to 2008')
print(g)

## Close the PNG device
dev.off()
