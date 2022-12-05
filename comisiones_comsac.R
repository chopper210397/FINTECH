# paquetes a utilizar
library(dplyr)
library(lubridate)
library(ggplot2)
library(writexl)
library(googlesheets4)
library(tidyr)
library(gmailr)
library(RPostgres)
library(DBI)
library(sqldf)
# install.packages("sqldf")
# install.packages("DBI")
# install.packages("RPostgres")

# leyendo googlesheets
###################################################################
############################### NDA ###############################
###################################################################
# googlesheet con data de voximplant
nda_data<-range_read("https://docs.google.com/spreadsheets/d/1xKqqAhjGRoU7HYXiHoLYg4z7BCVZ76lxXXybaAyU_Y4/edit?usp=sharing",
           sheet = "data",
           col_types = "c_ccnnnnccccccnnnnnc_____n")
1

# sapply(qa_interno_servicio, class)

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
qa_interno_servicio<-range_read("https://docs.google.com/spreadsheets/d/1tYXEEq_34kxoKh0Vo4mfG5aUopC5wbFNyeTXqZqzsL4/edit?usp=sharing",
           sheet = "Form Responses 1",
           col_types = "TccccnncncncccccncDcccccc")
# AUDITORIA INTERNA DE PQRSD
qa_interno_pqrsd<-range_read("https://docs.google.com/spreadsheets/d/1XgXYMt4qjep1_L8JUNCzM7Snfqp5XtnfKEV3DA_4HjU/edit?usp=sharing",
                                sheet = "Form Responses 1",
                                col_types = "TcDccccccnnncnccccccc")
# AUDITORIA INTERNA DE DESEMBOLS´OS
qa_interno_desembolsos<-range_read("https://docs.google.com/spreadsheets/d/1QxJoshRIxD_8tUMMgEOwhD1zaRhWUDX48mcAmuaZMDk/edit?usp=sharing",
                             sheet = "data")
# AUDITORIA INTERNA DE COMERCIAL
qa_interno_comercial<-range_read("https://docs.google.com/spreadsheets/d/1XLl8_naZa89kguxuEGAmbBq7R8tzdN30xncLY_ODxT0/edit?usp=sharing",
                                   sheet = "Form Responses 1",
                                 col_types = "TcccDccccnnccccccnccc")

###################################################################
###################### TIEMPO RESPUESTA PQRSD #####################
###################################################################
# POSGRE CON LA DATA DE LOS TICKETS
conn <- dbConnect(RPostgres::Postgres(), 
                 user="aflore-read-only", 
                 password="2eftvmj67ue",
                 host="afloreprodreplica.cfkkiii2ach9.us-east-1.rds.amazonaws.com", 
                 port=5432, 
                 dbname="aflore-prod")

db_query<-paste("select avg(coalesce(closed_at::date,now()::date) - created_at::date) from business_intelligence.tickets_ayuda_aflore  where (customer ='Luisa Moreno' or "owner" ='Luisa Moreno') and date_trunc('month',created_at)=date_trunc('month',now()-interval '1 month')")

viewDataFrame<-dbGetQuery(conn,db_query)

a<-as.data.frame( dbListTables(conn) )   #list all the tables 



