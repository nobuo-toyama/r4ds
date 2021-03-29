## 20 Vectors

library(tidyverse)

## ==== 20.1 Vector basics

typeof(letters)
typeof(1:10)

x <- list("a", "b", 1:10)
length(x)

## ==== 20.3 Important types of atomic vector

## ---- 20.3.1 Logical

1:10 %% 3 == 0

c(TRUE, TRUE, FALSE, NA)

## ---- 20.3.2 Numeric

typeof(1)
typeof(1L)
1.5L

x <- sqrt(2) ^ 2
x
x - 2

c(-1, 0, 1) / 0

## ---- 20.3.3 Character

x <- "This is a reasonably long string."
pryr::object_size(x)

y <- rep(x, 1000)
pryr::object_size(y)

## ---- 20.3.4 Missing values

## ==== 20.4 Using atomic vectors

## ---- 20.4.1 Coercion

x <- sample(20, 100, replace = TRUE)
y <- x > 10
sum(y)  # how many are greater than 10?
mean(y) # what proportion are greater than 10?

typeof(c(TRUE, 1L))
typeof(c(1L, 1.5))
typeof(c(1.5, "a"))

## ---- 20.4.3 Scalars and recycling rules

sample(10) + 100
runif(10) > 0.5

1:10 + 1:2

1:10 + 1:3

tibble(x = 1:4, y = 1:2)

tibble(x = 1:4, y = rep(1:2, 2))

tibble(x = 1:4, y = rep(1:2, each = 2))

## ---- 20.4.4 Naming vectors

c(x = 1, y = 2, z = 4)

set_names(1:3, c("a", "b", "c"))

## ---- 20.4.5 Subsetting

x <- c("one", "two", "three", "four", "five")
x[c(3, 2, 5)]

x[c(1, 1, 5, 5, 5, 2)]

x[c(-1, -3, -5)]

x[c(1, -1)]
#> Error in x[c(1, -1)]: only 0's may be mixed with negative subscripts

x <- c(10, 3, NA, 5, 8, 1, NA)

# All non-missing values of x
x[!is.na(x)]

# All even (or missing!) values of x
x[x %% 2 == 0]

x <- c(abc = 1, def = 2, xyz = 5)
x[c("xyz", "def")]

## ==== 20.5 Recursive vectors(lists)

x <- list(1, 2, 3)
x

str(x)

x_named <- list(a = 1, b = 2, c = 3)
str(x_named)

y <- list("a", 1L, 1.5, TRUE)
str(y)

z <- list(list(1, 2), list(3, 4))
str(z)

## ---- 20.5.1 Visualizing lists

x1 <- list(c(1, 2), c(3, 4))
x2 <- list(list(1, 2), list(3, 4))
x3 <- list(1, list(2, list(3)))

## ---- 20.5.2 Subsetting

a <- list(a = 1:3, b = "a string", c = pi, d = list(-1, -5))

str(a[1:2])
str(a[4])

str(a[[1]])
str(a[[4]])

a$a
a[["a"]]

## ==== 20.6 Attributes

x <- 1:10
attr(x, "greeting")
attr(x, "greeting") <- "Hi!"
attr(x, "farewell") <- "Bye!"
attributes(x)

## ==== 20.7 Augmented vectors

## ---- 20.7.1 Factors

x <- factor(c("ab", "cd", "ab"), levels = c("ab", "cd", "ef"))
typeof(x)
attributes(x)

## ---- 20.7.2 Dates and date-times

x <- as.Date("1971-01-01")
unclass(x)

typeof(x)
attributes(x)

x <- lubridate::ymd_hm("1970-01-01 01:00")
unclass(x)

typeof(x)
attributes(x)

attr(x, "tzone") <- "US/Pacific"
x

attr(x, "tzone") <- "US/Eastern"
x

y <- as.POSIXlt(x)
typeof(y)
attributes(y)

## ---- 20.7.3 Tibbles

tb <- tibble::tibble(x = 1:5, y = 5:1)
typeof(tb)
attributes(tb)

df <- data.frame(x = 1:5, y = 5:1)
typeof(df)
attributes(df)
