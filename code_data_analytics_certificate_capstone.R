#### Tools for analysis  

# Load packages

library(tidyverse)
library(lubridate)
library(janitor)
library(readr)
library(psych) # This package is used to output an organized table of the statistic result for the summary of the dataset.

# Load data.

bike_jan_2022 <- read_csv('/Volumes/THIAGO1TB/Thiago/2021/DataScience/google_data_analytics_certificate_course/capstone/case_study_1/data/202201-divvy-tripdata.csv')
bike_dec_2021 <- read_csv('/Volumes/THIAGO1TB/Thiago/2021/DataScience/google_data_analytics_certificate_course/capstone/case_study_1/data/202112-divvy-tripdata.csv')
bike_oct_2021 <- read_csv('/Volumes/THIAGO1TB/Thiago/2021/DataScience/google_data_analytics_certificate_course/capstone/case_study_1/data/202111-divvy-tripdata.csv')
bike_nov_2021 <- read_csv('/Volumes/THIAGO1TB/Thiago/2021/DataScience/google_data_analytics_certificate_course/capstone/case_study_1/data/202110-divvy-tripdata.csv')
bike_sep_2021 <- read_csv('/Volumes/THIAGO1TB/Thiago/2021/DataScience/google_data_analytics_certificate_course/capstone/case_study_1/data/202109-divvy-tripdata.csv')
bike_aug_2021 <- read_csv('/Volumes/THIAGO1TB/Thiago/2021/DataScience/google_data_analytics_certificate_course/capstone/case_study_1/data/202108-divvy-tripdata.csv')
bike_jul_2021 <- read_csv('/Volumes/THIAGO1TB/Thiago/2021/DataScience/google_data_analytics_certificate_course/capstone/case_study_1/data/202107-divvy-tripdata.csv')
bike_jun_2021 <- read_csv('/Volumes/THIAGO1TB/Thiago/2021/DataScience/google_data_analytics_certificate_course/capstone/case_study_1/data/202106-divvy-tripdata.csv')
bike_may_2021 <- read_csv('/Volumes/THIAGO1TB/Thiago/2021/DataScience/google_data_analytics_certificate_course/capstone/case_study_1/data/202105-divvy-tripdata.csv')
bike_apr_2021 <- read_csv('/Volumes/THIAGO1TB/Thiago/2021/DataScience/google_data_analytics_certificate_course/capstone/case_study_1/data/202104-divvy-tripdata.csv')
bike_mar_2021 <- read_csv('/Volumes/THIAGO1TB/Thiago/2021/DataScience/google_data_analytics_certificate_course/capstone/case_study_1/data/202103-divvy-tripdata.csv')
bike_feb_2021 <- read_csv('/Volumes/THIAGO1TB/Thiago/2021/DataScience/google_data_analytics_certificate_course/capstone/case_study_1/data/202102-divvy-tripdata.csv')
bike_jan_2021 <- read_csv('/Volumes/THIAGO1TB/Thiago/2021/DataScience/google_data_analytics_certificate_course/capstone/case_study_1/data/202101-divvy-tripdata.csv')

# Merging 12 months worth of data into a single csv file for analysis.

cyclistic_data <- list.files(path = '/Volumes/THIAGO1TB/Thiago/2021/DataScience/google_data_analytics_certificate_course/capstone/case_study_1/data', full.names = TRUE) %>% 
  lapply(read_csv) %>% 
  bind_rows


# Create backup data within the environment

backup_cyclistic <- cyclistic_data


# Inspect the data frame.  

str(cyclistic_data)


# Add new columns and format data type to aid analysis and visualization.  

cyclistic_data$date <- as.Date(cyclistic_data$started_at)

cyclistic_data$month <- format(as.Date(cyclistic_data$started_at), "%b_%y")

cyclistic_data$day <- format(as.Date(cyclistic_data$date),"%d")

cyclistic_data$year <- format(as.Date(cyclistic_data$date), "%Y")

cyclistic_data$weekday <- format(as.Date(cyclistic_data$date), "%A")

cyclistic_data$time <- format(cyclistic_data$started_at, format = "%H:%M")

# Format date and time

cyclistic_data$time <- as.POSIXct(cyclistic_data$time, format = "%H:%M")

cyclistic_data$ride_length <- (as.double(difftime(cyclistic_data$ended_at, cyclistic_data$started_at)))/60

str(cyclistic_data)

# Checking the dimensions of the data to help me to understand the data.  

dim(cyclistic_data)

# Descriptive statistics - summary of the data.

describe(cyclistic_data)

# Removing duplicates.  

cyclistic_data <- distinct(cyclistic_data)

#Filtering ride duration 

cyclistic_data <- cyclistic_data[!cyclistic_data$ride_length<0.1, ]

cyclistic_data <- cyclistic_data[!cyclistic_data$ride_length>1440, ]

cyclistic_data <- rename(cyclistic_data, customer_type = member_casual)

cyclistic_data <- rename(cyclistic_data, bike_type = rideable_type)

# Removing missing data.  

cyclistic_data <- cyclistic_data %>% 
  select(bike_type, customer_type, started_at, date, month, year, weekday, time, ride_length)
drop_na(cyclistic_data)

remove_empty(cyclistic_data)

remove_missing(cyclistic_data)

# Organizing the dataframe

cyclistic_data$weekday <- ordered(cyclistic_data$weekday, levels=c("Monday", "Tuesday", "Wednesday",
                                                                   "Thursday","Friday", "Saturday", "Sunday"))

cyclistic_data$month <- ordered(cyclistic_data$month, levels=c("Jan_21", "Feb_21", "Mar_21", "Apr_21","May_21",
                                                               "Jun_21","Jul_21", "Aug_21", "Sep_21", "Oct_21",
                                                               "Nov_21", "Dec_21", "Jan_22"))


#### Analysing the data  

# Summary statistics of the duration of the rides  

describe(cyclistic_data$ride_length)

# Describing how many customers in each category.  

table(cyclistic_data$customer_type)

# Describing how many rides each type of client performed.  

setNames(aggregate(ride_length ~ customer_type, cyclistic_data, sum), c("customer_type", "total_ride_length(mins"))

# Describing riding statistics of the two types of clients.  

cyclistic_data %>% 
  group_by(customer_type) %>% 
  summarise(min_dur = min(ride_length), max_dur = max(ride_length), median_dur = median(ride_length), avg_dur = mean(ride_length))

# Describing the riding duration by day of the week.  

aggregate(cyclistic_data$ride_length ~ cyclistic_data$customer_type + cyclistic_data$weekday, FUN = median)

aggregate(cyclistic_data$ride_length ~ cyclistic_data$customer_type + cyclistic_data$weekday, FUN = mean)

# Number of rides by day of the week and client type.  

cyclistic_data %>% 
  group_by(customer_type, weekday) %>% 
  summarise(total_rides = n(), avg_rides = mean(ride_length)) %>% 
  arrange(weekday)

#### Data visualization  

# Total rides by weekday

cyclistic_data %>% 
  group_by(customer_type, weekday) %>% 
  summarise(number_of_rides = n()) %>%
  arrange(customer_type, weekday) %>% 
  
  ggplot(aes(x = weekday, y = number_of_rides, fill = customer_type)) +
  geom_col(position = "dodge") +
  labs( x = "Days of the Week", y = "Total Number of Rides", caption = "Figure 1. Rides per day of the week", fill = "Type of membership") +
  scale_y_continuous(breaks = c(100000, 200000, 300000, 400000, 500000, 600000), labels = c("100k","200k","300k", "400k", "500k", "600k")) + 
  scale_fill_manual(values = c("black", "gray80")) +
  theme_bw() +
  theme(panel.border = element_blank(), panel.grid.major = element_blank(), panel.grid.minor = element_blank(), axis.line = element_line(colour = "black")) +
  theme(axis.text.x = element_text(colour = "black"), axis.text.y = element_text(colour = "black"), plot.caption = element_text(size = 12, hjust = 0))


# Monthly usage by customer type

cyclistic_data %>% 
  group_by(customer_type, month) %>% 
  summarise(total_rides = n(), `avergare_duration_(mins)` = mean(ride_length)) %>% 
  arrange(customer_type) %>% 
  
  ggplot(aes(x = month, y = total_rides, fill = customer_type)) +
  geom_col(position = "dodge") +
  labs(x = "Month", y = "Total number of rides", caption = "Figure 2. Rides per month", fill = "Type of membership") + 
  scale_y_continuous(breaks = c(100000, 200000, 300000, 400000, 500000, 600000), labels = c("100k","200k","300k", "400k", "500k", "600k")) + 
  scale_fill_manual(values = c("black", "gray80")) +
  theme_bw() +
  theme(panel.border = element_blank(), panel.grid.major = element_blank(), panel.grid.minor = element_blank(), axis.line = element_line(colour = "black")) +
  theme(axis.text.x = element_text(colour = "black", angle = 45, vjust = 0.5), axis.text.y = element_text(colour = "black"), plot.caption = element_text(size = 12, hjust = 0))

# Average ride duration the customer type usage by day of the week

cyclistic_data %>% 
  group_by(customer_type, weekday) %>% 
  summarise(average_ride_length = mean(ride_length)) %>% 
  
  ggplot(aes(x = weekday, y = average_ride_length, fill = customer_type)) +
  geom_col(position = "dodge") + 
  labs(x = "Day of the Week", y = "Average Ride Duration (min)",
       caption = "Figure 3. Average ride duration by customer type and day of the week",
       fill = "Type of membership") +
  scale_fill_manual(values = c("black", "gray80")) +
  theme_bw() +
  theme(panel.border = element_blank(), panel.grid.major = element_blank(), panel.grid.minor = element_blank(), axis.line = element_line(colour = "black")) +
  theme(axis.text.x = element_text(colour = "black"), axis.text.y = element_text(colour = "black"), plot.caption = element_text(size = 12, hjust = 0))

# Average ride duration by customer type and month

cyclistic_data %>% 
  group_by(customer_type, month) %>% 
  summarise(average_ride_length = mean(ride_length)) %>% 
  
  ggplot(aes(x = month, y = average_ride_length, fill = customer_type)) +
  geom_col(position = "dodge") +
  labs(x = "Month", y = "Average Ride Duration (min)", caption = "Figure 4. Average ride duration by customer type and month",
       fill = "Type of Membership") +
  scale_fill_manual(values = c("black", "gray80")) +
  theme_bw() +
  theme(panel.border = element_blank(), panel.grid.major = element_blank(), panel.grid.minor = element_blank(), axis.line = element_line(colour = "black")) +
  theme(axis.text.x = element_text(colour = "black", angle = 45, vjust = 0.5), axis.text.y = element_text(colour = "black"), plot.caption = element_text(size = 12, hjust = 0))


# Looking at the bike types rented

cyclistic_data %>% 
  ggplot(aes(x = bike_type, fill = customer_type)) + 
  geom_bar(position = "dodge") + 
  labs(x = "Bike type", y = "Number of rentals", caption = "Figure 5. Preferred bike type", fill = "Type of membership") +
  scale_y_continuous(breaks = c(500000, 1000000, 1500000), labels = c("500k", "1Mil", "1.5Mil")) +
  scale_fill_manual(values = c("black", "gray80")) +
  theme_bw() +
  theme(panel.border = element_blank(), panel.grid.major = element_blank(), panel.grid.minor = element_blank(), axis.line = element_line(colour = "black")) +
  theme(axis.text.x = element_text(colour = "black"), axis.text.y = element_text(colour = "black"), plot.caption = element_text(size = 12, hjust = 0))

# Demand throughout the day

```{r}
cyclistic_data %>% 
  group_by(customer_type, time) %>% 
  summarise(total_rides = n()) %>% 
  
  ggplot(aes(x = time, y = total_rides, color = customer_type, group = customer_type)) +
  geom_line() + scale_x_datetime(date_breaks = "1 hour", date_labels = "%H:%M", expand = c(0,0)) +
  theme(axis.text.x = element_text(angle = 45)) +
  labs(caption = "Figure 6. Demand throughout the day", x = "Time", y = "Total rides")+ 
  scale_colour_manual(values = c("black", "gray80")) +
  theme_bw() +
  theme(panel.border = element_blank(), panel.grid.major = element_blank(), panel.grid.minor = element_blank(), axis.line = element_line(colour = "black")) +
  theme(axis.text.x = element_text(colour = "black", angle = 45, vjust = 0.5), axis.text.y = element_text(colour = "black"), plot.caption = element_text(size = 12, hjust = 0))

# Demand throughout the day for every month of the year.

cyclistic_data %>% 
  group_by(customer_type, time, weekday) %>% 
  summarise(total_rides = n()) %>% 
  
  ggplot(aes(x = time, y = total_rides, color = customer_type, group = customer_type)) +
  geom_line() + scale_x_datetime(date_breaks = "1 hour", date_labels = "%H:%M", expand = c(0,0)) +
  theme(axis.text.x = element_text(angle = 45)) +
  labs(caption = "Figure 7. Pannel comparing the demand throughout the day for every month of the year", x = "Time", y = "Total rides")+ 
  scale_colour_manual(values = c("black", "gray80")) +
  theme_bw() +
  theme(panel.border = element_blank(), panel.grid.major = element_blank(), panel.grid.minor = element_blank(), axis.line = element_line(colour = "black")) +
  theme(axis.text.x = element_text(colour = "black", angle = 90, vjust = 0.5), axis.text.y = element_text(colour = "black"), plot.caption = element_text(size = 12, hjust = 0)) +
  facet_wrap (~ weekday)
