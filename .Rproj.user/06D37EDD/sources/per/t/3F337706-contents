# 1 al 31 de marzo
library(readr)
library(readxl)
library(lubridate)
library(dplyr)
library(ggplot2)
library(tidyr)

actividad<-read_csv("kpi_actividad.csv")

str(actividad)
names(actividad)
unique(actividad$`Nombres de medidas`)

# actividad %>% filter(`Coordinador virtual`!="Total")%>%
#   ggplot(aes(x=`Coordinador virtual`,y=`Valores de medidas`,fill=`Nombres de medidas`))+
#   geom_bar(stat = "identity",position = "dodge2")


actividad %>% filter(`Nombres de medidas`%in% c("% RR Creditos Renovacion",
                                                "% IAS con Credito Renovacion",
                                                "% RR Creditos Nuevos",
                                                "% IAS con Credito Nuevo",
                                                "% RR Creditos Total",
                                                "% IAS con Credito Total")) %>%
  filter(`Coordinador virtual`!="Total")%>%
  ggplot(aes(x=`Coordinador virtual`,y=`Valores de medidas`,fill=`Nombres de medidas`))+
  geom_bar(stat = "identity",position = "dodge2")+geom_hline(yintercept = 1,linetype='dashed')

ggsave("actividadporcentajeskpi.png", dpi=800,width = 14,height = 7)


# analisis por totales de kpis actividad
actividad %>% filter(`Nombres de medidas`%in% c("% RR Creditos Renovacion",
                                                "% IAS con Credito Renovacion",
                                                "% RR Creditos Nuevos",
                                                "% IAS con Credito Nuevo",
                                                "% RR Creditos Total",
                                                "% IAS con Credito Total")) %>%
  filter(`Coordinador virtual`=="Total")%>%
  ggplot(aes(x=`Coordinador virtual`,y=`Valores de medidas`,fill=`Nombres de medidas`))+
  geom_bar(stat = "identity",position = "dodge2")+geom_hline(yintercept = 1,linetype='dashed')+
  labs(title = "Total por kpi actividad en marzo",
       caption = "Resultado de todo el grupo en conjunto",x="",y="")

ggsave("totalactividadporcentajeskpi.png", dpi=800)

#------------------------------------------ gestion prioridades ------------------------------------------#
# esta data tuve que modificarla manualmente ya que tableau no me da el csv como datos
# sino como tabulación, es decir en formato de tabla
prioridades<-read_xlsx("gestion_prioridades.xlsx")

prioridades %>%filter(tipo!="Total general") %>%
  filter(variable %in% c("% Enviando","% Gestionados","% Contactados","% Activos","% Conv Solicitud","% Conv Actv" ) ) %>%
  mutate(numero=numero*100) %>% 
  ggplot(aes(x=variable,y=numero,fill=tipo))+
  geom_bar(stat = "identity",position = "dodge2")+
  labs(x="",y="porcentaje",title = "Indicadores por tipo de prioridad")
ggsave("indicadoresportipoprioridad.png",dpi = 800,width = 11,height = 4.5)
#------------------------------ revisando cuantos son de 5, 4 y 3 estrellas ------------------------------#
kpiactividad5stars<-read_csv("kpi_actividad_5_estrellas.csv")
kpiactividad4stars<-read_csv("kpi_actividad_4_estrellas.csv")
kpiactividad3stars<-read_csv("kpi_actividad_3_estrellas.csv")

kpiactividad5stars %>% filter(`Nombres de medidas` %in% c("Actual Creditos Nuevos","Actual Creditos Renovacion"))
