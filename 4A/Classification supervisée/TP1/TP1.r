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
# H0 : les variables sont d�pendantes (m�me moyenne)
# H1 : les variables sont ind�pendantes (il existe un i et un j pour 
# lesquels les moyennes sont �gales)
# p-value = 0.147 > 5%. On ne rejette pas H0, on ne rejette pas l'hyp
# de non corr�lation. 

1-pchisq(5.3571,3)

# p-value � partir de la fonction de r�p de la loi de Khi-2 de degr� 3 
# Degr� 3 car #Modalit�sV3-1 * #Modalit�sV1 = (2-1)*(4-1) = 1*3 = 3 

sum(chi2$residuals^2)
# Statistique de Khi 2 gr�ce � la somme des contributions (� chercher sur internet)

#---
  #1.2 - Test de Fisher 
x <- c(4,5,7,8,9,2,3,4,6,7,8)
y <- c(rep(0,5),rep(1,6))
# y contient 5 0 puis 6 1 (deux modalit�s 0 ou 1)

cbind(x,y)

#Mod�le lin�aire
lm(x~factor(y))

factor(y)
anova(lm(x~y))
# On teste si le mod�le lin�aire (y) � un effet pr�dictif sur x
# Pourquoi dans ce sens ? 
# On cherche � pr�dire Y l'int�r�t de le faire dans ce sens la variance de X 
# R� : � combien de pourcentage la variance de X explique la variable Y 
# Dans l'autre sens combien de variance de Y explique X pas int�ress� par �a.

# Df : degr�s de libert�. 
# Pour Fisher : #Modalit�s - 1 (K-1) et #Echantillons - #Modalit�s (n-K)

SCF <- (mean(x[1:5])-mean(x))^2*5+(mean(x[6:11])-mean(x))^2*6
# SCF : variance inter classe 

SCR <- sum(c((x[1:5]-mean(x[1:5]))^2,(x[6:11]-mean(x[6:11]))^2))
# SCR : variance intra classe

Fstat <- (SCF/1)/(SCR/9)
# K=2 (nombre de modalit�s dans la variable y (0 ou 1))
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
# R� = 0.134 faible donc X n'explique pas bcp Y

c(SCF,SCR,Fstat,pval,Rsq)
summary(lm(x~y))$r.squared
pchisq(6.585^2,df = 1, lower.tail = FALSE)

# 2 - Analyse pr�liminaire du jeu de donn�es iris, ANOVA et MANOVA
#---
  #2.1 Analyse pr�liminaire du jeu de donn�es iris

# Chgmt des donn�es
data("iris")

# Changement de noms des variables
names(iris) <- c("X1","X2","X3","X4","Y")

# On veut les varibles X qui vont �tre utiles pour
# d�terminer Y.
# X explique Y ??

# Lien graphique (boite � moustache) entre Y et X1
library(dplyr)
library(ggplot2)
iris %>%
  ggplot(aes(x = Y, y = X1)) +
  geom_boxplot()
# Y = (setosa, versicolor, virginica) = modalit�s
# Les �carts inter quartiles pour X1 sont importants.
# Graphiquement, X1 n'explique pas bien Y.

# Lien graphique (boite � moustache) entre Y 
# et chaque variable X
library("tidyr")
iris %>%
  gather("variable","mesure",-Y) %>%
  ggplot(aes(x = Y, y = mesure)) +
  geom_boxplot() +
  facet_wrap(~ variable, scales = "free_y")
# Les �carts inter quartiles pour X1 sont importants.
# Graphiquement, X1 n'explique pas bien Y.
# La m�diane de versicolor et de viriginica sont proches,
# Donc il y a bcp de risque d'erreur. 
# Les valeurs de X3 sont diff�rentes selon le Y.
# Donc X3 explique Y.
# Les valeurs de X4 sont diff�rentes selon le Y.
# Donc X4 explique Y.

# Graphiquement, X3 et X4 expliquent le mieux Y.


#---
  # 2.2 ANOVA
#Ajustement mod�le lineaire pour X1
lm(X1 ~ Y, data = iris)
summary(lm(X1 ~ Y, data = iris)) # R�sum�
summary(lm(X1 ~ Y, data = iris))$r.squared

# X1 : R� = 0.619  

#Extension a toutes les variables 
sapply(names(iris)[-5],
       function(x) summary(lm(as.formula(paste(x,"~ Y")),
                              data = iris))$r.squared)
# X1 : R� = 0.619  
# X2 : R� = 0.401
# X3 : R� = 0.941
# X4 : R� = 0.929

# R� coefficient de d�termination
# Les R� sont le plus proche de 1 pour X3 et X4. 
# X3 et X4 expliquent le mieux Y.
# X1 semble plut�t bien expliquer Y.

# Calcul de l'ANOVA (p-value du test) pour X1
anova(lm(X1~Y,data=iris))
anova(lm(X1~Y,data=iris))$`Pr(>F)`
anova(lm(X1~Y,data=iris))$`Pr(>F)`[1]
# H0 : il n'y a pas de lien entre x et y 
# H1 : il y a un lien entre x et y
# p-value < 5% : on rejette H0 donc X1 explique Y.

# Extension � chacune des variables
sapply(names(iris)[-5],
       function(x) anova(lm(as.formula(paste(x,"~ Y")),
                            data = iris))$`Pr(>F)`[1])
# p-value < 5% : on rejette H0 donc X1 explique Y.
# p-value < 5% : on rejette H0 donc X2 explique Y.
# p-value < 5% : on rejette H0 donc X3 explique Y.
# p-value < 5% : on rejette H0 donc X4 explique Y.
# X3 explique le mieux Y. X4 explique �galement tr�s bien
# Y. X1 et X2 expliquent nettement moins bien Y.


#---
  # 2.3 MANOVA
library(GGally)
ggpairs(iris, columns = 1:4, aes(color = Y, alpha = 0.8))

# En diagonal, la normalit� : 
  # Graphiquement, X2 a la meilleure normalit�. X1 et X3 peuvent suivre une loi uniforme �galement.
# En haut, la corr�lation
  # X3 et X4 sont fortement corr�l�s.
# En bas, l'homosc�dasticit�, renseigne sur l'homog�neit� des variances.
  # Celle ci n'est pas v�rifi�e car les nuages de points ne sont pas homog�nes.

#install.packages("mvnormtest")
library(mvnormtest)
mshapiro.test(as.matrix(t(iris[iris$Y=="versicolor",1:4])))
mshapiro.test(as.matrix(t(iris[iris$Y=="setosa",1:4])))
mshapiro.test(as.matrix(t(iris[iris$Y=="virginica",1:4])))
# p-value de setosa et virginica < 5% 
# Les tests sont siginificatifs donc on rejette H0 (hypothese de normalit�).
# Setosa et Virignica ne suivent pas une loi normale.

source("BoxMTest.R") # Fichier � r�cup�rer sur moodle
BoxMTest(iris[,1:4],iris$Y)
# On realise le test d'�galit� des matrices de variance-covariance.
# Test homog�n�it� variances entre classes.
# La p-value est < � 5%.
# On rejette l'hypoth�se d'homog�n�it� des variances.
# Nous ne sommes pas sous les conditions d'une MANOVA. 

iris_manova = manova(cbind(X1,X2,X3,X4)~Y,data=iris)
summary(iris_manova) 
# On rejette H0, on a bien effet des variables sur les sous especes de Y.



# 3 Analyse factorielle discriminante (iris de Fisher)
  # 3.1 Calcul des matrices

# V la matrice de variance-covariance globale non corrig�e
V = cov.wt(iris[,1:4], method = "ML")$cov

# ML donne un poids de 1 � chaque individu. 

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


  # 3.2 R�alisation de l'AFD

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