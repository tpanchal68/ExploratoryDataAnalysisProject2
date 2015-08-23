##############################
# 
# 1) Have total emissions from PM2.5 decreased in the United States 
#    from 1999 to 2008? Using the base plotting system, make a plot 
#    showing the total PM2.5 emission from all sources for each of 
#    the years 1999, 2002, 2005, and 2008.
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

## The total PM2.5 emission from all sources 
## for each of the years 1999, 2002, 2005, and 2008
TotalEmissionsByYear <- aggregate(Emissions ~ year, data = NEI, FUN = "sum")

## Create .png file for the plot
png("plot1.png", width=480, height=480, units = "px")

## Create Bar plot of data we are interested in
barplot(height=TotalEmissionsByYear$Emissions, names.arg=TotalEmissionsByYear$year, xlab="Years", ylab="Total PM2.5 Emissions", main="Total PM2.5 Emissions By Year")

## Close the PNG device
dev.off()
