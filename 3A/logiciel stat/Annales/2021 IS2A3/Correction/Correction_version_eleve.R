#======================================================================================================
# ELEMENTS DE CORRECTION -Examen
# Sofiane MAAZI
# 04/04/2021
#======================================================================================================

#---------------------------------------------------------------------------------
# Packages
#---------------------------------------------------------------------------------

library(stringr)
library(stringi)
library(readr)
library(dplyr)

#---------------------------------------------------------------------------------
# Lecture des tables
#---------------------------------------------------------------------------------

disney <- read_delim("IS2A3/Examens/IS2A3/2021/Sujet/Tables/disney.csv", 
                     ";", escape_double = FALSE, trim_ws = TRUE)

echantillon <- read_delim("IS2A3/Examens/IS2A3/2021/Sujet/Tables/echantillon.csv", 
                          ";", escape_double = FALSE, trim_ws = TRUE)

CA <- read_delim("IS2A3/Examens/IS2A3/2021/Sujet/Tables/CA.csv", 
                          ";", escape_double = FALSE, trim_ws = TRUE)

data <- read_delim("IS2A3/Examens/IS2A3/2021/Sujet/Tables/data.csv", 
                   ";", escape_double = FALSE, trim_ws = TRUE)

#---------------------------------------------------------------------------------
# QCM
#---------------------------------------------------------------------------------
# 1 et 3 : Faux
# 2 et 4 : Vrai

#---------------------------------------------------------------------------------
# PARTIE 1
#---------------------------------------------------------------------------------

#Q1

table(disney$Type)

# Q2 : Fonction auxiliaire

Vert1<-function(lettre){
  conversion<-str_to_lower(lettre)
  i<-which(letters==conversion)
  return(i)
}

Vert1("A")

# Q2 : Reponse

Vert<- function(nom){ 
  Lettres<-str_split(nom,"")[[1]]
  Points_Lettre<-c()
  for (i in 1:length(Lettres)){
    Points_Lettre<- c(Points_Lettre,Vert1(Lettres[i]))
  }
  return(sum(Points_Lettre))}

Mot<-"Crochet"
Vert(Mot)

# Q3

Jaune<- function(nom){ 
  Mot<-str_to_lower(nom)
  Lettres<-str_split(nom,"")[[1]]
  valeurs<-rep(2,str_length(nom))
  for (i in 1:length(Lettres)){
    if(Lettres[i] %in% c("m","i","c","k","e","y")){
      valeurs[i]<-6
    }
  }
  print(valeurs)
  return(sum(valeurs))}

Jaune("Pinocchio")

#Q4 

Bleu <- function(nom){ 
  Mot<-str_to_lower(nom)
  Lettres<-str_split(Mot,"")[[1]]
  valeurs<-rep(2,str_length(Mot))
  for (i in 1:length(Lettres)){
    if(Lettres[i] %in% c("a","e","i","o","u")){
      valeurs[i]<-6
    }
  }
  print(valeurs)
  return(sum(valeurs))}

Bleu("Lady")

# Q5 : Vectorisation impossible !

Bleu(disney$Personnage)

#Q6

g<-function(v,f){
  for (i in 1:length(v)){
    v[i]<- as.numeric( f(v[i]))
  }
  return(v)
}

#Q7

data<- data.frame( ID=disney$ID,
                   Personnage=disney$Personnage,
                   Type=disney$Type,
                   Vert=g(disney$Personnage,Vert),
                   Jaune=g(disney$Personnage,Jaune),
                   Bleu=g(disney$Personnage,Bleu)
                   )

data$Vert<-as.numeric(as.character(data$Vert))
data$Jaune<-as.numeric(as.character(data$Jaune))
data$Bleu<-as.numeric(as.character(data$Bleu))

#---------------------------------------------------------------------------------
# PARTIE 2
#---------------------------------------------------------------------------------

#Q2

Points_Taram<- data %>% filter(Personnage=="Taram")%>% select(Vert)
numerateur<- nrow(data %>% filter(Vert<=53,Type=="M")%>% select(Vert))
denominateur<-15

(proba<-numerateur/denominateur)

# Q3

Probabilite<-function(couleur,personnage){

  # Type des personnages
  
  Type_personnage_Joueur<- data[which(data$Personnage==personnage),"Type"]
  Type_personnage_Joueur<-as.character(Type_personnage_Joueur)
  Type_personnage_Merlin<- c("M","G")[- which(c("M","G")==Type_personnage_Joueur)]
  
  # Point personnage du Joueur
  
  Points_personnage_Joueur<- data[which(data$Personnage==personnage),couleur]
  Points_personnage_Joueur<-as.numeric(Points_personnage_Joueur)
  
  # Conditions du numerateur

  Personnages_meme_type_Merlin<- data %>% filter(Type== Type_personnage_Merlin) 
  Leurs_points<- Personnages_meme_type_Merlin[,couleur]
  
  # Probabilite
  
  numerateur<- length(which(Leurs_points<= Points_personnage_Joueur))
  denominateur<-15
  
  return(numerateur/denominateur)
  
}

Probabilite("Jaune","Ratigan")


#Q4) a)


Simulation<-function(personnage_Joueur,personnage_Merlin,couleur){
  matable<- data[,c("Personnage",couleur)]
  Point1<- data %>% filter(Personnage==personnage_Joueur) 
  Point1<-Point1[couleur]
  Point2<- data %>% filter(Personnage==personnage_Merlin) 
  Point2<-Point2[couleur]
  return(as.numeric(Point1>Point2))
}

Joueur<-"Jafar"
Merlin<-"Kaa"
couleur<-"Jaune"
Simulation(Joueur, Merlin,couleur)


# Q4) b) et Q4) c)

experience<-c()

i<-which(disney$Type=="G")
gentils<-disney$Personnage[i]

for (i in 1:10){
  monstre_Joueur1<-gentils[sample(1:15,1,replace=T)]
  monstre_Joueur2<-"Malefique"
  experience<-c(experience,Simulation(monstre_Joueur1,monstre_Joueur2,"Vert"))
}

experience<-as.numeric(experience)
empirique<- sum(experience)/length(experience)


# Comparaison

(theo<- Probabilite("Vert","Malefique"))
(empirique)

# Q5 a)

M1<- paste(data$ID,"-",data$Vert)
vert<- rep("vert",30)

M2<- paste(data$ID,"-",data$Jaune)
jaune<- rep("jaune",30)

M3<- paste(data$ID,"-",data$Bleu)
bleu<- rep("bleu",30)

Referentiel<-data.frame(ID=c(M1,M2,M3),
                        couleur=c(vert,jaune,bleu))

Pratique<- data.frame(ID=paste(echantillon$ID,"-",echantillon$Points))

Resultat<- inner_join(Referentiel,Pratique,by="ID")

# Q5 b)

table(echantillon$Victoire)/10000*100

#---------------------------------------------------------------------------------
# PARTIE 3
#---------------------------------------------------------------------------------

# Q1

plot(CA$jour,CA$maison_2018,type="l")
lines(CA$jour,CA$maison_2018, col = "blue") 
lines(CA$jour,CA$boutique_2018, col = "red") 
lines(CA$jour,CA$boutique_2017, col = "green") 

# Q2

Sac<-c(rep("E",10),
       rep("A",9),
       rep("I",8),
       rep(c("N","O","R","S","T","U"),6),
       rep("L",5),
       rep(c("D","M"),3),
       rep(c("B","C","P","F","G","H","V"),2),
       rep(c("J","Q","K","W","X","Y","Z"),1)
       )


Simulation_Tirage<-function(Mot){
  mot<- str_to_upper(Mot)
  
  matable<-data.frame(Mot=str_split(mot,"")[[1]],
                       Present=rep(0,str_length(mot)))
  
  compteur<-0
  
  while(sum(matable$Present)!=nrow(matable)){
    
    Sac<-sample(Sac,length(Sac),replace=F)
    lettre<-Sac[1]
    Sac<-Sac[-c(1)]
    print(lettre)
    
    if (lettre %in% matable$Mot){
      
      i<-which(matable$Mot==lettre & matable$Present==0)

      if(length(i)!=0){
        i<-min(i)
        matable$Present[i]<-1
    } 

    }

   compteur<-compteur+1
  }
  
 return(compteur) 
}


Simulation_Tirage("jafar")