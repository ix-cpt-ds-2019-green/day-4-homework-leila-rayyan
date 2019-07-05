
# =====================================================================================================================
#   Intro to Data manipulation                                                                                              
#   Taryn Morris                                                                                                                  
#   iXperience 2019 - Green
# =====================================================================================================================

#install some packages you need using install.packages()
#new packages you will need: readxl, hms, lubridate, gapminder, tidyverse
#install any packages you might not have already



#call packages from the library
library("hms")
library("readxl")
library("lubridate")
library("gapminder")
library("tidyverse")
library("ggplot2")

# SET WD
setwd("~/Desktop/iXperience/DataScienceGreen/2. R code")
getwd() #checks your current working directory



#########################ENTER GGPLOT2 ###################### -----

#enter ggplot2 ---> Super elegant, sensical and easy way of creating some amazing graphs!

#ggplot2 has 3 simple steps.
#1) start with ggplot()
#2) specify the dataset you want to use, and the aesthetic "aes" --> this is just which variables you want to plot
#3) add on layers step by step of different things you want to do e.g.:
  # - add a line plot()
  # - specify the colour of the line
  # add a legend
  # change the background colour
  # etc.
  #IMPORTANT - it's impossible to remember all these commands - when in doubt ... google! 
  # also check out the GGPLOT2 "cheatsheet"


#here is a basic example of ggplot2 commands
# build a data frame to use as an example
my_df <- data.frame(A = c(1:10), B = seq(22, 4, by= -2)) 
my_df

# make the very basic graph with 3 basic ggplot steps!
#1) data, 2) the variables you want to plot, 3) what kind of graph you want
ggplot(my_df, aes(x=A, y=B)) + 
  geom_point() 
#ta daaaaaaaaa

#let's go back to the Gapminder dataset

gapminder



# 1) SCATTERPLOTS -----
# make a simple scatterplot
ggplot(gapminder, aes(x=gdpPercap, y=lifeExp)) + 
  geom_point()


#Let's log scale the x-axis
ggplot(gapminder, aes(x=gdpPercap, y=lifeExp)) + 
  geom_point() + 
  scale_x_log10()


# Challenge: - make a scatterplot of  lifeExp vs gdpPercap with only the data for India

dt = filter(gapminder, country=="India")

ggplot(dt, aes(x=gdpPercap, y=lifeExp)) + geom_point() + scale_x_log10()

### ....


#Smashed that! Okay!

#lets colour the points according to continent
ggplot(gapminder, aes(x=gdpPercap, y=lifeExp, color=continent)) +
  geom_point() + 
  scale_x_log10()

#what if we only choose a specific year --> 2007
gapminder2007 <- filter(gapminder, year==2007)


# Lets try out some colour options
#colour points by continent
ggplot(gapminder2007, aes(x=gdpPercap, y=lifeExp, color=continent)) +
  geom_point() + 
  scale_x_log10()

#we can also change the shape and size of the points. Play around and see what happens
ggplot(gapminder2007, aes(x=gdpPercap, y=lifeExp, color=continent )) +
  geom_point(shape=16, size=2) + 
  scale_x_log10()


#colour points by population  
ggplot(data=gapminder2007, aes(x=gdpPercap, y=lifeExp, color=pop)) + 
  geom_point() +
  scale_x_log10()


#hmmmmm not uber useful. Whats going on?

#colour points by population size 
ggplot(data=gapminder2007, aes(x=gdpPercap, y=lifeExp, color=log10(pop))) + 
  geom_point() +
  scale_x_log10()

#What about size?
#colour points by population  
ggplot(data=gapminder2007, aes(x=gdpPercap, y=lifeExp, size=pop)) + 
  geom_point() +
  scale_x_log10()


# lets try a combo
ggplot(data=gapminder2007, aes(x=gdpPercap, y=lifeExp, color=continent, size=pop)) +
  geom_point()+
  scale_x_log10()


# what about shape?
ggplot(data=gapminder2007, aes(x=gdpPercap, y=lifeExp, shape=continent)) + 
  geom_point() +
  scale_x_log10() +
  scale_shape(solid = FALSE) # what if this is true?---fills in the shapes




#2) LINE GRAPH -----

ggplot(filter(gapminder, country=="China"), aes(x=gdpPercap, y=lifeExp)) +
  geom_line()

#add the points
ggplot(filter(gapminder, country=="China"), aes(x=gdpPercap, y=lifeExp)) +
  geom_line() +
  geom_point() # problem? it had no parentheses eariler. 


#it's good to remember that ggplot "layers" things on top of each other 
p <- ggplot(filter(gapminder, country=="China"), aes(x=gdpPercap, y=lifeExp))

p #whats in p. nothing. 

#so this
p + geom_line(color="lightblue") + geom_point(color="red")
#is different to this
p + geom_point(color="red") + geom_line(color="lightblue")



# we can also control the aesthetic of each geom in each geom or overall depending on where we put the code
#so this
p + geom_line() + geom_point(aes(color=year))
#is different to this
p + geom_line() + geom_point() + aes(color=year)



#What if we want to draw a line graph of mean life Exp obver time for each continet

gap_continent <- gapminder %>% group_by(year,continent)  %>% summarise(mean_lifeExp = mean(lifeExp))
ggplot(gap_continent, aes(x=year, y=mean_lifeExp, colour=continent)) +
 geom_line() + geom_point()



# 3) HISTOGRAM -----
#make a histogram
ggplot(data=gapminder2007, aes(x=lifeExp)) + 
  geom_histogram()

ggplot(data=gapminder2007, aes(x=lifeExp)) + 
  geom_histogram(binwidth=5)

ggplot(data=gapminder2007, aes(x=lifeExp)) + 
  geom_histogram(binwidth=1)


# but all continents are in same histogram
ggplot(data=gapminder2007, aes(x=lifeExp)) + 
  geom_histogram(aes(fill=continent), binwidth = 1, alpha=0.65, position="identity")


#Other options for the position parameter are "stack", "fill" and "dodge". 
#You can find out about them from their respective help pages.  Give them a try.

#Alternatively we can use smoothed density curves.

ggplot(data=gapminder2007, aes(x=lifeExp)) + 
  geom_density( aes(fill=continent), alpha=0.5) 


# or maybe its better to get an idea of the summary statistics using a box plot
# what would we need to plot on x, what would we need to plot on y?
ggplot(data=gapminder2007, aes(x=continent, y=lifeExp )) + 
  geom_boxplot() + 
  aes(fill=continent)


#or on a plain bar graph
ggplot(data=gapminder2007, aes(x=continent)) +
  geom_bar() +
  aes(fill=continent)

#whats the problem? Parentheses!!!



#4) FACET WRAPPING -----
#if you want to see graphs for each grouping (whatever your grouping might be)


#if we want to split each continent out we can use facet_grid
ggplot(gapminder2007, aes(x=gdpPercap, y=lifeExp, colour=continent)) +
  geom_point() +
  scale_x_log10() +
  facet_grid(~continent)

# check out the difference between facet_grid & facet_wrap
#facet_wrap puts stuff on different lines

#facetwrap is useful if we have loooots of graphs. e.g.
ggplot(gapminder, aes(x=gdpPercap, y=lifeExp)) + 
  geom_point() + 
  scale_x_log10() + 
  aes(color=continent) + 
  facet_wrap(~ year)


# or just put it all together using "+" 
myplot <- ggplot(data=gapminder2007, aes(x=lifeExp, y=gdpPercap, color=continent)) +
  geom_point() +
  labs(x='Life expectancy', y=NULL, title='GDP vs Life expectancy', color='Continent: ') +
  theme_classic()




#The gapminder package includes a country_colors object that colors countries by population size and continent.
#checkout this cool graph


myplot <- ggplot(gapminder2007, aes(y=lifeExp, x=gdpPercap, fill=country, size=sqrt(pop))) +
  geom_point(shape=21) +
  scale_x_log10() +
  scale_fill_manual(values=country_colors) +
  facet_wrap(~continent) +
  scale_size_continuous(range=c(1, 20)) +
  guides(fill=FALSE, size=FALSE)

myplot

#how can we save plots we made?
#easy! using #ggsave()
ggsave(filename = "Plot.pdf", plot = myplot)
#did it save?

ggsave(filename = "Plot.png", plot = p, dpi = 300)



#Some examples for you

## (1) Show how South African life expectancy has changed through time
ggplot(filter(gapminder, country=="South Africa"), aes(y=lifeExp, x=year)) + geom_point()


## (2) For each continent, show how the gdp per head has changed over time (you may need to do some manipulation for this)

##must find average gdp per head fore each country. 
ggplot(gapminder, aes(y=(sum(gdpPercap*pop)/sum(pop)), x=year, color=continent)) + geom_point()


#Yeon
group_by(gapminder, continent, year) %>% summarize(mean_gdpPercap = mean(gdpPercap)) %>%
  ggplot(aes(x=year, y=mean_gdpPercap, color=continent)) +
  geom_point() +
  geom_line() +
  ylab("Average GDP per Head") +
  xlab("Year") +
  ggtitle("GDP per Head by Continent") +
  theme(plot.title = element_text(hjust = 0.5))







#HOMEWORK

# 1)
#The diamonds data are included in the ggplot2 package. 
#We’re interested in the relationships between caret, price and color. 
#We know that price depends somewhat on carat, but does this dependence vary by color? 
# data = diamonds
ggplot(diamonds, aes(x = carat, y = price, colour = color)) + 
  geom_point(alpha=0.20) + labs(x = "Carat", y = "Price", title="Price vs Carat by Diamond Color") + 
  theme(plot.title = element_text(hjust = 0.5)) + facet_wrap(.~color)

#Produce a plot or plots that you feel best communicates the relationship and then 
#describe in words what you see.
#hard to tell. 
#As color moves down the alphabet, price and carat increase too. 

# 2) Work your way through this tutorial to learn how to plot on maps
#https://www.littlemissdata.com/blog/maps

# if you would like to practice more - 
#play around with the Cape Town Airbnb data - available freely here from airbnb - 
#http://insideairbnb.com/cape-town/?neighbourhood=&filterEntireHomes=false&filterHighlyAvailable=false&filterRecentReviews=false&filterMultiListings=false


