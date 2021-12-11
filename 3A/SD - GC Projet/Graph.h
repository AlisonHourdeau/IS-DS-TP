/* Graph.h */

#include "GraphReseau.h"
#include "GraphEcart.h"
#include "Chemin.h"

/*----------------------------------------------------------------------*/
/* --------------------------- GraphReseau ---------------------------- */
/*----------------------------------------------------------------------*/
/*
 * Intialiser le graph réseau à partir du fichier DIMACS
 * @param1 : le fichier DIMACS
 * @param2 : on récupere la source du graph de réseau, on utilise un int car le graph est numéroté (ref: HYOPTHESE)
 * @param3 : on récupere la fin du graph de réseau, on utiliser un int car le graph est numéroté (ref: HYPOTHESE)
 * @param4 : on récupere le nombre de sommets
 * @param5 : on récupere le nombre d'acrs
 * @return : pointeur vers un tableau de liste chainée de dimension nb_sommets alloué dynamiquement
 * les param2, param3, param4 et param5 sont récupérer pour etre utiliser dans la fonction principale de dinic
 */
/*            ----------------------------------------------            */
extern struct liste_graph_reseau * buildGraph(char *, int *, int *,int *,int *);
/*            ----------------------------------------------            */

/*
 * Imprimer le graph réseau
 * @param1 : le tableau de liste chainée de graph réseau est passé en paramétre
 * @param2 : le nombre de sommets est passé en partamtre qui permet de parcourir le tableau de liste chainée
 * @return : void (Cette fonction fait que des impressions dans la console)
 * cette fonction n'était pas demandé mais on l'a fait pour debugging
 */

/*            ----------------------------------------------            */
extern void imprimer_graph_reseau(struct liste_graph_reseau *, int);
/*            ----------------------------------------------            */

/*
 * Résultat final: le résult final sera rendu par une façon modifié de fichier DIIMACS (cf: Rapport d'analyse Partie Génération du fichier résultat)
 * @param1 : un fichier type File est pris en paramtere sur lequel les résultats seront stockées
 * @param2 : un tableau de liste chainée de graph réseau
 * @return : void : creer un fichier de result et imprime les résultats sur ce fichier
 */

/*            ----------------------------------------------            */
extern void renderResult(char *, struct liste_graph_reseau *,int, int, int, int, int);
/*            ----------------------------------------------            */

/*
 * La fonction imprime le graph réseau d'une manière plus compréhensible
 * @param1 : le graph réseau à imprimer
 * @param2 : le fichier dans le quel il faut imrpimer le grpah réseau
 * @param3 : le nombre de sommets pour parcourir le graph réseau
 * @return : void : la fonction imrpime le graph et ne fait pas de return
 */

/*            ----------------------------------------------            */
extern void renderResultV2(struct liste_graph_reseau*, char *,int,int);
/*            ----------------------------------------------            */

/*
 * Mise à jour de graph réseau, une fois qu'on a le graph d'écart final
 * On remplace les flots de graph de réseau en fonction des flots de graph d'écart
 * @param1 : un tableau de liste chainée de graph réseau
 * @param2 : un tableau de liste chainée de graph écart
 * @param3 : le nombre de sommets
 * @return : void
 */

/*            ----------------------------------------------            */
extern void updateFlowInNet(struct liste_graph_reseau *, struct liste_graph_ecart *, int);
/*            ----------------------------------------------            */

/*
 * On a fait une allocution dynamique du tableau, de la liste chainée et les maillons de graph de réseau
 * donc il faut liberer l'espace mémoire qu'on a alloué dyniqument pour le graph réseau
 * @param1 : l'addresse de graph réseau
 * @param2 : le nombre de sommets est passé en paramtre qui permet de parcourir le tableau
 * @return : void, il libere juste l'espace mémoire
 */

/*            ----------------------------------------------            */
extern void clear_liste_graph_reseau(struct liste_graph_reseau *, int);
/*            ----------------------------------------------            */




/*--------------------------------------------------------------------*/
/* --------------------------- GraphEcart --------------------------- */
/*--------------------------------------------------------------------*/

/*
 * Pour l'algorithme de dinic, on doit construire un graph d'écart.
 * On va manipuler et mettre à jour ce graph à chaque itération (cf: algorithme de dinic)
 * @param1 : on passe en paramètre le graph réseau, on va parcourir ce graph a fin de cobntruire le graph d'écart
 * @param2 : le nombre de sommets pour parcourir le tableau de graph
 * @return : le programme fait une allocution dynamique pour le grpah d'écart et
 * retourne le pointeur qui pouinte vers cette allocution mémoire
 */

/*            ----------------------------------------------            */
extern struct liste_graph_ecart * buildRG(struct liste_graph_reseau *, int);
/*            ----------------------------------------------            */

/*
 * Ce programme imprime le graph d'écart, ce n'est pas une fonction qui est demandé mais on le fait pour le debug
 * @param1 : Le graph d'écart
 * @param2 : le nombre de sommets est passé en parametre pour parcourir le tableau
 * @return : void c'est un programme d'affichage
 */

/*            ----------------------------------------------            */
extern void imprimer_graph_ecart(struct liste_graph_ecart *, int);
/*            ----------------------------------------------            */

/*
 * La fonction permet de trouver le plus court chemin dans le graph d'ecart entre la source et le sink
 * @param1 : le graph d'écart est passé en parametre pour trouver le plus court chemin
 * @param2 : la valeur de sommet de source
 * @param3 : la valeur de sommet de sink
 * @param4 : le nombre de sommets pour parcourir le tableau de liste chainée
 * @param5 : bool vérifie s'il y a des chemins possibles ou pas
 *           true : s'il y a des chemins possibles  et false : si il y a plus de chemin possible
 * @return : structure liste chemin (retourne le chemin q'il a trouvé)
 */

/*            ----------------------------------------------            */
extern  struct liste_chemin * shortestPath(struct liste_graph_ecart *,int, int, int, bool *);
/*            ----------------------------------------------            */

/*
 * La fonction permet de calculer la capacité résidual minimal dans un chemin
 * @param1 : le chemin
 * @return : capcité résidual minimal de chemin (la fonction parcours la liste chainée et comprant les valeurs pour trouver le minimum)
 */

/*            ------------------------------------------
 * @param2 : le nombre de sommets pour parcourir le graph d'écart----            */
extern int minCapa (struct liste_chemin *);
/*            ----------------------------------------------            */

/*
 * La fonction libere l'espace de l'allocution dynamique de graph d'écart
 * @param1 : le grpah d'écart
 * @param2 : le nombre de sommets pour parcourir le graph d'écart
 * @return : void, il libere juste l'espace mémoire
 */
/*            ----------------------------------------------            */
extern void clear_liste_graph_ecart(struct liste_graph_ecart *, int);
/*            ----------------------------------------------            */

/*
 * La fonction fait un mise à jour de graph d'écart (change les valeurs de flot du chemin)
 * @param1 : le chemin est passé en parametre
 * @param2 : le graph d'écart est passé en parametre (qui sera mis à jour)
 * @param3 : la valuer à ajouter dans les flot de chemin (capacité résidual minimale du chemin)
 */

/*            ----------------------------------------------            */
extern void updateFlowInRG(struct liste_chemin *, struct liste_graph_ecart *, int);
/*            ----------------------------------------------            */




/*--------------------------------------------------------------------*/
/* --------------------------- Chemin --------------------------- */
/*--------------------------------------------------------------------*/

/*
 * La fonction permet d'initaliser un chemin. Il fait l'allocution dynamique également
 * @return : la fonction retourne le pointeur de l'allocution mémoire du chemin
 */

/*            ----------------------------------------------            */
extern struct liste_chemin * init_liste_chemin();
/*            ----------------------------------------------            */

/*
 * La fonction n'est pas demandé mais cela aide pour le debugging. CFette fonction affiche un chemin
 * @param1 : le chemin à imprimer est passé en parametre
 * @return : void car c'est une fonction d'affichage
 */

/*            ----------------------------------------------            */
extern void imprimer_chemin(struct liste_chemin *);
/*            ----------------------------------------------            */

/*
 * La fonction libere l'espace de l'allocution dynamique du chemin
 * @param1 : l'addresse du chemin
 * @return : void, il libere juste l'espace mémoire
 */

/*            ----------------------------------------------            */
extern void clear_chemin(struct liste_chemin *);
/*            ----------------------------------------------            */
