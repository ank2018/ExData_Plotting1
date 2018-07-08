#plot2.R
# Below script will download the Electric Power Consumption Dataset from 
# https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip
# the script examines how household energy usage varies over a 2-day period in February, 2007
# Plot2

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

# Plot2
print("Plot the Graph")
png("plot2.png", width = 480, height = 480)

# plot lines - household global minute-averaged active power (in kilowatt)
plot(readfebdata$Time,readfebdata$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")


# shutdown the device
print("Shutdown Device")
dev.off()



