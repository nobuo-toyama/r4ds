## 8 Workflow: projects

## ==== 8.1 What is real?

## ==== 8.2 Where does your analysis live?

## ==== 8.3 Paths and directories

## ====8.4 RStudio projects

library(tidyverse)

ggplot(diamonds, aes(carat, price)) + 
    geom_hex()
ggsave("diamonds.pdf")

write_csv(diamonds, "diamonds.csv")

## ==== 8.5 Summary
