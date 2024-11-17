# Define the archive file name and URL
setwd("C://Users//varsh//ExData_Plotting2")
archiveFile <- "NEI_data.zip"
archiveURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"

# Download and unzip the archive file if it doesn't exist
if(!file.exists(archiveFile)) {
  download.file(url=archiveURL, destfile=archiveFile)
}

if(!(file.exists("summarySCC_PM25.rds") && file.exists("Source_Classification_Code.rds"))) { 
  unzip(archiveFile) 
}

# Load the NEI and SCC data frames
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Aggregate total emissions by year
aggTotals <- aggregate(Emissions ~ year, NEI, sum)

# Create the bar plot and save it as a PNG file
png("plot1.png", width=480, height=480, units="px", bg="transparent")
barplot(
  (aggTotals$Emissions) / 10^6,
  names.arg = aggTotals$year,
  xlab = "Year",
  ylab = "PM2.5 Emissions (10^6 Tons)",
  main = "Total PM2.5 Emissions From All US Sources"
)
dev.off()
