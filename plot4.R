#This source file will produce a png with various plots

#Load File and subset
#My computer has enough memory I shall read and subset rather than limit the read
#Load the initial dataset to begin with
data <- read.table("household_power_consumption.txt", sep=";", header = TRUE, na.strings="?", colClasses = "character")
#Convert Date column to date format for easier subsetting
data$Date <- suppressWarnings(as.Date(data$Date,"%d/%m/%Y"))
#Subset to the appropriate dates
data <- subset(data,Date>="2007-02-01")
data <- subset(data,Date<="2007-02-02")

#Plot 3 is a line plot of the 3 sub metering columns over time

#Convert required columns to numeric
data$Global_active_power <- as.numeric(data$Global_active_power)
data$Sub_metering_1 <- as.numeric(data$Sub_metering_1)
data$Sub_metering_2 <- as.numeric(data$Sub_metering_2)
data$Sub_metering_3 <- as.numeric(data$Sub_metering_3)
data$Voltage <- as.numeric(data$Voltage)
data$Global_reactive_power <- as.numeric(data$Global_reactive_power)

#Add a DateTime column
data$DateTime <- strptime(paste(data$Date, data$Time), "%Y-%m-%d %H:%M:%S")

#Open a png file for storing and displaying the data
png(file = "plot4.png", width = 480, height = 480)

#Set up the 2x2 plot matrix
par(mfrow=c(2,2))

#Plot 1,1 is the Global Active Power over Time
plot(data$DateTime,data$Global_active_power,type="l",xlab="",ylab="Global Active Power (kilowatts)")

#Plot 1,2 is the Voltage over datetime
plot(data$DateTime,data$Voltage,type="l",xlab="datetime",ylab="Voltage")

#Plot 2,1 is the sub metering plot
#Get the range to ensure the plots all appear on the same scale
yrange<-range(c(data$Sub_metering_1,data$Sub_metering_2,data$Sub_metering_3))
#Plot 1 and labels
plot(data$DateTime,data$Sub_metering_1,type="l",xlab="",ylab="Energy sub metering",ylim=yrange,col="black")
#Edit the parameters of the plot
par(new=T)
#Add plots 2 and 3
plot(data$Sub_metering_2,type="l",axes=F,col="red",ylim=yrange,xlab="",ylab="")
par(new=T)
plot(data$Sub_metering_3,type="l",axes=F,col="blue",ylim=yrange,xlab="",ylab="")
#Add a legend
legend("topright",col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lwd=1)

#Plot 2,2 is Global Reactive power over Time
plot(data$DateTime,data$Global_reactive_power,type="l",xlab="datetime",ylab="Global_reactive_power")

#Close the interaction with the display file
dev.off()
