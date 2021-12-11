## Contenu de l'archive

Cet archive contient le projet SD/GC : le problème de flot maximum
On utilise l'algorithm de DINIC pour résoudre ce problème : cf. Rapport pour plus de détail.

Cet carchine contient les fichiers suivant :

File.h

File.c

Chemin.h

Dinic.h

Dinic.c

GraphEcart.h

GraphReseau.h

Graph.h

Graph.c

Deplus, cet archive contient aussi notre rapport final du projet 

## Lignes de commandes pour compiler le fichier 
La commande 'make' va générer le fichier a.out 

Donc pour exécuter le fichier, il suffit de faire ./a.out DIMACS/nom_du_ficher.extension_du_fichier

Par exemple, ./a.out DIMACS/G_900_2700.max

Si vous souhaitez vérifier les leaks de mémoire, il suffit d'exécuter sur comme valgrind./a.out DIMACS/nom_du_ficher.extension_du_fichier

Par exemple, valgrind ./a.out DIMACS/G_900_2700.max

## Pour toute autre explication, acceder à notre rapport final 

