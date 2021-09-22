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
dataplot2 <- subset(dataEPC, Date == "1/2/2007" | Date == "2/2/2007")
dataplot2$Date <- as.Date(dataplot2$Date, format="%d/%m/%Y")
dataplot2$Time <- strptime(dataplot2$Time, format="%H:%M:%S")
dataplot2[1:1440,"Time"] <- format(dataplot2[1:1440,"Time"],"2007-02-01 %H:%M:%S")
dataplot2[1441:2880,"Time"] <- format(dataplot2[1441:2880,"Time"],"2007-02-02 %H:%M:%S")

#We will do a summary of our data and the basic plot
summary(dataplot2)

#Plot 2
plot(dataplot2$Time, dataplot2$Global_active_power, 
     type="l", xlab="",ylab="Global Active Power (kilowatts)")
title(main="Plot 2")

#save the plot into a 480 pixels and a height of 480 pixels PNG.
