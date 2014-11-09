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
## Generate plot
plot(plotdata$Time, plotdata$Sub_metering_1, type = "o", axis = FALSE, cex.lab = .75, cex.axis = .75, pch = NA, ylab = "Energy sub metering", xlab = "")
axis(2, at=c(0,10,20,30), labels= C("0","10","20","30")
lines(plotdata$Time, plotdata$Sub_metering_2, type = "o", pch = NA, col = "red")
lines(plotdata$Time, plotdata$Sub_metering_3, type = "o", pch = NA, col = "blue")
legend("topright",c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), y.intersp = 1, lty = c(1,1,1), lwd = c(1,1,1), col = c("black", "red",  "blue"), cex =0.7)
## Copy to png file
dev.copy(png, file = "plot3.png")
dev.off()