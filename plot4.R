#plot4.R
# Below script will download the Electric Power Consumption Dataset from 
# https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip
# the script examines how household energy usage varies over a 2-day period in February, 2007
# Plot4

# download the zip file from the fileURL location and store it in the destfile
print("Downloading the zip file..")
fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileURL, destfile = "household_power_consumption.zip", mode = "wb")

# unzip the zip file in the current location
print("Unzipping the zip file..")
unzip("household_power_consumption.zip")

# read the data file
print("Reading the data file..")
readfile <- read.table("household_power_consumption.txt",header = TRUE, sep=";",na = "?") 

#convert the Date and Time variables to Date/Time classes in R using the strptime() and as.Date()
print("Convert Date and Time Variables..")
readfile$Time <- strptime(paste(readfile$Date,readfile$Time), "%d/%m/%Y %H:%M:%S")
readfile$Date <- as.Date(readfile$Date, "%d/%m/%Y")

#read data for 2-day period in February, 2007
print("Read 2-day period in February, 2007")
readfebdata <- subset(readfile, Date %in% as.Date(c("2007-02-01","2007-02-02"), "%Y-%m-%d"))

# Plot4
print("Plot the Graph")
png("plot4.png", width = 480, height = 480)

# plot 2 rows and 2 columns
par(mfrow=c(2,2))

# Global_active_power: household global minute-averaged active power (in kilowatt)
plot(readfebdata$Time,readfebdata$Global_active_power, type = "l", col = "black", xlab = "", ylab = "Global Active Power")

# Voltage: minute-averaged voltage (in volt)
plot(readfebdata$Time,readfebdata$Voltage, type = "l", col = "black", xlab = "datetime", ylab = "Voltage")

# plot lines for 
#Sub_metering_1.It corresponds to the kitchen, containing mainly a dishwasher, an oven and a microwave (hot plates are not electric but gas powered.
#Sub_metering_2.It corresponds to the laundry room, containing a washing-machine, a tumble-drier, a refrigerator and a light.
#Sub_metering_3.It corresponds to an electric water-heater and an air-conditioner.
plot(readfebdata$Time,readfebdata$Sub_metering_1, type = "l", col = "black", xlab = "", ylab = "Energy sub metering")
lines(readfebdata$Time,readfebdata$Sub_metering_2, type = "l", col = "red")
lines(readfebdata$Time,readfebdata$Sub_metering_3, type = "l", col = "blue")

# add legend at top right corner
legend("topright", col=c("black","red","blue"),c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lty = 1)

# Global_reactive_power: household global minute-averaged reactive power (in kilowatt)
plot(readfebdata$Time,readfebdata$Global_reactive_power, type = "n", xlab = "datetime", ylab = "Global_reactive_power")
lines(readfebdata$Time,readfebdata$Global_reactive_power)

# shutdown the device
print("Shutdown Device")
dev.off()



