# DATA VOXIMPLANT _sac_ llamadas

library(readr)
library(readxl)
library(lubridate)
library(dplyr)
library(ggplot2)
library(tidyr)

llamadas<-read_xlsx("voximplant.xlsx")

str(llamadas)

llamadas$`Call duration`<-as.numeric(llamadas$`Call duration`)
llamadas$`Call cost`<-as.numeric(llamadas$`Call cost`)

hist(llamadas$`Call duration`)
hist(llamadas$`Call cost`)
