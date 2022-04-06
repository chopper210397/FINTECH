twilio_wthsp<-read_xlsx("twilio_wthsp_messages.xlsx")
mensajes<-read_xlsx("onlymessages.xlsx")
# install.packages("psych")
library(psych)
summary(twilio_wthsp)
# install.packages("tidytext")
# install.packages("wordcloud")
library(wordcloud)
library(tidytext)
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

twilio_wthsp %>% filter(whatsapp:+573043464061)
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
