
# =====================================================================================================================
#   Intro to Data manipulation                                                                                              
#   Taryn Morris                                                                                                                  
#   iXperience 2019 - Green
# =====================================================================================================================


##### GOOD CODING PRACTICE #####

# 1) Title your code 
# 2) Load your packages upfront
# 3) Set your working directory --> BUT PROJECTS ARE WAY BETTER
# 4) annotate your code - better for sharing and for memory
# 5) Make use of sections (4 consecutive ---- or #### or ====)
# 6) Use either lowercase or camelCase naming conventions. If needed use under_scores. 
# 7) Indentations can help make code more readable (Rstudio often does this for you).
# 8) Spaces help make code readable. And don’t change the function.



# LIBRARIES -----------------------------------------------------------------------------------------------------------

# To install a package use the command install.packages () (OR ...)
# You only need to install packages once (like downloading an app)
# notice the inverted commas. The command wont work without them - try it and see.
install.packages("tidyverse") 
install.packages("nycflights13")
install.packages("lubridate")
#install the package "nycflights13" 


# Load packages from library 
# You have to load packages every session - like opening the app you downloaded to use its functions
library(tidyverse)
library(nycflights13)  #you can read about it here if you need (https://github.com/hadley/nycflights13)
library(lubridate)


# WORKING DIRECTORY ---------------------------------------------------------------------------------------------------

#You can set the place to find your files and folder using setwd()
setwd("~/Desktop/iXperience/DataScienceGreen/2. R code")
# or navigate there via "files", " more options"
  
#BUT - NOW USE PROJECTS!
#BETTER OPTION!!!





# LETS GET TO IT  ---------------------------------------------------------------------------------------------------

#look at the inbuilt "flights" dataset from the nycflights13 package
flights     # it tells us flights is a "tibble" with 336 776 rows and 19 columns

#tibbles automatically display the first 10 rows of data but if you want to see more use print()
print(flights, n=20)
   

# you can still use all base R functions but answers displayed as tibbles, which can be very useful 
# try these commands we learnt in "Base R"

head(flights)

flights[2, 1]
flights[, 1]
flights[1, ]
flights[-2, ]
flights[, -1]
flights[c(1,5,7), ]
flights[, c(1,2)]
flights[flights$month=="12", c(10,9)]
subset(flights, arr_delay > 0)
gapminder[,year] # does this work?

  
# Remember - there is no 1 right way to get an answer. Whether you use base R, or Tidy R commands, or a little bit of each
# it's all good. You will soon find what works for you and what's quickest for you! (which is probably tidyr)




# Manipulating data with tidyr  ---------------------------------------------------------------------------------------------------

# -----  1) SELECT -----

#select() selects columns we want
flights_want <- select(flights, carrier, origin, year, month, day, hour, minute, dep_delay, arr_delay) 
#               select(data, columns)
# read this as ... make an object called flights_want by taking the flights dataframe and selecting the columns  carrier, origin ...)
flights_want
select(flights, carrier)
# how about removing a column we dont want?
flights_dont_want <- select(flights, -year)
flights_dont_want

#there are several helper elements we can use in the select() function - 
#(especially useful when working with biiiiiig datasets)
 #   - starts_with()
 #   - ends_with()
 #   - contains()
 #   - matches()       - matches a regular expression
 #   - num_range()
 #   - one_of()        - exclude/include columns from list of names
 #   - everything().

# select a few columns and put everything else after (ie change order)
flights_some <- select(flights, carrier, tailnum, year, month, day, everything()) 



# select the columns carrier, year, month, day, dep_delay, arr_delay, origin, destination, airtime, distance, time_hour   
# AND call it flights_clean -- check it gave you the right thing!
flights_clean = select(flights, carrier, year, month, day, dep_delay, arr_delay, origin, dest, air_time, distance, time_hour)

#^^^^^

names(flights) #gives column names

## 2) ARRANGE -----
#arrange() orders the tibble according to a chosen column (think "sort" in excel)
flights_sorted <- arrange(flights_clean, arr_delay) # default sort is ascending
flights_sorted

flights_sorted_bad <- arrange(flights_clean, desc(arr_delay)) # default sort is ascending
flights_sorted_bad

## 3) FILTER -----
#filter() gives rows matching a given criteria using: ==, !=, >, >=, <, <=, &, |
flights_AA <- filter(flights_clean, carrier = "AA") # gave us an error - why?

flights_AA <- filter(flights_clean, carrier == "AA") 
flights_AA

flights_AA_JFK <- filter(flights_clean, carrier == "AA" & origin == "JFK") 
flights_AA_JFK

flights_AA_DL <- filter(flights_clean, carrier == "AA" | carrier == "DL") 
flights_AA_DL


# filter the dataset for carrier MQ
flights_MQ <- filter(flights_clean, carrier=="MQ")

  
# filter the dataset for carrier MQ & destination ORD

flights_MQ_ORD = filter(flights_clean, carrier=="MQ" & dest == "ORD")
###^^^ 

## 4) MUTATE -----
#mutate() creates a new column (at the end of the dataframe) based on an existing column
# lets look at arrival delay as hours rather than minutes
flights_hours <- mutate(flights_clean, arr_delay_hours=arr_delay/60)
arrange(flights_hours, desc(arr_delay_hours))


# add a column of flight_speed to the flights_clean data
mutate(flights_clean, flight_speed = distance/air_time)


#make a date column
flights_date <- mutate(flights_clean, date = make_datetime(year, month, day))

#add in day of week
mutate(flights_date, day_of_week = wday(date, label=F))
#what happens if we make label = T?

mutate(flights_date, day_of_week = wday(date, label=T))

# Use rename() to change the name of columns without mutating.

flights_clean %>% rename(airline = carrier)

## 5) GROUP BY and SUMMARISE -----
#group_by() does not change the data, but is used in conjunction with summarise()
# summarise performs a function to a group of data created with group_by()


flights_mean_delay <- group_by(flights_clean, carrier)
flights_mean_delay <- summarise(flights_mean_delay, mean_arr_delay = mean(arr_delay))
flights_mean_delay


# whats the problem
# we didnt check our data set to look for missing values.
flights_mean_delay <- group_by(flights_clean, carrier)
flights_mean_delay <- summarise(flights_mean_delay, mean_arr_delay = mean(arr_delay, na.rm=T))
flights_mean_delay


flights_summary <- group_by(flights_clean, carrier)
flights_summary <- summarise(flights_summary, 
                            mean_arr_delay = mean(arr_delay, na.rm=T),
                            min_arr_delay = min(arr_delay, na.rm=T),
                            max_arr_delay = max(arr_delay, na.rm=T))
flights_summary
flight_summary_sorted <- arrange(flights_summary, mean_arr_delay)



## 6)  %>%  PIPING

# old way to get data that you wanted was step by step (or nesting commands in commands which can get very messy)
#e.g.   #see last example above ^^^


# enter piping! Glorious piping!
#remember to read piping as "and then"

flights_sep_summary <- flights_clean %>% drop_na() %>% 
                       filter(month == 9) %>% 
                       group_by(carrier) %>%
                       summarise(mean_arr_delay = mean(arr_delay),
                                 min_arr_delay = min(arr_delay),
                                 max_arr_delay = max(arr_delay)) %>% 
                       arrange(mean_arr_delay)


#### get the mean dep_delay, for American Airlines, for each month.
# which month had the worst delays
worst_delay = flights_clean %>% drop_na() %>% 
  filter(carrier=="AA") %>% group_by(month) %>% 
  summarise(mean_dep_delay = mean(dep_delay)) %>%
  arrange(mean_dep_delay)
worst_delay

#get the mean, min and max arrival delays for all airlines at each airport of origin
summary_arr = flights_clean %>% drop_na() %>% 
  group_by(origin) %>%
  summarise(mean_arr_delay = mean(arr_delay), min_arr = min(arr_delay), max_arr = max(arr_delay))  

#Which airport had the longest delay? from which airline?
arrange(summary_arr, max_arr)[3,]

# how long in hours?




## 7) GATHER AND SPREAD WIDE DATA
# gather() takes wide data and gathers into long data
# spread() takes long data and gatherss into wide data

flights_wide <- flights_clean %>% drop_na() %>% 
  group_by(carrier, month) %>%
  summarise(mean_arr_delay = mean(arr_delay)) 

flights_wide

flights_wide <- flights_clean %>% drop_na() %>% 
  group_by(carrier, month) %>%
  summarise(mean_arr_delay = mean(arr_delay)) %>% 
  spread(month, mean_arr_delay)

flights_wide

