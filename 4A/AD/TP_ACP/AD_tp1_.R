#----------------------------------------------------------------------
#-------------------- TP 1 : ANALYSE DE DONNEES -----------------------
#----------------------------------------------------------------------


#-----------------------importer un fichier----------------------------

#------------ librairie necessaire pour faire une acp -----------------
library("FactoMineR")
library("psych")
library("Hmisc")
library(factoextra)

#---------------------- Etude statistiques ----------------------------
mydata <- PUB

# Pour avoir un aperçu des données statistiques utilisées ainsi que leur type
str(mydata)

# Pour avoir un resumé des données
summary(mydata)

#preparation des données
rownames(mydata)<- mydata$Pays
mydata<-mydata[,-1]

head(mydata)

# Pour obtenir les variables, la quantité, ma moyenne, la médiane...
psych::describe(mydata)
# Le nom de la librairie est facultatif

#-------------------- Matrice de correlation --------------------------

# Permet d'obetnir la matrice de corrélation ainsi que les p-valeurs
rcorr(as.matrix(mydata))
# C'est une matrice symétrique. Sur la diagonale de cette matrice on a rien d'écrit

#------------------------------- ACP ----------------------------------

# On fait l'ACP
mydata.pca = PCA(mydata, scale.unit=TRUE, ncp=6, graph=FALSE)

# On regarde comment est composé mydata.pca
str(mydata.pca)

#Pour accèder aux valeurs propres et à leur pourcentage
mydata.pca$eig
# On a généré 6 composantes principales
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

#Pour accèder aux ..
mydata.pca$ind

#Contributions
mydata.pca$ind$contrib

# Pour avoir le tableau du poly page 52 
mydata.pca$var$cos2

# On affiche le graphique de l'acp
plot.PCA(mydata.pca, axes=c(1,2),choix="var")
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

