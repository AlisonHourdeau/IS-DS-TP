#============================================================
# TP 2 : ENSEIGNANT Sofiane MAAZI
#============================================================

#------------------------
# Exercice 1
#------------------------

# Il est conseille de lire le Memento R dans le fichier zip avant de faire cet exercice.

# Q1
?dpois # en faisant precederune fonction de R par un point d'interrogation on obtient de la documentation dessus.
       # NB : on peut aussi saisir le nom de la fonction dans  l'onglet help ( fenetre en bas à droite) pour obtenir de l'aide.
dpois(10,3) # renvoie P(X=10) quand X suit une loi de poisson de paramètre lambda=3

# Q2
rpois(17, lambda = 10) # la lettre r de la fonction signifie random

# Q3

x<- seq(-5,5,0.001)# on modelise l'intervalle par une séquence de nombres allant  de -5 a 5
                   # avec un pas de 0.01. Bien entendu, plus le pas est petit, plus l'intervalle est fidele
  
Y<- dnorm(x,mean=0.5,sd=1.2) # On calcule l'image du vecteur x par la fonction dnorm
             # Cela est possible car nous avons vu au TP1 qu'une fonction appliquee a un vecteur
             # de R s'applique a tous les elements qui le compose.
             # On appelle cela la vectorisation et c'est une notion tres importante en R.

?plot # documentation sur la fonction plot qui sert a tracer les graphiques

plot(x,         # valeurs de l'axe des abscisses
     Y,         # image de chacune des valeurs de l'axe des abscisses par la fonction dnorm
     type="l",  # on precise a R si on veut relier les points entre eux ou pas.Ici oui, en les reliants par une ligne ( d'ou la lettre l)
     pch=2,     # forme de chacun des points ( triangle, carre, rond...)
     col=3)     # couleur du point(  numero de la couleur parmi une palette de couleures presente par defaut dans R)

# Q4

x<- seq(-5,5,0.001) # intervalle identique a celui de la question precedente

g<-pnorm(x,mean=0.5,sd=1.2) # on utilise la vectorisation. pnorm est la fonction de repartition de la loi de poisson

?plot
plot(x,g,type="b",col="blue")


#------------------------
# Exercice 2
#------------------------

# 1ere approche

# Q1
sac<-c("R","B","B","V","V","V") # chaque lettre represente une boule ( R : Rouge / B: Bleu/ V : Vert)

#Q2
?sample # obtenir de la documentation sur la fonction sample qui permet de realiser un tirage aleatoire
sample(sac, # tirage dans le vecteur sac ...
       4,   # de 4 valeurs ...
       replace=T) # avec remise 

# 2eme approche

# Q1
sac<-c("R","B","V") # chaque lettre represente une couleur de boule ( R : Rouge / B: Bleu/ V : Vert)

#Q2
sample(c("R","B","V"), # Parmi les 3 couleurs...
       4, # on en tire 4...
       replace=T, # avec remise en respectant les probabilites de depart....
       prob=c(1/6, # sur les 6 boules, 1 seule est rouge donc proba de tirer une boule rouge est de 1/6
              2/6, # sur les 6 boules, 2 sont bleues donc proba de tirer une boule bleue est de 2/6
              3/6)) # sur les 6 boules, 3 sont vertes donc proba de tirer une boule verte est de 3/6

# N.B : Si on veut que le tirage soit sans remise, il faut mettre replace=F au lieu de replace=T.
#       On peut aussi tout simplement ne pas preciser le parametre replace. En effet, par defaut
#       on a replace=F

#------------------------
# Exercice 3
#------------------------

# Le fonctionnement des graphiques simples en R est toujours le meme :
# nom_simple_du_graphique(valeurs,parametres)
# Exemple de noms simples du graphique : pie, hist,boxplot,ect
# Attention : le type du graphique dépend du type de la variable (quantitative ou qualitative !)
#             cf le diaporama du cours !

valeurs<- c(9, 9.5,10,10,12,13,15,18,18.5,19.75)

# Q1
boxplot(valeurs, # valeurs de la serie statistique
        main = "Notes des eleves", # Titre du graphique
        xlab= "Sources : Donnees fictives pour illustrer le cours !", # Nom de l'axe des abscisses
        col="#699FE4", # couleur de remplissage
        fill="blue", # couleur du trait
        ylab = "Notes obtenues sur 20") # Nom de l'axe des ordonnes

# Q2

hist(valeurs) # on peut bien entendu ajouter des parametres en option comme ci-dessus


#------------------------
# Exercice 4
#------------------------


# Q1 :

# Pour importer une table csv, il faut utiliser le bouton Import Dataset
# puis From Text(readr) puis aller chercher la table via Browse
# puis regarder l'apercu de la table et changer le delimiteur au besoin
# ( point virgule ou virgule) pour changer l'asepect de la table
#  faire un copier coller du code en bas à droite de la boite de dialogue
# c'est le code qu'il aurait fallu saisir pour realiser l'importation
# cliquer sur importer
# coller le code dans votre script pour importer ainsi automatiquement la
# table a chaque lecture de script !


# Importation de la table 1

library(readr)
voitures_couleur <- read_delim("voitures_couleur.csv", 
                               ";", escape_double = FALSE, trim_ws = TRUE)
View(voitures_couleur)

# Importation de la table 2

library(readr)
voitures_pollution <- read_delim("voitures_pollution.csv", 
                                 ";", escape_double = FALSE, trim_ws = TRUE)
View(voitures_pollution)


# Q2 :
install.packages("dplyr") # uniquement si le package n'est pas installé sur le PC
library(dplyr) # chargement du package dplyr

# On realise une fusion des deux tables selon la variable ID
table_fusion<-inner_join(voitures_couleur, # premiere table a fusionner
                         voitures_pollution, # deuxieme table a fusionner
                         by="ID")            # variable commune aux 2 tables

# Q3 :

table_filtre<- table_fusion %>% filter(Co2<=20) # Verbe filter indique qu'on filtre

# Q4 : 

table_selection<- table_filtre %>% select(Co2) #  verbe select indique qu'on selectionne

# Q5 :

table_finale<-inner_join(voitures_couleur, # on enchaine les instructions
                         voitures_pollution, # grace au symbole %>%
                         by="ID")%>%
  filter(Co2<=20) %>%
  select(Co2)

