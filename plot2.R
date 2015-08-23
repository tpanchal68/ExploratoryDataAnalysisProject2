##############################
# 
# 2) Have total emissions from PM2.5 decreased in the Baltimore City, 
#    Maryland (fips == "24510") from 1999 to 2008? Use the base plotting 
#    system to make a plot answering this question.
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

## Subset data for Baltimore City
BaltimoreNEI <- subset(NEI, fips == "24510")

## The total PM2.5 emission from all sources 
## for each of the years 1999, 2002, 2005, and 2008
TotalEmissionsByYear <- aggregate(Emissions ~ year, data = BaltimoreNEI, FUN = "sum")

## Create .png file for the plot
png("plot2.png", width=480, height=480, units = "px")

## Create Bar plot of data we are interested in
barplot(height=TotalEmissionsByYear$Emissions, names.arg=TotalEmissionsByYear$year, xlab="Years", ylab="Total PM2.5 Emissions", main="Baltimore City Total PM2.5 Emissions By Year")

## Close the PNG device
dev.off()
