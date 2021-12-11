import java.util.Scanner;
/**
 * Tri par bule
 */

public class Tri1 {
    private static Scanner scanner = new Scanner(System.in);

    private static boolean isSorted(double[] tab){
        for(int i = 0; i<tab.length -1 ; i++){
            if(tab[i]>tab[i+1]) return false;
        }
        return true;
    }

    private static void Bule(double[] a) {
        double temp;
        boolean sorted = false;
        while(!sorted) {
            for (int i = 0; i < a.length-1; i++) {
                if (a[i] > a[i+1]) {
                    temp = a[i];
                    a[i] = a[i+1];
                    a[i+1] = temp;
                    sorted = isSorted(a);
                }
            }
        }
    }

    public static void fSort(double[] tab, int g, int d) { // g,d indice gauche, droite
        if (d <= g) return;
        int m = (g+d)/2;
        fSort(tab, g, m);
        fSort(tab, m+1, d);
        fusion(tab, g, m, d);
    }

    //Pour unifier les sous-tableaux:
    public static void fusion(double[] tab, int g, int m, int d) {    // longueurs des sous-tableaux
        int longg = m - g + 1;
        int longd = d - m;    // copies des sous-tableaux  deja tries
        double gtab[] = new double [longg];
        double dtab[] = new double [longd];
        for (int i = 0; i < longg; i++)
            gtab[i] = tab[g+i];
        for (int i = 0; i < longd; i++)
            dtab[i] = tab[m+i+1];    // indices dans les sous-tableaux
        int gind = 0;
        int dind = 0;    // construire le tableau d’origine depuis les copies gtab and dtab
        for (int i = g; i < d + 1; i++) {        // s’il y a des éléments à copier dans les deux tableaux, copier le min
            if (gind < longg && dind < longd) {
                if (gtab[gind] < dtab[dind]) {
                    tab[i] = gtab[gind];
                    gind++;            }
                else {
                    tab[i] = dtab[dind];
                    dind++;
                }
            }        // si dtab est déjà copié, copie du rest de gtab
            else if (gind < longg) {
                tab[i] = gtab[gind];
                gind++;
            }        // si gtab est déjà copié, copie du rest de dtab
            else if (dind < longd) {
                tab[i] = dtab[dind];
                dind++;
            }
        }
    }

    public static void main(String[] args) {
        System.out.println("Trier un tableau 1) donnez le nombre d'elements : ");
        int n = scanner.nextInt();
        double tab[] = new double[n];
        for (int i = 0; i < n; i++) {
            System.out.println("Donnez l'element suivant : ");
            tab[i] = scanner.nextDouble();
        }
        //Bule(tab);
        fSort(tab,0, tab.length-1);
        System.out.println("Le tableau trie est ");
        for (int i = 0; i < n; i++) {
            System.out.println(tab[i]);
        }
    }
}
