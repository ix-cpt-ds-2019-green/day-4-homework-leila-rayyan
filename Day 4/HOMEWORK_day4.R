## Name: Leila Rayyan
## Date: July 4th 

## Descriptive Stats Exercises

## 2 
precip_mean = mean(precip)
precip_med = median(precip)
hist(precip)
abline(v = mean(precip), col = "blue")
abline(v = median(precip), col = "red")

is_mean = mean(islands)
is_med = median(islands)
hist(islands)
abline(v = mean(islands), col = "blue")
abline(v = median(islands), col = "red")
## The mean and median for both datasets are not identical which suggests that the datasets are skewed. 
##The islands dataset is largely skewed to the right. The precip data is a little skewed to the left, but alsmost symmetrical. 

## 3 
## Our three major cities is NYC, ATL, San Francisco
library(nycflights13)
library(tidyverse)
flights$origin
nycdata  = filter(flights, origin=="JFK" | origin == "LGA" | dest == "JFK" | dest == "LGA")
sfdata = filter(flights, origin == "SFO" | origin == "SJC" | origin == "OAK" | dest == "SFO"| dest == "SJC" | dest == "OAK")
atldata = filter(flights, origin == "ATL" | origin == "FTY" | dest == "ATL" | dest == "FTY")

#depature delays
x = summary(nycdata$dep_delay)
y = summary(atldata$dep_delay)
z = summary(sfdata$dep_delay)
matrix(c(x, y, z), nrow = 3, ncol = 7, 
       dimnames = list(c("NYC", "ATL", "SF"), 
                       c("Min", "1stQ", "Med", "Mean", "3rdQ", "Max", "NA's")))
#arrival delays
x = summary(nycdata$arr_delay)
y = summary(atldata$arr_delay)
z = summary(sfdata$arr_delay)
matrix(c(x, y, z), nrow = 3, ncol = 7, 
       dimnames = list(c("NYC", "ATL", "SF"), 
                       c("Min", "1stQ", "Med", "Mean", "3rdQ", "Max", "NA's")))
#departure delay box plots
library(ggplot2)
nycdata$city = "NYC"
atldata$city = "ATL"
sfdata$city = "SF"
boxplot(nycdata$arr_delay)
boxplot(atldata$arr_delay)
boxplot(sfdata$arr_delay)

# 4 
library(lubridate)
jfk = filter(flights, origin=="JFK")
lga = filter(flights, origin=="LGA") 
jfk2 = jfk %>% mutate(weekday = weekdays(make_datetime(year, month, day, hour, minute))) 
ggplot(data = jfk2, aes(x = dep_delay)) + geom_histogram(aes(fill = weekday), position = "dodge") + labs(x = "Delay Time", y = "Frequency", title = "Delay Times from JFK by Weekday" )

names(jkf2)
lga2 = lga %>% mutate(weekday = weekdays(make_datetime(year, month, day, hour, minute))) 
ggplot(data = lga2, aes(x = dep_delay)) + geom_histogram(aes(fill = weekday), position = "dodge") + labs(x = "Delay Time", y = "Frequency", title = "Delay Times from LGA by Weekday" )

## 6 Exercises
# 1
1 - pnorm(30, mean = 40, sd = 3)
pnorm(40, mean = 40, sd = 3) - pnorm(35, mean = 40, sd = 3)
pnorm(45, mean = 40, sd = 3) - pnorm(40, mean = 40, sd = 3)
pnorm(45, mean = 40, sd = 3)

# 2 

choose(20, 5) * (1/3)^5 * (1 - (1/3))^(20 - 5)

1 - ( (choose(20, 4) * (1/3)^4 * (1 - (1/3))^(20 - 4)) + 
       (choose(20, 3) * (1/3)^3 * (1 - (1/3))^(20 - 3)) + 
       (choose(20, 2) * (1/3)^2 * (1 - (1/3))^(20 - 2)) + 
       (choose(20, 1) * (1/3)^1 * (1 - (1/3))^(20 - 1)))

(choose(20, 5) * (1/3)^5 * (1 - (1/3))^(20 - 5)) + 
  (choose(20, 4) * (1/3)^4 * (1 - (1/3))^(20 - 4)) + 
  (choose(20, 3) * (1/3)^3 * (1 - (1/3))^(20 - 3)) + 
  (choose(20, 3) * (1/3)^3 * (1 - (1/3))^(20 - 3)) 

# 3 
dbinom(5, 20, (1/3))

dbinom(3, 20, (1/3)) + dbinom(4, 20, (1/3)) + dbinom(5, 20, (1/3)) + dbinom(6, 20, (1/3))

# 4 
samp  = rpois(1000, lambda = 120)
mean(samp)
median(samp)
#very close to the theoretical mean and median--probability because my sample size is large. 

# 6
ppois(0, 1, lower=FALSE)

# 7

## 4c
library(datasets)
ChickWeight
ggplot(data = ChickWeight, aes(x = weight)) + geom_histogram(binwidth = 30)
#Shape is skewed to the right.
ggplot(data = ChickWeight, aes(x = scale(weight))) + geom_histogram(binwidth = 0.5)
#Data is still skewed to the right???

qqnorm(ChickWeight$weight)
qqline(ChickWeight$weight, col ="blue")

qqnorm(scale(ChickWeight$weight))
qqline(scale(ChickWeight$weight), col ="blue")
#not different. Only scale is different because scale normalizes the data?? Maybe I'm using scale incorrectly. 

dt = transform(ChickWeight, weight = log(weight))
qqnorm(dt$weight)
qqline(dt$weight, col ="blue")
# line is straigther than normal

dt = transform(ChickWeight, weight = sqrt(weight))
qqnorm(dt$weight)
qqline(dt$weight, col ="blue")
#steeper than log transformation

#2
#normal dist.
dt = rnorm(1000, 0, 0.5)
qqnorm(dt)
qqline(dt, col ="blue")

#exp dist.
dt2 = rexp(1000, 10)
qqnorm(dt2)
qqline(dt2, col ="blue")

#log trans.
qqnorm(log(dt2))
qqline(log(dt2), col ="blue")

#3
