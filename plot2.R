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


plot(hpc_data$Timepoint, hpc_data$Global_active_power, 
     type = "l",
     xlab = "",
     ylab = "Global Active Power (kilowatts)")
dev.copy(png, file = "plot2.png")
dev.off()