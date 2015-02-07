#This source file will produce a png plotting the 3 sub metering columns over time on the 1st and 2nd of February 2007

#Load File and subset
#My computer has enough memory I shall read and subset rather than limit the read
#Load the initial dataset to begin with
data <- read.table("household_power_consumption.txt", sep=";", header = TRUE, na.strings="?", colClasses = c("character","character",rep("numeric",7)))
#Convert Date column to date format for easier subsetting
data$Date <- suppressWarnings(as.Date(data$Date,"%d/%m/%Y"))
#Subset to the appropriate dates
data <- subset(data,Date>="2007-02-01")
data <- subset(data,Date<="2007-02-02")

#Plot 3 is a line plot of the 3 sub metering columns over time

#Add a DateTime column
data$DateTime <- strptime(paste(data$Date, data$Time), "%Y-%m-%d %H:%M:%S")

#Open a png file for storing and displaying the data
png(file = "plot3.png", width = 480, height = 480)

#Get the range to ensure the plots all appear on the same scale
yrange<-range(c(data$Sub_metering_1,data$Sub_metering_2,data$Sub_metering_3))

#Create the plot
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

#Close the interaction with the display file
dev.off()
