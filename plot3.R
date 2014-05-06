setwd("C:/Users/orojuan/Documents/Data Science/exploratory")
Sys.setlocale("LC_TIME", Sys.getlocale("LC_TIME"))
if(!file.exists("./exdata_data_household_power_consumption.zip")){
  download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",destfile="exdata_data_household_power_consumption.zip")
}
if(!file.exists("./household_power_consumption.txt")){
  unzip("./exdata_data_household_power_consumption.zip",exdir=getwd())
}
mydf <- read.table("./household_power_consumption.txt",header=T,sep=";",comment.char="",na.strings="?",colClasses=c(rep("character",2),rep("numeric",7)),nrow=2075259)
mydf$Datetime <- strptime(paste(mydf$Date,mydf$Time,sep=" "),format="%d/%m/%Y %H:%M:%S")
qry <- subset(mydf,mydf$Datetime >=strptime("2007-02-01 00:00:00",format="%Y-%m-%d %H:%M:%S") & mydf$Datetime < strptime("2007-02-03 00:00:00",format="%Y-%m-%d %H:%M:%S"))

png("plot3.png",width=480,height=480)
with(qry,{
  plot(Datetime,Sub_metering_1,type="l",ylab="Energy sub metering")
  lines(Datetime,Sub_metering_2,col="red")
  lines(Datetime,Sub_metering_3,col="blue")
  legend("topright",legend=names(qry)[7:9],lty=1,col=c("black","red","blue"))
})
dev.off()