library(ggplot2)
actividad<-read.csv("actividad_contactado.csv",sep = ",")

actividad<-actividad %>% mutate(mes=month(Timestamp))
unicos<-actividad %>%  dplyr::distinct(numero.de.documento,.keep_all = TRUE)
unicos %>% count(mes)
length( unique(actividad$numero.de.documento) )


a<-actividad %>% group_by(mes) %>% distinct(numero.de.documento,.keep_all = TRUE)
a %>% filter(mes!=5)%>% count(mes,cluster_segment) %>%
  ggplot(aes(x=cluster_segment,y=n,fill=as.factor(mes),label=n))+
  geom_bar(stat = "identity",position = "dodge2")+geom_text(position = position_dodge(0.9))


b<-a %>% count(mes,cluster_segment)
write_xlsx(b,"grafico.xlsx")
  