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
filtered_data <- na.omit(filtered_data[, c("DateTime", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3")])

# Open PNG graphics device with full path
png("C:/Cleaning Data/ExData_Plotting1/submetering_plot.png", width = 480, height = 480)

# Create the initial plot with Sub_metering_1
plot(filtered_data$DateTime, filtered_data$Sub_metering_1,
     type = "l",
     col = "black",
     xlab = "Date",
     ylab = "Energy Sub Metering",
     xaxt = "n")  # Suppress default x-axis

# Add lines for Sub_metering_2 and Sub_metering_3
lines(filtered_data$DateTime, filtered_data$Sub_metering_2, col = "red")
lines(filtered_data$DateTime, filtered_data$Sub_metering_3, col = "blue")

# Add custom x-axis labels
axis(1, at = filtered_data$DateTime[c(1, length(filtered_data$DateTime) / 2, length(filtered_data$DateTime))],
     labels = c("Thu", "Fri", "Sat"))  # Set custom labels at start, middle, end

# Add legend
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col = c("black", "red", "blue"), lty = 1)

# Close graphics device
dev.off()
