library(nycflights13)
library(tidyverse)

flights

filter(flights, month == 1, day == 1)

filter(flights, month == 11 | month == 12)

nov_dec <- filter(flights, month %in% c(11, 12))

filter(flights, !(arr_delay > 120 | dep_delay > 120))
filter(flights, arr_delay <= 120, dep_delay <= 120)

arrange(flights, year, month, day)

arrange(flights, desc(dep_delay))

select(flights, year, month, day)

select(flights, year:day)

select(flights, -(year:day))

?starts_with     # tidyselect

rename(flights, tail_num = tailnum)
colnames(flights)

?one_of
select(flights, contains("TIME"))

flights_sml <- select(flights, 
  year:day, 
  ends_with("delay"), 
  distance, 
  air_time
)
mutate(flights_sml,
  gain = dep_delay - arr_delay,
  speed = distance / air_time * 60
  )

mutate(flights_sml,
  gain = dep_delay - arr_delay,
  hours = air_time / 60,
  gain_per_hour = gain / hours
  )

transmute(flights,
  gain = dep_delay - arr_delay,
  hours = air_time / 60,
  gain_per_hour = gain / hours
  )

transmute(flights,
  dep_time,
  hour = dep_time %/% 100,
  minute = dep_time %% 100
  )

(x <- 1:10)
lag(x)
lead(x)
cumsum(x)
cummean(x)

y <- c(1, 2, 2, NA, 3, 4)
min_rank(y)
min_rank(desc(y))

row_number(y)
dense_rank(y)
#> [1]  1  2  2 NA  3  4
percent_rank(y)
cume_dist(y)

summarise(flights, delay = mean(dep_delay, na.rm = TRUE))

by_day <- group_by(flights, year, month, day)
summarise(by_day, delay = mean(dep_delay, na.rm = TRUE))

by_dest <- group_by(flights, dest)
delay <- summarise(by_dest,
  count = n(),
  dist = mean(distance, na.rm = TRUE),
  delay = mean(arr_delay, na.rm = TRUE)
)
delay <- filter(delay, count > 20, dest != "HNL")

# It looks like delays increase with distance up to ~750 miles 
# and then decrease. Maybe as flights get longer there's more 
# ability to make up delays in the air?
ggplot(data = delay, mapping = aes(x = dist, y = delay)) +
  geom_point(aes(size = count), alpha = 1/3) +
    geom_smooth(se = FALSE)

delays <- flights %>% 
    group_by(dest) %>% 
    summarise(
        count = n(),
        dist = mean(distance, na.rm = TRUE),
        delay = mean(arr_delay, na.rm = TRUE)
    ) %>% 
    filter(count > 20, dest != "HNL")

not_cancelled <- flights %>% 
  filter(!is.na(dep_delay), !is.na(arr_delay))

not_cancelled %>% 
    group_by(year, month, day) %>% 
    summarise(mean = mean(dep_delay))

delays <- not_cancelled %>% 
  group_by(tailnum) %>% 
  summarise(
    delay = mean(arr_delay)
  )

ggplot(data = delays, mapping = aes(x = delay)) + 
  geom_freqpoly(binwidth = 10)

delays <- not_cancelled %>% 
  group_by(tailnum) %>% 
  summarise(
    delay = mean(arr_delay, na.rm = TRUE),
    n = n()
  )

ggplot(data = delays, mapping = aes(x = n, y = delay)) + 
    geom_point(alpha = 1/10)

delays %>% 
    filter(n > 25) %>% 
    ggplot(mapping = aes(x = n, y = delay)) + 
    geom_point(alpha = 1/10)

# Convert to a tibble so it prints nicely
batting <- as_tibble(Lahman::Batting)

batters <- batting %>% 
  group_by(playerID) %>% 
  summarise(
    ba = sum(H, na.rm = TRUE) / sum(AB, na.rm = TRUE),
    ab = sum(AB, na.rm = TRUE)
  )

batters %>% 
  filter(ab > 100) %>% 
  ggplot(mapping = aes(x = ab, y = ba)) +
    geom_point() + 
    geom_smooth(se = FALSE)

batters %>% 
    arrange(desc(ba))

not_cancelled %>% 
  group_by(year, month, day) %>% 
  summarise(
    avg_delay1 = mean(arr_delay),
    avg_delay2 = mean(arr_delay[arr_delay > 0])
                 # the average positive delay
  )

# Why is distance to some destinations more variable than to others?
not_cancelled %>% 
    group_by(dest) %>% 
    summarise(distance_sd = sd(distance)) %>% 
    arrange(desc(distance_sd))

# When do the first and last flights leave each day?
not_cancelled %>% 
  group_by(year, month, day) %>% 
  summarise(
    first = min(dep_time),
    last = max(dep_time)
  )

not_cancelled %>% 
    group_by(year, month, day) %>% 
    mutate(r = min_rank(desc(dep_time))) %>% 
    filter(r %in% range(r))

# Which destinations have the most carriers?
not_cancelled %>% 
    group_by(dest) %>%
    summarise(carriers = n_distinct(carrier)) %>% 
    arrange(desc(carriers))

not_cancelled %>% 
    count(dest)

not_cancelled %>% 
    count(tailnum, wt = distance)

# How many flights left before 5am? (these usually indicate delayed
# flights from the previous day)
not_cancelled %>% 
    group_by(year, month, day) %>% 
    summarise(n_early = sum(dep_time < 500))

# What proportion of flights are delayed by more than an hour?
not_cancelled %>% 
    group_by(year, month, day) %>% 
    summarise(hour_prop = mean(arr_delay > 60))

daily <- group_by(flights, year, month, day)
(per_day   <- summarise(daily, flights = n()))
(per_month <- summarise(per_day, flights = sum(flights)))
(per_year  <- summarise(per_month, flights = sum(flights)))

daily %>% 
    ungroup() %>%             # no longer grouped by date
    summarise(flights = n())  # all flights

flights_sml %>% 
    group_by(year, month, day) %>%
    filter(rank(desc(arr_delay)) < 10)

popular_dests <- flights %>% 
    group_by(dest) %>% 
    filter(n() > 365)
popular_dests

popular_dests %>% 
    filter(arr_delay > 0) %>% 
    mutate(prop_delay = arr_delay / sum(arr_delay)) %>% 
    select(year:day, dest, arr_delay, prop_delay)

vignette("window-functions")
