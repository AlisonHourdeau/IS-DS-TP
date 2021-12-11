#--------------------------------------------------------------------------
#----------------------------------TP1-------------------------------------
#--------------------------------------------------------------------------

#1 - Reprise des exemples du cours 
#---
  #1.1 - Test du Chi-2
V3V1<-matrix(c(30,20,30,20,10,15,10,15),4,2,byrow=TRUE)
V3V1
chi2 = chisq.test(V3V1)
str(chi2)
chi2
# H0 : les variables sont dépendantes (même moyenne)
# H1 : les variables sont indépendantes (il existe un i et un j pour 
# lesquels les moyennes sont égales)
# p-value = 0.147 > 5%. On ne rejette pas H0, on ne rejette pas l'hyp
# de non corrélation. 

1-pchisq(5.3571,3)

# p-value à partir de la fonction de rép de la loi de Khi-2 de degré 3 
# Degré 3 car #ModalitésV3-1 * #ModalitésV1 = (2-1)*(4-1) = 1*3 = 3 

sum(chi2$residuals^2)
# Statistique de Khi 2 grâce à la somme des contributions (à chercher sur internet)

#---
  #1.2 - Test de Fisher 
x <- c(4,5,7,8,9,2,3,4,6,7,8)
y <- c(rep(0,5),rep(1,6))
# y contient 5 0 puis 6 1 (deux modalités 0 ou 1)

cbind(x,y)

#Modèle linéaire
lm(x~factor(y))

factor(y)
anova(lm(x~y))
# On teste si le modèle linéaire (y) à un effet prédictif sur x
# Pourquoi dans ce sens ? 
# On cherche à prédire Y l'intérêt de le faire dans ce sens la variance de X 
# R² : à combien de pourcentage la variance de X explique la variable Y 
# Dans l'autre sens combien de variance de Y explique X pas intéressé par ça.

# Df : degrés de liberté. 
# Pour Fisher : #Modalités - 1 (K-1) et #Echantillons - #Modalités (n-K)

SCF <- (mean(x[1:5])-mean(x))^2*5+(mean(x[6:11])-mean(x))^2*6
# SCF : variance inter classe 

SCR <- sum(c((x[1:5]-mean(x[1:5]))^2,(x[6:11]-mean(x[6:11]))^2))
# SCR : variance intra classe

Fstat <- (SCF/1)/(SCR/9)
# K=2 (nombre de modalités dans la variable y (0 ou 1))
# n = 11 (nombre de lignes)
# F = (SCF / (K-1)) / (SCR / (n-K))
# F : statistique de test de Fisher 

pval <- pf(Fstat,1,9,lower.tail=FALSE)
pval
# H0 : il n'y a pas de lien entre x et y 
# H1 : il y a un lien entre x et y
# p-value = 0.269 > 5% . On ne rejette pas H0. On ne rejette pas le fait
# que Y n'a pas d'influence sur X.

Rsq <- SCF/(SCF+SCR)
Rsq
# R² = 0.134 faible donc X n'explique pas bcp Y

c(SCF,SCR,Fstat,pval,Rsq)
summary(lm(x~y))$r.squared
pchisq(6.585^2,df = 1, lower.tail = FALSE)

# 2 - Analyse préliminaire du jeu de données iris, ANOVA et MANOVA
#---
  #2.1 Analyse préliminaire du jeu de données iris

# Chgmt des données
data("iris")

# Changement de noms des variables
names(iris) <- c("X1","X2","X3","X4","Y")

# On veut les varibles X qui vont être utiles pour
# déterminer Y.
# X explique Y ??

# Lien graphique (boite à moustache) entre Y et X1
library(dplyr)
library(ggplot2)
iris %>%
  ggplot(aes(x = Y, y = X1)) +
  geom_boxplot()
# Y = (setosa, versicolor, virginica) = modalités
# Les écarts inter quartiles pour X1 sont importants.
# Graphiquement, X1 n'explique pas bien Y.

# Lien graphique (boite à moustache) entre Y 
# et chaque variable X
library("tidyr")
iris %>%
  gather("variable","mesure",-Y) %>%
  ggplot(aes(x = Y, y = mesure)) +
  geom_boxplot() +
  facet_wrap(~ variable, scales = "free_y")
# Les écarts inter quartiles pour X1 sont importants.
# Graphiquement, X1 n'explique pas bien Y.
# La médiane de versicolor et de viriginica sont proches,
# Donc il y a bcp de risque d'erreur. 
# Les valeurs de X3 sont différentes selon le Y.
# Donc X3 explique Y.
# Les valeurs de X4 sont différentes selon le Y.
# Donc X4 explique Y.

# Graphiquement, X3 et X4 expliquent le mieux Y.


#---
  # 2.2 ANOVA
#Ajustement modèle lineaire pour X1
lm(X1 ~ Y, data = iris)
summary(lm(X1 ~ Y, data = iris)) # Résumé
summary(lm(X1 ~ Y, data = iris))$r.squared

# X1 : R² = 0.619  

#Extension a toutes les variables 
sapply(names(iris)[-5],
       function(x) summary(lm(as.formula(paste(x,"~ Y")),
                              data = iris))$r.squared)
# X1 : R² = 0.619  
# X2 : R² = 0.401
# X3 : R² = 0.941
# X4 : R² = 0.929

# R² coefficient de détermination
# Les R² sont le plus proche de 1 pour X3 et X4. 
# X3 et X4 expliquent le mieux Y.
# X1 semble plutôt bien expliquer Y.

# Calcul de l'ANOVA (p-value du test) pour X1
anova(lm(X1~Y,data=iris))
anova(lm(X1~Y,data=iris))$`Pr(>F)`
anova(lm(X1~Y,data=iris))$`Pr(>F)`[1]
# H0 : il n'y a pas de lien entre x et y 
# H1 : il y a un lien entre x et y
# p-value < 5% : on rejette H0 donc X1 explique Y.

# Extension à chacune des variables
sapply(names(iris)[-5],
       function(x) anova(lm(as.formula(paste(x,"~ Y")),
                            data = iris))$`Pr(>F)`[1])
# p-value < 5% : on rejette H0 donc X1 explique Y.
# p-value < 5% : on rejette H0 donc X2 explique Y.
# p-value < 5% : on rejette H0 donc X3 explique Y.
# p-value < 5% : on rejette H0 donc X4 explique Y.
# X3 explique le mieux Y. X4 explique également très bien
# Y. X1 et X2 expliquent nettement moins bien Y.


#---
  # 2.3 MANOVA
library(GGally)
ggpairs(iris, columns = 1:4, aes(color = Y, alpha = 0.8))

# En diagonal, la normalité : 
  # Graphiquement, X2 a la meilleure normalité. X1 et X3 peuvent suivre une loi uniforme également.
# En haut, la corrélation
  # X3 et X4 sont fortement corrélés.
# En bas, l'homoscédasticité, renseigne sur l'homogéneité des variances.
  # Celle ci n'est pas vérifiée car les nuages de points ne sont pas homogènes.

#install.packages("mvnormtest")
library(mvnormtest)
mshapiro.test(as.matrix(t(iris[iris$Y=="versicolor",1:4])))
mshapiro.test(as.matrix(t(iris[iris$Y=="setosa",1:4])))
mshapiro.test(as.matrix(t(iris[iris$Y=="virginica",1:4])))
# p-value de setosa et virginica < 5% 
# Les tests sont siginificatifs donc on rejette H0 (hypothese de normalité).
# Setosa et Virignica ne suivent pas une loi normale.

source("BoxMTest.R") # Fichier à récupérer sur moodle
BoxMTest(iris[,1:4],iris$Y)
# On realise le test d'égalité des matrices de variance-covariance.
# Test homogénéité variances entre classes.
# La p-value est < à 5%.
# On rejette l'hypothèse d'homogénéité des variances.
# Nous ne sommes pas sous les conditions d'une MANOVA. 

iris_manova = manova(cbind(X1,X2,X3,X4)~Y,data=iris)
summary(iris_manova) 
# On rejette H0, on a bien effet des variables sur les sous especes de Y.



# 3 Analyse factorielle discriminante (iris de Fisher)
  # 3.1 Calcul des matrices

# V la matrice de variance-covariance globale non corrigée
V = cov.wt(iris[,1:4], method = "ML")$cov

# ML donne un poids de 1 à chaque individu. 

# vecteurs des moyennes sous forme de matrice
by(iris[,1:4],iris$Y, colMeans)
simplify2array(by(iris[,1:4],iris$Y, colMeans))

# matrice G de centres des classes (moyenne par sous espece et variable)
G = t(simplify2array(by(iris[,1:4],iris$Y, colMeans)))

# 16
B = cov.wt(G, wt = as.vector(table(iris$Y)) , method = "ML" )$cov

Wi = lapply(levels(iris$Y) , function(k)
    cov.wt(iris[iris$Y == k, 1:4], method = "ML")$cov)
ni = table(iris$Y)

W = Reduce('+', Map('*', Wi,ni))/sum(ni)


#17
norm(V - ( W + B))


  # 3.2 Réalisation de l'AFD

eigen(V) # Decomposition en valeurs propres
eigen(V)$values
ACP=eigen(V)$vectors
c=as.matrix(iris[,1:4])%*%ACP[,1:2]
plot(c,col=iris$Y)
c = as.data.frame(c)
names(c) <- c("C1","C2")
c %>% mutate(Y = iris$Y) %>%
  ggplot(aes(x = C1, y = C2, color = Y, shape = Y)) +
  geom_point()