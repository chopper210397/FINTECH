# 1 al 31 de marzo
library(readr)
library(readxl)
library(lubridate)
library(dplyr)
library(ggplot2)
library(tidyr)

actividad<-read_csv("kpi_actividad_mayo.csv")

actividadscxia<-read_xlsx("Tabla Actividad SC.xlsx")
actividadsc<-read_xlsx("Tabla Actividad SC.xlsx")
actividadsolo<-read_xlsx("Tabla Actividad.xlsx")
variables<-colnames(actividadsolo)[2:16]
variables2<-colnames(actividadsc)[2:11]
variables3<-colnames(actividadscxia)[2:11]

actividadsolo<-actividadsolo %>% pivot_longer(cols = variables,names_to = "variable",values_to = "valores")
actividadsc<-actividadsc %>% pivot_longer(cols = variables2,names_to = "variable",values_to = "valores")
actividadscxia<-actividadscxia %>% pivot_longer(cols = variables3,names_to = "variable",values_to = "valores")
actividad<-rbind(actividadsolo,actividadsc,actividadscxia)
colnames(actividad)[1]<-"Coordinador virtual"
colnames(actividad)[2]<-"Nombres de medidas"
colnames(actividad)[3]<-"Valores de medidas"

# str(actividad)
# names(actividad)
# unique(actividad$`Nombres de medidas`)

# actividad %>% filter(`Coordinador virtual`!="Total")%>%
#   ggplot(aes(x=`Coordinador virtual`,y=`Valores de medidas`,fill=`Nombres de medidas`))+
#   geom_bar(stat = "identity",position = "dodge2")
# cual es el promedio del tamaño de la red de consejeros de un coordinador, ahi podriamos decir, tales coordinadores
# estan por encima de la meta o tal variable

actividad %>% filter(`Nombres de medidas`%in% c("% RR Creditos Renovacion",
                                                "% IAS con Credito Renovacion",
                                                "% RR Creditos Nuevos",
                                                "% IAS con Credito Nuevo",
                                                "% RR Creditos Total",
                                                "% IAS con Credito Total")) %>%
  filter(`Coordinador virtual`!="Total")%>%
  ggplot(aes(x=`Coordinador virtual`,y=`Valores de medidas`,fill=`Nombres de medidas`,
             label=round(`Valores de medidas`*100)))+
  geom_bar(stat = "identity",position = "dodge2")+geom_hline(yintercept = 1,linetype='dashed')+
  geom_text(size=3,position = position_dodge(width = 1))

ggsave("actividadporcentajeskpi.png", dpi=800,width = 14,height = 7)


# analisis por totales de kpis actividad
actividad %>% filter(`Nombres de medidas`%in% c("% RR Creditos Renovacion",
                                                "% IAS con Credito Renovacion",
                                                "% RR Creditos Nuevos",
                                                "% IAS con Credito Nuevo",
                                                "% RR Creditos Total",
                                                "% IAS con Credito Total")) %>%
  filter(`Coordinador virtual`=="Total")%>%
  ggplot(aes(x=`Coordinador virtual`,y=`Valores de medidas`,fill=`Nombres de medidas`,
             label=round(`Valores de medidas`*100)))+
  geom_bar(stat = "identity",position = "dodge2")+geom_hline(yintercept = 1,linetype='dashed')+
  labs(title = "Total por kpi actividad en marzo",
       caption = "Resultado de todo el grupo en conjunto",x="",y="porcentaje")+
  geom_text(position = position_dodge(width = 1))

ggsave("totalactividadporcentajeskpi.png", dpi=800,height = 8,width = 8)

#------------------------------------------ gestion prioridades ------------------------------------------#
# esta data tuve que modificarla manualmente ya que tableau no me da el csv como datos
# sino como tabulación, es decir en formato de tabla
# trabajando la data en r
# tipo = prioridad
# variable = kpis
# numero = valores
prioridades<-read_xlsx("gestion_prioridades_mayo.xlsx")
prioridades<-pivot_longer(prioridades,cols = colnames(prioridades)[2:length(colnames(prioridades))],
             names_to ="variable",values_to = "numero" )
colnames(prioridades)[1]<-"tipo"
#
prioridades<-read_xlsx("gestion_prioridades.xlsx")
#
# priority<-read_xlsx("prioridades.xlsx")
# priorityvariables<-colnames(priority)[2:11]
# prioridades<-priority %>% pivot_longer(cols = priorityvariables,names_to = "variable",
#                           values_to ="numero" )
# colnames(prioridades)[1]<-"tipo"
#
prioridades %>%filter(tipo!="Total general") %>%
  filter(variable %in% c("fct % Enviando","fct % Gestionados","fct % Contactados",
                         "fct % Activos","fct % Conv Solicitud","fct % Conv Actv" ) ) %>%
  mutate(numero=numero*100) %>% 
  ggplot(aes(x=variable,y=numero,fill=tipo,label=round(numero)))+
  geom_bar(stat = "identity",position = "dodge2")+
  labs(x="",y="porcentaje",title = "Indicadores por tipo de prioridad")+
  geom_text(position = position_dodge(width = 1))

  

ggsave("indicadoresportipoprioridad.png",dpi = 800,width = 11,height = 4.5)
#------------------------------ revisando cuantos son de 5, 4 y 3 estrellas ------------------------------#
kpiactividad5stars<-read_csv("kpi_actividad_5_estrellas.csv")
kpiactividad4stars<-read_csv("kpi_actividad_4_estrellas.csv")
kpiactividad3stars<-read_csv("kpi_actividad_3_estrellas.csv")

kpiactividad5stars %>% filter(`Nombres de medidas` %in% c("Actual Creditos Nuevos","Actual Creditos Renovacion"))
