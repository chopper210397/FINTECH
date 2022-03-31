# DATA VOXIMPLANT _sac_ llamadas
library(scales)
library(readr)
library(readxl)
library(lubridate)
library(dplyr)
library(ggplot2)
library(tidyr)
library(kableExtra)
library(writexl)
# install.packages("writexl")
# historico de llamadas
llamadas<-read_xlsx("voximplant_call_history.xlsx")


 str(llamadas)
# unique(llamadas$`Date of call start`)
unique(llamadas$`Call result message`)

llamadas %>% filter(mes==3)%>%  ggplot(aes(x=`Call result message`))+geom_bar()

incomingcallsmarzo<-llamadas %>% filter(mes==3) %>% count(`Is incoming`) %>% mutate(total=sum(n)) %>%
  mutate(porcentaje=round(n/total*100,1)) %>% select(`Is incoming`,n,porcentaje)

callresultmessagemarzo<-llamadas %>% filter(mes==3 & `Is incoming`=="no")  %>% count(`Call result message`) %>% mutate(suma=sum(n)) %>%
  mutate(porcentaje_total=round(n/suma*100,1)) %>% select(`Call result message`,n,porcentaje_total) %>% 
  arrange(-porcentaje_total) 

#
llamadas$`Date of call start`<-as.Date(llamadas$`Date of call start`)
llamadas<-llamadas %>% mutate(mes=month(`Date of call start`)) 


# 
# unique(llamadas$`Agent B`)
# unique(llamadas$`Agent A`)


llamadas$`Call duration`<-as.numeric(llamadas$`Call duration`)
llamadas$`Call cost`<-as.numeric(llamadas$`Call cost`)
# 
# hist(llamadas$`Call duration`)
# hist(llamadas$`Call cost`)

# solo marzo

a<-llamadas %>% filter(mes=="3" & `Call duration`!="0") %>%  group_by(`Agent A`)%>%  count(`Is incoming`)

a %>% ggplot(aes(x=reorder(`Agent A`,n),y=n))+
  geom_bar(stat = "identity",fill="lightblue")+coord_flip()+facet_grid(.~`Is incoming`)

ggsave("voximplant.png",dpi=800)

juliocesar<-llamadas %>% filter(`Agent A`=="Julio Cesar Osorio")
juliocesarsincero<-llamadas %>% filter(`Agent A`=="Julio Cesar Osorio" & `Call duration`!="0")

#---------- report by agent ----------#
reportbyagent %>% ggplot(aes(x=User,y=))
hist(reportbyagent$Online)
as.Date(reportbyagent$Online)


#------ voximplant por hora -------#
llamadas<-read_xlsx("voximplant_call_history.xlsx")
llamadas<-llamadas %>% mutate(mes=month(`Date of call start`)) 


unique(hour(llamadas$`Date of call start`))

llamadas<-llamadas %>% mutate(hora=hour(llamadas$`Date of call start`))
# llamadas$hora<-parse_date_time(llamadas$hora,"%H")
# seleccionando solo los de servicio para agente A
llamadas %>%filter(mes==3) %>% filter(`Agent A` %in% c("Tatiana Real",
                                     "Leidy Rojas" ,
                                     "Catalina Suarez Camero",
                                     "Laura Nieto",
                                     "Karen Fernandez",
                                     "Eduardo Enrique Sosa Zapata",
                                     "Natalia Piedrahita",
                                     "Luisa Fernanda Moreno Torres")) %>%
  ggplot(aes(x=hora,fill=`Agent A`))+geom_bar()


llamadas %>% filter(mes==3)%>% filter(`Agent A` %in% c("Tatiana Real",
                                     "Leidy Rojas" ,
                                     "Catalina Suarez Camero",
                                     "Laura Nieto",
                                     "Karen Fernandez",
                                     "Eduardo Enrique Sosa Zapata",
                                     "Natalia Piedrahita",
                                     "Luisa Fernanda Moreno Torres")) %>%
  count(`Agent A`) %>% arrange(-n) %>% mutate(total=sum(n)) %>% mutate(porcentaje=round(n/total*100,digits = 1))
# servicio
llamada_servicio<-llamadas %>% filter(mes==3)%>% filter(`Agent A` %in% c("Tatiana Real",
                                                       "Leidy Rojas" ,
                                                       "Catalina Suarez Camero",
                                                       "Laura Nieto",
                                                       "Karen Fernandez",
                                                       "Eduardo Enrique Sosa Zapata",
                                                       "Natalia Piedrahita",
                                                       "Luisa Fernanda Moreno Torres")) %>%
  group_by(hora,`Agent A`) %>% count(`Agent A`) %>% mutate(total=sum(n)) %>%
  mutate(porcentaje=round(n/total*100,digits = 1)) %>% arrange(hora)
# para todo el equipo
# llamadas entrantes por hora
llamadas %>% filter(mes==3) %>% filter(`Is incoming`=="yes") %>% count(hora) %>% ggplot(aes(x=hora,y=n))+geom_bar(stat = "identity",fill="brown")+
  scale_x_continuous(n.breaks = 15)+labs(title = "Llamadas entrantes por hora",y="")
ggsave("llamadasporhorasentrantes.png",dpi = 300)

# llamadas salientes por hora
llamadas %>% filter(mes==3) %>% filter(`Is incoming`=="no") %>% count(hora) %>% ggplot(aes(x=hora,y=n))+geom_bar(stat = "identity",fill="brown")+
  scale_x_continuous(n.breaks = 15)+labs(title = "Llamadas salientes por hora", y="")
ggsave("llamadasporhorassalientes.png",dpi = 300)














# tablas para calcular
# llamadas entrantes
llamadaentranteconteo<-llamadas %>%  filter(mes==3) %>% filter(`Is incoming`=="yes") %>% count(hora) 

write_xlsx(llamadaentranteconteo,"llamadaentranteconteo.xlsx")
# llamadas salientes
llamadasalienteconteo<-llamadas %>% filter(`Call duration`!=0)%>% filter(mes==3) %>% filter(`Is incoming`=="no") %>% count(hora) 
write_xlsx(llamadasalienteconteo,"llamadasalienteconteo.xlsx")
#
llamada_servicio %>% ggplot(aes(x=hora,y=total,fill=`Agent A`))+geom_bar(stat = "identity",position = "dodge2")+
  scale_x_continuous(n.breaks = 11)+labs(y="numero de llamadas salientes",
                                         title = "Número de llamadas salientes para área servicios")+ 
  guides(fill=guide_legend(title="Servicios"))


ggsave("llamadassalientesservicios.png",dpi = 700,width = 12)
# con el siguiente codigo validamos que los de servicio solo contestan entre 8am y 6pm
llamadas %>% filter(hour(`Date of call start`)==6 & `Agent A` %in% c("Tatiana Real",
                                                                     "Leidy Rojas" ,
                                                                     "Catalina Suarez Camero",
                                                                     "Laura Nieto",
                                                                     "Karen Fernandez",
                                                                     "Eduardo Enrique Sosa Zapata",
                                                                     "Natalia Piedrahita",
                                                                     "Luisa Fernanda Moreno Torres"))


llamadasduracion<-llamadas %>% filter(`Call duration`!=0)

