# reporte comercial aflore
library(readr)
library(readxl)
library(lubridate)
library(dplyr)
library(ggplot2)
library(tidyr)

#-------------------------------------------------------------------#
#---------------------------- ACTIVACIÓN ---------------------------#
#-------------------------------------------------------------------#

vinculado<-read_xlsx("consejerovinculado.xlsx",sheet = "data",
                     col_types = c("numeric","numeric","text","numeric","text","numeric","text","text","text","numeric","text"))
str(vinculado)

# damos formato a la fecha
vinculado$`Fecha de vinculacion`<-as.Date(vinculado$`Fecha de vinculacion`, format = "%d/%m/%Y")

# graficando

vinculado %>% ggplot(aes(x= Coordinador))+geom_bar()+coord_flip()

# coordinador por perfil
vinculado %>% filter(Coordinador!="NA")%>% filter(Perfil!="NA") %>% ggplot(aes(x=Coordinador,y=Constante,fill=Perfil))+geom_bar(stat = "identity")+coord_flip()+theme_minimal()

ggsave("coordinadorperfil.png",dpi = 300)
# coordinador separado por perfil y mes
vinculado %>% filter(Coordinador!="NA")%>% filter(Perfil!="NA")%>%
  ggplot(aes(x=Coordinador,y=Constante,color=mes))+geom_bar(stat = "identity")+coord_flip()+
  theme_minimal()+facet_grid(Perfil ~ mes)

ggsave("coordinadorperfilymes.png",dpi = 300)
# coordinador separado por  mes
vinculado %>% filter(Coordinador!="NA")%>% filter(Perfil!="NA")%>%
  ggplot(aes(x=Coordinador,y=Constante,color=mes))+geom_bar(stat = "identity")+coord_flip()+
  theme_minimal()+facet_wrap(.~ mes,nrow = 1)

ggsave("coordinadormes.png",dpi = 300)



