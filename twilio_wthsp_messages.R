twilio_wthsp<-read_xlsx("twilio_wthsp_messages.xlsx")
mensajes<-read_xlsx("onlymessages.xlsx")
# install.packages("psych")
library(psych)
summary(twilio_wthsp)
# install.packages("tidytext")
# install.packages("wordcloud")
# install.packages("googlesheets4")
library(googlesheets4)
library(wordcloud)
library(tidytext)
library(writexl)
colnames(twilio_wthsp)[6]<-"from"
colnames(twilio_wthsp)[14]<-"to"
# en el "from" estan los numeros de celulares de los coordinadores creo yo
# ya me confirmó cristhian que no son los números asi que el análisis de abajo no cuenta
# numeros<-unique(twilio_wthsp$from)
# gsub("whatsapp:","",numeros)
# numeros<-substr(numeros,start = 13,stop = 1000)
# which(numeros=="3207686682")

# al parecer la unica opción es extraer de los mensajes el nombre del coordinador virtual y contar 
# cuantas menciones tiene cada uno
# mensaje<-twilio_wthsp$body
# mensaje<-as.data.frame(mensaje)

#------------- con esto conteo cuantas menciones hay por coordinador -------------#

# lo ideal es buscar solo por un nombre porque si se busca por los dos nombres del CV los numeros se reducen bastante
coordinadores<-data.frame(x=c("Laura","Tatiana","Leidy","Luisa","Natalia","Eduardo"),y="")
coordinadores[1,2]<-length( grep("Laura",mensajes$Body))
coordinadores[2,2]<-length( grep("Tatiana",mensajes$Body))
coordinadores[3,2]<-length( grep("Leidy",mensajes$Body))
coordinadores[4,2]<-length( grep("Luisa",mensajes$Body))
coordinadores[5,2]<-length( grep("Natalia",mensajes$Body))
coordinadores[6,2]<-length( grep("Eduardo",mensajes$Body))

# hay problema con jose luis y jose jhiovanni porque se repite el nombre jose
length( grep("Jose Jhiovanni Vivas",mensajes$Body))


# buscar por from y to y tratar de reconstruir una conversación en base a una variable tiempo, esto poder unirlo
# el identifiacdor unico podria ser un emoji
# hay que reunirnos con dorita

# por emojis
length( grep("👋",mensajes$Body))
# 
# para saber que no es un mensaje automatizado, habria que poner un identificador unico, tal vez
# un codigo unico para reconocer que el mensaje no es de un bot, y tendrian que hacerlo en el saludo y la despedida
# final

# working with tibbles
text_df<-tibble(line=1:594144,text=mensajes$Body)

# contando el número de veces que se usó cada palabra
word_counted<-text_df %>% unnest_tokens(word,text) %>% count(word,sort = TRUE) %>% mutate(word = reorder(word, n)) 
# graficando las palabras más usadas
text_df %>% unnest_tokens(word,text) %>% count(word,sort = TRUE) %>% 
  filter(n>60000) %>% mutate(word = reorder(word, n)) %>%
  ggplot(aes(n, word)) +
  geom_col() +
  labs(y = NULL)

# nube de palabras más usadas
word_counted %>% 
  with(wordcloud(word, n, max.words = 100))


# contando las menciones a los cv, aqui salen numeros un poco mayores porque todos estan en minuscula
word_counted %>% filter(word %in% c("laura","tatiana","leidy","luisa","natalia","eduardo")) 

word_counted %>% filter(word %in% c("luis","jhiovanni",
                                    "dulfay","luz","esmeralda","sandra","jenny","nelson","olga")) 

#-------------------------------------------------------------------------#
#-------------------- RECONSTRUYENDO UNA CONVERSACIÓN --------------------#
#-------------------------------------------------------------------------#

# buscar por from y to y tratar de reconstruir una conversación en base a una variable tiempo, esto poder unirlo
# el identifiacdor unico podria ser un emoji
# debo probar primero con la data de un día a ver que conversaciones obtengo, me interesa las columnas 
# from, to, el body y alguna variable de fecha
twilio_wthsp_27_29<-read_xlsx("twilio_wthsp_messages_27_29.xlsx")
twilio_wthsp_27_29<-read_xlsx("twilio_wthsp_messages_18_22.xlsx")
twilio_wthsp_27_29<-twilio_wthsp_27_29 %>% select(-c(`Num Segments`,`Account Sid`,`Num Media`))

# la variable direction nos informa si es inbound (entrante) o outbound api(saliente), para saber la conversación con 
# alguien debo ver que en direction diga inbound, eso significa que ese numero nos respondió, y copiar el from to de esa
# fila y pegarlo en los comandos de to y from de abajo para los callsto

# parece que al ordenarlo por date sent si tiene sentido la conversación
callsto<-twilio_wthsp_27_29 %>% filter(To=="whatsapp:+573118522234" | From=="whatsapp:+573118522234") %>% arrange(`Date Sent`)
callsto2<-twilio_wthsp_27_29 %>% filter(To=="whatsapp:+573134094551" | From=="whatsapp:+573134094551") %>% arrange(`Date Sent`)
callsto3<-twilio_wthsp_27_29 %>% filter(To=="whatsapp:+573227604074" | From=="whatsapp:+573227604074") %>% arrange(`Date Sent`)

# write_xlsx(callsto,"mensajeacoso.xlsx")
# al parecer si esta funcionando todo bien asi que ahora crearemos un data frame con todas las conversaciones que tuvieron
# respuesta (osea inbound), tal vez necesite un bucle

#                                 1. primero seleccionaremos todos los inbound, estos serian los números de los que han contestado
numerosinbound<-twilio_wthsp_27_29 %>% filter(Direction=="inbound") %>% select(From)
numerosinboundunicos<-unique(numerosinbound$From)
numerodefilas<-length(numerosinboundunicos)

# for (i in 1:numerodefilas) {
#   print(twilio_wthsp_27_29 %>% filter(To==numerosinboundunicos[i] | From==numerosinboundunicos[i]) %>% arrange(`Date Sent`) )
# }

# maybe trying with lists...

# for (i in 1:numerodefilas) {
#   lista<-twilio_wthsp_27_29 %>% filter(To==numerosinboundunicos[i] | From==numerosinboundunicos[i]) %>% arrange(`Date Sent`) 
#   
# }

# for (i in 1:numerodefilas) {
#   A<-lapply(1:numerodefilas,function(x)twilio_wthsp_27_29 %>% filter(To==numerosinboundunicos[i] | From==numerosinboundunicos[i]) %>% arrange(`Date Sent`) )
# }

# nombre<-c()
# assign(nombre,1:10)
# d<-1:3
# fun<-function(x){x^2}
# a<-sapply(d,function(x)paste0(d,1))


for (i in 1:numerodefilas) {
  assign(paste0("DF",i), twilio_wthsp_27_29 %>% filter(To==numerosinboundunicos[i] | From==numerosinboundunicos[i]) %>% arrange(`Date Sent`)) 
}
# foo<-list(paste0("DF",seq(1,numerodefilas)))
# do.call(rbind,foo)
# DFTOTAL<-rbind(  paste0("DF",seq(1,numerodefilas))   )

#                           2. DFTOTAL es mi dataframe con todas las conversaciónes para la fecha evaluada
DFTOTAL<-do.call(rbind.data.frame,mget( paste0("DF",seq(1,numerodefilas)) ))
DFTOTAL<-DFTOTAL %>% select(`Date Sent`,Body)
rm(list=paste0("DF",seq(1,numerodefilas)))

#                           3. Creando googlesheet donde pondremos los mensajes
ss3 <- gs4_create(
  "TWILIO_WTHSP_MENSAJES",
  sheets = DFTOTAL
)
#                           4. Agregando data al googlesheet existente
sheet_write(DFTOTAL, ss = ss3,sheet = "DFTOTAL")
