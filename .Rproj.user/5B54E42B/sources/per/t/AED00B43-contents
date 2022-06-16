library(readxl)
library(lubridate)
library(dplyr)

tickets<-read_xls("tickets_mayo.xls",skip = 2)

tickets$`Closed at`<-as.Date( tickets$`Closed at`)
tickets$`Created at`<-as.Date( tickets$`Created at`)

# siempre se debe cambiar el numero del month(closed at) al mes que deseamos evaluar
tickets %>% filter(Customer=="Luisa Moreno" | Owner=="Luisa Moreno" ) %>% filter(!is.na(`Closed at`)) %>%
  filter(month(`Closed at`)==5) %>% 
  mutate(dia=(day(`Closed at`)-day(`Created at`))) %>%
  select(dia) %>% na.omit() %>% summarise(promedio=mean(dia))
 

tickets %>% filter(Customer=="Natalia Piedrahita" | Owner=="Natalia Piedrahita" )  %>% filter(!is.na(`Closed at`)) %>%
  filter(month(`Closed at`)==5) %>% 
  mutate(dia=day(`Closed at`)-day(`Created at`)) %>%
  select(dia) %>% na.omit() %>% summarise(promedio=mean(dia))

