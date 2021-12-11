/* Dinic.c */

#include "Dinic.h"


void dinic (struct liste_graph_reseau* tabReseau,int* flot,int source,int sink,int nb_sommets){
    
    /* Initialisation */
    struct liste_graph_ecart* tabEcart = buildRG(tabReseau,nb_sommets);
    struct liste_chemin* plus_court_chemin;
    int min;
    bool fini;
    
    /*Programme*/
    plus_court_chemin = shortestPath(tabEcart,source,sink,nb_sommets,&fini);
    
    while(fini){
        min = minCapa(plus_court_chemin);
        updateFlowInRG(plus_court_chemin,tabEcart,min);
        
        clear_chemin(plus_court_chemin);
        
        *flot+= min;
        
        plus_court_chemin = shortestPath(tabEcart,source,sink,nb_sommets,&fini);
    }
    clear_chemin(plus_court_chemin);
    
    updateFlowInNet(tabReseau,tabEcart,nb_sommets);
    
    clear_liste_graph_ecart(tabEcart,nb_sommets);
}
