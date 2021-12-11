/* main.c */

#include "Dinic.h"


int main(void) {
    printf("Saisissez le nom du fichier contenant le réseau initial: ");
    char fichier_dinic [50];
    scanf("%s", fichier_dinic);
    int source, sink, nb_sommets,nb_arcs;

    struct liste_graph_reseau* tabReseau = buildGraph(fichier_dinic, &source, &sink, &nb_sommets, &nb_arcs);

    /* f : flot */
    int f = 0;

    dinic(tabReseau, &f, source, sink,nb_sommets);

    printf("Le flot est passé de 0 à %d.\n", f);
    printf("Appuyez 1 pour generer un fichier dimancs du graph de réseau\n");
    printf("Appuyez 2 pour generer un fichier sommets et arcs (plus compréhensible)\n");
    int result;
    printf("Votre choix: ");
    scanf("%d", &result);
    if(result==1){
      renderResult("result.txt",tabReseau,nb_sommets,nb_arcs,source,sink,f);
    }else if(result==2){
      renderResultV2(tabReseau,"result.txt",f,nb_sommets);

    }

    printf("Le réseau de flot maximum à été enregistré dans le fichier `result.txt`.\n");

    clear_liste_graph_reseau(tabReseau,nb_sommets);
    return 0;
}
