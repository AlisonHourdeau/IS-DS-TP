#----------------------------------------------------------------------
  #-------------------- TP 2 : AFC -----------------------
#----------------------------------------------------------------------

#Importation des packages
library("FactoMineR")
library("psych")
library("Hmisc")
library(factoextra)
library(readxl)

#----------Lecture et préparation des données----------
mydata <- read_excel("data-look-virgule.xls")
str(mydata)

head(mydata)

mydata <- data.frame(mydata)
rownames(mydata) <- mydata$libellé
mydata<-mydata[,-1]
head(mydata)

#-----------Realisation de l'AFC-----------
mydata.ca = CA(mydata, ncp = 4, graph = FALSE)

str(mydata.ca)


#-----------Analyse des résultats-----------
#Valeurs propres
mydata.ca$eig

#4 premiers axes en fonction des marques
mydata.ca$col

#4 premiers axes en fonction des attributs
mydata.ca$row

#premier plan factoriel
mydata.ca = CA(mydata, ncp=2, graph=TRUE)