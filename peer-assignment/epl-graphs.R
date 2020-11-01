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
#filename1 <- paste("plot1",as.Date(now()),".", format(now(),"%Hh%Mm"),".png", sep = "")

#plot1 filename1 <- "plot1.png"
png(filename1)
with(hpc_dataFeb, hist(Global_active_power/1000*2, col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)", ylab = "Frequency"))
dev.off()

#plot2
png("plot2.png")
with(hpc_dataFeb,plot(DateTime,Global_active_power/1000*2, type = "l", ylab = "Global Active Power (kilowatts)"))
dev.off()

#plot3
png("plot3.png")
with (hpc_dataFeb, 
{
plot(DateTime,Sub_metering_1, col = "black", type = "l", ylab = "Energy sub metering", xlab = "")
lines(DateTime, Sub_metering_2, col = "red")
lines(DateTime, Sub_metering_3, col = "blue")
})
legend("topright", c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"), col = c("black", "red", "blue"), lty = c(1,1,1))
dev.off()


#plot4

png("plot4.png")
par(mfrow = c(2,2))
with(hpc_dataFeb,plot(DateTime,Global_active_power, type = "l", ylab = "Global Active Power (kilowatts)"))

plot(hpc_dataFeb$DateTime,hpc_dataFeb$Voltage, ylab = "Voltage", xlab = "datetime", type = "l")

with (hpc_dataFeb, 
      {
        plot(DateTime,Sub_metering_1, col = "black", type = "l", ylab = "Energy sub metering", xlab = "")
        lines(DateTime, Sub_metering_2, col = "red")
        lines(DateTime, Sub_metering_3, col = "blue")
      })
legend("topright", c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"), col = c("black", "red", "blue"), lty = c(1,1,1))

plot(hpc_dataFeb$DateTime,hpc_dataFeb$Global_reactive_power, type = "l")

dev.off()