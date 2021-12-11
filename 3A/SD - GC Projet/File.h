/* File.h */

#include <stdlib.h>
#include <stdio.h>
#include <stdbool.h>
#include <string.h>
#include <assert.h>
#include <ctype.h>


/*******************************************************************************************
 * IMPLANTATION
 *
 * Spécification de l'implantation
 *
 * Implantation de file :
 *
 *
 *
 * init_file
 * n nombre d'élements dans la file
 * on a un tableau int comme les informations stockée sont numéro (numéro de sommet) cf: HYPOTHESE GraphReseau.h
 *********************************************************************************************/

struct file {
    int * tab;
    int taille;
    int read_end;
    int write_end;
    int n;
};

/* Constructeur: Initialise à la file vide de taille donne (cette fonction fait de l'allocution dynamique)
 * @param1 : la taille de file à initialiser
 * @return : l'adresse de file est retourné
 */

 /*            ----------------------------------------------            */
extern struct file * init_file(int);
/*            ----------------------------------------------            */

/*
 * Destructeur : Cette fonction espace memoire alloué dynamique à la structure file
 * @param1 : l'adresse de file à détruire
 * @return : void, il libere juste l'espace mémoire
 */

 /*            ----------------------------------------------            */
extern void clear_file(struct file *);
/*            ----------------------------------------------            */

/*
 * La fonction sert à ajouter une valeur (un sommet) ans la table de file donc on en file un sommet
 * @param1 : l'adresse de file dans le quel il faut enfiler la valeu (sommet)
 * @param2 : valeur à enfiler (sommet à enfiler)
 * @return : void : on enfile dans le file donc on n'a pas de return
 */

 /*            ----------------------------------------------            */
extern void enfiler(struct file *, int);
/*            ----------------------------------------------            */

/*
 * La fonction sert à défiler une valuer
 * @param1 : le file de laquel il faut défiler
 * @return : la valeur défiler est retourné par la fonction
 */

 /*            ----------------------------------------------            */
extern int defiler(struct file *);
/*            ----------------------------------------------            */

/*
 * Une fonction intermédiairre qui sert à debugger, il imprime un file donné
 * @param1 : l'addresse du file à imprimer
 */

 /*            ----------------------------------------------            */
extern void print_file(struct file *);
/*            ----------------------------------------------            */
