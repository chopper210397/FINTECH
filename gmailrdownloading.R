# install.packages("tm")
# install.packages("gmailr")
library(gmailr)
library(dplyr)
# gm_auth_configure(path = "DoMoreWithR.json")
gm_auth(path = "DoMoreWithR.json")
my_threads<-gm_threads(num_results = 100)     
latest_thread <- gm_thread(gm_id(my_threads)[[2]])

latest_thread$messages

 my_drafts = gm_drafts()  
my_history = history(start_num)
