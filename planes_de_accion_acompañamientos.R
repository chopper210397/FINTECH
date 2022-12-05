library(googlesheets4)
library(dplyr)
library(lubridate)
library(tidyr)
library(gmailr)

# sheet planes de acción nuevo

# autentication with google cloud credentials
autentication<-gm_auth_configure(key = "299160033159-pk4ik6pfnb971sk5l9daavdmttqja27s.apps.googleusercontent.com",
                                 secret = "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")
1
# nombre de los sheets y por lo tanto de los coordinadores
nombres_hojas<-sheet_names("https://docs.google.com/spreadsheets/d/1hrHkd7Fy-rvtF9keyvtHKi9Po9HToY6vrutkI7qmsi4/edit?usp=sharing")
1
# reading the sheet
data<-range_read("https://docs.google.com/spreadsheets/d/1hrHkd7Fy-rvtF9keyvtHKi9Po9HToY6vrutkI7qmsi4/edit?usp=sharing",
                 sheet = nombres_hojas,
                 col_types = "DDcccccccc")

# creando diccionario para correos
correos <- c("Andrés Aguilar"="andresmauricio@aflore.co",
             "Camilo Escobedo"="camilo.escobedo@aflore.co",
             "Claudia Duque"="claudia.duque@aflore.co",
             "Dora Giraldo"="dora.giraldo@aflore.co",
             "Esmeralda Correa"="esmeralda@aflore.co",
             "Jose Jhiovanni Vivas"="jhiovanni.vivas@aflore.co",
             "Jose Luis Álvarez"="jose.alvarez@aflore.co",
             "Karen Fernández"="karen.fernandez@aflore.co",
             "Luisa Moreno"="luisa.moreno@aflore.co",
             "Luz Dary Useche"="luzdary@aflore.co",
             "Tatiana Real"="tatiana.real@aflore.co",
             "Andrea Reyes"="andrea.reyes@aflore.co"
             )

# selecting data from an specific day
# data<-data %>% filter(as.character(Timestamp)==as.character(today()-7))


# selecting data from yesterday , be careful if is monday cause cant yesterday is not friday so app dont send those messages
ifelse( as.character( max( data$Timestamp ) ) ==  as.character( today()-1),
        data <- data %>% filter( as.character( Timestamp ) == as.character( today()-1)),
        rm(list = ls()))

n_row_data<-nrow(data)
for (i in 1:n_row_data) {
 data_temp<-data[i,]

  created_message<-gm_mime() %>%
    gm_to( correos[data_temp$Colaborador] ) %>% 
    gm_cc("carolina.reyes@aflore.co,dora.giraldo@aflore.co,talento@aflore.co") %>%
    gm_from("luis.barrios@aflore.co") %>%
    gm_subject(paste0("Plan de acción acompañamiento de ", data_temp$Colaborador )) %>%
    gm_text_body(
      paste0( 
        "Hola ",data_temp$Colaborador," !","\n",
        "Te envío el resumen del acompañamiento realizado el día ",data_temp$`Fecha del acompañamiento`," junto a ",data_temp$`Realiza el acompañamiento`,"\n","\n",
        "Tipo de acompañamiento: ", "\t", data_temp$`Tipo de acompañamiento` ,"\n",
        "Realizó el acompañamiento: ","\t", data_temp$`Realiza el acompañamiento`,"\n",
        "Fecha de acompañamiento: ","\t", data_temp$`Fecha del acompañamiento` ,"\n",
        "Plazo: ", "\t", as.Date(data_temp$Plazo , "%m/%d/%Y") ,"\n", "\n",
        
        "A mejorar: ", "\n", data_temp$`A mejorar` ,"\n","\n",
        "Aspectos donde se evidencia avance vs acompañamientos anteriores: ", "\n", data_temp$`Aspectos donde se evidencia avance vs acompañamientos anteriores` ,"\n","\n",
        "Plan de acción: ", "\n", data_temp$`Plan de acción` ,"\n","\n",
        "Observaciones: ", "\n", data_temp$Observaciones ,"\n", "\n",
        " 'MENSAJE AUTOMÁTICO' "
      ) 
    )
  gm_send_message(created_message,user_id = "me")
1   
}
1

rm(list = ls())

