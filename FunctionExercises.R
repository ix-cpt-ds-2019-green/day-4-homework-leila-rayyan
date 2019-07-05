# 5 Excercises 

# 1 
bmi = function(h, w){
  x = (w/(h**2)) * 703
  return(x)
}

bmi(65, 120)

# 2
area_of_parallelogram = function(h, b){
  x = h * b
  return(x)
}

# 3
greetings = function(time){
  x = "12:00"
  x = substr(x, 1, 2)
  x = as.integer(x)
  if (x < 12 ) 
    return("Gunaydin!")
  if (x >= 12 & x < 19 )
    return("iyi gunler")
  else
    return("iyi aksamlar")
}

greetings(12:00)


