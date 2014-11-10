## Read Data
data <- read.table("household_power_consumption.txt", sep = ";", head = TRUE)
## Format Date field
x <- strptime(data[,1], "%d/%m/%Y")
y <- as.Date(x)
data[,1] <- y
## Filter for 2 days of data to be reported on
plotdata <- subset(data, Date < as.Date("2007-02-03") & Date > as.Date("2007-01-31"))
plotdata$Global_active_power <- as.numeric(as.character(plotdata$Global_active_power))
## Generate plot
hist(plotdata$Global_active_power, col = "red", xlab = "Global Active Power (kilowatts)", main = "Global Active Power")
## Copy to png file
dev.copy(png, file = "plot1.png")
dev.off()
