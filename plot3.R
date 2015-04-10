
#Reading in data and cleaning
library(dplyr)
data<- read.table(pipe('grep "1/2/2007\\|2/2/2007" "household_power_consumption.txt"'),
                  sep = ";", na.strings = "?")
names(data)<- c("Date", "Time", "Global_active_power", "Global_reactive_power", "Voltage", 
                "Global_intensity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
data<-filter(data, !grepl("11|12|21|22", Date))
data<-droplevels(data)

epc<-data %>% mutate(DateTime = paste(Date, Time)) %>% transform(DateTime= strptime(DateTime, "%d/%m/%Y %H:%M:%S"))


#Creating Plot3
png( file = "plot3.png", height = 480, width = 480)
par(mar = c(5.1, 4.1, 4.1, 2.1), mfrow = c(1,1), oma = c(0,0,0,0))
with(epc, {
  plot(DateTime, Sub_metering_1, col = "black", pch = ".", ylab = "Energy sub metering", xlab = "", 
       cex.axis = .8, cex.lab = .8, main = "")
  lines(DateTime, Sub_metering_1, col = "black")
  points(DateTime, Sub_metering_2, col = "red", pch = ".")
  lines(DateTime, Sub_metering_2, col = "red")
  points(DateTime, Sub_metering_3, col = "blue", pch = ".")
  lines(DateTime, Sub_metering_3, col = "blue")
})
legend("topright", lty = 1, col = c("black", "red", "blue"), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), cex = .8)

dev.off()