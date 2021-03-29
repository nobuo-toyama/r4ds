## 18 Pipes

library(magrittr)

## ==== 18.2 Piping alternatives

## ---- Intermediate steps

## ==== 18.3 When not to use the pipe

## ==== 18.4 Other tools from magrittr

rnorm(100) %>%
  matrix(ncol = 2) %>%
  plot() %>%
  str()

rnorm(100) %>%
  matrix(ncol = 2) %T>%
  plot() %>%
  str()

mtcars %$%
  cor(disp, mpg)

mtcars <- mtcars %>% 
  transform(cyl = cyl * 2)

mtcars %<>% transform(cyl = cyl * 2)
