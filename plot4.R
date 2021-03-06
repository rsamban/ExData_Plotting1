#create tmp file
temp <- tempfile()
#download data to temp file
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)
#unzip and load data
allData <- read.csv(unz(temp,"household_power_consumption.txt"), sep=";")
#delete temp file
unlink(temp)
#filter and massage data
Feb2DayData <- allData[allData$Date %in% c('1/2/2007','2/2/2007'),]
Feb2DayData$dateTime <- paste(Feb2DayData$Date,Feb2DayData$Time,sep=" ")
Feb2DayData$dateTime <- strptime(Feb2DayData$dateTime, '%d/%m/%Y %H:%M:%S')
Feb2DayData$Global_active_power <- as.numeric(Feb2DayData$Global_active_power)
#open png graphics device and create plot
png("plot4.png", width=480,height=480)
#4 plots in 2 X 2 matrix
par(mfcol=c(2,2))
#plot first column first row
plot(Feb2DayData$dateTime, Feb2DayData$Global_active_power/1000, type="l", xlab="", ylab="Global Active Power", yaxt="n")
#plot first column second row
plot(Feb2DayData$dateTime, Feb2DayData$Sub_metering_1, type="n", xlab="", ylab="Energy sub metering")
lines(Feb2DayData$dateTime, Feb2DayData$Sub_metering_1, col="black")
lines(Feb2DayData$dateTime, Feb2DayData$Sub_metering_2, col="red")
lines(Feb2DayData$dateTime, Feb2DayData$Sub_metering_3, col="blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col=c("black","red","blue"), lty=1)
#plot second column first row
plot(Feb2DayData$dateTime, Feb2DayData$Voltage, type="l", xlab="datetime", ylab="Voltage")
#plot second column second row
plot(Feb2DayData$dateTime, Feb2DayData$Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power")
#close the png device
dev.off()
