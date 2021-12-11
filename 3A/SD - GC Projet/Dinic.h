/* Dinic.h */

#include "Graph.h"

/*********************************************************************************************
 * IMPLANTATION
 *
 * Spécification de l'implantation
 *
 * Implantation de Dinic :
 *
 * Dinic contient que l'algorithme de dinic donné dans l'énoncé
 *********************************************************************************************/

 /*----------------------------------------------------------------------*/
 /* ------------------------------ Dinic ------------------------------- */
 /*----------------------------------------------------------------------*/

/*
 * La fonction est l'algorithme de dinic, il creer le tableau d'écart et il tourne l'algorithme, il met à jour le graph de réseau
 * @param1 : le graph de réseau est passé en paramétre
 * @param2 : le flot est passé en réference car on va le récuperer pour l'affichage
 * @param3 : le sommet source
 * @param4 : le sommet sink
 * @param5 : le nombre de sommets
 * @return : void (il met à jour le graph réseau et il fait une mise à jour de la valeur flot)
 */

/*            ----------------------------------------------            */
extern void dinic(struct liste_graph_reseau *, int *, int, int, int);
/*            ----------------------------------------------            */
