##load required packages
library(dplyr)
library(readr)

##set working directory
setwd("C:/vajraData/R/exploratoryDataAnalysis/ExData_Plotting1")

##check for unzipped file - if missing download source archive and unzip
if (!file.exists("household_power_consumption.txt")) {
  temp <- tempfile()
  download.file("http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)
  fileref <- unzip(temp)
  unlink(temp)
}
if (file.exists("household_power_consumption.txt")) {
  fileref <- "household_power_consumption.txt"
}


##Read in the data using readr() package
power <- read_delim(fileref,
                    locale = locale(date_names  = "en",
                                    date_format = "%d%.%m%.%Y"),
                    col_types = "Dcnnnnnnn",
                    delim = ";",
                    na = c("", "?")
)

##Subset the data - Filter using dplyr package
power.f <- filter(power, Date >= "2007-02-01" & Date <= "2007-02-02")

##Convert time to time class
power.f$Time <- paste(power.f$Date, power.f$Time, sep = " ")
power.f$Time <- strptime(power.f$Time, "%Y-%m-%d %H:%M:%S")

##Open graphics device
png(filename = "./figure/plot4.png", width = 480, height = 480, units = "px", pointsize = 10)

##Construct plots on screen for review
plot.new()
par(mfrow = c(2,2))
plot(power.f$Time, power.f$Global_active_power,
    xlab = "", ylab = "Global Active Power", type = 'l')

plot(power.f$Time, power.f$Voltage, xlab = "Datetime", ylab = "Voltage", type = 'l')

plot(power.f$Time, power.f$Sub_metering_1, xlab = "", ylab = "Energy sub metering", type = 'l')
lines(power.f$Time, power.f$Sub_metering_2, col = 'red')
lines(power.f$Time, power.f$Sub_metering_3, col = 'blue')
legend("topright", col = c('black', 'red', 'blue'), legend = c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3'), lty = 1)

plot(power.f$Time, power.f$Global_reactive_power, xlab = "datetime", ylab = "Global_reactive_power", type = 'l')

##Output plot
dev.off()
