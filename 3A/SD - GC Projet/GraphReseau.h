/* GraphReseau.h */

#define NIL_lr (struct liste_graph_reseau *) 0
#define NIL_mr (struct maillon_graph_reseau *) 0


/*********************************************************************************************
 * HYPOTHESE DE DEPART
 *
 * Tous les noms de sommets sont des numéros allant de 1 jusqu'à n (n soit le nombre de sommets)
 *
 * *******************************************************************************************/

/*********************************************************************************************
 * IMPLANTATION
 *
 * Spécification de l'implantation
 *
 * Implantation de Graph Réseau :
 *
 * Les maillons sont alloués dynamiquement.
 * Le champ next du dernier maillon vaut (struct maillon_graph_reseau*)0
 *
 * Le champ tete d'une liste pointe vers le premier maillon
 * La liste vide est codée par (tete)= ((struct maillon_grpah_reseau*)0
 *
 * Des listes distinctes ont des maillons distincts (pas de maillon partagé).
 *
 * Un graph de réseau est un tableau de taille n ( nombre de sommets ) de liste chainée
 * Chaque liste correspond à tous les arcs lié à un sommet
 * Identifiant de liste correspond au nom du sommet et les maillons contient les informations
 * de sommet de l'arrivé de l'arc, la capacité et flot
 *********************************************************************************************/


struct maillon_graph_reseau {
    int id;
    int flot;
    int capacite;
    struct maillon_graph_reseau * next;
};


struct liste_graph_reseau {
    int id;
    struct maillon_graph_reseau * head;
};
