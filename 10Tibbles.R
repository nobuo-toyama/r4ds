## 10 Tibbles

vignette("tibble")

## ==== 10.1 Introduction

library(tidyverse)

## ==== 10.2 Creating tibbles

as_tibble(iris)

tibble(
    x = 1:5, 
    y = 1, 
    z = x ^ 2 + y
)

tb <- tibble(
    `:)` = "smile", 
    ` ` = "space",
    `2000` = "number"
)
tb

tribble(
  ~x, ~y, ~z,
  #--|--|----
  "a", 2, 3.6,
  "b", 1, 8.5
)

## ==== 10.3 Tibbles vs. data.frame

## ---- 10.3.1 Printing

tibble(
    a = lubridate::now() + runif(1e3) * 86400,
    b = lubridate::today() + runif(1e3) * 30,
    c = 1:1e3,
    d = runif(1e3),
    e = sample(letters, 1e3, replace = TRUE)
)

nycflights13::flights %>% 
    print(n = 10, width = Inf)

options(tibble.print_max = n, tibble.print_min = m)

## to always print all columns
options(tibble.width = Inf)

nycflights13::flights %>% 
    View()

## ==== 10.3.2 Subsetting

df <- tibble(
    x = runif(5),
    y = rnorm(5)
)

## Extract by name
df$x

df[["x"]]

## Extract by position
df[[1]]

## To use these in a pipe
df %>% .$x

df %>% .[["x"]]

## ==== 10.4 Interacting with older code

as.data.frame(df)

## ==== 10.5 Exercises 
