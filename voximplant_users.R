library(readxl)
library(dplyr)
library(lubridate)
library(tidyr)
library(writexl)
library(ggplot2)
library(plyr)
# extrayendo la data de los usuarios de voximplant kit
data<-read_xlsx("data.xlsx")
a<-seq(1,244,by=4)
b<-seq(2,245,by=4)
c<-seq(3,245,by=4)
d<-seq(4,245,by=4)
nombres<-data[a,1]
correo<-data[b,1]
cargo<-data[c,1]
funcion<-data[d,1]

data_voximplant<-cbind(nombres,correo,cargo,funcion)
colnames(data_voximplant)<-c("nombres","correos","cargos","funcion")
write_xlsx(data_voximplant,"usuariosa_voximplant.xlsx")
#----------------------------------------------------------

data_forms<-read_xlsx("form_medio_tipo.xlsx")

data_forms %>% ggplot(aes(x=tiempo,y=consejero,color=`Medio de contacto`))+geom_line()
data_forms %>% ggplot(aes(x=tiempo,y=cliente,color=`Medio de contacto`))+geom_line()

#----------------------------------------------------------
gestion<-read_xlsx("gestioncomercial.xlsx")
gestion$mes<-as.Date(gestion$mes)

#----- mayo ------#
mayo<-rbind.fill(
gestion %>% filter(mes=="2022-05-01"),
gestion %>% filter(mes=="2022-05-01") %>%
   summarise(mes="mes",`medio de contacto`="medio de contacto",
             actividad=sum(actividad),activacion=sum(activacion),total=sum(total))
)

mayo_tabla<-gestion %>% filter(mes=="2022-05-01") %>% mutate(porcentaje.actividad=actividad/sum(actividad)*100,
                                                 porcentaje.activacion=activacion/sum(activacion)*100,
                                                 porcentaje.total=total/sum(total)*100)

#----- junio ------#
junio<-rbind.fill(
  gestion %>% filter(mes=="2022-06-01"),
  gestion %>% filter(mes=="2022-06-01") %>%
    summarise(mes="mes",`medio de contacto`="medio de contacto",
              actividad=sum(actividad),activacion=sum(activacion),total=sum(total))
)

junio_tabla<-gestion %>% filter(mes=="2022-06-01") %>% mutate(porcentaje.actividad=actividad/sum(actividad)*100,
                                                 porcentaje.activacion=activacion/sum(activacion)*100,
                                                 porcentaje.total=total/sum(total)*100)

write_xlsx( rbind(mayo_tabla,junio_tabla),"porcentajes_mayo_junio.xlsx")
#------------
gestion %>% ggplot(aes(x=mes,y=actividad,color=`medio de contacto`))+geom_line()
