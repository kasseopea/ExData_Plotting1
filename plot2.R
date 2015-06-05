#load the library
library (reshape)
library (lubridate)
library (dplyr)

#download the file and load them into data data frame
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl, destfile = "./proj1.zip")
data <- read.table(unz("proj1.zip", "household_power_consumption.txt") , header = T, sep=";")

#reformatting and mutating first use lubridate to convert date into dates
data[,1] <- dmy(data[,1])
#only extract related dates
data2 <- data[(data$Date == ymd("2007-02-01") | data$Date == ymd("2007-02-02")) ,]
#create a new column which is a combination of date and time, DateTime
data2 <- mutate(data2, DateTime = ymd_hms(paste(as.character(data2[,1]),data2[,2])) )

#open the device and plot
png(filename = "plot2.png", width=480, height=480)
par(mfrow = c(1,1), mar = c(4,4,2,2), oma= c(0,0,0,0))
with(data2, plot(DateTime, as.numeric(as.character(Global_active_power)), type = "l", ylab = "Global Active Power (kilowatts)"))
dev.off()