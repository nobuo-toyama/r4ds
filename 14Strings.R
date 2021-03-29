## 14 Strings

## ==== 14.1 Introduction
## --- 14.1.1 Prerequisites

library(tidyverse) # --> strinr

## ==== 14.2 String basics

string1 <- "This is a string"
string2 <- 'If I want to include a "quote" inside a string, I use single quotes'

double_quote <- "\"" # or '"'
single_quote <- '\'' # or "'"

x <- c("\"", "\\")
x
writeLines(x)

x <- "\u00b5"
x

c("one", "two", "three")

## ---- 14.2.1 String length

str_length(c("a", "R for data science", NA))

## ---- 14.2.2 Combining strings

str_c("x", "y")
str_c("x", "y", "z")

str_c("x", "y", sep = ", ")

x <- c("abc", NA)
str_c("|-", x, "-|")
str_c("|-", str_replace_na(x), "-|")

str_c("prefix-", c("a", "b", "c"), "-suffix")

name <- "Hadley"
time_of_day <- "morning"
birthday <- FALSE

str_c(
  "Good ", time_of_day, " ", name,
  if (birthday) " and HAPPY BIRTHDAY",
  "."
)

str_c(c("x", "y", "z"), collapse = ", ")


## ---- 14.2.3 Subsetting strings

x <- c("Apple", "Banana", "Pear")
str_sub(x, 1, 3)
str_sub(x, -3, -1)

## Note that str_sub() won’t fail if the string is too short:
## it will just return as much as possible:
str_sub("a", 1, 5)

## You can also use the assignment form of str_sub() to modify strings:
str_sub(x, 1, 1) <- str_to_lower(str_sub(x, 1, 1))
x

## ---- 14.2.4 Locales

## Turkish has two i's: with and without a dot, and it
## has a different rule for capitalising them:
str_to_upper(c("i", "ı"))
str_to_upper(c("i", "ı"), locale = "tr")

##  you may want to use str_sort() and str_order()
## which take an additional locale argument:

x <- c("apple", "eggplant", "banana")

str_sort(x, locale = "en")  # English
str_sort(x, locale = "haw") # Hawaiian

## ---- 14.2.5 Exercises

help(str_wrap)
help(str_trim)

## ==== 14.3 Matching patterns with regular expressions

## ---- 14.3.1 Basic matches

## The simplest patterns match exact strings:

x <- c("apple", "banana", "pear")
str_view(x, "an")   #  htmlwidgets package required for str_view().

## The next step up in complexity is .,
## which matches any character (except a newline):
str_view(x, ".a.")

## To create the regular expression, we need \\
dot <- "\\."

## But the expression itself only contains one:
writeLines(dot)

## And this tells R to look for an explicit .
str_view(c("abc", "a.c", "bef"), "a\\.c")

## To match a literal \ you need to write "\\\\"
## — you need four backslashes to match one!

x <- "a\\b"
writeLines(x)

str_view(x, "\\\\")

## ---- 14.3.1.1 Exercises

## ---- 14.3.2 Anchors

## '^' to match the start of the string.
## '$' to match the end of the string.
## If you begin with power (^), you end up with money ($).

x <- c("apple", "banana", "pear")
str_view(x, "^a")
str_view(x, "a$")

## To only match a complete string, anchor it with both ^ and $

x <- c("apple pie", "apple", "apple cake")
str_view(x, "apple")
str_view(x, "^apple$")

## ---- 14.3.2.1 Exercises

str_view(words, "^y", match = TRUE)
str_view(words, "x$", match = TRUE)

## ---- 14.3.3 Character classes and alternatives

## \d: matches any digit.
## \s: matches any whitespace (e.g. space, tab, newline).
## [abc]: matches a, b, or c.
## [^abc]: matches anything except a, b, or c.

## for a literal character that normally has
## special meaning in a regex

str_view(c("abc", "a.c", "a*c", "a c"), "a[.]c")
str_view(c("abc", "a.c", "a*c", "a c"), ".[*]c")
str_view(c("abc", "a.c", "a*c", "a c"), "a[ ]")

## You can use alternation to pick between one or more alternative patterns.
## For example, abc|d..f will match either ‘“abc”’, or "deaf".

str_view(c("grey", "gray"), "gr(e|a)y")

## ---- 14.3.3.1 Exercises

## ---- 14.3.4 Repetition

## how many times a pattern matches:

## ?: 0 or 1
## +: 1 or more
## *: 0 or more

x <- "1888 is the longest year in Roman numerals: MDCCCLXXXVIII"
str_view(x, "CC?")
str_view(x, "CC+")
str_view(x, "C[LX]+")

## You can also specify the number of matches precisely:

## {n}: exactly n
## {n,}: n or more
## {,m}: at most m
## {n,m}: between n and m

## By default these matches are “greedy”:
## they will match the longest string possible.

str_view(x, "C{2}")
str_view(x, "C{2,}")
str_view(x, "C{2,3}")

## You can make them “lazy”, matching the shortest string possible
## by putting a ? after them.

str_view(x, "C{2,3}?")
str_view(x, "C[LX]+?")

## ---- 14.3.4.1 Exercises

## ---- 14.3.5 Grouping and backreferences

## The following regular expression finds all fruits
## that have a repeated pair of letters.

str_view(stringr::fruit, "(..)\\1", match = TRUE)

## ---- 14.3.5.1 Exercises

## ==== 14.4 Tools

## Instead of creating one complex regular expression,
## it’s often easier to write a series of simpler regexps.

## ---- 14.4.1 Detect matches

## To determine if a character vector matches a pattern,
## use str_detect().

x <- c("apple", "banana", "pear")
str_detect(x, "e")

## How many common words start with t?
sum(str_detect(words, "^t"))

## What proportion of common words end with a vowel?
mean(str_detect(words, "[aeiou]$"))
mean(str_detect(words, "[^aeiou]$")) # consonant

## When you have complex logical conditions
## it’s often easier to combine multiple str_detect() calls
## with logical operators.

## Find all words containing at least one vowel, and negate(top "!")
no_vowels_1 <- !str_detect(words, "[aeiou]")
words[no_vowels_1]

## Find all words consisting only of consonants (non-vowels)
no_vowels_2 <- str_detect(words, "^[^aeiou]+$")
words[no_vowels_2]

identical(no_vowels_1, no_vowels_2)

## The results are identical,
## but I think the first approach is significantly easier to understand.

words[str_detect(words, "x$")]
str_subset(words, "x$")

df <- tibble(
    word = words,
    i = seq_along(word)
)
df %>%
    filter(str_detect(word, "x$"))

## A variation on str_detect() is str_count():
## rather than a simple yes or no,
## it tells you how many matches there are in a string:

x <- c("apple", "banana", "pear")
str_count(x, "a")

## On average, how many vowels per word?

mean(str_count(words, "[aeiou]"))

## It’s natural to use str_count() with mutate():

df %>%
    mutate(
        vowels = str_count(word, "[aeiou]"),
        consonants = str_count(word, "[^aeiou]")
  )

## Note that matches never overlap.

str_count("abababa", "aba")
str_view_all("abababa", "aba")

## ---- 14.4.1.1 Exercises

## 1

## 1.1 Find all words that start or end with x

ans <- words[str_detect(words, "^x") | str_detect(words, "x$") ]
ans

## 1.2 Find all words that start with a vowel
## and end with a consonant.

ans <- words[str_detect(words, pattern = "^[aeiou]") &
             str_detect(words, pattern = "[^aeiou]$")]
head(ans)
tail(ans)

## 1.3 Are there any words that contain
## at least one of each different vowel?

## 2 What word has the highest number of vowels?
## What word has the highest proportion of vowels?
## (Hint: what is the denominator?)

words[which.max(str_count(words, "[aeiou]"))]
words[which.max(str_count(words, "[aeiou]") / str_length(words))]

## ---- 14.4.2 Extract matches

## To extract the actual text of a match, use str_extract().

length(sentences)
head(sentences)

## Imagine we want to find all sentences that contain a colour.
## We first create a vector of colour names,
## and then turn it into a single regular expression:

colours <- c("red", "orange", "yellow", "green", "blue", "purple")
colour_match <- str_c(colours, collapse = "|")
colour_match

## Now we can select the sentences that contain a colour,
## and then extract the colour to figure out which one it is:

has_colour <- str_subset(sentences, colour_match)
matches <- str_extract(has_colour, colour_match)
head(matches)

## Note that str_extract() only extracts the first match.
## We can see that most easily by first selecting all the sentences
## that have more than 1 match:

more <- sentences[str_count(sentences, colour_match) > 1]
str_view_all(more, colour_match)

str_extract(more, colour_match)

## This is a common pattern for stringr functions,
## because working with a single match allows you to use
## much simpler data structures. To get all matches, use str_extract_all().

str_extract_all(more, colour_match)

## If you use simplify = TRUE, str_extract_all() will return a matrix
## with short matches expanded to the same length as the longest:

str_extract_all(more, colour_match, simplify = TRUE)

x <- c("a", "a b", "a b c")
str_extract_all(x, "[a-z]", simplify = TRUE)

## ---- 14.4.2.1 Exercises

## 1
## In the previous example, you might have noticed
## that the regular expression matched “flickered”, which is not a colour.
## Modify the regex to fix the problem.

# ???

## 2 From the Harvard sentences data, extract:
## 2.1 The first word from each sentence.

str_extract(sentences, "^[A-Z][a-z]*")
tail(sentences)

## 2.2 All words ending in ing.

head(str_extract(words, "^[A-Za-z]+ing$"), 10)
head(str_extract(sentences, "[A-Za-z]*[ing]"), 10)
head(str_extract_all(sentences, "^.*[ing]$", simplify = TRUE))
str_extract_all(sentences, "^.*ing$", simplify = TRUE)

## To Do: Try later again!!! 

## 2.3 All plurals.

head(str_extract(sentences, "^.*s$"))
str_extract_all(sentences, "[A-Z][a-z]+s$", simplify = TRUE)

## To Do: Try later again!!!

## ---- 14.4.3 Grouped matches 

## You can also use parentheses to extract parts of a complex match.
## For example, imagine we want to extract nouns from the sentences.
## As a heuristic, we’ll look for any word that comes after “a” or “the”.

noun <- "(a|the) ([^ ]+)"

has_noun <- sentences %>%
    str_subset(noun) %>%
    head(10)
has_noun %>% 
    str_extract(noun)

has_noun %>% 
  str_match(noun)


tibble(sentence = sentences) %>% 
  tidyr::extract(
    sentence, c("article", "noun"), "(a|the) ([^ ]+)", 
    remove = FALSE
  )

## ---- 14.4.4 Replacing matches

x <- c("apple", "pear", "banana")
str_replace(x, "[aeiou]", "-")

str_replace_all(x, "[aeiou]", "-")

x <- c("1 house", "2 cars", "3 people")
str_replace_all(x, c("1" = "one", "2" = "two", "3" = "three"))

sentences %>% 
  str_replace("([^ ]+) ([^ ]+) ([^ ]+)", "\\1 \\3 \\2") %>% 
  head(5)

## ---- 14.4.5 Splitting

sentences %>%
  head(5) %>% 
  str_split(" ")

"a|b|c|d" %>% 
  str_split("\\|") %>% 
  .[[1]]

sentences %>%
  head(5) %>% 
  str_split(" ", simplify = TRUE)

fields <- c("Name: Hadley", "Country: NZ", "Age: 35")
fields %>% str_split(": ", n = 2, simplify = TRUE)

x <- "This is a sentence.  This is another sentence."
str_view_all(x, boundary("word"))


str_split(x, " ")[[1]]

str_split(x, boundary("word"))[[1]]

## ==== 14.5 Other types of pattern

# The regular call:
str_view(fruit, "nana")
# Is shorthand for
str_view(fruit, regex("nana"))

bananas <- c("banana", "Banana", "BANANA")
str_view(bananas, "banana")

str_view(bananas, regex("banana", ignore_case = TRUE))

x <- "Line 1\nLine 2\nLine 3"
str_extract_all(x, "^Line")[[1]]

str_extract_all(x, regex("^Line", multiline = TRUE))[[1]]

phone <- regex("
  \\(?     # optional opening parens
  (\\d{3}) # area code
  [) -]?   # optional closing parens, space, or dash
  (\\d{3}) # another three numbers
  [ -]?    # optional space or dash
  (\\d{3}) # three more numbers
  ", comments = TRUE)

str_match("514-791-8141", phone)
