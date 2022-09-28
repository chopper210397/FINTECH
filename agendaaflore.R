library(googlesheets4)
library(dplyr)
library(lubridate)
library(tidyr)
install.packages("mailR")

nelson_rubio<-range_read("https://docs.google.com/spreadsheets/d/1QNXBhd_MWTbQFaYo_tw0O2WIWA1mzLNb8ZhyvjdEXcs/edit?usp=sharing",sheet = "Nelson Rubio",
                         col_types = "Dcccccc")
1