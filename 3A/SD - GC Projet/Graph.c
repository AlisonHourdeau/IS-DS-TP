/* Graph.c */

#include "Graph.h"


/* Reseau */

/*
 * FONCTION STATIC
 * La fonction permet d'ajouter en tete de liste de successeurs d'un sommet.
 * liste_graph_reseau contient deja le sommet de départ, dans la liste on enchaine
 * des des succsuers de ce sommet avec capacité (qui est passé en parametre)
 * @param1 : me sommet d'arrivé
 * @param2 : capacité de l'arcs
 * @param3 : La liste dans le quel il faut ajouter en ete est passé en parametre
 * @return : void : la fonction fait qu'un ajout en tete donc cette fonction ne fait pas de return
 */
static void ajout_en_tete_graph_reseau(int terminal, int cap, struct liste_graph_reseau * T){
    struct maillon_graph_reseau * nouveau = (struct maillon_graph_reseau *) malloc(sizeof(struct maillon_graph_reseau));

    nouveau -> id = terminal;
    nouveau -> flot = 0;
    nouveau -> capacite = cap;
    nouveau -> next = T-> head;

    T -> head = nouveau;
}

/*
 * FONCTION STATIC
 * La fonction permet d'imprimer un grpah d'ecart dans la console
 * La fonction imprime la liste des successeurs d'un sommet donc c'est une case de tabReseau
 * C'est une sous-fontion de imprimer_graph_reseau
 * @param1 : la liste de successeurs à imprimer est passé en parametre
 * @return : void : cette fonction affiche les donné dans la console de ne fait aucun return
 */

static void imprimer_liste_graph_reseau(struct liste_graph_reseau L) {
    struct maillon_graph_reseau* M;
    M = L.head;

    while (M!=NIL_mr) {
        printf("id : %d flot: %d capacite: %d\n",M->id, M->flot,M->capacite);

        M = M->next;
    }
}


struct liste_graph_reseau * buildGraph(char * fichierDimacs, int * source, int * sink, int * nb_sommets, int * nb_arcs) {
    FILE * fptr = fopen(fichierDimacs, "r");

    int value;
    int from;
    int to;
    int cap;
    bool table_created;
    char currentline[1000];

    assert(fptr != NULL);
    struct liste_graph_reseau * tab;
    table_created = false;

        while (fgets(currentline, sizeof(currentline), fptr) != NULL) {
        char delim[] = " ";
        char * ptr = strtok(currentline,delim);

        if (strcmp(ptr, "p") == 0) {
            ptr = strtok(NULL, delim);
            * nb_sommets = atoi(ptr);

            ptr = strtok(NULL, delim);
            * nb_arcs = atoi(&ptr[0]);

            tab = (struct liste_graph_reseau *) malloc((* nb_sommets) * sizeof(struct liste_graph_reseau));

            for (int i = 0 ; i < (* nb_sommets) ; i ++) {
                tab[i].id = i + 1;
                tab[i].head = NIL_mr;
            }

            table_created = true;
        }
        if (strcmp(ptr, "n") == 0) {
            ptr = strtok(NULL, delim);
            value = atoi(ptr);

            ptr = strtok(NULL, delim);
            if (strcmp(ptr, "s\n") == 0) { // utilisation de strtok coupe la ligne suivante aussi c est pour ca qu'on est obligé d'inclure \n aussi
                * source = value;
            }
            else if (strcmp(ptr, "t\n") == 0) {
                * sink = value;
            }
        }

        if (strcmp(ptr, "a") == 0 && table_created) {
            ptr = strtok(NULL, delim);
            from = atoi(ptr);

            ptr = strtok(NULL, delim);
            to = atoi(ptr);

            ptr = strtok(NULL, delim);
            cap = atoi(&ptr[0]);

            ajout_en_tete_graph_reseau(to, cap, &tab[from - 1]); /* HYPOTHESE DE DEPART */
        }
    }

    fclose(fptr);

    return tab;
}


void imprimer_graph_reseau(struct liste_graph_reseau * tabReseau, int nb_sommets) {
    printf("Graphe Réseau :\n");

    for (int i = 0 ; i < nb_sommets ; i ++) {
        printf("sommet : %d\n",i + 1); /* HYPOTHESE DE DEPART*/

        imprimer_liste_graph_reseau(tabReseau[i]);
    }

    printf("\n\n");
}

/*
 * FONCTION STATIC
 * La fonction est une fonction modifié de imprimer_liste_graph_reseau
 * Au lieu d'imprimer à la console, cette fonction imprime la liste de successeurs d'un sommet est imprimé dans le fichier
 * @param1 : la liste de successeurs d'un sommet (une case de tabReseau)
 * @param2 : le fichier dans le quel il faut imprimer les valeurs
 * @return : void : la fonction imprime les valeurs dans le fichier et ne fait aucun return
 */

static void imprimer_liste_graph_reseau_fichier(struct liste_graph_reseau L,FILE* fptr) {
    struct maillon_graph_reseau* M;
    M = L.head;

    while (M!=NIL_mr) {
        fprintf(fptr,"id : %d flot: %d capacite: %d\n",M->id, M->flot,M->capacite);

        M = M->next;
    }
}

int minCapa(struct liste_chemin * LC) {
    int min;

    struct maillon_chemin * parcours;
    parcours = LC -> head -> next;

    if (parcours == NIL_mc) {
        return -1; // si la liste est vide
    }
    else {
        min = parcours -> capacite_residual;
        parcours = parcours -> next;

        while (parcours != NIL_mc) {
            if (parcours -> capacite_residual < min && parcours -> capacite_residual != -1) {
                min = parcours -> capacite_residual;
            }

            parcours = parcours -> next;
        }
    }

    return min;
}

/*
 * FONCTION STATIC
 * La fonction cherche le flot d'un arc dans le grpah d'écart en fonction de sommet de départ et sommet d'arrivé
 * @param1 : sommet de départ
 * @param2 : sommet d'arrivé
 * @param3 : le graph d'écart est passé en paramtre pour parcourir le graph et trouver le flot
 */

static int getFlot(int initial, int terminal, struct liste_graph_ecart * tabEcart) {
    struct maillon_graph_ecart * parcours;
    parcours = tabEcart[initial - 1].head; /*HYPOTHESE DE DEPART*/

    while (parcours != NIL_mge && parcours -> id != terminal) {
        parcours = parcours -> next;
    }

    if (parcours == NIL_mge) {
        return -  1;
    }
    else {
        return parcours -> flot_entrant;
    }
}

void updateFlowInNet(struct liste_graph_reseau * tabReseau, struct liste_graph_ecart * tabEcart, int nb_sommets) {
    struct maillon_graph_reseau * M;
    for (int i = 0 ; i < nb_sommets ; i ++) {
        M = tabReseau[i].head;

        while (M != NIL_mr) {
            M -> flot = getFlot(M -> id, i + 1, tabEcart);
            M = M -> next;
        }
    }
}

void renderResultV2(struct liste_graph_reseau* tabReseau, char * file_name,int flot,int nb_sommets){
      FILE *fptr = fopen(file_name, "w");
      fprintf(fptr,"Graphe Réseau :\n");

      for (int i = 0 ; i < nb_sommets ; i ++) {
          fprintf(fptr,"sommet : %d\n",i + 1); /* HYPOTHESE DE DEPART*/

          imprimer_liste_graph_reseau_fichier(tabReseau[i],fptr);
      }

      fprintf(fptr,"\n\n");
      fprintf(fptr,"Le flot est passé de 0 à %d\n",flot);
      fclose(fptr);
}


/* GrapheEcart */

/*
 * FONCTION STATIC
 * La fonction permet d'initialiser les attributs de graph d'écart
 * head est initialiser à NIL_maillon_graph_ecart
 * id est initialiser a la valeur du sommet
 * @param1 : la liste de succsseurs est passé en paramtre qui contient le sommet de source (accessible via id)
 * @param2 : la valeur du sommet à initialiser est passé en paramtere
 * @return : void : ne fait pas de return, il initialise juste le graph d'écart à valeur de défault
 */

static void init_liste_graph_ecart(struct liste_graph_ecart * liste, int valeur_id_sommet_init){
    liste -> head = NIL_mge;
    liste -> id = valeur_id_sommet_init;
}

/*
 * FONCTION STATIC
 * La fonction fait un ajout en tete d'un sommet succsuer dans une liste de successeurs de graph d'écart
 * @param1 : la liste du sommet dans la quelle on veut ajouter un sommet succsuer (une case du tableau tabEcart)
 * @param2 : sommet succsuer (identifiant)
 * @param3 : le flot de l'arc entre le sommet d'origine et le sommet succsuer
 * @return : void : il fait qu'un ajout en tete
 */

static void ajout_en_tete_graph_ecart(struct liste_graph_ecart * liste, int valeur_id_sommet_courant, int valeur_flot_sommet_courant) {
    struct maillon_graph_ecart * M = (struct maillon_graph_ecart *) malloc(sizeof(struct maillon_graph_ecart));
    M -> id = valeur_id_sommet_courant;
    M -> flot_entrant = valeur_flot_sommet_courant;
    M -> next = liste -> head;
    liste -> head = M;
}

/*
 * FONCTION STATIC
 * La fonction ser utilisé pour enlever les arcs de graph d'écart pour lesquels le flot passe à 0
 * @param1 : la liste de succsuer d'un sommet est passé en paramtre
 * @param2 : sommet d'arrivé à enlever
 * en fonction de id de la liste et id de maillon à enlever on a retirer l'arc
 * @return : void : c'est une fonction qui retire un maillon d'une liste chainée donc pas de return
 */

static void retirer_de_la_liste(struct liste_graph_ecart * liste, int id_sommet_a_retirer) {
    struct maillon_graph_ecart * M;
    M = liste -> head;

    struct maillon_graph_ecart * M_succ;
    M_succ = M -> next;

    if (M -> id == id_sommet_a_retirer) {
        liste -> head = M -> next;

        free(M);
    }

    else {
        while (M_succ != NIL_mge && M_succ -> id != id_sommet_a_retirer) {
            M = M_succ;
            M_succ = M_succ -> next;
        }

        if (M_succ != NIL_mge) {
            struct maillon_graph_ecart * M_ret = M_succ;
            M_succ = M_succ -> next;
            M -> next = M_succ;

            free(M_ret);
        }
    }
}


void clear_liste_graph_ecart(struct liste_graph_ecart * tabEcart, int nb_sommets) {
    for (int i = 0 ; i < nb_sommets ; i ++) {
        struct maillon_graph_ecart * parcours = tabEcart[i].head;

        while (parcours != NIL_mge) {
            tabEcart[i].head = parcours -> next;

            free(parcours);

            parcours = tabEcart[i].head;
        }
    }

    free(tabEcart);
}

void clear_liste_graph_reseau(struct liste_graph_reseau * tabReseau, int nb_sommets) {
    for (int i = 0 ; i < nb_sommets ; i ++) {
        struct maillon_graph_reseau * parcours = tabReseau[i].head;

        while (parcours != NIL_mr) {
            tabReseau[i].head = parcours -> next;

            free(parcours);

            parcours = tabReseau[i].head;
        }
    }

    free(tabReseau);
}


struct liste_graph_ecart * buildRG(struct liste_graph_reseau * tabReseau, int nb_sommets) {
    struct liste_graph_ecart * tabEcart = (struct liste_graph_ecart *) malloc((nb_sommets) * sizeof(struct liste_graph_ecart));
    for (int i = 0 ; i < nb_sommets ; i += 1) {
        init_liste_graph_ecart(&tabEcart[i], i + 1);

        struct maillon_graph_reseau * M_r = tabReseau[i].head;

        while (M_r != NIL_mr) {
            if (M_r -> capacite - M_r -> flot != 0) {
                ajout_en_tete_graph_ecart(&tabEcart[i], M_r -> id, M_r -> capacite);
            }

            M_r = M_r -> next;
        }
    }

    return tabEcart;
}

/*
 * FONCTION STATIC
 * La fonction qui imprime la liste de graph d'écart (la liste corresspond à une case du tableau de graph écart)
 * @param1 : la liste graph écart à imprimer
 * @return : void : la fonction imprime juste la liste
 */

static void imprimer_liste_graph_ecart(struct liste_graph_ecart liste) {
    struct maillon_graph_ecart * parcours = liste.head;

    while (parcours != NIL_mge) {
        printf("id: %d\tflot_entrant:%d\n",parcours->id,parcours->flot_entrant);

        parcours = parcours->next;
    }
}


void imprimer_graph_ecart(struct liste_graph_ecart * tabEcart,int nb_sommets){
    printf("Graphe Écart : \n");

    for (int i = 0 ; i < nb_sommets ; i ++) {
        printf("Sommet : %d\n", i + 1);

        imprimer_liste_graph_ecart(tabEcart[i]);
    }

    printf("\n\n");
}


void updateFlowInRG(struct liste_chemin * chemin, struct liste_graph_ecart * tabEcart, int min) {
    int id_sommet = chemin -> head -> id;
    struct maillon_chemin * M_c  = chemin -> head -> next;
    struct maillon_graph_ecart * M_ge;

    while (M_c != NIL_mc) {
        M_ge = tabEcart[id_sommet - 1].head;

        while (M_ge != NIL_mge && M_ge -> id != M_c -> id) {
            M_ge = M_ge -> next;
        }

        if (M_ge->flot_entrant - min == 0) {
            retirer_de_la_liste(&tabEcart[id_sommet - 1], M_c -> id);
        }
        else {
            M_ge -> flot_entrant -= min;
        }

        int sommet_flot_a_repousser = M_c -> id;

        M_ge = tabEcart[sommet_flot_a_repousser - 1].head;

        while (M_ge != NIL_mge && M_ge->id != id_sommet) {
            M_ge = M_ge -> next;
        }

        if (M_ge == NIL_mge) {
            ajout_en_tete_graph_ecart(&tabEcart[sommet_flot_a_repousser - 1], id_sommet, min);
        }
        else {
            M_ge -> flot_entrant += min;
        }

        id_sommet = M_c -> id;
        M_c = M_c -> next;
    }
}


/* Chemin */

struct liste_chemin * init_liste_chemin() {
    struct liste_chemin * liste_chemin = (struct liste_chemin *) malloc(sizeof(struct liste_chemin));
    liste_chemin -> head = NIL_mc;
    return liste_chemin;
}

/*
 * FONCTION STATIC
 * Enfiler des successeurs : la fonction creer le file en fonction de table d'écart
 * pas obliger de parcourir tous le graph, il suffit d'atteindre le sink (condition ligne 405)
 * @param1 : tabEcart est passé en parametre pour parcourir
 * @param2 : le file dans le quel les sommets doit etre enfiler
 * @param3 : sommet_source
 * @param4 : tableau de predecesseurs
 * @param5 : sink
 * @return :
 */

static bool enfiler_successeurs (struct liste_graph_ecart * tabEcart, struct file * file_f, int sommet_source, int predecesseurs[], int sink) {
    struct maillon_graph_ecart * parcours = tabEcart[sommet_source - 1].head;
    bool flag = false;

    while (parcours != NIL_mge) {
        if (predecesseurs[parcours -> id - 1] == 0) {
            enfiler(file_f, parcours -> id);
            predecesseurs[parcours -> id - 1] = sommet_source;
        }

        if (predecesseurs[sink - 1] != 0) {
            flag = true;
        }

        parcours = parcours -> next;
    }

    return flag;
}

/*
 * FONCTION STATIC
 * La fonction fait un ajout en tete de la liste chemin un maillon,
 * le maillon_chemin est creer à l'intérieur de la fonction et ajouté à la liste
 * @param1 : la liste chemin dans le quel il faut ajouter un sommet
 * @param2 : l'identifiant du sommet à ajouter
 * @param3 : la capcité residual du sommet d'avant et le sommet à ajouter
 * @return : void : la fonction ajoute un maillon dans la liste
 */

static void ajout_en_tete_chemin(struct liste_chemin * liste_chemin, int valeur_id_sommet_courant, int capRes) {
    struct maillon_chemin * M = (struct maillon_chemin *) malloc(sizeof(struct maillon_chemin));

    M -> id = valeur_id_sommet_courant;
    M -> capacite_residual = capRes;
    M -> next = liste_chemin -> head;

    liste_chemin -> head = M;
}


struct liste_chemin * shortestPath(struct liste_graph_ecart * tabEcart, int source, int sink, int nb_sommets, bool * fini) {
    struct liste_chemin * plus_court_chemin = init_liste_chemin();
    int predecesseurs[nb_sommets];

    for (int i = 0 ; i < nb_sommets ; i += 1) {
        predecesseurs[i] = 0;
    }

    predecesseurs[source - 1] = source;

    struct file * file_f = init_file(nb_sommets);
    enfiler(file_f, source);

    * fini = false;
    int sommet;

    sommet = defiler(file_f);

    while (!(* fini) && sommet != -1) {
        * fini = enfiler_successeurs (tabEcart, file_f, sommet, predecesseurs, sink);
        sommet = defiler(file_f);
    }

    if (predecesseurs[sink - 1] != 0) {
        ajout_en_tete_chemin(plus_court_chemin, sink, getFlot(predecesseurs[sink - 1], sink, tabEcart));

        int prec = predecesseurs[sink - 1];

        while (prec != predecesseurs[prec - 1]) {
            ajout_en_tete_chemin(plus_court_chemin, prec, getFlot(predecesseurs[prec - 1], prec, tabEcart));

            prec = predecesseurs[prec - 1];
        }
    }

    ajout_en_tete_chemin(plus_court_chemin, source, -1);

    clear_file(file_f);

    return plus_court_chemin;
}


void imprimer_chemin(struct liste_chemin * LC){
    struct maillon_chemin * M = LC -> head;

    printf("Chemin : \n");

    while (M != NIL_mc) {
        printf("id : %d capacite : %d\t", M -> id, M -> capacite_residual);

        M = M -> next;
    }

    printf("\n\n");
}


void clear_chemin(struct liste_chemin * liste_chemin) {
    struct maillon_chemin * parcours = liste_chemin -> head;

    while (parcours != NIL_mc) {
        liste_chemin -> head = parcours -> next;

        free(parcours);

        parcours = liste_chemin -> head;
    }

    free(liste_chemin);
}


void renderResult(char * fichier_render, struct liste_graph_reseau * tabReseau, int nb_sommets, int nb_arcs, int source, int sink, int flot) { /* Dans un graph de réseau les arcs restent les memes seul leur flot change */
    FILE *fptr = fopen(fichier_render, "w");

    fprintf(fptr, "c Pb de flot max\n");

    fprintf(fptr, "c pb lines (nodes, links)\n");
    fprintf(fptr, "p %d %d\n", nb_sommets, nb_arcs);

    fprintf(fptr, "c source\n");
    fprintf(fptr, "n %d s\n", source);

    fprintf(fptr, "c sink\n");
    fprintf(fptr, "n %d t\n", sink);

    fprintf(fptr, "c arc (from, to, capa, flot)\n");
    for (int i = 0 ; i < nb_sommets ; i ++) {
        struct maillon_graph_reseau * parcours = tabReseau[i].head;

        while (parcours != NIL_mr) {
            fprintf(fptr, "a %d %d %d %d\n", tabReseau[i].id, parcours -> id, parcours -> capacite, parcours -> flot);

            parcours = parcours -> next;
        }
    }

    fprintf(fptr, "c flot maximum\n");
    fprintf(fptr, "s %d\n", flot); /*s : solution*/

    fclose(fptr);
}
