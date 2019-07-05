
##### Intro to R #####
### iXperience 2019 - Green ###
### Taryn Morris ###



# This is a comment, R ignores these lines
# very useful to add headings, notes about the code, instructions etc. (esp when sharing code)
# "they" say not to write lines of code or comments longer than 80 charachters (see count bottom left)

# to # out chunks of code (for whatever reason) - you can use -- shift comd c--- (undo same way)
# most likey --- shift alt c --> please check and let us know.


try
it
with
these
lines


### we run code in a few different ways
# a) run botton top right corner - very tedious
# b) to run a whole line -> cmd enter (mac)  or cntl enter (windows) (anywhere on the line)
# c) to run a chunk of a line - highlight the chunk -> cmd enter (or ctrl enter)

'Hello World!'
print('Hello World!')
print("Welcome to R")


# RStudio is useful as it autofills "" and ()
#try it below


# RStudio also colour codes different types of code (e.g. numbers, #comments, 
# commands, and functions will all be colour coded differently)

# you can change your colour theme in Preferences --> appearance



# to turn a comment into a Section  add #### or ---- or ==== (4 or more of any type)
# read more here - https://support.rstudio.com/hc/en-us/articles/200484568-Code-Folding-and-Sections

#navigate to a section now.
# COME BACK TO THIS SECTION #####


############ DATA TYPES ##############

# the most common types of data are:
# 1) numbers (integars and decimals), 
# 2) logical (also called booleans), 
# 3) characters (many charachters put together is also known as a string - think words or sentances) 
# 4) dates, 
# 5) factors 


# we use the command class() to check what type of data we are working on.


# 1) NUMBERS -----
number_type <- 23

# 3 ways to view something 
number_type   # just run the name of the object
print(number_type) #use the print() function
                   #highlight and run (often useful to not have extra pieces of code littering your script)
class(number_type)

# what about decimals
decimals_type <- 23.754643
class(decimals_type)



# We can use basic arithmetic symbols to perform operations with numbers

#sum
2 + 2

#substraction
4 - 9

#multiplication
3*2

#division
7/2


# OR
a <- 7
b <- 2

a/b


#we can change the number of decimals 
round(a/b, 0)

#
pi
round(pi, 2)

#negation, change the sign of a number
-a

#square, cube, fourth power, etcetera
a^2
b^2
b^3




# 2) CHARACTERS -----

"We use character strings to represent text"

# either with single quotes ' or double quotes "

text1 <- 'Hello'
text1

text2 <- "World!"
text2

class(text2)


# what about putting lots of words together?

# we can try using the command c()
statement <- c("What", "is", "up", "?")
#didnt work! why not?

statement # is this what we wanted

#instead we can use the concatenate function cat()
statement_together <- cat("What", "is", "up", "?")


# processing text is a whole chapter in itself and we are going to spend some time later 
# in the weeks playing with text
# really useful for analysing text such as tweets, or articles etc.



# 3) LOGICAL  -----

#A logical (aka) boolean variable can only be TRUE or FALSE

truth <- True
truth <- TRUE
truth <- T
class(truth)
# vs 
truth_the_letter <- "T"
class(truth_the_letter) # and how to get out of an unfisnished command

falsehood <- FALSE
falsehood


#We can compare variables, the result of a comparison is always "logical"

a <- 7
b <- 2

a > b # a greater than b
b >= a # b greater than or equal to a
b <= a # b smaller or equal to a

b == 2 #b is equals (==) 2
b == 50 #b is equals (==) 50

#what if we we use one equals
b = 30
b
# we define a new value to b. This is why we use <- ... to cut down on confusion.
b <- 2 # make b 2 again.

# a is not equals (!=)  23
a != 23

# We can evaluate that multiple conditions are true with and -> &
a != 23 & a < b
a != 23 & a > b

# We can evaluate that any condition is true with `or` -> |
a != 23 | a > b




# right we get the just of data types - let's move onto data structures:




############ DATA STRUCTURES ##############
# Data structures are those objects we use to store information (data)
# main structures include

# 1) vector
# 2) matrix
# 3) dataframe
# 4) lists



###### 1) VECTORS ---------------
# we combine elements into a vector using the c( ) function

# remember vectrors are a single column of data - all of one type

names <- c("Taryn", "Neil", "Diana", "Kenny", "Connor")
class(names)

country <- c( "SA", "SA", "DR Congo", "USA", "Canada")


SA_local <- c(T, T, F, F, F)
class(SA_local)

age <- c(21, 25, 27, 29, 31)
class(age)

dogs <- c(0, 2, 0, 1, 1)


gender <- c("F", "M", "F", "M", "M")
class(gender)
gender <- as.factor(c("F", "M", "F", "M", "M"))
class(gender)

role <- as.factor(c("Teacher", "Teacher", "TA", "TA", "TA"))
class(role)




###### 2) MATRIX -------------------------
# we can combine vectors of the same length into matrix  
# remember vectors are multiple columns of data - all of one type

teacher_country <- cbind(names, country) # column bind
teacher_country
#or 
teacher_country <- rbind(names, country) # row bind
teacher_country


#OR

matrix(c(1,2,3,4,5,6,7,8,9,10), nrow=2, ncol=5)



###### 3) DATAFRAME -------------------------
# we can combine vectors of the same length into dataframe 
# remember vectors are multiple columns of data - all of one type

best_teachers <- data.frame(names, country, age, dogs, gender, role, stringsAsFactors = FALSE)
class(best_teachers)


# you can "coerce" an object into the desired type e.g.
#using commands like 
# as.factor(),  as.numeric(), as.character(),  as.logical()





#### subsetting from structures -----


# We access elements in a vector with brackets []
names[1] # returns the 1st name in the vector
names[4] # returns the 4th name

# we access elements of a matrix or dataframe using [row, column] 
# (think of this almost as a cell like in excel)

best_teachers[2,1] # will return the element in the 2nd row and first column
best_teachers[2,5] # will return the element in the 2nd row and first column
best_teachers[5,3]

# we can get a whole row by leaving the columninput blank
best_teachers[3, ]
# or we can get 2 or more rows
best_teachers[c(3,5), ] # get rows 3 and row 5
best_teachers[3:5, ]

# or
# we can get a whole column by leaving the row input blank
best_teachers[ ,2]
best_teachers[ ,3:5]
best_teachers[ ,c(1,3:5)]

#we can also remove columns and rows using - 
best_teachers[-1 ,] # maybe we fired taryn
best_teachers[ ,-5] # maybe we dont think gender is a binary factor

# we can access columns using the column names
best_teachers[ , "dogs"]
best_teachers[ , c("names", "dogs")]

#another way to subset a column using column names $
best_teachers$names
best_teachers$role


#### we can use [ ] to replace elements in our lists or vector
best_teachers[1,4] <- 1   # taryn got a puppy. Woo hoo!
best_teachers 




# the end of ultra basics!
# dorky thumbs up
# this is not a hashtag
