library("data.table")

#Reads data from file
pwrdata <- data.table::fread(input = "household_power_consumption.txt"
                             , na.strings="?"
)

# Prevents Scientific Notation
pwrdata[, Global_active_power := lapply(.SD, as.numeric), .SDcols = c("Global_active_power")]

# Making a POSIXct date capable of being filtered and graphed by time of day
pwrdata[, dateTime := as.POSIXct(paste(Date, Time), format = "%d/%m/%Y %H:%M:%S")]

# Filter data for 2007-02-01 and 2007-02-02
pwrdata <- pwrdata[(dateTime >= "2007-02-01") & (dateTime < "2007-02-03")]

png("plot4.png", width=420, height=420)

par(mfrow=c(2,2))



# Plot 1
plot(pwrdata[, dateTime], pwrdata[, Global_active_power], type="l", xlab="", ylab="Global Active Power")

# Plot 2
plot(pwrdata[, dateTime],pwrdata[, Voltage], type="l", xlab="datetime", ylab="Voltage")

# Plot 3
plot(pwrdata[, dateTime], pwrdata[, Sub_metering_1], type="l", xlab="", ylab="Energy sub metering")
lines(pwrdata[, dateTime], pwrdata[, Sub_metering_2], col="red")
lines(pwrdata[, dateTime], pwrdata[, Sub_metering_3],col="blue")
legend("topright", col=c("black","red","blue")
  , c("Sub_metering_1  ","Sub_metering_2  ", "Sub_metering_3  ")
  , lty=c(1,1)
  , bty="n"
  , cex=.5) 

#Plot 4
plot(pwrdata[, dateTime], pwrdata[,Global_reactive_power], type="l", xlab="datetime", ylab="Global_reactive_power")

dev.off()