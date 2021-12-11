import java.util.Scanner;
/**
 * Algorithme de Newton pour calculer la racine quarre
 */
public class Newton {
    private static Scanner scanner = new Scanner(System.in);

    public static void main(String[] args) {
        System.out.println("Donner un nombre : ");
        scanner.useDelimiter(",|\\.");
        double n = scanner.nextDouble();
        double x = 1;
        for (int i = 1; i < 10; i++) {
            //calculer la  valeur suivante
            x = ( x + n / x ) / 2;
        }        
        System.out.println("La racine de " + n + " est " + x);
    }
}
