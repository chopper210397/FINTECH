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

# #
# creditos2<-creditos %>% group_by(`fecha actualizacion`,`estado solicitud`) %>%
#   dplyr::summarise(montosolicitado=n(`monto solicitado cliente`),montoaprobado=n(`monto aprobado`)) %>%
#   arrange(`fecha actualizacion`)

creditos2<-creditos %>% group_by(`fecha actualizacion`,`estado solicitud`) %>%
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





#------------------------------------------------------------#
#------------------------------------------------------------#
#-------        ANALISIS CREDITOS Y SEGUROS        ----------# ----------------------------------------------------
#------------------------------------------------------------#
#------------------------------------------------------------#
# 2021 - 2022
cred_seg<-read_xlsx("creditos_seguros.xlsx")
str(cred_seg)

hist(cred_seg$`Credit Amount`)
hist(cred_seg$`Credit Disbursement Amount`)
hist(cred_seg$`Annual Interest`)
hist(cred_seg$`Total Payment`)
hist(cred_seg$`Total Fga Amount`)
hist(cred_seg$`Total Insurance Amount`)

# scatterplot
cred_seg %>% ggplot(aes(x=`Total Insurance Amount`,y=(`Credit Disbursement Amount`)/1000)) +
  geom_point(color="blue")+coord_flip()

cred_seg %>% ggplot(aes(x=`Total Fga Amount`,y=(`Credit Disbursement Amount`)/1000)) +
  geom_point(color="blue")+coord_flip()

cred_seg %>% ggplot(aes(x=`Total Fga Amount`,y=(`Credit Disbursement Amount`)/1000)) +
  geom_bin2d(color="blue")+coord_flip()

cred_seg %>% ggplot(aes(x=`Total Insurance Amount`,y=(`Credit Disbursement Amount`)/1000)) +
  geom_bin2d(color="blue")+coord_flip()
# histograms
cred_seg  %>% ggplot(aes(x=(`Credit Disbursement Amount`)/1000))+geom_histogram(color="darkblue", fill="lightblue")
cred_seg  %>% ggplot(aes(x=(`Credit Amount`)/1000))+geom_histogram(color="darkblue", fill="lightblue")
cred_seg  %>% ggplot(aes(x=`Annual Interest`))+geom_histogram(color="darkblue", fill="lightblue")
cred_seg  %>% ggplot(aes(x=(`Total Payment`)/1000))+geom_histogram(color="darkblue", fill="lightblue")
cred_seg  %>% ggplot(aes(x=`Total Fga Amount`))+geom_histogram(color="darkblue", fill="lightblue")
cred_seg  %>% ggplot(aes(x=`Total Insurance Amount`))+geom_histogram(color="darkblue", fill="lightblue")

# graph lines
cred_seg2<-cred_seg %>% group_by(`Disbursement Date`) %>%
  summarise(creditdisbursement_amount=sum(`Credit Disbursement Amount`),credit_amount=sum(`Credit Amount`),
            interesanual=mean(`Annual Interest`), pagototal=sum(`Total Payment`),
            fgatotal=sum(`Total Fga Amount`), seguro_monto=sum(`Total Insurance Amount`))

cred_seg2 %>% ggplot(aes(x=`Disbursement Date`))+
  geom_line(aes(y=cred_seg2$seguro_monto),colour="blue")+
  geom_line(aes(y=cred_seg2$fgatotal),colour="red")

#------------------------------ agrupamos por mes ------------------------------#
cred_seg3<-cred_seg2 %>% mutate(month(`Disbursement Date`))
  
cred_seg3<-cred_seg3 %>% group_by(format(as.Date(cred_seg3$`Disbursement Date`), "%Y-%m")) %>%
  summarise(creditdisbursement_amount=sum(creditdisbursement_amount), 
            credit_amount=sum(credit_amount), interesanual=mean(interesanual), pagototal=sum(pagototal),
            fgatotal=sum(fgatotal), seguro_monto=sum(seguro_monto))

colnames(cred_seg3)[1]<-"fecha"
cred_seg3$fecha<-fast_strptime( cred_seg3$fecha,format =  "%Y-%m")
cred_seg3$fecha<-as.Date(cred_seg3$fecha)

# graficando
cred_seg3 %>% ggplot(aes(x=fecha))+
  geom_line(aes(y=(seguro_monto)/1000000),colour="blue",size=1.5)+
  geom_line(aes(y=(fgatotal)/1000000),colour="red",size=1.5)+
  labs(title = "suma de seguros y fondo de garantia desembolsado por mes",
                                               caption = "Rojo=fga, azul=seguro",x="",y="en millones")


cred_seg3 %>% ggplot(aes(x=fecha))+geom_line(aes(y=(creditdisbursement_amount)/1000000),colour="red",size=1.5)+
  geom_line(aes(y=(credit_amount)/1000000),colour="blue",size=1.5)+
  labs(title = "suma de credito total y credito desembolsado por mes",
                                                     caption = "Rojo=credito desembolsado, azul=credito total",
       x="",y="en millones")

cred_seg3 %>% ggplot(aes(x=fecha,y=interesanual))+geom_line(colour="blue",size=2)+
  labs(title = "tasa de interés anual promedio",
       caption = "",
       x="",y="promedio por mes")

#-------- 2022 ---------#
# lo evaluamos por día
cred_seg2 %>% filter(`Disbursement Date`>="2022-01-01") %>%
  ggplot(aes(x=`Disbursement Date`))+geom_line(aes(y=(credit_amount)/1000),color="red",size=1.2)+
  geom_line(aes(y=(creditdisbursement_amount)/1000),color="blue",size=1.2)+
  labs(title = "2022- credito total y desembolso de credito",
       caption = "Rojo= credito total, Azul= Credito desembolsado",
       x="",y="en miles")

cred_seg2 %>% ggplot(aes(x=`Disbursement Date`))+
  geom_line(aes(y=(seguro_monto)/1000000),colour="blue",size=1)+
  geom_line(aes(y=(fgatotal)/1000000),colour="red",size=1)+
  labs(title = "suma de seguros y fondo de garantia desembolsado por mes",
       caption = "Rojo=fga, azul=seguro",x="",y="en millones")

# model
summary( lm(creditdisbursement_amount~interesanual+fgatotal+seguro_monto,  data = cred_seg2) )
