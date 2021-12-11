#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>

#define (struct maillon_cours *) NIL
#define (struct dictionnaire *) NIL_dict

struct cours {
    double value;
    int jour;
};

struct maillon_cours{
    struct cours* c;
    struct maillon_cours* next;
};

struct list_cours{
    struct maillon_cours* tete;
    int nbelem;
};

struct action {
    double num_action;
    struct list_cours * L;
};

void ajout_cours_action(struct action * A, struct cours * cours){
    struct maillon_cours * M = (struct maillon_cours *) malloc(sizeof(struct maillon_cours));
    M -> C = cours;
    M -> next = NIL;
    if (A -> L -> tete == NIL) {
        A -> L -> tete = M;
    }
    else {
        M -> next = A -> L -> tete;
        A -> L -> tete = M;
    }
    A -> L -> nbelem += 1;
}

bool action_complete(struct action * A, int deb, int fin) { // structure fonctionne ssi chaque jour n'apparait qu'une fois pour chaque action.
    struct maillon_cours * M = A -> L -> tete;
    int cpt = 0;
    while (M != NIL) {
        if (M -> C -> jour >= deb && M -> C -> jour < fin) {
            cpt += 1;
        }
        M = M -> next;
    }
    return fin-deb == cpt;
}

// 2.2
// Q9
// arbre : taille inconnue lors de la création. (Table de hachage nécessite de connaître la taille dès le début)

// Q10
struct dictionnaire {
    struct dictionnaire * gauche;
    struct action * noeud_A;
    struct dictionnaire * droite;
}
// gauche : sous-arbre gauche du noeud courant
// noeud pointeur de la valeur courante : une action
// droit : sous-arbre droit du noeud courant

// Q11
void print_actions(struct dictionnaire * D, int deb, int fin) {
    if (D != NIL_dict) {
        print_actions(D -> gauche, deb, fin);
        if (action_complete(D -> noeud_A, deb, fin)) {
            printf("%lf\n", D -> noeud_A -> num_action);
        }
        print_actions(D -> droit, deb, fin);
    }
}

// Q 12
void print_actions(struct dictionnaire * D, int deb, int fin) {
    if (D != NIL_dict) {
        double res;
        if (action_complete(D -> noeud_A, deb, fin)) {
            res = D -> noeud_A -> num_action;
        }
        if (/* res se termine par 67 */) {
            printf("%lf\n", res);
            print_actions(D -> gauche, deb, fin);
            print_actions(D -> droit, deb, fin);
        }
        else {
            print_actions(D -> gauche, deb, fin);
            print_actions(D -> droit, deb, fin);
            printf("%lf\n", res);
        } 
    }
}
