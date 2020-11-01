dataurl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(dataurl, destfile = "./data/powerdata.zip")
unzip("./data/powerdata.zip", exdir = "./data", overwrite = TRUE)
hpc_data <- read.csv("./data/household_power_consumption.txt", sep = ";", na.strings = "?")
library(lubridate)
hpc_data$Date <- dmy(hpc_data$Date)
hpc_dataFeb <- subset(hpc_data, Date >= "2007-02-01" & Date <= "2007-02-02")
rm(hpc_data)
hpc_dataFeb$Time <- as.character(hpc_dataFeb$Time)
DateTime <- paste(hpc_dataFeb$Date,hpc_dataFeb$Time, sep = " ")
DateTime <- ymd_hms(DateTime)
hpc_dataFeb$DateTime <- DateTime
hpc_dataFeb$Global_active_power <- as.numeric(hpc_dataFeb$Global_active_power)

png("plot1.png")
with(hpc_dataFeb, hist(Global_active_power/1000*2, col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)", ylab = "Frequency"))
dev.off()