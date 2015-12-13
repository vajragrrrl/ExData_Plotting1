library(dplyr)
library(readr)
setwd("C:/vajraData/R/exploratoryDataAnalysis/ExData_Plotting1")

if (!file.exists("household_power_consumption.txt")) {
  temp <- tempfile()
  download.file("http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)
  file <- unzip(temp)
  unlink(temp)
}

if (file.exists("household_power_consumption.txt")) {
  file <- "household_power_consumption.txt"
}


#Read in the data using readr() package
power <- read_delim(file,
                    locale = locale(date_names = "en",
                                   date_format = "%d%.%m%.%Y",
                                   time_format = "%H:%M:%Z" ),
                    col_types = "Dtnnnnnnn",
                    delim = ";",
                    na = c("", "?"),
                    progress = interactive()
                    )

#Practice Code - May also be used to verify results
#Read in the data using read.table
#powerCheck <- read.delim2(file,
#                    header = TRUE,
#                    sep = ";",
#                    stringsAsFactors = FALSE,
#                    dec = ".")


#Subset the data - Method 1 - Filter using dplyr package
power.f <- filter(power1, Date %in% c("1/2/2007","2/2/2007") )
#Subset the data - Method 2 - Practice Code
#Results should match output above
#powerCheckSub <- powerCheck[powerCheck$Date %in% c("1/2/2007","2/2/2007") ,]


power.f$Global_active_power <- as.numeric(power.f$Global_active_power)


plot1 <- function() {
  hist(power.f$Global_active_power,
      main = paste("Global Active Power"),
      col = "red",
      xlab = "Global Active Power (Kilowatts)")
  dev.copy(png, file = "./figure/plot1.png", width = 480, height = 480)
  dev.off()
}
plot1()