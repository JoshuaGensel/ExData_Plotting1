library(tidyverse)
library(lubridate)

if(!file.exists("./data/hpc_subset.csv")){
    dir.create("./data")
    download.file(
        "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",
        "./data/hpc.zip")
    unzip("./data/hpc.zip", exdir = "./data")
    write_csv(read_delim("./data/household_power_consumption.txt", 
                         delim = ";", 
                         skip = 66637, 
                         n_max = 69517-66637,
                         na = "?",
                         col_names = c("Date","Time","Global_active_power","Global_reactive_power","Voltage","Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3")
    ), 
    file = "./data/hpc_subset.csv")
}

hpc_data = read_csv("./data/hpc_subset.csv") %>% mutate(Timepoint = dmy_hms(paste(Date, Time)))

par(mfrow = c(2,2))

plot(hpc_data$Timepoint, hpc_data$Global_active_power, 
     type = "l",
     xlab = "",
     ylab = "Global Active Power (kilowatts)")

plot(hpc_data$Timepoint, hpc_data$Voltage,
     type = "l",
     xlab = "datetime",
     ylab = "Voltage")

plot(hpc_data$Timepoint, hpc_data$Sub_metering_1, 
     type = "n",
     xlab = "",
     ylab = "Energy sub metering")
lines(hpc_data$Timepoint, hpc_data$Sub_metering_1, col = "black")
lines(hpc_data$Timepoint, hpc_data$Sub_metering_2, col = "red")
lines(hpc_data$Timepoint, hpc_data$Sub_metering_3, col = "blue")
legend("topright", 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col = c("black", "red", "blue"),
       lty = 1,
       bty = "n",
       inset = c(0.05,0),
       cex = 0.9
       )

plot(hpc_data$Timepoint, hpc_data$Global_reactive_power,
     type = "l",
     xlab = "datetime",
     ylab = "Global_reactive_power")

dev.copy(png, file = "plot4.png")
dev.off()

