import static java.lang.Math.*;

/**
 * Les objets mobiles.
 */
public class Moveable extends FieldObject {

    /**
     * Niveau de carburant.
     */
    protected double fuel;

    /**
     * Constructeur.
     *
     * @param f  Terrain sur lequel vit l'objet.
     * @param w  Poids
     * @param x  Abscisse
     * @param y  Ordonnée
     */
    // on initialise le carburant à la largeur du plateau
    public Moveable(Field f, int w, double x, double y) {
	    super(f, w, x, y);
	    this.fuel = this.field.width;
    }

    /**
     * Calcul de la distance à un point de coordonnées données.
     *
     * @param x  Abscisse
     * @param y  Ordonnée
     * @return Distance
     */
    // calcul de la distance euclidienne entre l'objet mobile et les coordonnées en entrée
    protected double dist(double x, double y) {
        double diff_x = Math.pow(this.x - x , 2);
        double diff_y = Math.pow(this.y - y , 2);
	    return Math.sqrt(diff_x + diff_y);
    }

    /**
     * Se déplacer vers un point de coordonnées données.
     *
     * @param x  Abscisse cible
     * @param y  Ordonnée cible
     */
    // on vérifie que celui qui veut bouger est un robot ou un objet non porté
    // que l'objet a assez d'essence pour se déplacer au point ( x , y )
    // si il n'en a pas assez on le fait se déplacer sur l'axe des abscisses
    // pour lui permettre d'aller le plus loin possible avec son carburant
    // si le robot a une charge supérieure à sa charge maximale on ne lui permet pas de se déplacer
    public void goTo(double x, double y) {
        boolean robotCanMove = this instanceof Robot && ((Robot) this).maxLoad > ((Robot) this).cargoWeight();
        boolean notRobotCanMove = !( this instanceof Robot);
        if( ! this.lifted ){
            if( robotCanMove || notRobotCanMove ) {
                if (x > this.field.width) x = this.field.width;

                if (y > this.field.heigth) y = this.field.heigth;

                while (this.fuel - dist(x, y) < 0 && x > 0) {
                    if (this.x > x) x += 1;
                    else x -= 1;
                }

                if (this.fuel - dist(x, y) >= 0) {
                    this.fuel -= dist(x, y);
                    this.x = x;
                    this.y = y;
                    if (this instanceof Robot && ((Robot) this).cargoWeight() < ((Robot) this).maxLoad ) {

                        for (FieldObject fieldObject : ((Robot) this).cargo) {
                            fieldObject.x = x;
                            fieldObject.y = y;
                        }
                    }
                }
            }
        }

    }

}
