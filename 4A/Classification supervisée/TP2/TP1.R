## ----setup, include=FALSE-----------------------------------
knitr::opts_chunk$set(echo = TRUE)


## ----cars---------------------------------------------------
summary(cars)


## -----------------------------------------------------------
library(ggplot2)


## -----------------------------------------------------------
# 1. Reprise des exemples du cours

# 1.1 Test du Khi-deux

V3V1<-matrix(c(30,20,30,20,10,15,10,15),4,2,byrow=TRUE) 
V3V1
chi2 = chisq.test(V3V1)
str(chi2)
chi2 
1-pchisq(5.3571,3)  # calcul de la statistique du khi-deux en effectuant la somme de ces contributions.
sum(chi2$residuals^2)

# p-values calculées à partir de la fonction de répartition de la loi de khi-2 de degré 3 (4-1) * (2-1)
# et de la valeur de la statistique khi-2 ( statistique de test).
# p-value supérieure à 0.05, donc on ne rejette pas l'hypothèse d'indépendance H0.

# 1.2 Test de Fisher

x <- c(4,5,7,8,9,2,3,4,6,7,8) 
y <- c(rep(0,5),rep(1,6)) 
cbind(x,y)
lm(x~factor(y))
factor(y)
anova(lm(x~y))
SCF <- (mean(x[1:5])-mean(x))^2*5+(mean(x[6:11])-mean(x))^2*6 
SCR <- sum(c((x[1:5]-mean(x[1:5]))^2,(x[6:11]-mean(x[6:11]))^2)) 
Fstat <- (SCF/1)/(SCR/9)
pval <- pf(Fstat,1,9,lower.tail=FALSE)
pval
Rsq <- SCF/(SCF+SCR)
Rsq
c(SCF,SCR,Fstat,pval,Rsq)
summary(lm(x~y))$r.squared
pchisq(6.585^2,df = 1, lower.tail = FALSE)

# Ratio de deux tests du khi deux : test de Fisher.

# La p-valeur est supérieure au seuil fixé. Y n'a donc pas d'effet significatif sur la variable X.
# 9 : nombre d'échantillons - nombre de modalités = 11 - 2 = 9
# 1 : nombre de modalités - 1 = 2-1= 1

# Réalisation d'une anova avec une hypothèse HO suivant une loi de Ficher à n-k, k-1 degrés de liberté.


# 2. Analyse préliminaire du jeu de données iris, ANOVA et MANOVA

# 2.1 Analyse préliminaire du jeu de données

data("iris")

names(iris) <- c("X1","X2","X3","X4","Y")

library(dplyr) 
library(ggplot2)
iris %>%
  ggplot(aes(x = Y, y = X1)) + geom_boxplot()

library("tidyr") 
iris %>%
  gather("variable","mesure",-Y) %>% ggplot(aes(x = Y, y = mesure)) + geom_boxplot() +
  facet_wrap(~ variable, scales = "free_y")

# X3 et X4 permettent de différencier les espèces. Distributions très serrées.

# 2.2 ANOVA

# Ajustement du modèle linéaire pour X1

lm(X1 ~ Y, data = iris)
summary(lm(X1 ~ Y, data = iris)) # Résumé summary(lm(X1 ~ Y, data = iris))$r.squared


# Extension à chacune des variables

sapply(names(iris)[-5],
       function(x) summary(lm(as.formula(paste(x,"~ Y")),
                              data = iris))$r.squared)
# X3 a un r carré le plus élévé, elle explique à 94% la variable Y.
# 94 % de la variance de X4 explique Y.

# Calcul de l'ANOVA

anova(lm(X1~Y,data=iris)) 
anova(lm(X1~Y,data=iris))$`Pr(>F)` 
anova(lm(X1~Y,data=iris))$`Pr(>F)`[1]

# La p-valeur est inférieure au seuil fixé de 5% donc Y a un effet significatif sur X1.

# Extension à chacune des variables

sapply(names(iris)[-5],
       function(x) anova(lm(as.formula(paste(x,"~ Y")),
                            data = iris))$`Pr(>F)`[1])

# Les p-valeurs sont inférieures à 5%. On rejette l'hypothèse H0 (pas d'effet).
# La sous-espèce a un effet significatif pour toutes les variables.
# On ne peut pas savoir si l'ensemble X (X1, X2, X3, X4) a un effet significatif (MANOVA).

alpha_glo = 0.05 
d=4
alpha = alpha_glo/d 
alpha
pvalue = sapply(names(iris)[-5],
                function(x) anova(lm(as.formula(paste(x,"~ Y")),
                                     data = iris))$`Pr(>F)`[1])
pvalue
any(pvalue < alpha)

# Rejet de H0 pour alpha = 0.05 corrigé par Bonferroni.
# La distribution est différente entre nos groupes pour au moins un des groupes.

# TRUE : moins une des
# p-valeurs est inférieure à 0,0125 donc on rejette H_0 au risque global alpha = 0,05 !

# 2.3 MANOVA

library(GGally)
ggpairs(iris, columns = 1:4, aes(color = Y, alpha = 0.8))

# Variances : nuages de points. L'hypothèse n'est pas vérifiée.

#install.packages("mvnormtest")
library(mvnormtest) 
mshapiro.test(as.matrix(t(iris[iris$Y=="versicolor",1:4])))
mshapiro.test(as.matrix(t(iris[iris$Y=="setosa",1:4]))) 
mshapiro.test(as.matrix(t(iris[iris$Y=="virginica",1:4])))

# Les p-valeurs sont inférieures au seuil de 5% pour les sous espèces versicolor et virginica.
# La normalité n'est donc pas vérifiée pour ces deux classes.

source("BoxMTest.R") # Fichier à récupérer sur moodle 
BoxMTest(iris[,1:4],iris$Y)

# Les matrices de covariance sont significativement différentes.

iris_manova = manova(cbind(X1,X2,X3,X4)~Y,data=iris)
summary(iris_manova, test = "Wilks")

# Nous avons un effet significatif. Effet de nos variables X sur Y.

help("summary.manova")

# 3. Analyse factorielle discriminante (iris de Fisher) 

# 3.1 Calcul des matrices



V = cov.wt(iris[,1:4], method="ML")$cov

by(iris[,1:4],iris$Y, colMeans)
G =t(simplify2array(by(iris[,1:4],iris$Y, colMeans)))
G


B = cov.wt(G,wt= as.vector(table(iris$Y)), method="ML")$cov

Wi = lapply(levels(iris$Y) , function(k)
  cov.wt(iris[iris$Y == k, 1:4], method = "ML")$cov)
ni = table(iris$Y)

W = Reduce('+', Map('*', Wi,ni))/sum(ni)

norm(V-(W+B)) #2,14*10^^-15 normalement.

# 3.2 Réalisation de l'AFD

eigen(V)# Decomposition en valeurs propres
eigen(V)$values
ACP=eigen(V)$vectors
ACP
c=as.matrix(iris[,1:4])%*%ACP[,1:2]
plot(c,col=iris$Y)

c =as.data.frame(c)
names(c) <-c("C1","C2")
c%>% mutate(Y = iris$Y)%>%
  ggplot(aes(x = C1, y = C2, color = Y, shape = Y))+
  geom_point()

l=eigen(V)$values

prop_var=l/sum(l)
cumsum(prop_var)

# Discrimination assez bonne. Variance expliquée sur cette première composante doit être importante.
#explication cumulée 



## -----------------------------------------------------------

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

cumsum(prop_var)

solve(V)#inverse la matrice 

M=solve(V)%*%B
eigen(M) # Decomposition en valeurs propres
eigen(M)$values
AFD=eigen(P)$vectors
c=as.matrix(iris[,1:4])%*%AFD[,1:2]
plot(c,col=iris$Y)
c = as.data.frame(c)
names(c) <- c("C1","C2")
c %>% mutate(Y = iris$Y) %>%
  ggplot(aes(x = C1, y = C2, color = Y, shape = Y)) +
  geom_point()


l=eigen(M)$values

prop_var=l/sum(l)

cumsum(prop_var)



## -----------------------------------------------------------

cumsum(prop_var)

solve(W)#inverse la matrice 

M=solve(W)%*%B
eigen(M) # Decomposition en valeurs propres
eigen(M)$values
AFD=eigen(P)$vectors
c=as.matrix(iris[,1:4])%*%AFD[,1:2]
plot(c,col=iris$Y)
c = as.data.frame(c)
names(c) <- c("C1","C2")
c %>% mutate(Y = iris$Y) %>%
  ggplot(aes(x = C1, y = C2, color = Y, shape = Y)) +
  geom_point()


l=eigen(M)$values

prop_var=l/sum(l)

cumsum(prop_var)


#difference avec ACP
c=as.matrix(iris[,1:4])%*%ACP[,1:2]
plot(c,col=iris$Y)

c =as.data.frame(c)
names(c) <-c("C1","C2")
c%>% mutate(Y = iris$Y)%>%
  ggplot(aes(x = C1, y = C2, color = Y, shape = Y))+
  geom_point()



## -----------------------------------------------------------
G =t(simplify2array(by(iris[,1:4],iris$Y, colMeans)))

alphai0=-G%*%solve(W)%*%t(G)
alphai0  
#on prend la diagonale de la matrice qui correspond à la constante


2*solve(W)%*%t(G)#vecteur ai1 à aip


#question 22
alpha=matrix(0,5,3)
rownames(alpha)=c("intercept","X1","X2","X3","X4")
colnames(alpha) = levels(iris$Y)
for(i in 1:3){
  barXi=matrix(G[i,],4,1) #centre de Xj pour Y=i
  alpha[1,i]=-t(barXi) %*% solve(W)%*% barXi
  alpha[2:5,i]=2*solve(W) %*% barXi
}
alpha


#question 23
# cbind de 1 pour éviter les boucles sur les matrices
# pour pouvoir faire iris*alpha
# rajout de colonne de 1 fait la somme des alpha

alpha[1,1]+sum(iris[1,1:4]* alpha[2:5,1]) #score pour l'individu 1 dans la classe i 


score=as.matrix(cbind(1,iris[,1:4]))%*%alpha

score[1:10,]
 
#plus le score est élevé mieux l'individu est placé 
View(score)


Ypredit=apply(score,1,function(x) names(which.max(x)))

head(Ypredit)


Ypredit=levels(iris$Y)[apply(score,1,which.max)]
head(Ypredit)


table(Ypredit)



table(Y=iris$Y,Ypredit) 
#table de confusion
#diagonale toutes les bonnes classifications
# 3 mal classées par l'AFD car si on regardde le graphique on se rend compte que par le découpage vertical 3 sont mal classés. triangle bleu et carré vert.

TBC=mean(iris$Y==Ypredit)
TBC #taux de bon classement

TMC=mean(iris$Y==Ypredit)
TMC # taux de mauvais classement


# on a surrestimé les performances car nous avons effectué la validation sur des données déjà présentes dans le modèle


## -----------------------------------------------------------

head(iris)
length(iris)




