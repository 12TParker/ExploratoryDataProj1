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
plot(plotdata$Time, plotdata$Global_active_power , type = "o", pch = NA, ylab = "Global Active Power (kilowatts)", xlab = "")
## Copy to png file
dev.copy(png, file = "plot2.png")
dev.off()