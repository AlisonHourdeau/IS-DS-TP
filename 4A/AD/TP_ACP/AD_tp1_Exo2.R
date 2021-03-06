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

#----------------------importation des donn�es-------------------------
mydata <- read_excel("Data_eleves.xls")
  #Suppression des donn�es vides
mydata<-mydata[-(28:30),-16]

#---------------------- Etude statistiques ----------------------------



# Pour avoir un aper�u des donn�es statistiques utilis�es ainsi que leur type
str(mydata)

# Pour avoir un resum� des donn�es
summary(mydata)

#preparation des donn�es
mydata<-data.frame(mydata)
rownames(mydata) <- mydata$eleves
mydata<-mydata[,-1]

head(mydata)


# Pour obtenir les variables, la quantit�, la moyenne, la m�diane...
psych::describe(mydata)

#-------------------- Matrice de correlation --------------------------

# Permet d'obetnir la matrice de corr�lation ainsi que les p-valeurs
rcorr(as.matrix(mydata))
# La matrice de corr�lation est sym�trique. La diagonale est nulle.
# Plus la corr�lation est proche de 1, plus les mati�res sont corr�l�es.
# Par exemple, Arts et Education musicale semble fortement corr�l�es (corr�lation = 0.70)
# 5% d'erreur = on prend les valeurs inf�rieures � 0.05 dans la matrice des p-valeurs pour valider.
# La p-value des notes d'arts et d'�ducation musicale est 0, donc les notes d'arts et d'�ducation musicale sont fortement corr�l�es.
# Cela signifie que les notes �voluent dans le m�me sens (m�me note en arts semble indiquer bonne note en �ducation musicale).

# Les coefficients les plus importants sont :
  # Orthographe et anglais (corr�lation : 0.65)
  # Expression et histoire (corr�lation : 0.59)
  # Expression et �ducation musicale (corr�lation : 0.63)
  # Expression et arts (corr�lation : 0.72)
  # Maths et expression (corrlation : 0.59)
  # Maths et anglais (corr�lation : 0.70)
  # Maths et histoire (corr�lation : 0.64)
  # Anglais et histoire (corr�lation : 0.59)
  # Arts et �ducation musicale (corr�lation : 0.70)

# En regardant les p-valeurs, on peut dire que les mati�res suivantes sont corr�l�es (5% d'erreur) :
  # Orthographe et anglais (p-value : 0.0002)
  # Expression et histoire (p-value : 0.0012) 
  # Expression et �ducation musicale (p-value : 0.0004)
  # Expression et arts (p-value : 0.0000) 
  # Maths et expression (p-value : 0.0012)
  # Maths et anglais (p-value : 0.0000) 
  # Maths et histoire (p-value : 0.0003) 
  # Anglais et histoire (p-value : 0.0011)
  # Arts et �ducation musicale (p-value : 0.0000) 


#------------------------------- ACP ----------------------------------

# On fait l'ACP
mydata.pca = PCA(mydata, scale.unit=TRUE, ncp=6, graph=FALSE)

# On regarde comment est composé mydata.pca
str(mydata.pca)

#Pour acc�der aux valeurs propres et � leur pourcentage
mydata.pca$eig
# On a g�n�r� 6 composantes principales
# On a décomposé la trace de la matrice en 6 .. On passe donc d'un tableau à 6 variables à un graphique avec deux axes représenant toutes les variables....

# On retient le minimum de composantes principales...
# La première composante contient 44,98% de l'information...
# La première + la deuxième composantes contiennes 70,7% de l'information...
# La première + la deuxième + troisième composantes contiennes 83% de l'information...
# On cherche plan de projection donc avec le maximum d'information possible pour le moindre coût... 
# On veut que l'image projettée soit fidèle au modèle..
# =>Ici on est pret à prendre 83% de l'information pour représenter les composantes.

# On va y ajouter de nouvelles choses :
# On sait que la trace de la matrice = 6 (somme diago =6). Donc 1/6 * la somme des diago =1 (on a calculé une moyenne).
# Donc on va mettre un seuil pour définir d'accepter ou non une composante. 
# On va donc conserver la valeur propre si elle est supérieur à 1. 
# => Donc ici on va seulement conserver 2 valeurs propres (les deux premières). => C'est la méthode de KAISER.

# RQ : Interpretatbilité ... Quand on a 8/9.. On peut discuter d'accepter ou on la composante principale...
# Dans notre cas on va devoir accepter la troisième composante principale pour recupérer et obtenir 80% de l'information.

#Pour accèder aux variances
mydata.pca$var


contribution_moy_theo <- 100/nrow(mydata);

#Pour accèder aux ..
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
# Avec le critère que Kaiser, on garde 3 axes qui représente à eux 83% de la variance

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

#diminuer nombre de clisters � 3
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

