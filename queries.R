library(DBI)
library(RMySQL)
#install.packages("dplyr")
library(dplyr)
#install.packages("ggplot2")
library(ggplot2)

MyDataBase <- dbConnect(#esta es la funcion que hace que se conecte
  drv = RMySQL::MySQL(),
  dbname = "shinydemo",
  host = "shiny-demo.csa7qlmguqrf.us-east-1.rds.amazonaws.com",
  username = "guest",
  password = "guest")

dbListTables(MyDataBase)

dbListFields(MyDataBase, 'CountryLanguage')#conexión y nombre de la tabla

DataDB <- dbGetQuery(MyDataBase, "select * from CountryLanguage") #se envia y se guarda la consulta

# El Objeto DataDB es un data frame pertenece a R
# y podemos aplicar los comandos usuales

class(DataDB)#ya es un data.frame
head(DataDB)

unique(DataDB$Language) #vemos que esta  "Spanish"

per.spanish <-  DataDB %>% filter(Language == "Spanish")

class(per.spanish)
head(per.spanish)
dim(per.spanish)

ggplot(per.spanish, aes(x = Percentage, y = CountryCode, colour = IsOfficial)) + 
  geom_point() + 
  theme_grey() + ggtitle("Personas que hablan español por país")+
  xlab("Cantidad de personas (%)") +
  ylab("País")

ggplot(per.spanish, aes(x = Percentage, y = CountryCode, colour = IsOfficial)) + 
  geom_point() + 
  theme_grey() + ggtitle("Personas que hablan español por país")+
  xlab("Cantidad de personas (%)") +
  ylab("País")

dbDisconnect(MyDataBase)
