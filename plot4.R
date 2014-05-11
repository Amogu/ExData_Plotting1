temp <- tempfile()
download.file("http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp, method = "curl")
con1 <- unz(temp, "household_power_consumption.txt")
data <- read.table(con1, header = TRUE, sep = ";", na.strings = "?")
data$Time<-as.character(data$Time)
data$Date<-as.character(data$Date)
data$DateTime <- as.POSIXct(paste(data$Date, data$Time), format="%d/%m/%Y %H:%M:%S")
dataA <- subset(data, as.Date(data$Date, format="%d/%m/%Y") %in% as.Date(c("2007-02-01", "2007-02-02"), format="%Y-%m-%d"))

png(file = "plot4.png", width = 480, height = 480)
opar <- par(no.readonly=TRUE)
par(mfrow=c(2,2))
plot(dataA$DateTime, dataA$Global_active_power, ylab = "Global Active Power (kilowatts)", xlab ="", type ="l")
plot(dataA$DateTime, dataA$Voltage, ylab = "Voltage", xlab ="datetime", type ="l")
plot(dataA$DateTime, dataA$Sub_metering_1, ylab = "Energy sub metering", xlab ="", type ="l")
lines(dataA$DateTime, dataA$Sub_metering_2, col="red")
lines(dataA$DateTime, dataA$Sub_metering_3, col="blue")
legend("topright", c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"), lty=c(1), col=c("black","red", "blue"))


plot(dataA$DateTime, dataA$Global_reactive_power, ylab = "Global_reactive_power", xlab ="datetime", type ="l")

par(opar)
dev.off()











par(opar)