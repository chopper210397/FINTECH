library(googlesheets4)
library(dplyr)
library(lubridate)
library(tidyr)
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
                 col_types = "DDccccccc")

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
        data <- data %>% filter( as.character( Timestamp ) == as.character( today()-1 )),
        0 )

# data<-data[13,]

  created_message<-gm_mime() %>%
    gm_to( correos[data$Colaborador] ) %>% 
    gm_cc("carolina.reyes@aflore.co,talento@aflore.co") %>%
    gm_bcc("dora.giraldo@aflore.co") %>% 
    gm_from("luis.barrios@aflore.co") %>%
    gm_subject(paste0("Plan de acción acompañamiento de ", data$Colaborador )) %>%
    gm_text_body(
      paste0( 
        "Hola ",data$Colaborador," !","\n",
        "Te envío el resumen del acompañamiento realizado el día ",data$`Fecha del acompañamiento`," junto a ",data$`Realiza el acompañamiento`,"\n","\n",
        "Realizó el acompañamiento: ","\t", data$`Realiza el acompañamiento`,"\n",
        "Fecha de acompañamiento: ","\t", data$`Fecha del acompañamiento` ,"\n",
        "Plazo: ", "\t", as.Date(data$Plazo , "%m/%d/%Y") ,"\n", "\n",
        
        "A mejorar: ", "\n", data$`A mejorar` ,"\n","\n",
        "Aspectos donde se evidencia avance vs acompañamientos anteriores: ", "\n", data$`Aspectos donde se evidencia avance vs acompañamientos anteriores` ,"\n","\n",
        "Plan de acción: ", "\n", data$`Plan de acción` ,"\n","\n",
        "Observaciones: ", "\n", data$Observaciones ,"\n", "\n",
        " 'MENSAJE AUTOMÁTICO' "
      ) 
    )
  gm_send_message(created_message,user_id = "me")
1  

rm(list = ls())


