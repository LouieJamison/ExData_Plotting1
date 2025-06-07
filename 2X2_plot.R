# Load data
eda_data <- read.table("C:/Cleaning Data/ExData_Plotting1/household_power_consumption.txt",
                       header = TRUE,
                       sep = ";",
                       na.strings = "?",
                       stringsAsFactors = FALSE)

# Convert Date column to Date format
eda_data$Date <- as.Date(eda_data$Date, format = "%d/%m/%Y")

# Create DateTime column
eda_data$DateTime <- as.POSIXct(paste(eda_data$Date, eda_data$Time),
                                format = "%Y-%m-%d %H:%M:%S")

# Filter data for February 1-2, 2007
feb_dates <- eda_data$Date >= as.Date("2007-02-01") & eda_data$Date <= as.Date("2007-02-02")
filtered_data <- eda_data[feb_dates, ]

# Remove rows with NA in relevant columns
filtered_data <- na.omit(filtered_data[, c("DateTime", "Global_active_power", "Voltage", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3", "Global_reactive_power")])

# Open PNG graphics device with full path
png("C:/Cleaning Data/ExData_Plotting1/2x2_plot.png", width = 480, height = 480)

# Set up 2x2 plotting layout
par(mfrow = c(2, 2))

# Plot 1: Global Active Power
plot(filtered_data$DateTime, filtered_data$Global_active_power,
     type = "l",
     xlab = "",
     ylab = "Global Active Power",
     xaxt = "n")
axis(1, at = filtered_data$DateTime[c(1, length(filtered_data$DateTime) / 2, length(filtered_data$DateTime))],
     labels = c("Thu", "Fri", "Sat"))

# Plot 2: Voltage
plot(filtered_data$DateTime, filtered_data$Voltage,
     type = "l",
     xlab = "",
     ylab = "Voltage",
     xaxt = "n")
axis(1, at = filtered_data$DateTime[c(1, length(filtered_data$DateTime) / 2, length(filtered_data$DateTime))],
     labels = c("Thu", "Fri", "Sat"))

# Plot 3: Energy Sub Metering
plot(filtered_data$DateTime, filtered_data$Sub_metering_1,
     type = "l",
     col = "black",
     xlab = "",
     ylab = "Energy sub metering",
     xaxt = "n")
lines(filtered_data$DateTime, filtered_data$Sub_metering_2, col = "red")
lines(filtered_data$DateTime, filtered_data$Sub_metering_3, col = "blue")
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col = c("black", "red", "blue"), lty = 1, bty = "n")

# Plot 4: Global Reactive Power
plot(filtered_data$DateTime, filtered_data$Global_reactive_power,
     type = "l",
     xlab = "datetime",
     ylab = "Global_reactive_power",
     xaxt = "n")
axis(1, at = filtered_data$DateTime[c(1, length(filtered_data$DateTime) / 2, length(filtered_data$DateTime))],
     labels = c("Thu", "Fri", "Sat"))

# Reset par to default
par(mfrow = c(1, 1))

# Close graphics device
dev.off()