# Load data
eda_data <- read.table("C:/Cleaning Data/ExData_Plotting1/household_power_consumption.txt",
                       header = TRUE,
                       sep = ";",
                       na.strings = "?",
                       stringsAsFactors = FALSE)

eda_data$Date <- as.Date(eda_data$Date, format = "%d/%m/%Y")

eda_data$DateTime <- as.POSIXct(paste(eda_data$Date, eda_data$Time),
                                format = "%Y-%m-%d %H:%M:%S")

feb_dates <- eda_data$Date >= as.Date("2007-02-01") & eda_data$Date <= as.Date("2007-02-02")

filtered_data <- eda_data[feb_dates, ]

png("histogram.png", width = 480, height = 480)

hist(filtered_data$Global_active_power,
     main = "Global Active Power",
     xlab = "Global Active Power (kilowatts)",
     ylab = "Frequency",
     col = "red")

dev.off()

