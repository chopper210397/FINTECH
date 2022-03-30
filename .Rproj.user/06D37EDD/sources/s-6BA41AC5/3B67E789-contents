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
unique(vinculado$`Fecha de vinculacion`)
zonas<-unique(vinculado$Zona)
zonas<-data.frame(zonas)
zonas<-zonas %>% arrange(zonas)


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


vinculado %>% filter(Coordinador!="NA")%>% filter(Perfil!="NA")%>%
  ggplot(aes(x=mes,y=Constante))+geom_bar(stat = "identity")+coord_flip()+theme_minimal()

vinculado %>% filter(Coordinador!="NA")%>% filter(Perfil!="NA")%>%
  ggplot()+geom_bar(aes(x=mes,y=Constante,fill=mes),stat = "identity")+
  labs(title = "Consejeros vinculados por mes",x="",y="")+ theme_minimal()

ggsave("consejerospormes.png",dpi = 700)


vinculado %>% filter(Coordinador!="NA")%>% filter(Perfil!="NA")%>%
  ggplot()+ geom_bar(aes(x=Zona))+coord_flip()

#seleccionando para marzo
zonas<-vinculado %>%filter(mes=="marzo") %>%  filter(Coordinador!="NA")%>% filter(Perfil!="NA")%>%
  count(Zona) %>% arrange(-n)

zona3meses<-vinculado  %>%  filter(Coordinador!="NA")%>% filter(Perfil!="NA")%>% group_by(mes) %>% 
  count(Zona) %>% arrange(mes,-n)


top20zonas<-zonas[1:20,]
top40zonas<-zonas[1:40,]
zona3meses[1:20,]
subset()

top20zonas %>% 
  ggplot(aes(x=reorder(Zona,n),y=n))+ geom_bar(stat = "identity",fill="brown")+coord_flip()+
  labs(title = "Top 20 consejeros por zona",x="",y="")

top40zonas %>% 
  ggplot(aes(x=reorder(Zona,n),y=n))+ geom_bar(stat = "identity",fill="brown")+coord_flip()+
  labs(title = "Top 40 consejeros por zona en marzo",x="",y="")

ggsave("top40zonas.png",dpi = 700)


zona3meses %>% 
  ggplot(aes(x=reorder(Zona,n),y=n))+ geom_bar(stat = "identity",fill="brown")+coord_flip()+
  labs(title = "Top 40 consejeros por zona en marzo",x="",y="")+facet_grid(.~mes)
