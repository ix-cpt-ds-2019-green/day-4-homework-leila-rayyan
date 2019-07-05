## PART A --> TIDYING DATA 

#Go through the data tidying case study in r4ds - https://r4ds.had.co.nz/tidy-data.html#case-study
#Feel free to read the preceding sections if you need more info.



## PART B --> MANIPULATE DATA
#install and load gapminder package
install.packages("gapminder")
library(gapminder)
##^^^

#### LETS MANIPULATE#####

#the dataset is in the builtin object gapminder package
gapminder[1:5]

## 1) SELECT -----
#select() selects columns we want

# select country, year and population
select(gapminder, country, year, pop)

# select continent and pop
select(gapminder, continent, pop)

# remove the column continent
gapminder[-2]

## 2) ARRANGE -----
#arrange() orders the tibble according to a chosen column 

#sort the dataset by life Exp
le = arrange(gapminder, lifeExp)

#which Country in which year had the lowest life expectancy
le[1,c(1,3)]
'
# A tibble: 1 x 2
country  year
<fct>   <int>
  1 Rwanda   1992
'
#which Country in which year had the highest life expectancy
le[1704, c(1, 3)]
'
# A tibble: 1 x 2
country  year
<fct>   <int>
  1 Japan    2007
'

## 3) FILTER -----
#filter() gives rows matching a given criteria using: ==, !=, >, >=, <, <=, &, |

#filter data for the year 2007
filter(gapminder, year==2007)

#filter data for the year 2007 and population <= 999999
filter(gapminder, year==2007 & pop<=999999)

# filter data to get all continents except Asia
filter(gapminder, continent!="Asia")

# filter data to get all continents except Asia or data where life expectancy is < 30
filter(gapminder, continent!="Asia" | lifeExp < 30)

# filter the dataset for continent of Africa for the year of 2005
filter(gapminder, continent=="Africa" & year==2005)
  #none exist?
  
  
## 4) MUTATE -----
#mutate() creates a new column (at the end of the dataframe) based on an existing column

# add another column to the gapminder dataframe with the total gdp in millions of dollars
### totalgdp = (gdpPercap * pop)/1000000

mutate(gapminder, tot_gdp = (gdpPercap * pop)/1000000)

## 5) GROUP BY and SUMMARISE -----
#group_by() with summarise()

# get the mean life expectancy for the data set (hint) you dont always have to use group by
mean(gapminder$lifeExp)
# 59.47444

# get the mean life expectancy per country.
per_C = group_by(gapminder, country)
x = summarise(per_C, life_exp_country = mean(lifeExp))
    # which country has the highest, and the lowest?
#highest = Australia
#lowest = Afghanistan

# get mean life expectancy per year 
per_y = group_by(gapminder, year)
summarise(per_y, mean_life_exp_per_year = mean(lifeExp))
    # what do you notice.
        #There is steady increase of mean life expectancy as the years increase. 

# Some questions to answer ----

## Were there any data missing?
#No...

## 1) What was the total population of Africa in 2002? hint use the function #sum
africa = filter(gapminder, continent=="Africa" & year== 2002)
sum(africa$pop)
# 833723916

## 2) What were the top 10 countries in the world by gdp_per_head in 2002?
y = filter(gapminder, year == 2002)
x = arrange(y, desc(gdpPercap))
x[1:10,1]
'
1 Norway       
2 United States
3 Singapore    
4 Kuwait       
5 Switzerland  
6 Ireland      
7 Netherlands  
8 Canada       
9 Austria      
10 Denmark      
'
## 3) Which country, in which year had the lowest life expectancy?
x = arrange(gapminder, lifeExp)
select(x, country, year)[1,]
# Rwnada 1992

## 4) Which country, in which year had the biggest population?
x = arrange(gapminder, desc(pop))
select(x, country, year)[1,]
#China    2007

## 5) Which 3 countries have the highest average life expectancy?
gr = group_by(gapminder, country)
g = summarise(gr, meanlife = mean(lifeExp))
x = arrange(g, desc(meanlife))
select(x, country)[1:3,]
'
1 Iceland
2 Sweden 
3 Norway 
'
## 6) Which 3 countries have the highest average population?
y = group_by(gapminder, country)
x = summarise(y, meanpop = mean(pop))
z = arrange(x, desc(meanpop))
z[1:3,]
'
  country          meanpop
  <fct>              <dbl>
1 China         958160052.
2 India         701130740.
3 United States 228211232.
'