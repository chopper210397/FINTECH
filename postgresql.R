# install.packages("RPostgreSQL")
library(RPostgreSQL)
drv<-dbDriver("PostgreSQL")
conexion <- dbConnect(drv,dbname="data_prueba",
                      host="localhost",port=5432,
                      user="postgres",password="rufo2324")
# consulta si existe una tabla
##dbExistsTable(conexion,"postgres")
dbCreateTable(conexion,"iris2",iris)
dbReadTable(conexion,"iris2")
dbSendQuery(conexion, "CREATE TABLE Employees(Id INTEGER PRIMARY KEY, Name VARCHAR(20))")

