# Load required libraries
library(quantmod)
library(tidyverse)

# Set start and end dates for 2022
start_date <- as.Date("2022-01-01")
end_date <- as.Date("2022-12-31")

# Get stock data (Example with Apple Inc.)
getSymbols("AAPL", src = "yahoo", from = start_date, to = end_date)

# Convert to data frame for easier manipulation with dplyr
aapl_data <- as.data.frame(AAPL)

# Analyze or manipulate data
# Example: Calculate daily returns
aapl_data <- aapl_data %>% 
  mutate(Daily_Return = (AAPL.Adjusted - lag(AAPL.Adjusted)) / lag(AAPL.Adjusted))

# Plotting the stock movement
ggplot(aapl_data, aes(x = index(AAPL), y = AAPL.Adjusted)) +
  geom_line() +
  labs(title = "AAPL Stock Movement in 2022", x = "Date", y = "Adjusted Closing Price")

