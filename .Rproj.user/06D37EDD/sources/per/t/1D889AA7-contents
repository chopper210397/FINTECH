# install.packages("zoo")
library(zoo)
library(readxl)
library(dplyr)
library(lubridate)
library(ggplot2)

itbx<-read_xlsx("itbx.xlsx")
itbxgroup<-read_xlsx("itbxgroup.xlsx")

str(itbx)

hist(itbx$bill_duration)

boxplot(itbx300$bill_duration,ylim=c(0,2000))

itbx300<-itbx %>% filter(call_duration>=300)

itbx300$date<-as.Date(itbx300$date)


itbx300date<-itbx300 %>% count(date)

itbx300date %>% ggplot(aes(x=date,y=n))+geom_line()

itbx %>%  ggplot(aes(x=call_duration))+geom_bar()
itbxgroup<-itbxgroup %>% filter(date<"2022-02-01")
itbxgroup<-itbxgroup %>% arrange(date)
itbxgroup<-itbxgroup %>% filter(count>50)
itbxgroup %>% ggplot(aes(x=date,y=count))+geom_line()

#------------- llamadas aflore -------------#
llamadasaflore<-read_xlsx("llamadas_aflore.xlsx")

plot(x=llamadasaflore$Fecha,y=llamadasaflore$Duración)

medianllamada<-llamadasaflore %>% group_by(Fecha) %>% summarise(mediana_llamada=median(Duración),
                                                                promedio_llamada=mean(Duración)) %>% 
  arrange(Fecha)


str(medianllamada)

medianllamada %>% ggplot(aes(x=Fecha))+geom_line(aes(y=mediana_llamada),color="red")+
  geom_line(aes(y=promedio_llamada),color="blue")+labs(x="",y="segundos",title="Duración de llamada en segundos",
                                                       caption = "rojo = mediana, azul= promedio")

# tomamos la mediana como valor referencial

proyeccion<-c("2363",
  "2908",
  "3736",
  "4566",
  "4856",
  "5155",
  "5467",
  "5799")

proyeccion<-ts(proyeccion,start = c(2022,5),frequency = 12 )

ts.plot(proyeccion)

#---------------------------------------------------------------------------------------
portafolio<-read.csv("portafolio.csv",sep = ";")

portafolio %>% group_by(Mes.Desembolso)

portafolio$Fecha.Desembolso<-as.Date(portafolio$Fecha.Desembolso,"%d/%m/%Y")
portafolio<-portafolio %>% mutate(añomes=format(as.Date(portafolio$Fecha.Desembolso), "%Y-%m"))


mesyear<-portafolio %>% count(añomes) 
mesyear<-mesyear[5:103,]
portafoliomensual<-ts(mesyear$n,start = c(2014,1),frequency = 12)
x11()
ts.plot(portafoliomensual)

