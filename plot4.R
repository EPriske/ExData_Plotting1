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
dataplot4 <- subset(dataEPC, Date == "1/2/2007" | Date == "2/2/2007")
dataplot4$Date <- as.Date(dataplot4$Date, format="%d/%m/%Y")
dataplot4$Time <- strptime(dataplot4$Time, format="%H:%M:%S")
dataplot4[1:1440,"Time"] <- format(dataplot4[1:1440,"Time"],"2007-02-01 %H:%M:%S")
dataplot4[1441:2880,"Time"] <- format(dataplot4[1441:2880,"Time"],"2007-02-02 %H:%M:%S")

#We will do a summary of our data and the basic plot
summary(dataplot4)

#Plot 4
par(mfrow=c(2,2))
par(mar=c(1,1,1,1))
with(dataplot4,{
  plot(dataplot4$Time,dataplot4$Global_active_power,type="l",  xlab="",ylab="Global Active Power")  
  plot(dataplot4$Time,dataplot4$Voltage, type="l",xlab="datetime",ylab="Voltage")
  plot(dataplot4$Time,dataplot4$Sub_metering_1,type="n",xlab="",ylab="Energy sub metering")
  with(dataplot4,lines(Time,Sub_metering_1))
  with(dataplot4,lines(Time,Sub_metering_2,col="red"))
  with(dataplot4,lines(Time,Sub_metering_3,col="blue"))
  legend("topright", lty=1, col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), cex = 0.6)
  plot(dataplot4$Time,dataplot4$Global_reactive_power,type="l",xlab="datetime",ylab="Global_reactive_power")
})

#save the plot into a 480 pixels and a height of 480 pixels PNG.