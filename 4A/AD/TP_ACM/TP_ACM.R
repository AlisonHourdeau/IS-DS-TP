#----------------------------------------------------------------------
#-------------------- TP 2 : AMC -----------------------
#----------------------------------------------------------------------

#Importation des packages
library("FactoMineR")
library("psych")
library("Hmisc")
library(factoextra)
library(readxl)

#----------Lecture et préparation des données----------
mydata=read.table("Race-canine.txt",sep="\t", head=T,encoding = "latin1", colClasses = "factor" )
head(mydata)

rownames(mydata) <- mydata$Race
mydata<-mydata[,-1]
head(mydata)

#-----------Realisation de l'ACM-----------
library(ggplot2)
mydata.mca = MCA(mydata, graph=FALSE,quali.sup = 7,ncp=3)
library(plyr)


#-----------Analyse des résultats-----------
#Valeurs propres
  #sous forme de tableau
mydata.mca$eig

  #sous forme de graphique 
fviz_eig(mydata.mca, addlabels = TRUE)

#Inertie moyenne (Critère de Kaiser)

sum(mydata.mca$eig[,2]>(100/nrow(mydata.mca$eig)), na.rm=TRUE)
  #ou
  #sum(mydata.mca$eig[,1]>(sum(mydata.mca$eig[,1])/nrow(mydata.mca$eig)), na.rm=TRUE)

  #Graphique
fviz_screeplot (mydata.mca) +
geom_hline (yintercept = 100/nrow(mydata.mca$eig), linetype = 2, color = "red")

#Inertie totale
which(mydata.mca$eig[,3]>80)[1]

  #Graphique
barplot(mydata.mca$eig[,3])
lines(c(0,20),c(80,80))

##Q2##
mydata.mca$var$contrib
mydata.mca$var$cos2
mydata.mca$var$coord
sign(mydata.mca$var$coord)

#Q 3
Taille=colSums(mydata.mca$var$contrib[1:3,])
Poid=colSums(mydata.mca$var$contrib[4:6,])
Velocité=colSums(mydata.mca$var$contrib[7:9,])
Intellegence=colSums(mydata.mca$var$contrib[10:12,])
Affection=colSums(mydata.mca$var$contrib[12:14,])
Agressivité=colSums(mydata.mca$var$contrib[14:16,])
rbind(Taille,Poid,Velocité,Intellegence,Affection,Agressivité)

#Q4
nrow(mydata)
mydata.mca$ind$contrib
mydata.mca$ind$cos2
mydata.mca$ind$coord
sign(mydata.mca$ind$coord)

#Q5
mydata.mca$quali.sup

#Q6
  #Graphique individus
fviz_mca_ind(mydata.mca,)

  #Graphique variables catégories
fviz_mca_var(mydata.mca, repel = TRUE)

  #Map Dim1 et 2
plot(mydata.mca, axes = c(1,2), choix="ind", invisible = c("var","quali.sup"))
     ?plot.MCA

#CAH
library(ggplot2)
library(plyr)
library(philentropy)
library(factoextra)

data.hcpc <- HCPC(mydata.mca, nb.clust = 4, proba = 1, graph = FALSE)
plot(data.hcpc, choice="bar")             

plot(data.hcpc, choice="tree")
data.hcpc$desc.var$test.chi2

data.hcpc$desc.var$category$'4'

barplot(data.hcpc$desc.var$category$'1'[,1])
plot(data.hcpc,choice="map",draw.tree = F)
