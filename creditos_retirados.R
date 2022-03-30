library(readr)
library(readxl)
library(dplyr)
library(ggplot2)
library(lubridate)
library(tidyr)
library(kableExtra)


creditos<-read_xlsx("creditos_retirados.xlsx")
str(creditos)
unique(creditos$Status)
creditos$`Created At`<-as.Date(creditos$`Created At`)
creditos$`Updated At`<-as.Date(creditos$`Updated At`)

creditos<-creditos %>% mutate(mes=month(`Created At`))



creditos %>% ggplot(aes(x=Status,fill=as.factor(mes)))+geom_bar(position = "dodge2")+
  labs(title = "Estatus de enero a marzo",x="",y="numero de transacciones", caption = "1=Enero, 2=Febrero, 3=Marzo")

ggsave("statuseneromarzo.png",dpi = 300,width = 14,height = 7)

mesestatusconteo<-creditos %>% group_by(mes,Status) %>% count(Status)

groupedmes<-creditos %>% group_by(mes) %>% count(mes)
colnames(groupedmes)[2]<-"totalpormes"

creditmesgrouped<-merge(x=mesestatusconteo,y=groupedmes,all.x = TRUE)
creditmesgrouped<-creditmesgrouped %>% mutate(porcentaje=n/totalpormes*100)



kbl(creditmesgrouped,booktabs = T) %>% kable_styling(latex_options = "striped")
