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

# Remove rows with NA in Global_active_power or DateTime
filtered_data <- na.omit(filtered_data[, c("DateTime", "Global_active_power")])

# Open PNG graphics device with full path
png("C:/Cleaning Data/ExData_Plotting1/lineplot.png", width = 480, height = 480)

# Create line plot with custom x-axis
plot(filtered_data$DateTime, filtered_data$Global_active_power,
     type = "l",
     main = "Global Active Power (kilowats)",
     xlab = "Date",
     ylab = "Global Active Power (kilowatts)",
     xaxt = "n")  # Suppress default x-axis
axis(1, at = filtered_data$DateTime[c(1, length(filtered_data$DateTime) / 2, length(filtered_data$DateTime))],
     labels = c("Thu", "Fri", "Sat"))  # Set custom labels at start, middle, end

# Close graphics device
dev.off()
