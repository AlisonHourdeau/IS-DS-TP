/* Chemin.h */

#include "File.h"
#define NIL_lc (struct liste_chemin *) 0
#define NIL_mc (struct maillon_chemin *) 0

/*********************************************************************************************
 * IMPLANTATION
 *
 * Spécification de l'implantation
 *
 * Implantation de chemin :
 *
 * Les maillons sont alloués dynamiquement.
 * Le champ next du dernier maillon vaut (struct maillon_chemin*)0
 *
 * Le champ tete d'une liste pointe vers le premier maillon
 * La liste vide est codée par (tete)= ((struct maillon_chemin*)0
 *
 * Des listes distinctes ont des maillons distincts (pas de maillon partagé).
 *
 * Un chemin est une liste chainée
 * les maillons contient les informations (sommet et la capacité résidual)
 * la capacité résidual de sommet source est -1
 *********************************************************************************************/

struct maillon_chemin {        // Maillon source
    int id;                    // id = sommet_source
    int capacite_residual;     // capacite_residual = -1
    struct maillon_chemin * next;
};


struct liste_chemin {
    struct maillon_chemin * head;
};
