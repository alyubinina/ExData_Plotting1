# Get data --------------------------------------------------------------------
# Download a zipped file
if (!file.exists("household_power_consumption.zip")) {
  download.file("https://d396qusza40orc.cloudfront.net/exdata_data_household_power_consumption.zip",
                "household_power_consumption.zip")
}

# Read a dataset
dataset <- read.csv(unz("exdata_data_household_power_consumption.zip", "household_power_consumption.txt"), 
                    header = TRUE, sep = ";", na.strings = "?", colClasses = "character")

# Get a subset of data from the dates 2007-02-01 and 2007-02-02
dataset <- dataset[dataset$Date %in% c("1/2/2007", "2/2/2007"),]

# Prepare data for making a plot4 ---------------------------------------------
# Convert data in columns 3-9 to numeric
dataset[,3:9] <- sapply(dataset[,3:9], as.numeric)

# Convert Date and Time variables to POSIXlt format and create Date_Time variable
dataset$Date_Time <- strptime(paste(dataset[,1], dataset[, 2]), "%d/%m/%Y  %H:%M:%S")

# Construct the plot4 in plot4.png --------------------------------------------
png("plot4.png")
par(mfrow = c(2, 2))
with(dataset, plot(Date_Time, Global_active_power, type = "l", xlab = "", 
                   ylab = "Global Active Power"))
with(dataset, plot(Date_Time, Voltage, type = "l", xlab = "datetime", ylab = "Voltage"))
with(dataset, {
  plot(Date_Time, Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering")
  lines(Date_Time, Sub_metering_2, col = "red")
  lines(Date_Time, Sub_metering_3, col = "blue")
  legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), bty = "n",
         lty = 1, col = c("black", "red", "blue"))
})
with(dataset, plot(Date_Time, Global_reactive_power, type = "l", xlab = "datetime", 
                   ylab = "Global_reactive_power"))
dev.off()
