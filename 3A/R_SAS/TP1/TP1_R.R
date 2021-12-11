#==========================================================================
# TP1
#==========================================================================

# Exercice 1

# --> Variables simples

# Q1 
nombre<-pi

#Q2
nombre<-round(nombre,2)

#Q3
rang<-"Sir"

#Q4
prenom<-"william"

#Q5
nom<-"JONES"

#Q6
install.packages("stringr") # a utiliser une seule fois si le package n'est pas encore installé ( telechargement du package depuis Intenet sur le PC)
library(stringr) # R va chercher le package sur l'ordinateur et on peut utiliser les fonctions dans le packages !
rang<-str_to_upper(rang)
prenom<-str_to_title(prenom)
nom<-str_to_lower(nom)
identite<-paste(rang,prenom,nom)


# --> Vecteurs

# Q1
remove(list = ls()) # on peut aussi utiliser le symbole pinceau !

# Q2
A<-c(7,26,7,18,22,18,7)

# Q3
B<-c(8,4,8,2,4,5,13)

# Q4
C<-c(10,20)

# Q5
D<-rep(7,50)

# Q6
E<-seq(0,50,2) # equivalent Ã  E<-seq(from=0,to=50,by=2)

#Q7 
# A[2] renvoie le deuxieme element du vecteur A
# Plus generalement, A[i] renvoie le i eme du vecteur A

#Q8
i<-which(A>=25) # renvoie la position des elements du vecteur A superieurs ou egaux a 25

#Q9
A[i]<-0 # change la valeur de tous les elements du vecteur A superieurs ou egaux a 25 par 0

#Q10
A+4     # ajoute 4 a tous les elements du vecteur A
2*A+4   # multiplie par 2 tous les elements du vecteur A et leur ajoute 4
exp(A)  # prend l'exponentielle de chaque element du vecteur A

# Remarque : plus generalement ( et sous certaines conditions) si on note f une fonction,
# X un vecteur et x1,...,xn ses Ã©lements, alors f(X) renvoie c(f(x1),...,f(xn))

#Q11
sum(A)      # somme de tous les elements du vecteur A
prod(A)     # produit de tous les elements du vecteur A
range(A)    # valeurs minimale et maximale du vecteur A
length(A)   # taille ( nombre d'element) du vecteur A
summary(A)  # indicateurs statistiques du vecteur A

# Q12
A+B   # renvoie un vecteur dont un element est la somme des elements 
      # de A et B siues a la meme position

# Q13
A+C  # idem que la question Q12 sauf que cette fois ci le vecteur C n'a pas
     # la meme taille que le vecteur A. R "repete" donc plusieurs fois le vecteur C
     # pour realiser la somme demandee. R previent l'utilisateur par un
     # message d'avertissement !


#Q14
rbind(A,B) # les vecteurs A et B sont empiles

#Q15
cbind(A,B)  # les vecteurs A et B sont colles cotes a cotes

#Q16
table(A) # la modalite 7 est presente 3 fois dans le vecteur A
         # la modalite 18 est presente 2 fois dans le vecteur A
         # la modalite 22 est presente 1 fois dans le vecteur A
         # la modalite 26 est presente 1 fois dans le vecteur A

#Q17
A<-sort(A)

# --> Matrices

#Q1
M <- matrix(c(1, 2, 3, 4), nrow=2, ncol=2) # creation de la matrice
M      # afficher la matrice
M[1,2] # afficher l'element a la premiere ligne et deuxieme colonne de M
M[,1]  # afficher la premiere colonne de la matrice M
M[1,]  # afficher la premiere ligne de la matrice M

#Q2
N <- matrix(c(10, 20, 30, 40), nrow=2, ncol=2)

#Q3
V <-c(1,0,3,4,5,5,0,4,5,6,3,4,0,1,3,2) 
P <- matrix(V, nrow=4, ncol=4)

#Q4
nrow(M) # nombre de lignes de M
ncol(M) # nombre de colonnes de M
dim(M)  # nombre de lignes et de colonnes de M

#Q5
M*N   # produit coefficient par coefficient
M%*%N # produit matriciel

#Q6
diag(x = c(12,45,17,6), nrow=4, ncol=4, names = TRUE)

#Q7
P1 <- P[which(apply(P<3.5, 2, all)), , drop=FALSE]


# --> Table de donnees

# Q1
# Les colonnes et les lignes d'une data.frame sont des vecteurs !
# La data.frame a des proprietes similaires aux matrices !

#Q2
informations<-data.frame(
  nom = c("Isaac","Marc","Lucie"),
  sexe =c("H","H","F"),
  age=c(21,26,23),
  taille=c(1.7,1.82,1.57)
)

#Q3
summary(informations)
# Remarque  On a un format factor au lieu de character ici mais ce n'est pas bien grave !

#Q4
informations$taille # selection de la variable taille de la table informations
informations$age[2] # selection de la 2eme modalite de la variable age de la table informations

#Q5
informations <- informations[order(informations$taille,decreasing=T),]

#Q6
informations$poids<-informations$taille/2-15

# Q7

# Methode1
j<-which(informations$sexe %in% "H") # selectionne les numeros de lignes ou l'individu est de sexe masculin
mean(informations$poids[j])

# Methode 2
install.packages("dplyr") # a utiliser une seule fois si le package n'est pas encore installé ( telechargement du package depuis Intenet sur le PC)
library(dplyr) # R va chercher le package sur l'ordinateur
informations %>% group_by(sexe)%>% summarise(mean(poids,na.rm = TRUE))

# Methode 3
library(dplyr)
matable<-filter(informations,sexe=="H")
mean(matable$poids)

#Q8

# Methode 1 : Tri croissant de la table selon la variable poids et selection de
# la premiere ligne

informations[order(informations$poids),][1,]

# Methode 2 : Utilisation du which
informations[which(informations$poids==min(informations$poids)),]

#Q9
informations$IMC<- informations$poids/(informations$taille**2)

#Q10
mean(informations$taille) # moyenne
median(informations$taille) #mediane
var(informations$taille) #variance NON CORRIGEE
sd(informations$taille) # ecart type de la variance NON CORRIGE
((n-1)/n)*var(informations$taille) # variance CORRIGEE

# Exercice 2

# Q1
factorielle1<-1
for(i in 1:10){factorielle1<-factorielle1*i}

# Q2
factorielle2<-prod(c(1:10))

#Q3

factorielle<-function(n){
  message<- "Le parametre de la  fonction n'est pas un entier strictement positif !"
  if (n%%1==0 & sign(n) == 1){message<-prod(seq(1:n))}
  return(message)
}

factorielle(10)

#Q4 : On utilise la fonction ecrite a la question precedente
coeffbinomial<-function(n,p){
  resultat<-factorielle(n)/(factorielle(p)*factorielle(n-p))
  return(resultat)
}

coeffbinomial(3,1)

# Q5
depart<-1

while(factorielle(depart)<=2020){
  depart<-depart+1
}

paste("La factorielle de",depart,"vaut",factorielle(depart))



