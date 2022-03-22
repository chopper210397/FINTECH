#------------------------------------------------------------#
#------------------------------------------------------------#
#------- ANALISIS CRÉDITOS, CAUSAS Y CONSECUENCIAS ----------# 
#------------------------------------------------------------#
#------------------------------------------------------------#

library(readr)
library(readxl)
library(lubridate)
library(dplyr)
library(ggplot2)
library(tidyr)

creditos<-read_xlsx("solicitudes_creditos.xlsx")
str(creditos)
unique(creditos3$`estado solicitud`)
unique(creditos$`fecha actualizacion`)
# formateando la data
creditos$`fecha creacion`<-as.Date(creditos$`fecha creacion`)
creditos$`fecha actualizacion`<-as.Date(creditos$`fecha actualizacion`)
creditos$`monto solicitado cliente`<-as.numeric(creditos$`monto solicitado cliente`)

#
creditos2<-creditos %>% group_by(`fecha actualizacion`,`estado solicitud`) %>%
  dplyr::summarise(montosolicitado=n(`monto solicitado cliente`),montoaprobado=n(`monto aprobado`)) %>%
  arrange(`fecha actualizacion`)

creditos %>% group_by(`fecha actualizacion`,`estado solicitud`) %>%
  count(`monto solicitado cliente`,`monto aprobado`) %>% 
  arrange(`fecha actualizacion`)

#------------------------------#
#        2021 - 2022           #
#------------------------------#

# numero de aprobados, desaprobados, etc por estado solicitud desde 2021 a actualidad
creditos3<-creditos %>% count(`fecha actualizacion`,`estado solicitud`) %>% arrange(`fecha actualizacion`)

# todos los estados de solicitud incluidos
creditos3  %>% ggplot(aes(x=`fecha actualizacion`,y=n))+
  geom_line()+facet_wrap(.~`estado solicitud`)

# abandonado
creditos3 %>% filter(`estado solicitud`%in% c("Abandonado")) %>% ggplot(aes(x=`fecha actualizacion`,y=n))+
  geom_line()+facet_wrap(.~`estado solicitud`)

# grid por estado solicitud desde 2021 para la data mas larga
creditos3 %>% filter(`estado solicitud`%in% c("Aprobado","Denegado","Retirado","Vencido")) %>% ggplot(aes(x=`fecha actualizacion`,y=n))+
  geom_line()+facet_grid(.~`estado solicitud`)

# grid por estado solicitud desde 2021 para la data mas larga
creditos3 %>% filter(`estado solicitud`%in% c("En proceso")) %>% ggplot(aes(x=`fecha actualizacion`,y=n))+
  geom_line()+facet_grid(.~`estado solicitud`)

# grid por estado solicitud desde 2021 para la data mas larga
creditos3 %>% filter(`estado solicitud`%in% c("Aprobado")) %>% ggplot(aes(x=`fecha actualizacion`,y=n))+
  geom_line()+facet_grid(.~`estado solicitud`)


#------------------------------#
#            2022              #
#------------------------------#

# numero de aprobados, desaprobados, etc por estado solicitud desde 2021 a actualidad
creditos2022<-creditos %>% filter(`fecha actualizacion`>"2022-01-01") %>%  count(`fecha actualizacion`,`estado solicitud`) %>%
  arrange(`fecha actualizacion`)

# todos los estados de solicitud incluidos
creditos2022  %>% ggplot(aes(x=`fecha actualizacion`,y=n))+
  geom_line()+facet_wrap(.~`estado solicitud`)

# abandonado
creditos2022 %>% filter(`estado solicitud`%in% c("Abandonado")) %>% ggplot(aes(x=`fecha actualizacion`,y=n))+
  geom_line()+facet_wrap(.~`estado solicitud`)

# grid por estado solicitud desde 2021 para la data mas larga
creditos2022 %>% filter(`estado solicitud`%in% c("Aprobado","Denegado","Retirado","Vencido")) %>% ggplot(aes(x=`fecha actualizacion`,y=n))+
  geom_line()+facet_grid(.~`estado solicitud`)

# grid por estado solicitud desde 2021 para la data mas larga
creditos2022 %>% filter(`estado solicitud`%in% c("En proceso")) %>% ggplot(aes(x=`fecha actualizacion`,y=n))+
  geom_line()+facet_grid(.~`estado solicitud`)

# grid por estado solicitud desde 2021 para la data mas larga
creditos2022 %>% filter(`estado solicitud`%in% c("Aprobado")) %>% ggplot(aes(x=`fecha actualizacion`,y=n))+
  geom_line()+facet_grid(.~`estado solicitud`)
