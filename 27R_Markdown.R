## 27 R Markdown

## ==== 27.2 R Markdown basics

## ---- 27.2.1 Exercises

## ==== 27.3 Text formatting with Markdown

## ---- 27.4.2 Chunk options

## ---- 27.4.3 Table

knitr::kable(
  mtcars[1:5, ], 
  caption = "A knitr kable."
)

## ---- 27.4.4 Caching

## ---- 27.4.5 Global options

comma <- function(x) format(x, digits = 2, big.mark = ",")
comma(3452345)
comma(.12358124331)

## ==== 27.5 Troubleshooting

## ==== 27.6 YAML header

## ---- 27.6.1 Parameters



