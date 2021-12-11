/*File.c */

#include "File.h"


struct file * init_file (int taille) {
    struct file * F = (struct file *) malloc(sizeof(struct file));
    
    F -> taille = taille;
    F -> tab = (int *) malloc(taille * sizeof(int));
    
    for(int i = 0 ; i < taille ; i ++){
        F -> tab[i] = 0;
    }
    
    F -> write_end = 0;
    F -> read_end = 0;
    F -> n = 0;
    
    return F;
}


void clear_file (struct file * F) {
    free(F -> tab);
    free(F);
}


void enfiler(struct file * F, int sommet_a_enfiler) {
    if(F -> n < F -> taille){
        F -> tab[F -> write_end] = sommet_a_enfiler;
        F -> write_end = (F -> write_end + 1) % F -> taille;
        F -> n ++;
    }
}


int defiler (struct file * F) {
    int sommet = -1;
    
    if(F -> n > 0){
        sommet = F -> tab[F -> read_end];
        
        F -> tab[F -> read_end] = 0;
        F -> read_end = (F -> read_end + 1) % F -> taille;
        F -> n --;
    }
    
    return sommet;
}


void print_file(struct file* F) {
    printf("File : ");
    
    for(int i = 0 ; i < F -> taille ; i ++){
        printf("%d\t",F -> tab[i]);
    }
    
    printf("\n\n");
}

