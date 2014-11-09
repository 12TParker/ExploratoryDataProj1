## Read Data
data <- read.table("household_power_consumption.txt", sep = ";", head = TRUE)
## Format Date field
x <- strptime(data[,1], "%d/%m/%Y")
y <- as.Date(x)
data[,1] <- y
## Filter for 2 days of data to be reported on
plotdata <- subset(data, Date < as.Date("2007-02-03") & Date > as.Date("2007-01-31"))
plotdata$Global_active_power <- as.numeric(as.character(plotdata$Global_active_power))
## Convert Time field toa combined Date and Time field 
datetime <- paste(plotdata[,1], plotdata[,2])
datetime <- as.POSIXct(strptime(datetime, "%Y-%m-%d %H:%M:%S"))
plotdata[,2] <- datetime
## Set plot frame
par(mfrow = c(2, 2), mar = c(7, 4, 2, 3), oma = c(0, 0, 2, 0))
## Generate plot 1
plot(plotdata$Time, plotdata$Global_active_power , type = "o", cex.lab = .75, cex.axis = .75, pch = NA, ylab = "Global Active Power", xlab = "")
## Generate plot 2
plot(plotdata$Time, plotdata$Voltage , type = "o", pch = NA, cex.lab = .75, cex.axis = .75, ylab = "Voltage", xlab = "datetime")
## Generate plot 3
plot(plotdata$Time, plotdata$Sub_metering_1, type = "o", cex.lab = .75, cex.axis = .75, pch = NA, ylab = "Energy sub metering", xlab = "")
lines(plotdata$Time, plotdata$Sub_metering_2, type = "o", pch = NA, col = "red")
lines(plotdata$Time, plotdata$Sub_metering_3, type = "o", pch = NA, col = "blue")
legend("topright",c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), bty = "n", lty = c(1,1,1), lwd = c(2,2,2), col = c("black", "red",  "blue"), cex=.48)
## Generate plot 4
plot(plotdata$Time, plotdata$Global_reactive_power , type = "o", cex.lab = .75, cex.axis = .75, pch = NA, ylab = "global_reactive_power", xlab = "datetime")
## Copy to png file
dev.copy(png, file = "plot4.png")
dev.off()