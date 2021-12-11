#================================================================================================
# ELEMENTS DE CORRECTION COURS/TP DU 16/12/2019 et 06/01/2020
# Enseignant : Sofiane MAAZI
#================================================================================================

#------------------------------------------------------------------------
# IMPORTATION DE LA TABLE
#------------------------------------------------------------------------
library(readr)
MAGASIN <- read_csv("C:/Users/nom.prenom/TP/MAGASIN.csv") #mettre entre guillemet le chemin ou se troive le
View(MAGASIN)

#------------------------------------------------------------------------
# APERCU DE LA TABLE ET INFORMATIONS GENERALES
#------------------------------------------------------------------------
str(MAGASIN)      # affiche la structure de la table
summary(MAGASIN)  # affiche des indicateurs statistiques
dim(MAGASIN)      # renvoie le nombre de lignes et colonnes de la table

#------------------------------------------------------------------------
# INCIDENCE DES VALEURS MANQUANTES
#------------------------------------------------------------------------

X<-c(1,2,3,4,NA)  # Creation d'une serie statistique X

# Quand on tient compte des valeurs manquantes

sum(X)            # Calcul de la somme des valeurs de X 
mean(X)           # Calcul de la moyenne des valeurs de X

# Quand on ne tient pas compte des valeurs manquantes

sum(X,na.rm=TRUE)    # Calcul de la somme des valeurs de X 
mean(X,na.rm=TRUE)   # Calcul de la moyenne des valeurs de X

#------------------------------------------------------------------------
# FUSION DE TABLES
#------------------------------------------------------------------------

# Importation de la table ARTICLES

library(readr)
ARTICLES <- read_csv("nom.prenom/TP/ARTICLES.csv")
View(ARTICLES)

# Fusion (methode avec merge)

Fusion<-merge(MAGASIN,ARTICLES,by="REF")

# Fusion (methode avec dplyr)

library(dplyr)
Fusion<-inner_join(MAGASIN,ARTICLES,by="REF")

# Les 2 methodes sont equivalentes. Il faut trier par ordre croissant la table selon ID_CARD pour
# le voir !

#------------------------------------------------------------------------
# COMBINER PLUSIEURS INSTRUCTION DE DPLYR AVEC LE SYMBOLE %>%
#------------------------------------------------------------------------

# install.packages ( a executer uniquement si le package n'est pas installe)
library("dplyr")

# CONSERVER LES LIGNES DE LA TABLE OU LA REDUCTION EST STRICTEMENT
# INFERIEURE A 50% PUIS TRIER CES LIGNES PAR ORDRE CROISSANT SELON
# LA VARIABLE REDUCTION

# METHODE 1  (PAS A PAS)

A<-filter(MAGASIN,REDUCTION<0.5)
B<-arrange(A,REDUCTION)

# METHODE 2  (EQUIVALENTE)

A<- MAGASIN %>% filter(REDUCTION<0.5)
B<- A %>% arrange(REDUCTION)

# METHODE 3 (MEILLEURE METHODE !)

A<- MAGASIN %>% filter(REDUCTION<0.5) %>% arrange(REDUCTION)

#------------------------------------------------------------------------
# VARIABLES QUALITATIVES
#------------------------------------------------------------------------

# Utilisation de la fonction table() pour calculer des effectifs
# Utilisation de la fonction prop.table() pour calculer des frequences

X<-MAGASIN$RAYON # selection de la variable rayon de la table MAGASIN
                 # equivalent a X<- MAGASIN %>% select( RAYON)

A<-table(X)      # tableau des effectifs pour chaque modalité de la variable RAYON


B<-cumsum(A)     # tableau des effectifs cumules 

C<-A/sum(A)      # tableau des frequences 
                 # equivalent a C<-prop.table(X)

D<- cumsum(C) # tableau des frequences cumulees


# -> Graphique secteurs (frequences)

pie(A,
    main=paste0("Rayons du magasin"),
    col=c("#DFA847","#699FE4","blue","red","green","grey","pink"))

# -> Graphique barres (effectifs)

barplot(A,
        main=paste0("Rayons","\n","du magasin"),
        col=c("#DFA847","#699FE4","blue","red","green","grey","pink"))

#------------------------------------------------------------------------
# VARIABLE QUANTITATIVE
#------------------------------------------------------------------------

# Importer la table TV
# Tracer un histogramme

hist(TV$heures.tv,  # variable consideree
     main = "Nombre d'heures passees devant la television par jour", # titre du graphique
     xlab = "Heures",  # titre de l'axe des abscisses
     ylab = "Effectif",# titre de l'axe des ordonnees
     col = "orange")   # couleur du graphique

# Calcul des quantiles d'une serie de note d'eleves

quantile(c(9, 9.5,10,10,12,13,15,18,18.5,19.75), # serie statistique consideree
         type=2,  # methode de calcul des quantiles
         probs=c(0.3, 0.9) # quantiles demandes ( par defaut ce sont les quartiles)
         )

# Diagramme a moustaches

boxplot(c(9, 9.5,10,10,12,13,15,18,18.5,19.75), # serie statistique consideree
        main = "Notes des eleves",              # titre du graphique
        xlab= "Sources : Donn?es fictives pour illustrer le cours !", # titre axe des ordonnees
        col="red", # couleur du graphique
        ylab = "Notes obtenues sur 20" #titre de l'axe des ordonnees
        )

# Diagrammes a moustaches de deux series statistiques
# Identique aux lignes de codes precedentes sauf qu'on ajoute une serie

boxplot(c(2, 8,8.5,9,9.25,9.25,9.75,10,10.5,19), # serie 1
        c(9, 9.5,10,10,12,13,15,18,18.5,19.75),  # serie 2
        col=c("#DFA847","#699FE4"),
        xlab= "Sources : Donn?es fictives pour illustrer le cours !",
        main = paste("Notes des eleves","\n","comparaison de groupes"),
        fill=c("blue","red"),
        ylab = "Notes obtenues sur 20")

# Calcul d'indicateurs statistiques simples sur un jeu de donnees

# Importation du jeu de donnees cars qu'on stocke dans une table voitures
data("cars")
voitures<-cars

mean(voitures$dist)   # moyenne de la variable dist de la table voiture
median(voitures$dist) # mediane de la variable dist de la table voiture

(tableau<-table(voitures$speed)) # calcul du mode de la variable speed de la table voiture
i<-which(tableau==max(tableau))  # renvoie la position des elements dansla ligne du dessous
tableau[i]

# Calcul de la variance et de l'ecart type (non corrige) pour la variable
# speed de la table voitures

(var(voitures$speed)) # variance corrigee
(sd(voitures$speed))  # ecart type corrige

# On remarque que (sd(voitures$speed)) equivaut a la racine de la variance :
sqrt(var(voitures$speed))

# Calcul de la variance et de l'ecart type (non corrige ou empirique) pour la variable
# speed de la table voitures

# Methode 1 : On ecrit une fonction qui calcule la variance

# Methode 2 : On deduit la variance non corrigee de la variance corrigee

n<-length(voitures$speed) # nombre d'observations de la variable speed
variance<-((n-1)/n) *var(voitures$speed) # variance non corrigee
sqrt(variance)  # ecart type non corrige

# Calcul du moment d'ordre r a l'aide d'une fonction

Moment<-function (X,r){
  return(mean((X-mean(X))**r))
}

Moment(voitures$speed,2) # On retrouve bien la variance non corrigee ( ou empirique)
