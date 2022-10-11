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
# reading the sheet

for (selected_agent in nombres_hojas) {
  
  gm_mime() %>% gm_to("luis.barrios@aflore.co") %>% gm_from("luis.barrios@aflore.co") %>%
    gm_subject(paste0("Plan de acción acompañamiento de ", selected_agent )) %>% gm_text_body(
      paste0( 
        "Hola ",nombres_hojas[2]," !","\n",
        "Te envío el resumen del acompañamiento realizado el día de hoy junto a ",luis_barrios$`Realiza el acompañamiento`[nrow(luis_barrios)],"\n","\n",
        "Realizó el acompañamiento: ","\t", luis_barrios$`Realiza el acompañamiento`[nrow(luis_barrios)] ,"\n",
        "Fecha de acompañamiento: ","\t", luis_barrios$`Fecha de acompañamiento`[nrow(luis_barrios)] ,"\n",
        "Plazo: ", "\t", luis_barrios$Plazo[nrow(luis_barrios)] ,"\n", "\n",
        
        "A mejorar: ", "\n", luis_barrios$`A mejorar`[nrow(luis_barrios)] ,"\n","\n",
        "Aspectos donde se evidencia avance vs acompañamientos anteriores: ", "\n", luis_barrios$`Aspectos donde se evidencia avance vs acompañamientos anteriores`[nrow(luis_barrios)] ,"\n","\n",
        "Plan de acción: ", "\n", luis_barrios$`Plan de acción`[nrow(luis_barrios)] ,"\n","\n",
        "Observaciones: ", "\n", luis_barrios$Observaciones[nrow(luis_barrios)] ,"\n"
      ))
  
  
}

data<-range_read("https://docs.google.com/spreadsheets/d/1QNXBhd_MWTbQFaYo_tw0O2WIWA1mzLNb8ZhyvjdEXcs/edit?usp=sharing",
                 sheet = nombres_hojas[1],
                 col_types = "Dcccccc")
1

ifelse(luis_barrios$`Fecha de acompañamiento`[nrow(luis_barrios)]==today(),
       
mensaje<-gm_mime() %>% gm_to("luis.barrios@aflore.co") %>% gm_from("luis.barrios@aflore.co") %>%
  gm_subject(paste0("Plan de acción acompañamiento de ", nombres_hojas[2]   )) %>% gm_text_body(
    paste0( 
      "Hola ",nombres_hojas[2]," !","\n",
      "Te envío el resumen del acompañamiento realizado el día de hoy junto a ",luis_barrios$`Realiza el acompañamiento`[nrow(luis_barrios)],"\n","\n",
      "Realizó el acompañamiento: ","\t", luis_barrios$`Realiza el acompañamiento`[nrow(luis_barrios)] ,"\n",
      "Fecha de acompañamiento: ","\t", luis_barrios$`Fecha de acompañamiento`[nrow(luis_barrios)] ,"\n",
      "Plazo: ", "\t", luis_barrios$Plazo[nrow(luis_barrios)] ,"\n", "\n",
      
      "A mejorar: ", "\n", luis_barrios$`A mejorar`[nrow(luis_barrios)] ,"\n","\n",
      "Aspectos donde se evidencia avance vs acompañamientos anteriores: ", "\n", luis_barrios$`Aspectos donde se evidencia avance vs acompañamientos anteriores`[nrow(luis_barrios)] ,"\n","\n",
      "Plan de acción: ", "\n", luis_barrios$`Plan de acción`[nrow(luis_barrios)] ,"\n","\n",
      "Observaciones: ", "\n", luis_barrios$Observaciones[nrow(luis_barrios)] ,"\n"
                                                  ))
,"")

gm_send_message(mensaje,user_id = "me")
