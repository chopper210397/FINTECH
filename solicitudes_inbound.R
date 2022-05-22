library(readxl)
library(dplyr)
library(lubridate)
library(ggplot2)
library(tidyr)
library(tidytext)
library(writexl)
# link del trabajo: https://docs.google.com/spreadsheets/d/1NTLgngraiUbJValH80b0-eGm_n6T8FJN46PkB9o9bBs/edit?usp=sharing

comentarios<-read_xlsx("comentarios.xlsx")
comments_only<-comentarios %>% select(comentarios)

words<-comments_only %>% unnest_tokens(word,comentarios) %>% count(word,sort = TRUE) %>% mutate(word = reorder(word, n)) 

stopwords_es <- read.csv("https://bitsandbricks.github.io/data/stopwords_es.csv",
                         stringsAsFactors = FALSE)

words_tokenizado <- words %>% 
  anti_join(stopwords_es, by = c("word" = "STOPWORD"))


write_xlsx(words_tokenizado,"words.xlsx")
