#----------------------------------------------------------------------
#-------------------- TP 1 : ANALYSE DE DONNEES -----------------------
#----------------------------------------------------------------------

#-------------------------------Exercice 2-----------------------------

#-----------------------importer un fichier----------------------------

#------------ librairie necessaire pour faire une acp -----------------
library("FactoMineR")
library("psych")
library("Hmisc")
library(factoextra)

#------------ librairie necessaire pour lire un fichier excel----------
#install.packages("readxl")
library(readxl)

#----------------------importation des donnÈes-------------------------
mydata <- read_excel("Data_eleves.xls")
  #Suppression des donnÈes vides
mydata<-mydata[-(28:30),-16]

#---------------------- Etude statistiques ----------------------------



# Pour avoir un aperÁu des donnÈes statistiques utilisÈes ainsi que leur type
str(mydata)

# Pour avoir un resumÈ des donnÈes
summary(mydata)

#preparation des donnÈes
mydata<-data.frame(mydata)
rownames(mydata) <- mydata$eleves
mydata<-mydata[,-1]

head(mydata)


# Pour obtenir les variables, la quantitÈ, la moyenne, la mÈdiane...
psych::describe(mydata)

#-------------------- Matrice de correlation --------------------------

# Permet d'obetnir la matrice de corrÈlation ainsi que les p-valeurs
rcorr(as.matrix(mydata))
# La matrice de corrÈlation est symÈtrique. La diagonale est nulle.
# Plus la corrÈlation est proche de 1, plus les matiËres sont corrÈlÈes.
# Par exemple, Arts et Education musicale semble fortement corrÈlÈes (corrÈlation = 0.70)
# 5% d'erreur = on prend les valeurs infÈrieures ‡ 0.05 dans la matrice des p-valeurs pour valider.
# La p-value des notes d'arts et d'Èducation musicale est 0, donc les notes d'arts et d'Èducation musicale sont fortement corrÈlÈes.
# Cela signifie que les notes Èvoluent dans le mÍme sens (mÍme note en arts semble indiquer bonne note en Èducation musicale).

# Les coefficients les plus importants sont :
  # Orthographe et anglais (corrÈlation : 0.65)
  # Expression et histoire (corrÈlation : 0.59)
  # Expression et Èducation musicale (corrÈlation : 0.63)
  # Expression et arts (corrÈlation : 0.72)
  # Maths et expression (corrlation : 0.59)
  # Maths et anglais (corrÈlation : 0.70)
  # Maths et histoire (corrÈlation : 0.64)
  # Anglais et histoire (corrÈlation : 0.59)
  # Arts et Èducation musicale (corrÈlation : 0.70)

# En regardant les p-valeurs, on peut dire que les matiËres suivantes sont corrÈlÈes (5% d'erreur) :
  # Orthographe et anglais (p-value : 0.0002)
  # Expression et histoire (p-value : 0.0012) 
  # Expression et Èducation musicale (p-value : 0.0004)
  # Expression et arts (p-value : 0.0000) 
  # Maths et expression (p-value : 0.0012)
  # Maths et anglais (p-value : 0.0000) 
  # Maths et histoire (p-value : 0.0003) 
  # Anglais et histoire (p-value : 0.0011)
  # Arts et Èducation musicale (p-value : 0.0000) 


#------------------------------- ACP ----------------------------------

# On fait l'ACP
mydata.pca = PCA(mydata, scale.unit=TRUE, ncp=6, graph=FALSE)

# On regarde comment est compos√© mydata.pca
str(mydata.pca)

#Pour accÈder aux valeurs propres et ‡ leur pourcentage
mydata.pca$eig
# On a gÈnÈrÈ 6 composantes principales
# On a d√©compos√© la trace de la matrice en 6 .. On passe donc d'un tableau √† 6 variables √† un graphique avec deux axes repr√©senant toutes les variables....

# On retient le minimum de composantes principales...
# La premi√®re composante contient 44,98% de l'information...
# La premi√®re + la deuxi√®me composantes contiennes 70,7% de l'information...
# La premi√®re + la deuxi√®me + troisi√®me composantes contiennes 83% de l'information...
# On cherche plan de projection donc avec le maximum d'information possible pour le moindre co√ªt... 
# On veut que l'image projett√©e soit fid√®le au mod√®le..
# =>Ici on est pret √† prendre 83% de l'information pour repr√©senter les composantes.

# On va y ajouter de nouvelles choses :
# On sait que la trace de la matrice = 6 (somme diago =6). Donc 1/6 * la somme des diago =1 (on a calcul√© une moyenne).
# Donc on va mettre un seuil pour d√©finir d'accepter ou non une composante. 
# On va donc conserver la valeur propre si elle est sup√©rieur √† 1. 
# => Donc ici on va seulement conserver 2 valeurs propres (les deux premi√®res). => C'est la m√©thode de KAISER.

# RQ : Interpretatbilit√© ... Quand on a 8/9.. On peut discuter d'accepter ou on la composante principale...
# Dans notre cas on va devoir accepter la troisi√®me composante principale pour recup√©rer et obtenir 80% de l'information.

#Pour acc√®der aux variances
mydata.pca$var


contribution_moy_theo <- 100/nrow(mydata);

#Pour acc√®der aux ..
mydata.pca$ind

#Contributions
mydata.pca$ind$coord

# Pour avoir le tableau du poly page 52 
mydata.pca$var$cos2

# On affiche le graphique de l'acp
plot.PCA(mydata.pca, axes=c(1,2),choix="var")
plot.PCA(mydata.pca, axes=c(3,1),choix="var")
plot.PCA(mydata.pca, axes=c(2,3),choix="var")

plot.PCA(mydata.pca, axes=c(1,2),choix="ind")


# Pour aller plus loins :
mydata.pcaN = PCA(mydata, scale.unit=TRUE, ncp=6, graph=FALSE, quanti.sup = 1)
plot.PCA(mydata.pcaN, axes=c(1,2),choix="var")

mydata.pcaN = PCA(mydata, scale.unit=TRUE, ncp=6, graph=FALSE, ind.sup = c(1,2))
plot.PCA(mydata.pcaN, axes=c(1,2),choix="ind")


# POUR AVOIR LE GRAPHIQUE DES VALEURS PROPRES :
fviz_eig(mydata.pca, addlabels = TRUE, ylim = c(0, 50))
#Coupure a dim=3 donc on garde 3 facteurs
# Avec le crit√®re que Kaiser, on garde 3 axes qui repr√©sente √† eux 83% de la variance

fviz_eig(mydata.pca,choice = "eigenvalue", addlabels = TRUE )+ geom_hline (yintercept = 1, linetype = 2, color= "red")

barplot(mydata.pca$eig[,3]) + lines(c(0,20),c(80,80),type = "l", lty=2,col="red")


#Realisation CAH
#install.packages("ggplot")
library(ggplot)
library(plyr)
library(philentropy)
library(factoextra)

#diviser en 4 clusters
data.hcpc <- HCPC(mydata.pca, nb.clust = 4, proba = 1, graph=FALSE)

#visualiser gain d'inertie
plot(data.hcpc, choice="bar")

#diminuer nombre de clisters ‡ 3
data.hcpc <- HCPC(mydata.pca, nb.clust = 3, proba = 1, graph=FALSE)

#pour avoir les groupes/classes
plot(data.hcpc, choice="tree")

#analyser les vars les + explicites pour les classes
data.hcpc$desc.var$quanti$'1'
data.hcpc$desc.var$quanti$'2'
data.hcpc$desc.var$quanti$'3'



pl1 <- fviz_cluster(data.hcpc, ellipse = FALSE )
fviz_add(pl1, df=mydata, axes = c(1,2))
?fviz_add
?fviz_cluster

plot(data.hcpc,choice="map",draw.tree = F)

