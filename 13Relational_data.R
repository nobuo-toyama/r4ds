## 13 Relational data

## ==== 13.1 Introduction

## ---- 13.1.1 Prerequisites

library(tidyverse)
library(nycflights13)

## ==== 13.2 nycflights13

airlines

airports

planes

weather

## ---- 13.2.1 Exercises

## ==== 13.3 Keys

planes %>%
    count(tailnum) %>%
    filter(n > 1)

weather %>%
    count(year, month, day, hour, origin) %>%
    filter(n > 1)

flights %>%
    count(year, month, day, flight) %>%
    filter(n > 1)

flights %>%
    count(year, month, day, tailnum) %>%
    filter(n > 1)

## ---- 13.3.1 Exercises

## ==== 13.4 Mutating joins

flights2 <- flights %>%
    select(year:day, hour, origin, dest, tailnum, carrier)
flights2

flights2 %>%
    select(-origin, -dest) %>%
    left_join(airlines, by = "carrier")

flights2 %>%
    select(-origin, -dest) %>%
    mutate(name = airlines$name[match(carrier, airlines$carrier)])

## ---- 13.4.1 Understanding joins

x <- tribble(
    ~key, ~val_x,
     1, "x1",
     2, "x2",
     3, "x3"
)
y <- tribble(
  ~key, ~val_y,
     1, "y1",
     2, "y2",
     4, "y3"
)

## ---- 13.4.2 Inner join

x %>%
    inner_join(y, by = "key")

## ---- 13.4.3 Outer joins

?left_join

?right_join

?full_join

## ---- 13.4.4 Duplicate keys

x <- tribble(
  ~key, ~val_x,
     1, "x1",
     2, "x2",
     2, "x3",
     1, "x4"
)
y <- tribble(
  ~key, ~val_y,
     1, "y1",
     2, "y2"
)
left_join(x, y, by = "key")

x <- tribble(
  ~key, ~val_x,
     1, "x1",
     2, "x2",
     2, "x3",
     3, "x4"
)
y <- tribble(
  ~key, ~val_y,
     1, "y1",
     2, "y2",
     2, "y3",
     3, "y4"
)
left_join(x, y, by = "key")

## ---- 13.4.5 Defining the key columns

flights2 %>%
    left_join(weather)

flights2 %>%
    left_join(planes, by = "tailnum")

flights2 %>%
    left_join(airports, c("dest" = "faa"))

flights2 %>%
    left_join(airports, c("origin" = "faa"))

## ---- 13.4.6 Exercises

## 1

airports %>%
    semi_join(flights, c("faa" = "dest")) %>%
    ggplot(aes(lon, lat)) +
    borders("state") +
    geom_point() +
    coord_quickmap()

## 2 - 5

## ---- 13.4.7 Other implementations

## You can use base::merge()

## Otherwise use SQL

## ==== 13.5 Filtering joins

top_dest <- flights %>%
    count(dest, sort = TRUE) %>%
    head(10)
top_dest

flights %>%
    filter(dest %in% top_dest$dest)

flights %>%
    semi_join(top_dest)

flights %>%
    anti_join(planes, by = "tailnum") %>%
    count(tailnum, sort = TRUE)

## ---- 13.5.1 Exercises

anti_join(flights, airports, by = c("dest" = "faa"))

anti_join(airports, flights, by = c("faa" = "dest"))

## ==== 13.6 Join problems

airports %>% count(alt, lon) %>% filter(n > 1)

## ==== 13.7 Set operations

df1 <- tribble(
  ~x, ~y,
   1,  1,
   2,  1
)
df2 <- tribble(
  ~x, ~y,
   1,  1,
   1,  2
)

intersect(df1, df2)
union(df1, df2)
setdiff(df1, df2)
setdiff(df2, df1)
