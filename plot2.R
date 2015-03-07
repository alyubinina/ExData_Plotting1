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

# Prepare data for making a plot2 ---------------------------------------------
# Convert data in columns 3-9 to numeric
dataset[,3:9] <- sapply(dataset[,3:9], as.numeric)

# Convert Date and Time variables to POSIXlt format and create Date_Time variable
dataset$Date_Time <- strptime(paste(dataset[,1], dataset[, 2]), "%d/%m/%Y  %H:%M:%S")

# Construct the plot2 in plot2.png --------------------------------------------
png("plot2.png")
plot(dataset$Date_Time, dataset$Global_active_power, type = "l", xlab = "", 
     ylab = "Global Active Power (kilowatts)")
dev.off()
