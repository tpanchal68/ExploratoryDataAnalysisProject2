##############################
# 
# 4) Across the United States, how have emissions from coal combustion-related
#    sources changed from 1999-2008?
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

## Now extract Coal data from the table
#coal_data <- combo_table[(grepl("coal", combo_table$EI.Sector, ignore.case=TRUE)), ]
coal_data <- combo_table[(grepl("comb.*coal", combo_table$EI.Sector, ignore.case=TRUE)), ]

library(ggplot2)

## The total PM2.5 emission from coal 
## for each of the years 1999, 2002, 2005, and 2008
TotalEmissionsByYear <- aggregate(Emissions ~ year, data = coal_data, FUN = "sum")

## Create .png file for the plot
png("plot4.png", width=680, height=480, units = "px")

## Create plots of data we are interested in
g <- ggplot(TotalEmissionsByYear, aes(factor(year), Emissions))
g <- g + geom_bar(stat='identity') +
        xlab("Year") +
        ylab("Total PM2.5 Emissions") +
        ggtitle('Total Emissions from Coal from 1999 to 2008')
print(g)

## Close the PNG device
dev.off()
