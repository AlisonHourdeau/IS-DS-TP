# -*- coding: utf-8 -*-
"""
Created on Thu Mar 25 10:07:39 2021

@author: sofiane.maazi
"""

#***********************************
# EXERCICE 1
#***********************************

# Question 1

def Fahrenheit(TC):
    return 32+1.8*TC

Fahrenheit(36)

# Question 2

def Celsius(TF):
    return (TF-32)/1.8

Celsius(96.8)

# Question 3

Fahrenheit(Celsius(96.8))
Celsius(Fahrenheit(36))

#***********************************
# EXERCICE 2
#***********************************

#----------------------------------------------------
# Généralités 
#----------------------------------------------------

# Question 1

import pandas
import matplotlib
import scipy 
import numpy 
import statistics as stats # Utilisation d'un alias pour le nom du module


# Question 2

foot = pandas.read_csv('C:/Users/sofiane.maazi/Documents/COURS_FINAL_2020/TP2/data.csv')
foot.head() # pour voir les premieres lignes

# Question 3

foot.shape

# Question 4

foot.info()

# Question 5

list(foot.columns)
list(foot) # c'est equivalent !

#----------------------------------------------------
# Variables quantitatives
#----------------------------------------------------

# Question 1

foot.describe()

# Question 2

foot["Age"].describe()
foot.Age.describe()    # c'est equivalent !

# Question 3

foot.Age.mean()
foot.Age.median()
foot.Age.var()
foot.Age.std()
foot.Age.min()
foot.Age.max()
stats.mode(foot.Age) # vient du packages stats ie statistics ( voir plus haut)

foot.Age.quantile([0.25, 0.50, 0.75])
foot.Age.quantile([0.2,0.3,0.6,0.15])

# Question 4

foot.Age.hist() # histogramme
foot.Age.plot(kind = "kde") # densité


# Question 5
foot.boxplot(column = "Age", grid = True)
foot.boxplot(column = "Age", grid = False)

#----------------------------------------------------
# Variables qualitatives
#----------------------------------------------------

# Question 1

foot.Club.describe()

# Question 2

foot.Club.unique()

# Question 3

foot.Club.value_counts()

# Question 4

pandas.crosstab(foot.Club, "freq")
pandas.crosstab(foot.Club, "freq", normalize=True)

# Question 5

tableau = pandas.crosstab(foot["Preferred Foot"], "freq")
tableau.plot.bar()

# Question 6

tableau.plot.pie(subplots=True, figsize = (6, 6))


#***********************************
# EXERCICE 3
#***********************************

X = [1,2,3,4,8,10]
Y = [7,10,13,16,28,34]

#=========================================================
# Methode de Wald
#=========================================================

# Question 1

from math import floor
from statistics import mean
from statistics import median

# On peut aussi importer directement tout le contenu de la bibliotheque
# On peut aussi donner un alias au nom de la bibliothèque

import statistics as stats


def separer2(U):
    n=len(U)
    m=floor(n/2)
    G=U[0:m]
    D=U[m:n+1]   
    return G,D

# Question 2

def coeffW(U,V):
    X=separer2(U)
    Y=separer2(V)
    a= (mean(Y[0])-mean(Y[1]))/(mean(X[0])-mean(X[1]))
    b= mean(Y[0])-a*mean(X[0])
    return a,b

coeffW(X,Y)
