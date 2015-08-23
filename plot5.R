##############################
# 
# 5) How have emissions from motor vehicle sources changed from 1999-2008 
#    in Baltimore City?
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

## In order to find COAL related emission, it would be easier if we merge both tables
## and work with combined table.  merge both tables with comon column which is SCC
if(!exists("combo_table")){
        combo_table <- merge(NEI, SCC, by="SCC")
}

## Subset data for Baltimore City
BaltimoreData <- subset(combo_table, fips == "24510")

## Now extract Onroad Motor Vehicle data from the table
motor_vehicle <- BaltimoreData[(grepl("Onroad", BaltimoreData$Data.Category, ignore.case=TRUE)), ]

library(ggplot2)

## The total PM2.5 emission from onroad motor vehicles in Baltimore City
## for each of the years 1999, 2002, 2005, and 2008
TotalEmissionsByYear <- aggregate(Emissions ~ year, data = motor_vehicle, FUN = "sum")

## Create .png file for the plot
png("plot5.png", width=680, height=480, units = "px")

## Create plots of data we are interested in
g <- ggplot(TotalEmissionsByYear, aes(factor(year), Emissions))
g <- g + geom_bar(stat='identity') +
        xlab("Year") +
        ylab("Total PM2.5 Emissions") +
        ggtitle('Total Emissions from Onroad motor vehicles in Baltimore City from 1999 to 2008')
print(g)

## Close the PNG device
dev.off()
