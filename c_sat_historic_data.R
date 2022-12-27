# reading C-SAT data from googlesheets
# install.packages("googlesheets4")
library(googlesheets4)
library(dplyr)
library(lubridate)
library(tidyr)
library(ggplot2)
# token: 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
# tal parece que los nombres de los sheets no pueden contener tildes o falla la lectura mediante gs4

# name_of_sheets<-sheet_names("https://docs.google.com/spreadsheets/d/12VXX9J2UixC3IWMwmwzoGXgRCWl8KoONXS2t_bEqeEM/edit?usp=sharing")

nelson_rubio<-range_read("https://docs.google.com/spreadsheets/d/12VXX9J2UixC3IWMwmwzoGXgRCWl8KoONXS2t_bEqeEM/edit?usp=sharing",
                         sheet = "Nelson Rubio",
                         col_types = "Dncccnc")
1  # este 1 es para seleccionar el perfil de google pre configurado, no borrar
luz_dary_useche<-range_read("https://docs.google.com/spreadsheets/d/12VXX9J2UixC3IWMwmwzoGXgRCWl8KoONXS2t_bEqeEM/edit?usp=sharing",
                            sheet = "Luz Dary Useche",
                            col_types = "Dncccnc")
jose_luis_alvarez<-range_read("https://docs.google.com/spreadsheets/d/12VXX9J2UixC3IWMwmwzoGXgRCWl8KoONXS2t_bEqeEM/edit?usp=sharing",
                              sheet = "Jose Luis Alvarez",
                              col_types = "Dncccnc")
camilo_escobedo<-range_read("https://docs.google.com/spreadsheets/d/12VXX9J2UixC3IWMwmwzoGXgRCWl8KoONXS2t_bEqeEM/edit?usp=sharing",
                            sheet = "Camilo Escobedo",
                            col_types = "Dncccnc")
tatiana_real<-range_read("https://docs.google.com/spreadsheets/d/12VXX9J2UixC3IWMwmwzoGXgRCWl8KoONXS2t_bEqeEM/edit?usp=sharing",
                         sheet = "Tatiana Real",
                         col_types = "Dncccnc")
luisa_moreno<-range_read("https://docs.google.com/spreadsheets/d/12VXX9J2UixC3IWMwmwzoGXgRCWl8KoONXS2t_bEqeEM/edit?usp=sharing",
                         sheet = "Luisa Moreno",
                         col_types = "Dncccnc")
leidy_rojas<-range_read("https://docs.google.com/spreadsheets/d/12VXX9J2UixC3IWMwmwzoGXgRCWl8KoONXS2t_bEqeEM/edit?usp=sharing",
                        sheet = "Leidy Rojas",
                        col_types = "Dncccnc")
karen_fernandez<-range_read("https://docs.google.com/spreadsheets/d/12VXX9J2UixC3IWMwmwzoGXgRCWl8KoONXS2t_bEqeEM/edit?usp=sharing",
                            sheet = "Karen Fernandez",
                            col_types = "Dncccnc")
catalina_suarez<-range_read("https://docs.google.com/spreadsheets/d/12VXX9J2UixC3IWMwmwzoGXgRCWl8KoONXS2t_bEqeEM/edit?usp=sharing",
                            sheet = "Catalina Suarez",
                            col_types = "Dncccnc")

# nuevos sheet agregados
jose_jhiovanni<-range_read("https://docs.google.com/spreadsheets/d/12VXX9J2UixC3IWMwmwzoGXgRCWl8KoONXS2t_bEqeEM/edit?usp=sharing",
                           sheet = "Jose Jhiovanni Vivas",
                            col_types = "Dncccnc")
esmeralda_correa<-range_read("https://docs.google.com/spreadsheets/d/12VXX9J2UixC3IWMwmwzoGXgRCWl8KoONXS2t_bEqeEM/edit?usp=sharing",
                             sheet = "Esmeralda Correa",
                           col_types = "Dncccnc")
andres_aguilar<-range_read("https://docs.google.com/spreadsheets/d/12VXX9J2UixC3IWMwmwzoGXgRCWl8KoONXS2t_bEqeEM/edit?usp=sharing",
                           sheet = "Andrés Aguilar",
                           col_types = "Dncccnc")
andrea_reyes<-range_read("https://docs.google.com/spreadsheets/d/12VXX9J2UixC3IWMwmwzoGXgRCWl8KoONXS2t_bEqeEM/edit?usp=sharing",
                         sheet = "Andrea Reyes",
                         col_types = "Dncccnc")
cristian_castro<-range_read("https://docs.google.com/spreadsheets/d/12VXX9J2UixC3IWMwmwzoGXgRCWl8KoONXS2t_bEqeEM/edit?usp=sharing",
                         sheet = "Cristian Castro",
                         col_types = "Dncccnc")



# homogenizando los nombres de las columnas
colnames(luz_dary_useche)<-colnames(nelson_rubio)
colnames(jose_luis_alvarez)<-colnames(nelson_rubio)
colnames(camilo_escobedo)<-colnames(nelson_rubio)
colnames(tatiana_real)<-colnames(nelson_rubio)
colnames(luisa_moreno)<-colnames(nelson_rubio)
colnames(leidy_rojas)<-colnames(nelson_rubio)
colnames(karen_fernandez)<-colnames(nelson_rubio)
colnames(catalina_suarez)<-colnames(nelson_rubio)
colnames(jose_jhiovanni)<-colnames(nelson_rubio)
colnames(esmeralda_correa)<-colnames(nelson_rubio)
colnames(andres_aguilar)<-colnames(nelson_rubio)
colnames(andrea_reyes)<-colnames(nelson_rubio)
colnames(cristian_castro)<-colnames(nelson_rubio)

# creando columna nombre
nelson_rubio<-nelson_rubio %>% mutate(nombre= 'Nelson Rubio')
luz_dary_useche<-luz_dary_useche %>% mutate(nombre='Luz Dary Useche')
jose_luis_alvarez<-jose_luis_alvarez %>% mutate(nombre='Jose Luis Alvarez')
camilo_escobedo<-camilo_escobedo %>% mutate(nombre='Camilo Escobedo')
tatiana_real<-tatiana_real %>% mutate(nombre='Tatiana Real')
luisa_moreno<-luisa_moreno %>% mutate(nombre='Luisa Moreno')
leidy_rojas<-leidy_rojas %>% mutate(nombre='Leidy Rojas')
karen_fernandez<-karen_fernandez %>% mutate(nombre='Karen Fernandez')
catalina_suarez<-catalina_suarez %>% mutate(nombre='Catalina Suarez')
jose_jhiovanni<-jose_jhiovanni %>% mutate(nombre='Jose Jhiovanni Vivas')
esmeralda_correa<-esmeralda_correa %>% mutate(nombre='Esmeralda Correa')
andres_aguilar<-andres_aguilar %>% mutate(nombre='Andrés Aguilar')
andrea_reyes<-andrea_reyes %>% mutate(nombre='Andrea Reyes')
cristian_castro<-cristian_castro %>% mutate(nombre='Cristian Castro')

# data total unida
historic_data<-bind_rows(
  nelson_rubio,
  luz_dary_useche,
  jose_luis_alvarez,
  camilo_escobedo,
  tatiana_real,
  luisa_moreno,
  leidy_rojas,
  karen_fernandez,
  catalina_suarez,
  jose_jhiovanni,
  esmeralda_correa,
  andres_aguilar,
  andrea_reyes,
  cristian_castro
)


# escribiendo la data en un googlesheet que sirve como fuente para el dashboard
sheet_write(historic_data,
            ss="https://docs.google.com/spreadsheets/d/1CNdsejB5HRBYDAj6pajzfpjE60_BBSf2uA_KRWAkJPc/edit?usp=sharing",
            sheet="historic_data_by_agent")
rm(list=ls())


#########################################################################
# # install.packages("plotly")
# library(plotly)
# # # dibujo de C-SAT promedio por mes para todo el equipo (como esta en el ppt ComSac de caro para juriscoop)
# ggplot( historic_data %>% group_by(Timestamp) %>% summarise(avg_calification=mean(`¿Cómo calificarías la atención que te dio Nelson de Aflore?`)) ,
#         aes(x=Timestamp,y=avg_calification,label=round(avg_calification,1 ))) + geom_line()  +
#   geom_label()  + labs(x="",y="",title = "C-SAT")
# 
# historic_data<-historic_data %>% mutate(semana= week(historic_data$Timestamp))
# historic_data_weekly<-historic_data %>% group_by(semana,nombre) %>%
#   summarise(promedio=mean(`¿Cómo calificarías la atención que te dio Nelson de Aflore?`))
# 
# # generating two plots of c-sat for kati
# 
# historic_data_weekly %>% filter(nombre %in% unique(historic_data_weekly$nombre)[1:6]) %>% ggplot(aes(x=semana,y=promedio,color=nombre))+
#   geom_line()
#       
# historic_data_weekly %>% filter(nombre %in% unique(historic_data_weekly$nombre)[7:12]) %>% ggplot(aes(x=semana,y=promedio,color=nombre))+
#   geom_line(size=2)
# 
# historic_data %>% filter(nombre =="Andrés Aguilar") %>%
#   ggplot(aes(x=Timestamp,y=`¿Cómo calificarías la atención que te dio Nelson de Aflore?`))+geom_line()
# 
# # tener como triggere timestamp


