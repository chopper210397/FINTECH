library(readxl)
library(lubridate)
library(dplyr)

tickets<-read_xls("tickets_agosto.xls",skip = 2)

tickets$`Closed at`<-as.Date( tickets$`Closed at`)
tickets$`Created at`<-as.Date( tickets$`Created at`)

# siempre se debe cambiar el numero del month(closed at) al mes que deseamos evaluar
tickets %>% filter(Customer=="Luisa Moreno" | Owner=="Luisa Moreno" ) %>% filter(!is.na(`Closed at`)) %>%
  filter(month(`Closed at`)==8) %>% 
  mutate(dia=(day(`Closed at`)-day(`Created at`))) %>%
  select(dia) %>% na.omit() %>% arrange(-dia)   %>% summarise(promedio=mean(dia))                      # el slice head lo use
                                                                                                      # para modificar una data
                                                                                                      # para eduardo
                                                                                                      # %>% slice_head(n=67)


a<-tickets %>% filter(Customer=="Luisa Moreno" | Owner=="Luisa Moreno" ) %>% filter(!is.na(`Closed at`)) %>%
  filter(month(`Closed at`)==8) %>% 
    mutate(dia=(day(`Closed at`)-day(`Created at`))) %>% arrange(-dia) 

tickets %>% filter(Customer=="Luisa Moreno" | Owner=="Luisa Moreno" ) %>% filter(!is.na(`Closed at`)) %>%
  filter(month(`Closed at`)==7) %>% 
  mutate(dia=(day(`Closed at`)-day(`Created at`))) %>%
  select(dia) %>% na.omit() %>% arrange(dia)  %>% filter(dia<6) %>% summarise(promedio=mean(dia))  



tickets %>% filter(Customer=="Natalia Piedrahita" | Owner=="Natalia Piedrahita" )  %>% filter(!is.na(`Closed at`)) %>%
  filter(month(`Closed at`)==6) %>% 
  mutate(dia=day(`Closed at`)-day(`Created at`)) %>%
  select(dia) %>% na.omit()%>% arrange(dia)  %>% slice_head(n=70) %>%  summarise(promedio=mean(dia))

