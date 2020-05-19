library("data.table")



#Reads in data from file then subsets data for specified dates
pwrdata <- data.table::fread(input = "household_power_consumption.txt"
                             , na.strings="?"
)

# Restricting histogram from printing scientific notation
pwrdata[, Global_active_power := lapply(.SD, as.numeric), .SDcols = c("Global_active_power")]

# Change Date Column to Date Type
pwrdata[, Date := lapply(.SD, as.Date, "%d/%m/%Y"), .SDcols = c("Date")]

# data filtered for 2007-02-01 and 2007-02-02
pwrdata <- pwrdata[(Date >= "2007-02-01") & (Date <= "2007-02-02")]

png("plot1.png", width=480, height=480)

# Plot1
hist(pwrdata[, Global_active_power], main="Global Active Power", 
  xlab="Global Active Power (kilowatts)", ylab="Frequency", col="Red")
dev.off()