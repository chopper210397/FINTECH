# paquetes a utilizar
library(dplyr)
library(lubridate)
library(ggplot2)
library(writexl)
library(googlesheets4)
library(tidyr)
library(gmailr)

# leyendo googlesheets
###################################################################
############################### NDA ###############################
###################################################################
# googlesheet con data de voximplant
nda_data<-range_read("https://docs.google.com/spreadsheets/d/1xKqqAhjGRoU7HYXiHoLYg4z7BCVZ76lxXXybaAyU_Y4/edit?usp=sharing",
           sheet = "data",
           col_types = "c_ccnnnnccccccnnnnnc_____n")
1

# sapply(qa_externo_data, class)

nda_data$`Date from`<-ymd_hms(nda_data$`Date from`,tz=Sys.timezone())

###################################################################
############################ QA EXTERNO ###########################
###################################################################
# googlesheet con data de los c-sat enviados
qa_externo_data<-range_read("https://docs.google.com/spreadsheets/d/1CNdsejB5HRBYDAj6pajzfpjE60_BBSf2uA_KRWAkJPc/edit?usp=sharing",
            sheet="historic_data_by_agent")

###################################################################
############################ QA INTERNO ###########################
###################################################################
# AUDITORIA INTERNA DE SERVICIO

# AUDITORIA INTERNA DE PQRSD

# AUDITORIA INTERNA DE DESEMBOLS´OS

# AUDITORIA INTERNA DE COMERCIAL
