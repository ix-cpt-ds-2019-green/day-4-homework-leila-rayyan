# =====================================================================================================================
# = Reading and writing files                                                                                                       =
# =  Taryn Morris                                                                                                                 =
# = iXperience 2019 - Green                                                   
# =====================================================================================================================


# LIBRARIES -----------------------------------------------------------------------------------------------------------
install.packages("writexl")
library(readr)
library(readxl)
library(writexl)
library(tidyverse)

# FILE SYSTEM INTERACTION ---------------------------------------------------------------------------------------------

# you need to set your working directory to tell R where to find your data.
#using the command setwd() - if you know your file paths well OR ... 

setwd("~/Desktop/iXperience/DataScienceGreen/2. R code")
getwd()

#Best is to work in a project instead. # this points R to the directory in which the project sits.
#much easier to share

#Open the file sharing project now ***


list.files() # lists the files in the project directory



# CSV FILES [READ] ----------------------------------------------------------------------------------------------------

# A "delimited file" is one in which fields are separated by a special character. This character is generally one of
# the following:
#
# * comma (",")
# * semi-colon (";")
# * pipe ("|") or
# * white space (space or tab).

# There's a suite of base R related functions for working with delimited files. Each performs a slightly different variation
# on the same theme.
#
# * read.table()  - white space separator
# * read.csv()    - "," separator; "." for decimal point
# * read.csv2()   - ";" separator; "," for decimal point
# * read.delim()  - tab separator; "." for decimal point
# * read.delim2() - tab separator; "," for decimal point
#
# Important arguments:
# - header
# - sep
# - na.strings
# - nrows
# - skip
# - comment.char
# - stringsAsFactors

#tidyverse also reads in files
#read_csv 

### See data import cheat sheet for alllllll the commands you might need.



#read.csv (baseR) and read_csv(tidyverse - more specifically readr) ultimately both achieve reading in data but
#tidyverse option is way sleaker and more user friendly

# But dont take my word for it - let's try it and see.


### BASE R DATA IMPORT 

airbnb_baseR <- read.csv("data/airbnb_capetown.csv")
airbnb_baseR


# this is quite hard to look at and get a sense of. There are several functions that can help us (from my ppt)


class(airbnb_baseR)

#1. Look at the dataframe
airbnb_baseR

#2. look at the head of the data frame
head(airbnb_baseR)

#3. look at the tail of the data frame
tail(airbnb_baseR)

#4. look at the names of the dataframe
names(airbnb_baseR)

#5. look at the attributes of the dataframe
attributes(airbnb_baseR)

#6. look at the dimensions of the data frame
dim(airbnb_baseR)

#7. look at the number of columns of the dataframe
ncol(airbnb_baseR)
#8. look at the number of rows of the dataframe
nrow(airbnb_baseR)
#9 look at the summary of the dataframe
summary(airbnb_baseR)
#10 look at the structure of the dataframe
structure(airbnb_baseR)
# With read.csv() character columns are converted to factors by default.
# Q. Check column classes and fix.
#    - Should name be a factor?
#    - Should hostname be a factor?
class(airbnb_baseR$name)
airbnb_baseR$name = as.character(airbnb_baseR$name)
class(airbnb_baseR$host_name)
airbnb_baseR$host_name = as.character(airbnb_baseR$host_name)
class(airbnb_baseR$city)
airbnb_baseR$city = as.character(airbnb_baseR$city)
class(airbnb_baseR$neighbourhood)
airbnb_baseR$neighbourhood = as.character(airbnb_baseR$neighbourhood)

#we would have to fix this and change columns as factors into what they should be OR
airbnb_baseR <- read.csv("data/airbnb_capetown.csv", stringsAsFactors = F)
str(airbnb_baseR)

# but now we would have to change the columns that are not factors but should be into factors.

# Lets see what happens if we use tidyverse (readr package to read in a csv)

airbnb_tidy <- read_csv("data/airbnb_capetown.csv")
airbnb_tidy                 
#all characters are characters now. Shouldnt room types and property types be factors?
#I can still get a summary 

summary(airbnb_tidy)


# lets do a little something to this.
airbnb_clean <- airbnb_tidy %>% select(name, city, price)


# CSV FILES [WRITE] ---------------------------------------------------------------------------------------------------

write_csv(airbnb_clean, path = "my_airbnb_data.csv")

# There are other functions in base R for writing flat files:
#
# - write.csv() and
# - write.csv2().
# - write.table()

# There are also a set of functions in the readr package:
#
# - write_delim()
# - write_csv() and
# - write_tsv().



# EXCELS FILES  ------------------------------------------------------------------------------------------------

#very similar process for reading and writing to excel.
# The read_excel() function will handle both XLS and XLSX files. There are lower level functions for handling specific
# also
# - read_xls() and
# - read_xlsx().


# The write_xlsx() function will write a data frame to a XLSX file.

# The read_excel() function will handle both XLS and XLSX files. There are lower level functions for handling specific
# file types:
#
# - read_xls() and
# - read_xlsx().
#
# This function will not open a file directly from a URL.



# The write_xlsx() function will write a data frame to a XLSX file.






# RDA / RDS -----------------------------------------------------------------------------------------------------------

# These are not really "flat" file formats, but it makes sense to talk about them now.
# Such a file can capture one or more R objects in binary format.

x <- 3
y <- 5

save(results, x, y, file = "a-few-variables.rda") #does not work for me. Results not found. 
saveRDS(x, file = "a-single-variable.rds")

# Remove these variables from the environment.
#
rm(results, x, y)
#
# Verify that they are gone.

# Load single variable (and optionally rename).
#
z <- readRDS("a-single-variable.rds")

load("a-few-variables.rda")

