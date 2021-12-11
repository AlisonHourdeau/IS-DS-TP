# -*- coding: utf-8 -*-
"""
Created on Sun Apr  4 22:16:25 2021

@author: sofiane.maazi
"""

#***********************************
# EXERCICE 1
#***********************************

# Q1 a)

mystere=0
type(mystere)

# Q1 b)

mystere=52.1
type(mystere)

mystere="Polytech"
type(mystere)

mystere=["table","chaise"]
type(mystere)

mystere= 5+2j
type(mystere)


# Q2) a)

semaine=("lundi","mardi","mercredi","jeudi","vendredi")
type(semaine)

semaine=["lundi","mardi","mercredi","jeudi","vendredi"]
type(semaine)


# Q2) b)

# methode 1
for jours in semaine:
    print(jours)
    
# methode 2

semaine[0]
semaine[3]  

# Q2) c)

grimoire= {"phenix": "rouge", 
           "niffleur":"noir",
           "gnome": "marron"}

# Q2) d)

grimoire["hippogriffe"] = "gris"

# N.B : Pour creer un dictionnaire, on peut le creer vide puis 
#       ajouter les elements successivement

grimoire= {}
grimoire["phenix"] = "rouge"
grimoire["niffleur"] = "noir"
grimoire["gnome"] = "marron"
grimoire["hippogriffe"] = "gris"


# Q2) e)

# Methode 1

for creatures in grimoire.items():
    print(creatures)
    
# Methode 2

for creature,couleur in grimoire.items():
    print("La couleur d'un", creature, "est", couleur,".")


#***********************************
# EXERCICE 2
#***********************************


import math
import random

# Remarque générale :
    # - random.random() : retourne nombre a virgule aleatoire dans [0,1[
    # - random.uniform() : retourne nombre a virgule aleatoire dans [a,b[
    # - random.randint() : retourne nombre entier aleatoire dans [a,b[    
       
# Q1) a)

def monRandom(n,a,b):
    """ Ceci est un commentaire de fonction
    """
    somme = 0.0
    sommeCarres = 0.0
    for i in range(n):
        x = random.randint(a,b) 
        somme = somme + x
        sommeCarres = sommeCarres + x * x
    moyenne = somme / n
    ecartType = math.sqrt(sommeCarres / n - moyenne * moyenne)
    return moyenne, ecartType

monRandom(6,40,50)

# Q1) b)

def testRandom(n,a,b):
    moyenne, ecartType = monRandom(n,a,b)
    print("moyenne:", moyenne, ", erreur:", abs(moyenne - 0.5))
    print("ecart-type:", ecartType, ", erreur:", abs(ecartType - math.sqrt(1/12)))

testRandom(6,40,50)
testRandom(1000000,40,50)


# Q2)

def monRandintSimple(n, a, b):
    res = {}
    for x in range(a, b+1):
        res[x] = 0
    for i in range(n):
        x = random.randint(a, b)
        res[x] += 1
    return res

monRandintSimple(5, 10, 15)


def monRandint(n, a, b):
    d = monRandintSimple(n, a, b)
    for x in range(a, b + 1):
        print(x, ":", d[x] / n)
    
monRandint(5,10,15)


# Q3)

def chaineADN(n):
    chaine=[]
    for i in range(n):
        nucleotide= random.randint(0,3)
        chaine.append("ATCG"[nucleotide])
    return(chaine)

chaineADN(6)


# Q4)

def permut(liste):
    lcopy = liste[:]
    res = []
    for t in liste:
        j = random.randint(0, len(lcopy) - 1)
        res.append(lcopy[j])
        lcopy.pop(j)
    return res

permut(["rouge","bleu","jaune"])



#***********************************
# EXERCICE 3
#***********************************
	

# Q1

# Methode 1

def geom0(p0,q,t) :
    return (p0*q**t)

geom0(1,2,3)

# Methode 2


def f(x):
    return(2*x)

def astuce(p0,f,t):
    p = p0
    for i in range(t):
        p = f(p)
    return p
    
astuce(1,f,3)


# Q2

def arithm(r0,raison,t):
    return(r0+t*raison)

arithm(1,1,3)


# Q3

# Remarque
# 2 facons de tracer des graphes sous Python : 
    # - 1. fonction plot() de matplotlib.pylab 
    # - 2. fonction plot() de sympy.
    
# arange : permet de choisir les valeurs des axes des abscisses
    
from matplotlib.pylab import plot, arange

# Exemples:
    
import matplotlib.pyplot as plt

X = arange(0,6,1) 
Y1 = arithm(1,2,X)
Y2=geom0(1,2,X)
plt.xlim(0,7)
plot(X,Y1) 
plot(X,Y2)


# Bonus :
    
import numpy as np
import matplotlib.pyplot as plt

x = np.linspace(0, 2*np.pi, 30)
y = np.cos(x)
plt.plot(x, y)
plt.xlim(-1, 5)


# Q4 a)


def  seuil(k) :
    v = 1           
    t=0             
    while v <= k:   
        v = 2*v        
        t=t+1         
    return t,v

seuil(21) # test

# Q4 b)

seuil(1000)

# Q4 c)

arithm(1,2,10)

# Q4 d)

# Au temps t=10, on a 1000 habitants pour 21 ressources toutes choses
# egales par ailleurs...


import pandas
import matplotlib
import scipy 
import numpy 


# 5) a)

foot = pandas.read_csv('C:/Users/sofiane.maazi/Documents/japon.csv')
foot.head() # pour voir les premieres lignes


# 5) c)

# q= racine 30eme de v30/v0
v0= 83.6
v30=116.8

q= (v30/v0)**(1/30)

# On en déduit la valeur pour 1973 (t=23 ici car on change d'échelle !)

vsolution= v0*(q**23) # 108 environ : c'est coherent d'apres la table Japon !

# Calculons la population en 1990 avec ce modele

v40=v0*(q**40) # 130 alors que dans le tableau on est plus a 123.5 !
