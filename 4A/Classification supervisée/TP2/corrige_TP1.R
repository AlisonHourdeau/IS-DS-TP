## ------------------------------------------------
knitr::opts_chunk$set(echo = TRUE, error = TRUE)


## ----Test du Chi-deux----------------------------
V3V1<-matrix(c(30,20,30,20,10,15,10,15),4,2,byrow=TRUE)
V3V1
chi2 = chisq.test(V3V1)
str(chi2)
chi2
1-pchisq(5.3571,3)
sum(chi2$residuals^2)


## ----Test de Fisher------------------------------
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


## ----chargement----------------------------------
data("iris")
head(iris)


## ----renommage-----------------------------------
names(iris) <- c("X1","X2","X3","X4","Y") 


## ----boxplot X1 sachant Y------------------------
library(dplyr)
library(ggplot2)
iris %>% 
  ggplot(aes(x = Y, y = X1)) + 
  geom_boxplot()


## ----boxplot des X en fonction de Y--------------
library("tidyr")
iris %>% 
  gather("variable","mesure",-Y) %>% 
  ggplot(aes(x = Y, y = mesure)) + 
  geom_boxplot() +
  facet_wrap(~ variable, scales = "free_y")


## ----Ajustement du modèle linéaire pour X1 en fonction de Y----
lm(X1 ~ Y, data = iris)
shapiro.test(iris$X1[iris$Y == "setosa"])

# Test de normalité groupe par groupe : 
by(data = iris$X1, INDICES = iris$Y, shapiro.test)
# Ici accepte l'hypothèse de normalité dans chacune des classes

# Test d'homogénité des variances : 
bartlett.test(iris$X1, iris$Y)
# p-value = 0.0003345
# On rejette l'homogénéité des variances
# Attention : conclusion du test de l'ANOVA possiblement erronnées

summary(lm(X1 ~ Y, data = iris)) # Résumé
summary(lm(X1 ~ Y, data = iris))$r.squared


## ----Ajustement du modèle linéaire de chaque X en fonction de Y----
sapply(names(iris)[-5], 
       function(x) summary(lm(as.formula(paste(x,"~ Y")), 
                              data = iris))$r.squared)


## ------------------------------------------------
anova(lm(X1~Y,data=iris)) 
anova(lm(X1~Y,data=iris))$`Pr(>F)`
anova(lm(X1~Y,data=iris))$`Pr(>F)`[1]


## ------------------------------------------------
sapply(names(iris)[-5], 
       function(x) anova(lm(as.formula(paste(x,"~ Y")), 
                            data = iris))$`Pr(>F)`[1])


## ------------------------------------------------
alpha_glo = 0.05
d = 4
alpha = alpha_glo/d
alpha

pvalue = sapply(names(iris)[-5], 
       function(x) anova(lm(as.formula(paste(x,"~ Y")), 
                            data = iris))$`Pr(>F)`[1])
pvalue
any(pvalue < alpha) # TRUE : moins une des 
# p-valeurs est inférieure à 0,0125 donc on rejette H_0 au risque global alpha = 0,05 ! La distribution de X varie en fonction du groupe Y.


## ----Nuages de point deux a deux, message=FALSE----
library(GGally)
ggpairs(iris, columns = 1:4, aes(color = Y, alpha = 0.8))


## ----Test de normalité---------------------------
# install.packages("mvnormtest")
library(mvnormtest)
mshapiro.test(as.matrix(t(iris[iris$Y=="versicolor",1:4])))
mshapiro.test(as.matrix(t(iris[iris$Y=="setosa",1:4])))
mshapiro.test(as.matrix(t(iris[iris$Y=="virginica",1:4])))


## ----Test M de Box-------------------------------
source("BoxMTest.R") # Fichier à récupérer sur moodle
BoxMTest(iris[,1:4],iris$Y)


## ----Test de la manova---------------------------
iris_manova = manova(cbind(X1,X2,X3,X4)~Y,data=iris)


## ----Résumé du test de la MANOVA-----------------
summary(iris_manova) # compléter


## ----Statistiques de test de la MANOVA-----------
help("summary.manova")
summary(iris_manova,"Pillai")
summary(iris_manova,"Wilks")  
summary(iris_manova,"Hotelling-Lawley") 
summary(iris_manova,"Roy") 


## ------------------------------------------------
V = cov.wt(iris[,1:4],method = "ML")$cov


## ------------------------------------------------
by(iris[,1:4],iris$Y, colMeans)
simplify2array(by(iris[,1:4],iris$Y, colMeans))
G = t(simplify2array(by(iris[,1:4],iris$Y, colMeans)))


## ------------------------------------------------
B = cov.wt(G, wt = as.vector(table(iris$Y)) , method = "ML")$cov


## ------------------------------------------------
Wi = lapply(levels(iris$Y), function(k)
  cov.wt(iris[iris$Y== k,1:4],method="ML")$cov) # Liste de Wi
ni = table(iris$Y)  # Vecteur de ni

W = Reduce('+',Map('*',Wi,ni))/sum(ni)


## ------------------------------------------------
# Proposer un indicateur synthétique du fait que V = W + B
norm(V - (W + B)) 


## ------------------------------------------------
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


## ------------------------------------------------
l = eigen(V)$values
l
prop_var = l/sum(l) # 0.924618723 0.053066483 0.017102610 0.005212184
cumsum(prop_var)


## ------------------------------------------------
M = solve(V) %*% B
eigen(M) # Decomposition en valeurs propres
eigen(M)$values
AFD=eigen(M)$vectors
d=as.matrix(iris[,1:4])%*%AFD[,1:2]
plot(d,col=iris$Y)

d = as.data.frame(d)
names(d) <- c("D1","D2")
d %>% mutate(Y = iris$Y) %>% 
  ggplot(aes(x = D1, y = D2, color = Y, shape = Y)) + 
  geom_point()



## ------------------------------------------------
eigen(solve(V) %*% B)$vectors 
eigen(solve(W) %*% B)$vectors

l = eigen(solve(V) %*% B)$values # lambda
eigen(solve(W) %*% B)$values # lambda/(1-lambda)
l/(1-l)


## ------------------------------------------------
i = 1 # Classe 1 (setosa)
dim(G[i,])
dim(G[i,,drop = FALSE])
Xi <- matrix(G[i,],4,1)
# Xi <- t(G[i,,drop = FALSE])
- t(Xi) %*% solve(W) %*% Xi  # Premier alpha_{i0}
2 * solve(W) %*% Xi # Les 4 autres ! 


## ------------------------------------------------
alpha=matrix(0,5,3)
rownames(alpha) = c("intercept","X1","X2","X3","X4")
colnames(alpha) = levels(iris$Y)
for (i in 1:3) {
  barXi=matrix(G[i,],4,1) # centres de Xj pour Y=i
  alpha[1,i]=-t(barXi)%*%solve(W)%*%barXi
  alpha[2:5,i]=2*solve(W)%*%barXi
}
alpha


## ------------------------------------------------
alpha[1,1] + sum(iris[1,1:4] * alpha[2:5,1]) # Score pour l'individu 1 dans la classe 1
c(1,as.matrix(iris[1,1:4])) %*% alpha[,1, drop = FALSE]
c(1,as.matrix(iris[1,1:4])) %*% alpha
head(as.matrix(cbind(1,iris[1:4])) %*% alpha)


## ------------------------------------------------
s=as.matrix(cbind(1,iris[,1:4]))%*%alpha
s[1:10,]
names(which.max(s[150,]))
Ypredit = apply(s, 1, function(x) names(which.max(x)))


## ------------------------------------------------
Ypredit=levels(iris$Y)[apply(s,1,which.max)]
Ypredit[1:10]
table(Ypredit)
table(Y = iris$Y,Ypredit) # Matrice de confusion
TBC = mean(iris$Y == Ypredit)
TBC
TMC = mean(iris$Y != Ypredit)
TMC

