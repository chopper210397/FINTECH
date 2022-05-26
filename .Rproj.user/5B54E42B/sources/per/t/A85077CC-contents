library(readxl)
library(dplyr)
library(lubridate)
library(ggplot2)
library(stringr)
library(readr)
# install.packages("googlesheets4")
library(googlesheets4)
library(google)

not_interested<-read_xlsx("Solicitudes e informacion Sac .xlsx",sheet = "No interesados ")
# variables interesantes a primera vista:
# fecha, tipo, comentario, causa de desestimiento,  monto aprobado, producto, plazo
# ------------- WORKING DATA ----------------#
not_interested$`Monto Aprobado`<-str_replace(not_interested$`Monto Aprobado`,"COP ","")
not_interested$`Monto Aprobado`<-as.numeric(not_interested$`Monto Aprobado`)
#----------------------- toda la data -----------------------------# desde 2020
not_interested %>% count(`Causa de Desistimiento`) %>% arrange(-n)
not_interested %>% count(TIPO) %>% arrange(-n)
not_interested %>% count(`Monto Aprobado`) %>% arrange(-n)
not_interested %>% count(Producto) %>% arrange(-n)
not_interested %>% count(PLAZO) %>% arrange(-n)
#-----------------------ultimo año --------------------------------
