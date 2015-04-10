
#Reading in data and cleaning
library(dplyr)

data<- read.table(pipe('grep "1/2/2007\\|2/2/2007" "household_power_consumption.txt"'),
                  sep = ";", na.strings = "?")
names(data)<- c("Date", "Time", "Global_active_power", "Global_reactive_power", "Voltage", 
                "Global_intensity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
data<-filter(data, !grepl("11|12|21|22", Date))
data<-droplevels(data)

epc<-data %>% mutate(DateTime = paste(Date, Time)) %>% transform(DateTime= strptime(DateTime, "%d/%m/%Y %H:%M:%S"))


#Creating Plot1
par(mar = c(5,5,2,5), mfrow = c(1,1), oma = c(0,0,0,0))
with(epc, hist(Global_active_power, col = "red", cex.lab = .8, cex.axis = .8, 
               xlab = "Global Active Power (kilowatts)", main = "Global Active Power",
               cex.main = .9))
dev.copy(png, file = "plot1.png", height = 480, width = 480)
dev.off()