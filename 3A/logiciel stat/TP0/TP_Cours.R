#======================================================================================================
# ELEMENTS DE CORRECTION
# Sofiane MAAZI
# 17/03/2021
#======================================================================================================

#------------------------------------------------------------------------------------------------------
# Reponses aux questions - PARTIE 1 : Preparer le support de travail
#------------------------------------------------------------------------------------------------------

# - Installation du package dplyr

install.packages("dplyr")

# - Importation des packages

library(dplyr)
library(DT)
library(ggplot2)
library(forcats)

#------------------------------------------------------------------------------------------------------
# Reponses aux questions - PARTIE 2 : Interroger une table de donnees
#------------------------------------------------------------------------------------------------------

# Q1

# - Chargement de la table data
#   NB :  le bouton import dataset genere directement le code !

library(readr)
cinema <- read_delim("COURS_FINAL_2020/data.csv", 
                     ";", escape_double = FALSE, trim_ws = TRUE)
View(cinema)


# - Chargement de la table ecrans3D
#   NB :  le bouton import dataset genere directement le code !

library(readr)
ecrans3D <- read_delim("COURS_FINAL_2020/TP0/Correction/ecrans3D.csv", 
                       ";", escape_double = FALSE, trim_ws = TRUE)
View(ecrans3D)


#Q2
str(cinema)       # 1er apercu de la base de donnees

#Q3
summary(cinema)  # affiche des indicateurs statistiques

#Q4
dim(cinema)       # nombre de lignes et de colonnes

#Q5
Reponse<- cinema %>% select(FAUTEUILS)

#Q6
Reponse<- cinema %>% filter(FAUTEUILS>1000)

#Q7
Reponse<- cinema %>% filter(FAUTEUILS>1000,ECRANS>2)

#Q8
Reponse<- cinema %>% arrange(FAUTEUILS)
Reponse<- cinema %>% arrange(desc(FAUTEUILS))

#Q9
cinema<- cinema %>% mutate(DOTATION=FAUTEUILS+5)

#Q10
Reponse<- cinema %>% group_by(CODE_COMMUNE) %>% summarise(MOYENNE=mean(FAUTEUILS,na.rm = T))

#11
cinema2<- merge(cinema,ecrans3D,by="ID")
cinema2<- inner_join(cinema,ecrans3D,by="ID")

# N.B : On peut combiner plusieurs verbes de dplyr a la suite avec l'operateur %>%

# Ainsi :

Reponse<- cinema %>% select(FAUTEUILS) %>% filter(FAUTEUILS>1000)

# est equivalent a :

Reponse<- select(cinema,FAUTEUILS)
Reponse<- filter(Reponse,FAUTEUILS>1000)

#12
cinema2 <-cinema2 %>% rename(CODE_POSTAL=CODE_COMMUNE)

#------------------------------------------------------------------------------------------------------
# Reponses aux questions - PARTIE 3 : Proprietes du type data.frame
#------------------------------------------------------------------------------------------------------

selection<- cinema2$FAUTEUILS      # approche vectorielle
selection<- cinema2["FAUTEUILS"]   # approche table de donnees
selection<- cinema2[,"FAUTEUILS"]  # approche matricielle


#------------------------------------------------------------------------------------------------------
# Reponses aux questions - PARTIE 4 : Variables qualitatives
#------------------------------------------------------------------------------------------------------

#Q1
code_postaux_paris<-75100:75120
paris<-cinema2 %>% filter(CODE_COMMUNE %in% code_postaux_paris )

#Q2
unique(paris$COMMUNE)

#Q3

# - Methode 1
montableau<-table(paris$COMMUNE) 
addmargins(montableau) 

# - Methode 2 : mise en forme moins austere
pull(paris,COMMUNE) %>% table() %>% as.data.frame() %>% datatable(rownames = F,colnames=c("Commune","Effectifs"))

#N.B : On peut croiser plus d'une variable avec la commande table.
montableau2<-table(paris$COMMUNE,paris$`ECRANS 3D`)
addmargins(montableau2)

#Q4

# - Methode 1
prop.table(table(paris$COMMUNE)) # les effectifs sont divises par le nb total des valeurs non-manquantes

# - Methode 2
pull(paris,COMMUNE) %>% 
  table() %>% 
  prop.table() %>%
  as.data.frame() %>% 
  datatable(rownames = F,colnames=c("Commune","Frequences")) %>%
  formatPercentage("Freq",1)


#N.B : On peut utiliser la commande prop.table pour croiser plus d'une variable !

#- Pourcentage en ligne
addmargins(round(prop.table(montableau2,1)*100,2))

#- Pourcentage en colonne
addmargins(round(prop.table(montableau2,2)*100,2))

#Q5
filtre<-cinema %>% filter(CODE_COMMUNE %in% c(75105,75106) )

# Representation graphique simple

barplot(table(filtre$COMMUNE))
pie(table(filtre$COMMUNE)) # ( a eviter autant que possible !)

# Representation graphique elaboree

barplot(
  
  height = table(filtre$COMMUNE), # tableau des effectifs 
  
  main= "Repartition des cinemas a Paris", # titre principal
  xlab = "Arrondissements", # titre de l'axe des abscisses
  ylab = "Nombre de cinemas",  # titre de l'axe des ordonnees
  
  col.main= "#52d41a", # couleur du titre principal
  col.lab= c("#7f1ad4"), # couleur du titre des axes
  
  font.main= 2, # police du titre principal
  font.lab= 2, # police du titre des axes
  
  cex.main= 2, # taille du titre principal
  cex.lab= 1.7, # taille du titre des axes
  
  horiz = F, # orientation du graphique horizontale ou verticale
  
  ylim=c(0,20), # limite de l'axe des abscisses
  
  col= c("lightblue","cornsilk"), # couleurs des barres
  
  names.arg = c("5eme","6eme"), # on force le nom des étiquettes de graduations
  col.axis="#be9235", # couleur des étiquettes de graduations
  font.axis=4, # style des étiquettes de graduations
  cex.axis=1.5, # police des étiquettes de graduations
  las=1, # orientation des etiquettes
  
)

# Pour aller plus loin et obtenir de beaux graphiques, on peut utiliser
# le package ggplot !

paris<-as.data.frame(paris)

# Exemple 

ggplot(paris,aes(x=fct_infreq(COMMUNE),fill=fct_infreq(COMMUNE)))+
  geom_bar()+
  ggtitle("Cinemas parisiens")+
  xlab(label="Arrondissements")+
  ylab(label="Nomre de cinemass")+
  theme(axis.text.x=element_blank())+
  theme(legend.title=element_blank())

#------------------------------------------------------------------------------------------------------
# Reponses aux questions - PARTIE 5 : Variables quantitatives
#------------------------------------------------------------------------------------------------------

# N.B Le parametre na.rm=T permet d'enlever les valeurs manquantes dans le
# calcul des indicateurs statistiques

# Q1

variable<-cinema2$FAUTEUILS
hist(cinema2$FAUTEUILS)

# Q2 : statistique de tendance centrale 

# - Moyenne (376.089)
mean(variable,na.rm=T) 

# - Mediane (177)
median(variable,na.rm=T) 

# - Mode (177)
sort(table(variable),decreasing=T,na.rm=T)

# Q3 : nombre moyens d'ecran par commune (788 environ)
weighted.mean(variable,cinema2$ECRANS,na.rm = T) 

# Q4 : statistiques de position

# - Quartiles
quantile(variable,probs=c(0.25,0.5,0.75),na.rm=T,type=1) 

# - Deciles
quantile(variable,probs=seq(0.1,0.9,by=0.1),na.rm=T,type=1) 

# Q5
boxplot(variable)

# Q6 : statistiques de dispersion

# - Etendue
diff(range(variable,na.rm))

# Ecart interquartiles (methode 1)
IQR(variable,na.rm=T)

# Ecart interquartiles (methode 2)
q<-quantile(variable,c(0.25,0.5,0.75),na.rm=T,type=1) 
q["75%"]-q["25%"]

# - Variance corrigee et ecart type corrige
var(variable,na.rm = T) 
sd(variable,na.rm=T) 

# Variance 
n<-length(variable)
variance<-(n-1)/n*var(variable,na.rm = T) 

# Ecart-type
sqrt(variance)

# Coefficient de variation pour un echantillon
sd(variable,na.rm=T)/mean(variable,na.rm=T) 

# Q7
cinema3<- cinema2 %>% filter(!is.na(FAUTEUILS))

ggplot(data=cinema3,aes(FAUTEUILS))+
  geom_density()+
  xlab("Densite de la variable fauteuil")

#Q8

# - Methode 1
plot(ecdf(variable))

# - Methode 2

ggplot(data=cinema3,aes(x=FAUTEUILS))+stat_ecdf()+
  xlab(label="Nombre de fauteuils")+
  ylab(label="Frequence")


# NB : comment changer le nom d'une ligne ( ici 7eme ligne)
dimnames(cinema3)[[1]][7]<-"ABC" # methode 1
row.names(cinema3)[7]<-"ABC" # methode 2
