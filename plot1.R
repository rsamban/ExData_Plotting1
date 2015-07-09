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
#open png graphics device and create histogram
png("plot1.png", width=480,height=480)
hist(Feb2DayData$Global_active_power/1000, col="red", main="Global Active Power", xlab="Global Active Power (kilowatts)", xaxt="n")
#close the png device
dev.off()
