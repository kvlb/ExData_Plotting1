#This source file will produce a png histogramming the Global Active Power data on the 1st and 2nd of February 2007

#Load File and subset
#My computer has enough memory I shall read and subset rather than limit the read
#Load the initial dataset to begin with
data <- read.table("household_power_consumption.txt", sep=";", header = TRUE, na.strings="?", colClasses = "character")
#Convert Date column to date format for easier subsetting
data$Date <- suppressWarnings(as.Date(data$Date,"%d/%m/%Y"))
#Subset to the appropriate dates
data <- subset(data,Date>="2007-02-01")
data <- subset(data,Date<="2007-02-02")

#Plot 1 is a histogram of the Global Active Power points

#Convert required column to numeric
data$Global_active_power <- as.numeric(data$Global_active_power)

#Open a png file for storing and displaying the data
png(file = "plot1.png", width = 480, height = 480)

#Create the histogram
hist(data$Global_active_power, main="Global Active Power", col="red", xlab="Global Active Power (kilowatts)")

#Close the interaction with the display file
dev.off()

