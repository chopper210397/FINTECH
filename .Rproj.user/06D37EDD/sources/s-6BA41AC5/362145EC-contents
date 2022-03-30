# DATA VOXIMPLANT _sac_ llamadas

library(readr)
library(readxl)
library(lubridate)
library(dplyr)
library(ggplot2)
library(tidyr)

llamadas<-read_xlsx("voximplant.xlsx")

str(llamadas)
unique(llamadas$`Date of call start`)

llamadas$`Date of call start`<-as.Date(llamadas$`Date of call start`)
llamadas<-llamadas %>% mutate(mes=month(`Date of call start`))


unique(llamadas$`Agent B`)
unique(llamadas$`Agent A`)


llamadas$`Call duration`<-as.numeric(llamadas$`Call duration`)
llamadas$`Call cost`<-as.numeric(llamadas$`Call cost`)

hist(llamadas$`Call duration`)
hist(llamadas$`Call cost`)

# solo marzo

a<-llamadas %>% filter(mes=="3" & `Call duration`!="0") %>%  group_by(`Agent A`)%>%  count(`Is incoming`)

a %>% ggplot(aes(x=reorder(`Agent A`,n),y=n))+
  geom_bar(stat = "identity",fill="lightblue")+coord_flip()+facet_grid(.~`Is incoming`)

ggsave("voximplant.png",dpi=800)

juliocesar<-llamadas %>% filter(`Agent A`=="Julio Cesar Osorio")
juliocesarsincero<-llamadas %>% filter(`Agent A`=="Julio Cesar Osorio" & `Call duration`!="0")

