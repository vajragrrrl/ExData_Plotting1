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

##Construct plot
plot(power.f$Time, power.f$Global_active_power, xlab = "", ylab = "Global Active Power (kilowatts)", type = "l")

##Output plot
dev.copy(png, file = "./figure/plot2.png", width = 480, height = 480)
dev.off()


