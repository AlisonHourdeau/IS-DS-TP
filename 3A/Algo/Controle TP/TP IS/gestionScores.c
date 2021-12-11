#include <stdio.h>
#define Max 1000

void lectureScores(int scoVec[]){
    int val,i=0;
    printf("Enter a score : ");
    scanf("%d",&val);
    while(val>=0 && i<Max){
        scoVec[i]=val;
        printf("\nEnter a score : ");
        scanf("%d",&val);
        i++;
    }
    scoVec[i]=-1;
}

void afficheScores(int scoVec[]){
    int i=0,val=scoVec[0];
    while(val!=-1 && i<Max){
        printf("%d\t",val);
        i++;
        if(i%10==0){
            putchar('\n');
        }
        val=scoVec[i];
    }
    putchar('\n');
}

float moyenneScores(int scoVec[]){
    int i=0,val=scoVec[0];
    float somme=0;
    while(val!=-1 && i<Max){
        somme = somme + val;
        i++;
        val=scoVec[i];
    }
    return somme/i;
}

void seuilScores(int scoVec[], float val, int *nbSupVal, int *nbZero){
    *nbSupVal = 0;
    *nbZero =0;
    int i=0;
    int valLocal=scoVec[0];
    while(valLocal!=-1 && i<Max){
        if((valLocal*1.0)>= val){
            *nbSupVal = *nbSupVal +1;
        }
        if(valLocal==0){
            *nbZero = *nbZero+1;
        }
        i++;
        valLocal=scoVec[i];
    }
}
        

void test(){
    int scoVec[Max];
    lectureScores(scoVec);
    printf("Affichage\n");
    afficheScores(scoVec);
    putchar('\n');
    float moyenne=moyenneScores(scoVec);
    printf("Moyenne : %f\n",moyenne);
    int nbZero,nbSupVal;
    float val=moyenne; // on fixe moyenne car c est demande dans l'exercice
    seuilScores(scoVec,val,&nbSupVal,&nbZero);
    printf("Nombres de zeros: %d\tNomres de valeurs superieur a %f : %d\n",nbZero,val,nbSupVal);
}
        

int main(){
    test();
    return 0;
    
}
