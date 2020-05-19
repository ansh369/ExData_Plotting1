library("data.table")

#Reads data from file then subsets data for specified dates
pwrdata <- data.table::fread(input = "household_power_consumption.txt"
                             , na.strings="?"
)

# Prevents Scientific Notation
pwrdata[, Global_active_power := lapply(.SD, as.numeric), .SDcols = c("Global_active_power")]

# Making a POSIXct date capable of being filtered and graphed by time of day
pwrdata[, dateTime := as.POSIXct(paste(Date, Time), format = "%d/%m/%Y %H:%M:%S")]

# Data filtered for 2007-02-01 and 2007-02-02
pwrdata <- pwrdata[(dateTime >= "2007-02-01") & (dateTime < "2007-02-03")]

png("plot3.png", width=500, height=500)

#Plot3
plot(pwrdata[, dateTime], pwrdata[, Sub_metering_1], type="l", xlab="", ylab="Energy sub metering")
lines(pwrdata[, dateTime], pwrdata[, Sub_metering_2],col="red")
lines(pwrdata[, dateTime], pwrdata[, Sub_metering_3],col="blue")
legend("topright"
       , col=c("black","red","blue")
       , c("Sub_metering_1  ","Sub_metering_2", "Sub_metering_3")
       ,lty=c(1,1), lwd=c(1,1))

dev.off()