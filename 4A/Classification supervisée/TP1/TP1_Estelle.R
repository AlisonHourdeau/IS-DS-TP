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

# install.packages("mvnormtest")
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

# 15.

?cov.wt

V = cov.wt(iris[,1:4], method="ML")$cov

by(iris[,1:4],iris$Y, colMeans)
G =t(simplify2array(by(iris[,1:4],iris$Y, colMeans)))
G

# 16.

B = cov.wt(G,wt= as.vector(table(iris$Y)), method="ML")$cov

Wi = lapply(levels(iris$Y) , function(k)
  cov.wt(iris[iris$Y == k, 1:4], method = "ML")$cov)
ni = table(iris$Y)

W = Reduce('+', Map('*', Wi,ni))/sum(ni)

# 17.

# Indicateur synthétique du fait que V = W+B.
norm(V-(W+B)) #2,94*10^^-15 normalement.

# 3.2 Réalisation de l'AFD

# 18.

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

# 19

inverse_V = solve(V) # Inverse de la matrice V
result = inverse_V%*%B

# Reprise du code de l'ACP pour réaliser l'AFD

eigen(result)# Decomposition en valeurs propres
eigen(result)$values
AFD=eigen(result)$vectors
AFD
c=as.matrix(iris[,1:4])%*%AFD[,1:2]
plot(c,col=iris$Y)

c =as.data.frame(c)
names(c) <-c("C1","C2")
c%>% mutate(Y = iris$Y)%>%
  ggplot(aes(x = C1, y = C2, color = Y, shape = Y))+
  geom_point()

l=eigen(result)$values

prop_var=l/sum(l)
cumsum(prop_var)

# ACP : variance totale. On n'a pas d'information entre les classes.
# AFD : on a l'information de matrice-covariance intra classe.
# Principale différence : sur ce qu'on lui donne à décomposer dans eigen().


# 20. Remplacement de V-1 par W-1

inverse_W = solve(W) # Inverse de la matrice W
result_bis= inverse_W%*%B

# Reprise du code de l'ACP pour réaliser l'AFD

eigen(result_bis)# Decomposition en valeurs propres
eigen(result_bis)$values
AFD=eigen(result_bis)$vectors
AFD
c=as.matrix(iris[,1:4])%*%AFD[,1:2]
plot(c,col=iris$Y)

c =as.data.frame(c)
names(c) <-c("C1","C2")
c%>% mutate(Y = iris$Y)%>%
  ggplot(aes(x = C1, y = C2, color = Y, shape = Y))+
  geom_point()

l=eigen(result_bis)$values
l
prop_var=l/sum(l)
cumsum(prop_var)

# Le premier vecteur propre de solve(W)%*%B est égal à la valeur du premier vecteur propre de solve(V)%*%B mais avec un -.

l = eigen(solve(V) %*% B)$values #lambda
eigen(solve(W) %*% B)$values # lambda(1-lambda)

# 21 : comparaison en terme de visualisation des nuages de points.

# AFD : pour la classe rouge, une droite verticale suffit.
# AFD permet de mieux discriminer. 
# AFD : aucun intérêt d'ajouter une composante, la première suffit.

# 3.3 Calcul des scores discriminants

# 22.

by(iris[,1:4],iris$Y, colMeans)
G =simplify2array(by(iris[,1:4],iris$Y, colMeans)) # on enlève le t par rapport à la précédente formule.
G

resultat=2*solve(W)%*%G
resultat

r = -t(G)%*%solve(W)%*%G # prendre les résultats de la diagonale de la matrice obtenue.
diag(r)

# Sous forme d'un seul tableau

G =t(simplify2array(by(iris[,1:4],iris$Y, colMeans)))

alpha=matrix(0,5,3)
rownames(alpha) = c("intercept", "X1", "X2", "X3", "X4")
colnames(alpha) = levels(iris$Y)
for (i in 1:3) {
  barXi=matrix(G[i,], 4,1) # centres de Xj pour Y=i
  alpha[1,i]= -t(barXi)%*%solve(W)%*%barXi
  alpha[2:5,i]=2*solve(W)%*%barXi
}
alpha

# 23.

##### Individu 1 #####

# Score pour l'individu 1 dans la classe 1:
alpha[1,1] + sum(iris[1,1:4] * alpha[2:5,1]) # 185.5926

# Score pour l'individu 1 dans la classe 2:
alpha[1,2] + sum(iris[1,1:4] * alpha[2:5,2]) # 84.9868

# Score pour l'individu 1 dans la classe 3
alpha[1,3] + sum(iris[1,1:4] * alpha[2:5,3]) # -9.813089

##### Individu 2 #####

#Score pour l'individu 2 dans la classe 1
alpha[1,1] + sum(iris[2,1:4] * alpha[2:5,1]) # 151.9135

#Score pour l'individu 2 dans la classe 2
alpha[1,2] + sum(iris[2,1:4] * alpha[2:5,2]) # 71.36252

# Tout calculer en même temps
scores = as.matrix(cbind(1,iris[,1:4]))%*%alpha
scores
dim(scores)
scores[1:10,]

# 24.

names(which.max(scores[150,]))

Ypredit = apply(scores, 1, function(x) names(which.max(x)))

# On affecte l'individu dans la colonne où le score est le plus élevé :
Ypredit = levels(iris$Y)[apply(scores, 1, which.max)]
Ypredit[1:10]

table(Ypredit)

table(Y = iris$Y, Ypredit) # Matrice de confusion

# Taux de bon classement
TBC = mean(iris$Y == Ypredit) # 0.98
TBC

# Taux de mauvais classement
TMC = mean(iris$Y != Ypredit) # 0.02
TMC








