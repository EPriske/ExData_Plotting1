#The first step is to download the file and load it into your Working Directory.
#Then load all the required libraries and read the data from the text file.
library(ggplot2)
dataEPC <- read.table("household_power_consumption.txt",skip=1,sep=";")

#We will make the variable names more descriptive and change their values.
names(dataEPC) <- c("Date","Time","Global_active_power","Global_reactive_power",
                    "Voltage","Global_intensity","Sub_metering_1","Sub_metering_2",
                    "Sub_metering_3")

#Transoforming the variables into numbers, dates and time.
dataEPC$Global_active_power <- as.numeric(dataEPC$Global_active_power)
dataEPC$Global_reactive_power <- as.numeric(dataEPC$Global_reactive_power)
dataEPC$Voltage <- as.numeric(dataEPC$Voltage)
dataEPC$Global_intensity <- as.numeric(dataEPC$Global_intensity)
dataEPC$Sub_metering_1 <- as.numeric(dataEPC$Sub_metering_1)
dataEPC$Sub_metering_2 <- as.numeric(dataEPC$Sub_metering_2)
dataEPC$Sub_metering_3 <- as.numeric(dataEPC$Sub_metering_3)

#We will filter the data with only the dates given to us.
#The date and time has to be configured.
dataplot3 <- subset(dataEPC, Date == "1/2/2007" | Date == "2/2/2007")
dataplot3$Date <- as.Date(dataplot3$Date, format="%d/%m/%Y")
dataplot3$Time <- strptime(dataplot3$Time, format="%H:%M:%S")
dataplot3[1:1440,"Time"] <- format(dataplot3[1:1440,"Time"],"2007-02-01 %H:%M:%S")
dataplot3[1441:2880,"Time"] <- format(dataplot3[1441:2880,"Time"],"2007-02-02 %H:%M:%S")

#We will do a summary of our data and the basic plot
summary(dataplot3)

#Plot 3
plot(dataplot3$Time,dataplot3$Sub_metering_1,type="n",xlab="",ylab="Energy sub metering")
with(dataplot3,lines(Time,as.numeric(as.character(Sub_metering_1))))
with(dataplot3,lines(Time,as.numeric(as.character(Sub_metering_2)),col="red"))
with(dataplot3,lines(Time,as.numeric(as.character(Sub_metering_3)),col="blue"))
legend("topright", lty=1, col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
title(main="Plot 3")

#save the plot into a 480 pixels and a height of 480 pixels PNG.