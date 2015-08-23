##############################
# 
# 6) Compare emissions from motor vehicle sources in Baltimore City with 
#    emissions from motor vehicle sources in Los Angeles County, California 
#    (fips == "06037"). Which city has seen greater changes over time in motor 
#    vehicle emissions?
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

## In order to find moter vehicle related emission, it would be easier if we merge both tables
## and work with combined table.  merge both tables with comon column which is SCC
if(!exists("combo_table")){
        combo_table <- merge(NEI, SCC, by="SCC")
}

## Subset data for Baltimore City and LA county
LABaltimoreData <- subset(combo_table, fips == "24510"|fips == "06037")

## Now extract Onroad Motor Vehicle data from the table for Baltimore City and LA County
LABaltimore_motor_vehicle <- LABaltimoreData[(grepl("Onroad", LABaltimoreData$Data.Category, ignore.case=TRUE)), ]

library(ggplot2)

## The total PM2.5 emission from onroad motor vehicles in Baltimore City and LA county
## for each of the years 1999, 2002, 2005, and 2008
TotalEmissionsByYear <- aggregate(Emissions ~ year + fips, data = LABaltimore_motor_vehicle, FUN = "sum")

#Add appropriate name for each fips
TotalEmissionsByYear$fips[TotalEmissionsByYear$fips=="24510"] <- "Baltimore, MD"
TotalEmissionsByYear$fips[TotalEmissionsByYear$fips=="06037"] <- "Los Angeles, CA"

## Create .png file for the plot
png("plot6.png", width=1040, height=480, units = "px")

## Create plots of data we are interested in
g <- ggplot(TotalEmissionsByYear, aes(factor(year), Emissions))
g <- g + geom_bar(stat = "identity") +
        facet_wrap(~ fips) +
        xlab("Year") +
        ylab("Total PM2.5 Emissions") +
        ggtitle('Total Onroad motor vehicle Emissions in Baltimore City vs LA County from 1999 to 2008')
print(g)
## Close the PNG device
dev.off()
