library(googlesheets4)
library(dplyr)
library(lubridate)
library(tidyr)
library(ggplot2)

# autentication needed
autentication<-gm_auth_configure(key = "299160033159-pk4ik6pfnb971sk5l9daavdmttqja27s.apps.googleusercontent.com",
                                 secret = "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")
1

# se eliminan los dos ultimos nombres porque son del "resume" e "indicadores"
name_of_sheets<-head( sheet_names("https://docs.google.com/spreadsheets/d/12VXX9J2UixC3IWMwmwzoGXgRCWl8KoONXS2t_bEqeEM/edit?usp=sharing"),-2 )

# first we read all sheets from our googlesheet
for (selected_agent in name_of_sheets) {
    assign(
             gsub(" ","_",selected_agent) ,
      
             (range_read("https://docs.google.com/spreadsheets/d/12VXX9J2UixC3IWMwmwzoGXgRCWl8KoONXS2t_bEqeEM/edit?usp=sharing",
                        sheet = selected_agent , col_types = "Dnccc")) %>% mutate(nombre=selected_agent)
          )
}

# falta ponerle a todos los dataframes los mismos nombres de columnas
# AHORA YA SE QUE SI ESCRIBO LOS DATA FRAMES MANUALMENTE SI LES PUEDO APLICAR 
# FUNCIONES CON LAPPLY O UN FOR, EL PROBLEMA ES QUE LA FUNCIÓN COLNAMES() NO HACE EFECTO
# POR LO TANTO HAY QUE BUSCAR OTRO CAMINO 
df_list<-list( )

lapply(df_list ,
       function(x) x %>% mutate(id="1") )


for (i in 1:length(df_list)) {
  df_list[[i]]<-df_list[[i]] %>% rename()
}

for (i in 1:length(df_list)) {
  print(names(df_list[[i]])<-c("Timestamp","Calificación","FCR","Comentario","Teléfono","Nombre"))
  
}


for (df in df_list) {
  colnames(df)<-c("Timestamp","Calificación","FCR","Comentario","Teléfono","Nombre")
}


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
  andres_aguilar
)
