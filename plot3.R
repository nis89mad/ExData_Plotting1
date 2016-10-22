plot3 <- function() {
    
    powerCon <- read.table("./household_power_consumption.txt", sep = ";", header = TRUE)
    
    # dates made datee columns
    powerCon$Date <- as.Date(powerCon$Date,format = "%d/%m/%Y")
    
    #only 2007/02/01-02
    Power2007 <- rbind(subset(powerCon, Date == "2007-02-01"), subset(powerCon, Date == "2007-02-02"))
    Power2007$DateTime <- paste(Power2007$Date, Power2007$Time)
    Power2007$DateTime <- strptime(Power2007$DateTime, format = "%Y-%m-%d %H:%M:%S")
    
    #looked for NA values in columns - no NA2
    #apply(Power2007,2, function(x) {sum(is.na(x))})
    #Looked for ? values in columns - no ?
    #apply(Power2007,2, function(x) {sum(x=="?")})
    
    #Making variables numeric
    Power2007$Global_active_power <- as.numeric(as.character(Power2007$Global_active_power))
    Power2007$Global_reactive_power <- as.numeric(as.character(Power2007$Global_reactive_power))
    Power2007$Voltage <- as.numeric(as.character(Power2007$Voltage))
    Power2007$Sub_metering_1 <- as.numeric(as.character(Power2007$Sub_metering_1))
    Power2007$Sub_metering_2 <- as.numeric(as.character(Power2007$Sub_metering_2))
    Power2007$Sub_metering_3 <- as.numeric(as.character(Power2007$Sub_metering_3))
    
    png("plot3.png")
    
    par(cex.axis = 0.75, cex.lab = 0.75, cex.main = 0.75)
    with(Power2007, plot(x = DateTime, y = Sub_metering_1,type = "n", xlab = "", ylab = "Energy sub metering"))
    with(Power2007, lines(DateTime, Sub_metering_1))
    with(Power2007, lines(DateTime, Sub_metering_2, col = "red"))
    with(Power2007, lines(DateTime, Sub_metering_3, col = "blue"))
    legend(legend = c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"), pch = "_", col = c("black", "red", "blue"), 'topright',cex = 0.75)
    
    dev.off()

}