library(rvest)
library(devtools)
library(dplyr)
library(datametria)
library(lubridate)
df<-bcrp(periodo = "diarias", serie = "PD04638PD", nombre = "S/ por US$")

ra<-df %>% mutate(dia=substr(Fecha,1,2)) %>% mutate(mes=ifelse( substr(Fecha,3,5)=="Ene",01,
                                                                ifelse(substr(Fecha,3,5)=="Feb",02,
                                                                       ifelse(substr(Fecha,3,5)=="Mar",03,
                                                                              ifelse(substr(Fecha,3,5)=="Abr",04,
                                                                                     ifelse(substr(Fecha,3,5)=="May",05,
                                                                                            ifelse(substr(Fecha,3,5)=="Jun",06,
                                                                                                   ifelse(substr(Fecha,3,5)=="Jul",07,
                                                                                                          ifelse(substr(Fecha,3,5)=="Ago",08,
                                                                                                                 ifelse(substr(Fecha,3,5)=="Set",09,
                                                                                                                        ifelse(substr(Fecha,3,5)=="Oct",10,
                                                                                                                               ifelse(substr(Fecha,3,5)=="Nov",11,
                                                                                                                                      ifelse(substr(Fecha,3,5)=="Dic",12,"mes_no_tipificado"))))))))))))) %>%
  mutate(year=ifelse( substr(Fecha,6,7)>90,paste0("19",substr(Fecha,6,7)), paste0("20",substr(Fecha,6,7)) )) %>% 
  mutate(Fecha2=paste0(dia,"-",mes,"-",year)) %>% select(`S/ por US$`,Fecha2)

ra$Fecha2<-as.Date(ra$Fecha2,format = "%d-%m-%Y")

ra %>% 
  filter(Fecha2> "2022-03-01" ) %>% filter( Fecha2<"2022-06-10")
