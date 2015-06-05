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


#open device, reset the margins and plot
png(filename = "plot1.png", width=480, height=480)
par(mfrow = c(1,1), mar = c(4,4,2,2), oma= c(0,0,0,0))
hist( as.numeric(as.character(data2$Global_active_power)), col = "red", main = "Global Active Power", xlab="Global Active Power (kilowatts)")
dev.off()


