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
                         col_types = "Dnccc")
1  # este 1 es para seleccionar el perfil de google pre configurado, no borrar
luz_dary_useche<-range_read("https://docs.google.com/spreadsheets/d/12VXX9J2UixC3IWMwmwzoGXgRCWl8KoONXS2t_bEqeEM/edit?usp=sharing",
                            sheet = "Luz Dary Useche",
                            col_types = "Dnccc")
jose_luis_alvarez<-range_read("https://docs.google.com/spreadsheets/d/12VXX9J2UixC3IWMwmwzoGXgRCWl8KoONXS2t_bEqeEM/edit?usp=sharing",
                              sheet = "Jose Luis Alvarez",
                              col_types = "Dnccc")
camilo_escobedo<-range_read("https://docs.google.com/spreadsheets/d/12VXX9J2UixC3IWMwmwzoGXgRCWl8KoONXS2t_bEqeEM/edit?usp=sharing",
                            sheet = "Camilo Escobedo",
                            col_types = "Dnccc")
tatiana_real<-range_read("https://docs.google.com/spreadsheets/d/12VXX9J2UixC3IWMwmwzoGXgRCWl8KoONXS2t_bEqeEM/edit?usp=sharing",
                         sheet = "Tatiana Real",
                         col_types = "Dnccc")
luisa_moreno<-range_read("https://docs.google.com/spreadsheets/d/12VXX9J2UixC3IWMwmwzoGXgRCWl8KoONXS2t_bEqeEM/edit?usp=sharing",
                         sheet = "Luisa Moreno",
                         col_types = "Dnccc")
leidy_rojas<-range_read("https://docs.google.com/spreadsheets/d/12VXX9J2UixC3IWMwmwzoGXgRCWl8KoONXS2t_bEqeEM/edit?usp=sharing",
                        sheet = "Leidy Rojas",
                        col_types = "Dnccc")
karen_fernandez<-range_read("https://docs.google.com/spreadsheets/d/12VXX9J2UixC3IWMwmwzoGXgRCWl8KoONXS2t_bEqeEM/edit?usp=sharing",
                            sheet = "Karen Fernandez",
                            col_types = "Dnccc")
catalina_suarez<-range_read("https://docs.google.com/spreadsheets/d/12VXX9J2UixC3IWMwmwzoGXgRCWl8KoONXS2t_bEqeEM/edit?usp=sharing",
                            sheet = "Catalina Suarez",
                            col_types = "Dnccc")

# nuevos sheet agregados
jose_jhiovanni<-range_read("https://docs.google.com/spreadsheets/d/12VXX9J2UixC3IWMwmwzoGXgRCWl8KoONXS2t_bEqeEM/edit?usp=sharing",
                           sheet = "Jose Jhiovanni Vivas",
                            col_types = "Dnccc")
esmeralda_correa<-range_read("https://docs.google.com/spreadsheets/d/12VXX9J2UixC3IWMwmwzoGXgRCWl8KoONXS2t_bEqeEM/edit?usp=sharing",
                             sheet = "Esmeralda Correa",
                           col_types = "Dnccc")
andres_aguilar<-range_read("https://docs.google.com/spreadsheets/d/12VXX9J2UixC3IWMwmwzoGXgRCWl8KoONXS2t_bEqeEM/edit?usp=sharing",
                           sheet = "Andrés Aguilar",
                           col_types = "Dnccc")
andrea_reyes<-range_read("https://docs.google.com/spreadsheets/d/12VXX9J2UixC3IWMwmwzoGXgRCWl8KoONXS2t_bEqeEM/edit?usp=sharing",
                         sheet = "Andrea Reyes",
                         col_types = "Dnccc")



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
  andrea_reyes
)


# escribiendo la data en un googlesheet que sirve como fuente para el dashboard
sheet_write(historic_data,
            ss="https://docs.google.com/spreadsheets/d/1CNdsejB5HRBYDAj6pajzfpjE60_BBSf2uA_KRWAkJPc/edit?usp=sharing",
            sheet="historic_data_by_agent")
rm(list=ls())

# # dibujo de C-SAT promedio por mes para todo el equipo (como esta en el ppt ComSac de caro para juriscoop)
# ggplot( last_month %>% group_by(mes) %>% summarise(avg_calification=mean(`¿Cómo calificarías la atención que te dio Nelson de Aflore?`)) ,
#         aes(x=mes,y=avg_calification,label=round(avg_calification,1 ))) + geom_line()  +
#   geom_label()  + labs(x="",y="",title = "C-SAT")


# tener como triggere timestamp


