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

#open the png device
png(filename = "plot4.png", width=480, height=480)
#make columns in the output
par(mfrow = c(2,2), mar = c(4,4,2,2), oma= c(0,0,0,0))
#graph 1 - Global Active Power
with(data2, plot(DateTime, as.numeric(as.character(Global_active_power)), type = "l", ylab = "Global Active Power (kilowatts)" , xlab=""))
#graph 2 - Voltage
with(data2, plot(DateTime, as.numeric(as.character(Voltage)), type = "l", ylab = "Voltage", xlab="datetime"))
#graph 3 - Energy sub metering, the legend box is transparent
with(data2, {
     plot(DateTime, as.numeric(as.character(Sub_metering_1)), type = "l", xlab="", ylab = "Energy Sub Metering")
     lines(DateTime, as.numeric(as.character(Sub_metering_2)), type = "l", col="red")
     lines(DateTime, as.numeric(as.character(Sub_metering_3)), type = "l", col="blue")
     })
legend("topright", lty="solid" ,col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), bty="n")
#graph 4 - Global Reactive Power
with(data2, plot(DateTime, as.numeric(as.character(Global_reactive_power)), type = "l", xlab="datetime" , ylab = names(data[4])))
dev.off()