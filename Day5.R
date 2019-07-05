x = 3
if (x %% 2 == 0) {
  print("Even!")
} else {
  print("Odd!")
}


x = 1:10
ifelse(x %% 2, "Odd!", "Even!")

for (i in 1:10) {
  cat(sprintf("%d is %s.\n", i, ifelse(i %% 2, "odd", "even")))
}

#sprintf is a printing format.

# 1 = T
# 0 = F

#while loop
i = 0
while (i < 10) {
  i = i + 1
  if (i %% 2) next
  print(paste("i =", i))
}


circle_perimeter <- function(r) {
  C = 2 * pi * r
  return(C)
}

circle_perimeter(5)


scale.unit <- function(x) (x - min(x)) / (max(x) - min(x)) #inline function code works
scale.unit(c(-2, 4, 6, 2))
