library(googlesheets4)
library(dplyr)
library(lubridate)
library(tidyr)
library(ggplot2)


###############################  C-SAT #####################################
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
# df_list<-list( )
# 
# lapply(df_list ,
#        function(x) x %>% mutate(id="1") )
# 
# 
# for (i in 1:length(df_list)) {
#   df_list[[i]]<-df_list[[i]] %>% rename( = )
# }
# 
# for (i in 1:length(df_list)) {
#   print(names(df_list[[i]])<-c("Timestamp","Calificación","FCR","Comentario","Teléfono","Nombre"))
#   
# }
# 
# 
# for (df in df_list) {
#   colnames(df)<-c("Timestamp","Calificación","FCR","Comentario","Teléfono","Nombre")
# }

new_column_names<-c("Timestamp","Calificación","FCR","Comentario","Teléfono","Nombre")

# homogenizando los nombres de las columnas
colnames(Andrés_Aguilar)<-new_column_names
colnames(Camilo_Escobedo)<-new_column_names
colnames(Catalina_Suarez)<-new_column_names
colnames(Cristian_Castro)<-new_column_names
colnames(Diego_Cruz)<-new_column_names
colnames(Dulfay_Linares)<-new_column_names
colnames(Esmeralda_Correa)<-new_column_names
colnames(Jenny_Rincón)<-new_column_names
colnames(Jorge_Fernández)<-new_column_names
colnames(Jose_Jhiovanni_Vivas)<-new_column_names
colnames(Jose_Luis_Alvarez)<-new_column_names
colnames(Karen_Fernandez)<-new_column_names
colnames(Leidy_Rojas)<-new_column_names
colnames(Luisa_Moreno)<-new_column_names
colnames(Luz_Dary_Useche)<-new_column_names
colnames(Natalia_Piedrahita)<-new_column_names
colnames(Nelson_Rubio)<-new_column_names
colnames(Sandra_Herrera)<-new_column_names
colnames(Tatiana_Real)<-new_column_names
colnames(Yaneth_Murillo)<-new_column_names

# UNIENDO TODA LA DATA DE C-SAT (QA EXTERNO)
historic_data<-bind_rows(
  Andrés_Aguilar,
  Camilo_Escobedo,
  Catalina_Suarez,
  Cristian_Castro,
  Diego_Cruz,
  Dulfay_Linares,
  Esmeralda_Correa,
  Jenny_Rincón,
  Jorge_Fernández,
  Jose_Jhiovanni_Vivas,
  Jose_Luis_Alvarez,
  Karen_Fernandez,
  Leidy_Rojas,
  Luisa_Moreno,
  Luz_Dary_Useche,
  Natalia_Piedrahita,
  Nelson_Rubio,
  Sandra_Herrera,
  Tatiana_Real,
  Yaneth_Murillo
)

historic_data %>%
  group_by(trunc.Date(Timestamp,'months'),Nombre) %>%
  summarise(promedio_c_sat=mean(Calificación))


###############################  QA #####################################

##########################  QA INTERNO ##################################

qa_servicio<-range_read("https://docs.google.com/spreadsheets/d/1tYXEEq_34kxoKh0Vo4mfG5aUopC5wbFNyeTXqZqzsL4/edit?usp=sharing",
           sheet ="Form Responses 1" , col_types = "DccccnncncncccccncDccc")

qa_pqr<-range_read("https://docs.google.com/spreadsheets/d/1XgXYMt4qjep1_L8JUNCzM7Snfqp5XtnfKEV3DA_4HjU/edit?usp=sharing",
                        sheet ="Form Responses 1" , col_types = "DcDccccccnnncncccccc")
