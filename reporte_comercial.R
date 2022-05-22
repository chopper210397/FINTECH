# reporte comercial aflore
library(readr)
library(readxl)
library(lubridate)
library(dplyr)
library(ggplot2)
library(tidyr)
library(purrr)
library(forcats)
#-------------------------------------------------------------------#
#---------------------------- ACTIVACIÓN ---------------------------#
#-------------------------------------------------------------------#

vinculado<-read.csv("consejerovinculado1.csv",sep = ",")
                     

# vinculado<-read_xlsx("consejerovinculado.xlsx",
#                      col_types = c("numeric","numeric","text","numeric","text","numeric","text","text","text","numeric"))
# str(vinculado)
unique(vinculado$Fecha.de.vinculacion)
zonas<-unique(vinculado$Zona)
zonas<-data.frame(zonas)
zonas<-zonas %>% arrange(zonas)

colnames(vinculado)[10]<-"Constante"
# damos formato a la fecha
vinculado$Fecha.de.vinculacion<-as.Date(vinculado$Fecha.de.vinculacion, format = "%d/%m/%Y")
vinculado<-vinculado %>% mutate(mes=month(Fecha.de.vinculacion))
vinculado$mes<-as.factor(vinculado$mes)
# levels(vinculado$mes)<-c("enero","febrero","marzo","abril")
# graficando

vinculado%>% count(Coordinador)  %>% filter(Coordinador!="NA")%>%
  ggplot(aes(x= Coordinador,y=n,label=n))+geom_bar(stat = "identity",fill="brown")+coord_flip()+labs(x="",y="")+
  geom_text()
ggsave("coordinador.png",dpi = 700,height = 6,width = 7)
# por cada tipo de perfil que porcentaje se convierte con gestion comercial y que 
# porcentaje se activa con gestion comercial
# toda la info que tenemos agrega valor si es con gestion comercial sino eso lo revisa lina
# su hipotesis es uqe los especialistas no requieren gestion comercial

vinculado1<-read.csv("zz.csv")
vinculado1<-vinculado1 %>% mutate(mes=month(Fecha.de.vinculacion))
# coordinador por perfil para abril
vinculado1 %>%  filter(Coordinador!="NA")%>% filter(Perfil!="NA") %>%
  ggplot(aes(x=Coordinador,y=Constante,fill=Perfil))+geom_bar(stat = "identity") +coord_flip()+
  theme_minimal()

vinculado1 %>% filter(Coordinador!="NA")%>% filter(Perfil!="") %>%
  count(Coordinador,Perfil) %>% ggplot(aes(x=n,y=Coordinador,fill=Perfil,label=n))+
  geom_bar(stat = "identity",position = "dodge2")+geom_text(position = position_dodge(width = .75))

ggsave("coordinadorperfil.png",dpi = 300,height = 8,width = 8)
# coordinador separado por perfil y mes
vinculado1 %>% filter(Coordinador!="NA")%>% filter(Perfil!="NA")%>%
  ggplot(aes(x=Coordinador,y=Constante,color=mes))+geom_bar(stat = "identity")+coord_flip()+
  theme_minimal()+facet_grid(Perfil ~ mes)+theme(legend.position = "none")+labs(x="",y="")


vinculado1 %>% filter(Coordinador!="NA")%>% filter(Perfil!="NA") %>%
  count(Perfil,mes,Coordinador)  %>% ggplot(aes(x=n,y=Coordinador,fill=mes,label=n))+
  geom_bar(stat = "identity",position = "dodge" )+geom_vline(xintercept = 100,linetype="dashed")+
  geom_vline(xintercept = 150,linetype="dashed")+geom_vline(xintercept = 125,linetype="dashed",color="gray")

vinculado1 %>% filter(!Coordinador %in% c("Sandra Herrera","Olga Lucia Alvarado",""))%>% filter(Perfil!="") %>%
  count(Perfil,mes,Coordinador)  %>% ggplot(aes(x=n,y=Coordinador,fill=as.factor(mes),label=n))+
  geom_bar(stat = "identity",position = "dodge" )+geom_vline(xintercept = 100,linetype="dashed")+
  geom_vline(xintercept = 125,linetype="dashed",color="gray")+
  facet_grid(~Perfil)+geom_text(position = position_dodge(width = 1))


ggsave("coordinadorperfilymes.png",dpi = 300,height = 7,width = 8)
# coordinador separado por  mes
vinculado1 %>% filter(!Coordinador %in% c("Sandra Herrera","Olga Lucia Alvarado",""))%>% filter(Perfil!="")%>%
  ggplot(aes(x=Coordinador,y=Constante,color=as.factor(mes)))+geom_bar(stat = "identity")+coord_flip()+
  theme_minimal()+facet_wrap(.~ mes,nrow = 1)+theme(legend.position = "none")+labs(x="",y="")

vinculado1 %>% filter(!Coordinador %in% c("Sandra Herrera","Olga Lucia Alvarado","")) %>%
  count(Coordinador,mes) %>% ggplot(aes(x=Coordinador,y=n,fill=as.factor(mes),label=n))+
  geom_bar(stat = "identity",position ="dodge")+coord_flip()+geom_text(position = position_dodge(width = 1))

ggsave("coordinadormes.png",dpi = 300,height = 7,width = 8)


vinculado %>% filter(Coordinador!="NA")%>% filter(Perfil!="NA")%>%
  ggplot(aes(x=mes,y=Constante))+geom_bar(stat = "identity")+coord_flip()+theme_minimal()

vinculado %>% filter(Coordinador!="NA")%>% filter(Perfil!="NA")%>%
  ggplot()+geom_bar(aes(x=mes,y=Constante,fill=mes),stat = "identity")+
  labs(title = "Consejeros vinculados por mes",x="",y="")+ theme_minimal()

vinculado1 %>% filter(Coordinador!="NA")%>% filter(Perfil!="NA")%>% count(mes,Constante) %>% 
  ggplot(aes(x=as.factor(mes),y=n,label=n))+geom_bar(stat = "identity",fill="lightblue")+geom_text()+
  labs(x="mes",y="",title = "Consejeros vinculados por mes")
                    
ggsave("consejerospormes.png",dpi = 700)


vinculado %>% filter(Coordinador!="NA")%>% filter(Perfil!="NA")%>%
  ggplot()+ geom_bar(aes(x=Zona))+coord_flip()

#seleccionando para abril
top20zonas<-zonas[1:20,]
top40zonas<-zonas[1:40,]
zona3meses[1:20,]
top20zonas<-as.data.frame(top20zonas)
# seleccionando el top 20 zonas para poner en el gráfico
top20zonas<-(vinculado1 %>% count(Zona) %>% arrange(-n) %>% slice_head(n=20))[1]

vinculado1 %>% filter(Zona %in% top20zonas$Zona) %>% count(Zona,mes) %>% arrange(-n) %>%
  ggplot(aes(x = n,y=reorder(Zona,n),fill=as.factor(mes),label=n))+
  geom_bar(stat = "identity",position = "dodge")+
  labs(x="cantidad de vinculados",y="",title = "Cantidad de vinculados por zona al 10" )+
  geom_text(position = position_dodge(width = 1))

ggsave("vinculadosporzonaultimosdosmeses.png",dpi = 700,width = 7,height = 8)


zonas<-vinculado %>%filter(mes=="4") %>%  filter(Coordinador!="NA")%>% filter(Perfil!="NA")%>%
  count(Zona) %>% arrange(-n)

zona3meses<-vinculado  %>%  filter(Coordinador!="NA")%>% filter(Perfil!="NA")%>% group_by(mes) %>% 
  count(Zona) %>% arrange(mes,-n)

# zona por mes
vinculado %>%  filter(Coordinador!="NA")%>% filter(Perfil!="NA") %>%
  filter(Zona %in% unique(top20zonas$top20zonas)) %>% count(mes,Zona) %>%
  ggplot(aes(x=n,y=reorder(Zona,n),fill=mes,label=n))+
  geom_bar(stat = "identity",position = "dodge")+
  labs(x="",y="",title = "Consejeros vinculados por zona de enero a abril")+
  geom_text(position = position_dodge(width = .75))

ggsave("consejerosporzonaeneroabril.png",dpi = 700,height = 10,width = 10)



subset()
unique(top20zonas$Zona)
top20zonas %>% 
  ggplot(aes(x=reorder(Zona,n),y=n))+ geom_bar(stat = "identity",fill="brown")+coord_flip()+
  labs(title = "Top 20 consejeros por zona",x="",y="")
ggsave("top20zonas.png",dpi = 700)

top40zonas %>% 
  ggplot(aes(x=reorder(Zona,n),y=n))+ geom_bar(stat = "identity",fill="brown")+coord_flip()+
  labs(title = "Top 40 consejeros por zona en marzo",x="",y="")

ggsave("top40zonas.png",dpi = 700)


zona3meses %>% 
  ggplot(aes(x=reorder(Zona,n),y=n))+ geom_bar(stat = "identity",fill="brown")+coord_flip()+
  labs(title = "Top 40 consejeros por zona en marzo",x="",y="")+facet_grid(.~mes)
