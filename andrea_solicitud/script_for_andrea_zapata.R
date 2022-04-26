library(tidyverse)
library(readxl)
applications_bi<-read_xlsx("applications_bi.xlsx")
gestioncomercial<-read_xlsx("gestion_comercial.xlsx")
# filtering needed values
applications_bi<-applications_bi %>% select(ID,`Client ID`,`Created At`,Status,
                           `Client Document Number`,`Client Type Request`,
                           `Advisor ID`,`Client Type Request New`,`Aflore Product ID`)
gestioncomercial<-gestioncomercial %>% select(`Nombre Asesor`,`Numero De Documento`,
                                              Timestamp,`Nombre Asesor`,`Tipo De Persona`,`Medio De Contacto`)
# joins

newdata<-applications_bi %>% inner_join(gestioncomercial,by = c("Client Document Number"="Numero De Documento"))
# filtering again
newdata %>% ggplot(aes(x=`Tipo De Persona`))+geom_bar()
newdata %>% filter(`Tipo De Persona`=="Cliente" & `Client Type Request`=="Nuevo" & 
                     `Advisor ID` %in% c('23296','26508', '23313') & `Client Type Request New`=="Cliente directo")

# plots
gestioncomercial %>% ggplot(aes(x=`Medio De Contacto`,fill=`Tipo De Persona`))+geom_bar(position = "dodge2")


