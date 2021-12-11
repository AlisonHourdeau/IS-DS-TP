#include <stdio.h>

void traitementSuite(int *nb, float *min, float *max){
    float val;
    *nb = 0;
    *min = 0;
    *max = 0;
    printf("Entrer un nombre reel different de 0 : ");
    scanf("%f",&val);
    if(val!=0){
        *nb=*nb+1;
        *min=val;
        *max=val;
        printf("Entrer un nombre reel different de 0 : ");
        scanf("%f",&val);
        while(val!=0){
            *nb=*nb+1;
            if(*min>val){
                *min=val;
            }
            if(*max<val){
                *max=val;
            }
            printf("Entrer un nombre reel different de 0 : ");
            scanf("%f",&val);
        }
    }
}

void testTraitementSuite(){
    int nb;
    float min,max;
    traitementSuite(&nb,&min,&max);
    printf("Nb of entries : %d\n",nb);
    printf("Minimum : %f\n",min);
    printf("Maximum : %f\n",max);
}
    
int main(){
    testTraitementSuite();
    return 0;
}
            
    
