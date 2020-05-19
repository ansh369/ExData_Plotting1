
library("data.table")


#Reads in data from file then subsets data for specified dates
pwrdata <- data.table::fread(input = "household_power_consumption.txt"
                                                      , na.strings="?")

# Restricting histogram from printing scientific notation
pwrdata[, Global_active_power := lapply(.SD, as.numeric), .SDcols = c("Global_active_power")]

# Making a POSIXct date capable of being filtered and graphed by time of day
pwrdata[, dateTime := as.POSIXct(paste(Date, Time), format = "%d/%m/%Y %H:%M:%S")]

# Data filtered for 2007-02-01 and 2007-02-02
pwrdata <- pwrdata[(dateTime >= "2007-02-01") & (dateTime < "2007-02-03")]

png("plot2.png", width=440, height=460)

#Plot 2
plot(x = pwrdata[, dateTime]
     , y = pwrdata[, Global_active_power]
     , type="l", xlab="", ylab="Global Active Power (kilowatts)")

dev.off()

