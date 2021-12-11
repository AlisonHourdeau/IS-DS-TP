//Controle TP KIROUCHENASSAMY BADMAVASAN
#include <stdio.h>
#include <string.h>
#define NCH 20 //pour les chaines de caracteres 
#define N 15 // max du vecteur espace 

typedef struct {
    char nom [NCH];
    int dept;
    int nbHab;
} Ville;

typedef struct{
    Ville espace [N];
    int dernier;
}Region;

int chargementVille(Ville *ville){
    if(scanf("%s",ville->nom)!=EOF){
        scanf("%d",&ville->dept);
        scanf("%d",&ville->nbHab);
        return 1;
    }
    else{
        return 0;
    }
}

void chargementRegion(Region *r){
    Ville ville;
    int i=0;
    while(chargementVille(&ville)==1 && i<N){
        r->espace[i]=ville;
        i++;
    }
    r->dernier = i-1; // je increment i a la fin (ligne 34) donc la valeur de dernier est égal à i-1 
}

void affichage(Region r){
    for(int i=0;i<=r.dernier;i++){
        printf("Nom Ville : %s\t", r.espace[i].nom);
        printf("Department : %d\t", r.espace[i].dept);
        printf("nb. d'habitants : %d\t", r.espace[i].nbHab);
        putchar('\n');
    }
}

int nbHabtot(Region r){ 
    // j ai changé le nom de la fonctio pour evioter l'ambiguité avec l attribut de la ville. 
    int somme = 0;
    for(int i=0;i<=r.dernier;i++){
        somme = somme + r.espace[i].nbHab;
    }
    return somme;
}

float moyenneNbHabDep(Region r,int dept){
    int somme=0,count=0;
    for(int i=0;i<=r.dernier;i++){
        if(r.espace[i].dept==dept){
            somme = somme + r.espace[i].nbHab;
            count++;
        }
    }
    if(count == 0){
        return -1; // dans le cas ou le department n existe pas 
    } else{
        return somme/(count*1.0);
    }
} 
        
//on cherche dept et nombre d habitanst en fonction du nom de ville 

void infosV(Region r, char ville [], int *dep, int *nb){
    int i =0;
    int found =0;
    while(i<=r.dernier && found==0){
        if(strcmp(r.espace[i].nom,ville)==0){
            *dep = r.espace[i].dept;
            *nb = r.espace[i].nbHab;
            found =1;
        }
        i++;
    }
}

void plusPeuplee (Region r, char v1[], char v2[]){
    int indice1=-1,indice2=-1,nbHab1,nbHab2;
    for(int i=0;i<=r.dernier;i++){
        if(strcmp(r.espace[i].nom,v1)==0){
            indice1=i;
        }
        if(strcmp(r.espace[i].nom,v2)==0){
            indice2=i;
        }
    }
    
    if(indice1 != -1 && indice2 !=-1){ // verification si les deux villes passe en paramtre exites 
        nbHab1 = r.espace[indice1].nbHab;
        nbHab2 = r.espace[indice2].nbHab;
        if(nbHab1 > nbHab2){
            printf("%s (%d) a plus d'habitants que %s (%d)\n",v1,nbHab1,v2,nbHab2);
        }
        else{
            if(nbHab1 < nbHab2){
            printf("%s (%d) a plus d'habitants que %s (%d)\n",v2,nbHab2,v1,nbHab1);
            }
            else{
                printf("Les deux villes ont le meme nombre d'habitants (%d)\n",nbHab1);
            }
        }
    }
    else{
        if(indice1==-1){
        printf("%s n existe pas dans la region\n",v1);
        }
        if(indice2==-1){
            printf("%s n existe pas dans la region\n",v2);
        }
    }
}

int main(){
    //Initialisation
    Region r;
    int dep=-1,nb=-1; // varaibles propres a la fonction infosV qui nous permet de dire si la ville existe ou pas 
    float moyenne; // varaible propre a la fonction moyenneNbHabDep qui nous permet de dire si la ville existe ou pas 
    int departMoyenne = 59; // la variable contient le numero du departement pour la quelle on souhaite calculer la valeur de moyenne par ville 
    char v1 [NCH]; // c est la ville pour la quelle on cherche le department et nombre d'habitants 
    strcpy(v1,"Cambrai"); // on initialise ici le nom de la ville 
    
    
    //chargement
    chargementRegion(&r);
    //affichage
    affichage(r);
    
    // nombre total d habitants dans la region
    printf("Nombre total d'habitants dans cette region: %d\n", nbHabtot(r));
    
    // moyen d'habitant par ville dans un departement donne 
    moyenne = moyenneNbHabDep(r,departMoyenne);
    if( moyenne != -1 ){
        printf("Nombre moyen d'habitant par ville du department %d: %f\n",departMoyenne,moyenne);
    }
    else{
        printf("Le department passe en parametre n existe pas dans la region\n");
    }
    
    // affichage du numero de departement et nombre d habitants d une ville 
    infosV(r,v1, &dep,&nb);
    if(dep != -1 && nb !=-1){
        printf(" Ville : %s  Department : %d  Nb Habitants : %d\n",v1,dep,nb);
    }
    else{
        printf("Ville not found\n");
    }
    
    // affichage de la ville ayant le plus grand nombre d habitants 
    plusPeuplee(r,"Lille","Lens");
    return 0;
}
