
#Reading in data and cleaning
library(dplyr)
data<- read.table(pipe('grep "1/2/2007\\|2/2/2007" "household_power_consumption.txt"'),
                  sep = ";", na.strings = "?")
names(data)<- c("Date", "Time", "Global_active_power", "Global_reactive_power", "Voltage", 
                "Global_intensity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
data<-filter(data, !grepl("11|12|21|22", Date))
data<-droplevels(data)

epc<-data %>% mutate(DateTime = paste(Date, Time)) %>% transform(DateTime= strptime(DateTime, "%d/%m/%Y %H:%M:%S"))


#Creating Plot4
png( file = "plot4.png", height = 480, width = 480)

par(mar = c(5.1, 4.1, 4.1, 2.1), mfrow = c(2,2), oma = c(1,1,2,1))
with(epc, plot(DateTime, Global_active_power, pch = ".", 
               ylab = "Global Active Power", xlab = "", cex.lab = 1, cex.axis = 1),
     main = "")
with(epc, lines(DateTime, Global_active_power))

with(epc, plot(DateTime, Voltage, pch = ".",
               ylab = "Voltage", xlab = "datetime", cex.lab = 1, cex.axis = 1, main = ""))
with(epc, lines(DateTime, Voltage))

with(epc, {
  plot(DateTime, Sub_metering_1, col = "black", pch = ".", ylab = "Energy sub metering", xlab = "", 
       cex.axis = 1, cex.lab = 1, main = "")
  lines(DateTime, Sub_metering_1, col = "black")
  points(DateTime, Sub_metering_2, col = "red", pch = ".")
  lines(DateTime, Sub_metering_2, col = "red")
  points(DateTime, Sub_metering_3, col = "blue", pch = ".")
  lines(DateTime, Sub_metering_3, col = "blue")
})
legend("topright", lty = 1, col = c("black", "red", "blue"), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), cex = .8, bty = "n")

with(epc, plot(DateTime, Global_reactive_power, pch = ".", 
               ylab = "Global_reactive_power", xlab = "datetime", cex.lab = 1, 
               cex.axis = 1, main = ""))
with(epc, lines(DateTime, Global_reactive_power))

dev.off()