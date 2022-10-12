library(googlesheets4)
library(dplyr)
library(lubridate)
library(tidyr)
library(tidyr)
library(gmailr)
# install.packages("rJava")

# sheet Planes de acción

# autentication with google cloud credentials
autentication<-gm_auth_configure(key = "299160033159-pk4ik6pfnb971sk5l9daavdmttqja27s.apps.googleusercontent.com",
                                 secret = "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")
1
# nombre de los sheets y por lo tanto de los coordinadores
nombres_hojas<-sheet_names("https://docs.google.com/spreadsheets/d/1QNXBhd_MWTbQFaYo_tw0O2WIWA1mzLNb8ZhyvjdEXcs/edit?usp=sharing")
# estos correos deben estar en el mismo orden que los nombres de nombres_hojas
correos<-c("luisa.moreno@aflore.co",
           "tatiana.real@aflore.co",
           "esmeralda@aflore.co",
           "andresmauricio@aflore.co",
           "luzdary@aflore.co",
           "karen.fernandez@aflore.co",
           "jhiovanni.vivas@aflore.co",
           "camilo.escobedo@aflore.co",
           "jose.alvarez@aflore.co",
           "nelson.rubio@aflore.co",
           "leidy.rojas@aflore.co",
           "catalina.suarez@aflore.co")
# Juntando nombres con sus respectivos correos, deben estar en el mismo orden
nombres_hojas<-as.data.frame( cbind(nombres_hojas,correos) )

# reading the sheet
for (selected_agent in nombres_hojas[,1]) {
  
    data<-range_read("https://docs.google.com/spreadsheets/d/1QNXBhd_MWTbQFaYo_tw0O2WIWA1mzLNb8ZhyvjdEXcs/edit?usp=sharing",
                   sheet = selected_agent,
                   col_types = "Dcccccc")
    
    
    if ( max(data$`Fecha de acompañamiento`)== today() ) 
      {
      
    
    
    created_message<-gm_mime() %>%
      gm_to(  as.character( (nombres_hojas %>% filter(nombres_hojas==selected_agent))[2]  )) %>% 
      gm_cc("carolina.reyes@aflore.co") %>%
      gm_bcc("dora.giraldo@aflore.co") %>% 
      gm_from("luis.barrios@aflore.co") %>%
      gm_subject(paste0("Plan de acción acompañamiento de ", selected_agent )) %>%
      gm_text_body(
      paste0( 
        "Hola ",selected_agent," !","\n",
        "Te envío el resumen del acompañamiento realizado el día de hoy junto a ",data$`Realiza el acompañamiento`[nrow(data)],"\n","\n",
        "Realizó el acompañamiento: ","\t", data$`Realiza el acompañamiento`[nrow(data)] ,"\n",
        "Fecha de acompañamiento: ","\t", data$`Fecha de acompañamiento`[nrow(data)] ,"\n",
        "Plazo: ", "\t", data$Plazo[nrow(data)] ,"\n", "\n",
        
        "A mejorar: ", "\n", data$`A mejorar`[nrow(data)] ,"\n","\n",
        "Aspectos donde se evidencia avance vs acompañamientos anteriores: ", "\n", data$`Aspectos donde se evidencia avance vs acompañamientos anteriores`[nrow(data)] ,"\n","\n",
        "Plan de acción: ", "\n", data$`Plan de acción`[nrow(data)] ,"\n","\n",
        "Observaciones: ", "\n", data$Observaciones[nrow(data)] ,"\n", "\n",
        " 'MENSAJE AUTOMÁTICO ' "
            ) 
                )
    
    gm_send_message(created_message,user_id = "me")
    
      }
  
}
# OBSERVACIONES:
# CADA HOJA DEBE ESTAR CON SU RESPECTIVO CORREO PARA QUE EL ENVÍO SE HAGA CORRECTAMENTE, POR LO TANTO
# LO IDEAL ES QUE NO SE MODIFIQUE EL ORDEN DE LAS HOJAS DEL SHEET PLANES DE ACCIÓN, EN CASO SE HAGA
# SE ME DEBE INFORMAR PARA HACER LOS CAMBIOS RESPECTIVOS, POSTERIORMENTE DEJARÉ EL CÓDIGO MÁS
# AUTOMATIZADO PARA QUE NO TENGAMOS ESTE PROBLEMA
# token : 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