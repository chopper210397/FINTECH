# install.packages("RPostgreSQL")
library(RPostgreSQL)
drv<-dbDriver("PostgreSQL")
conexion <- dbConnect(drv,dbname="aflore-prod",
                      host="afloreprodinstance.cfkkiii2ach9.us-east-1.rds.amazonaws.com",port=5432,
                      user="labarrios",password="Ub3uM#C!StpPer6Z!Q9")
# consulta si existe una tabla
##dbExistsTable(conexion,"postgres")
dbCreateTable(conexion,"iris2",iris)
dbReadTable(conexion,"")
dbSendQuery(conexion, "CREATE TABLE Employees(Id INTEGER PRIMARY KEY, Name VARCHAR(20))")

