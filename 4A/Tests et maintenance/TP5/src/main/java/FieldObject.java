import static java.lang.Math.*;

/**
 * Tous les objets.
 */
public class FieldObject {

    /**
     * Les objets sont caractérisés par un poids et des coordonnées.
     * Ils appartiennent à un terrain, et peuvent être portés ou non.
     */
    protected Field field;
    protected int weight;
    protected double x, y;
    protected boolean lifted;

    /**
     * Constructeur.
     *
     * @param f  Terrain sur lequel vit l'objet.
     * @param w  Poids
     * @param x  Abscisse
     * @param y  Ordonnée
     */

    /* si le poids de l'objet est inférieur ou égale à 0 on l'initialise à 1 */
    /* si l'abscisse de l'objet est inférieur à 0 on l'initialise à 0 */
    /* si l'ordonnée de l'objet est inférieur à 0 on l'initialise à 0 */
    /* si l'abscisse de l'objet est supérieur à la largeur  du plateau on lui attribue cette largeur */
    /* si l'ordonnée de l'objet est supérieur à la hauteur  du plateau on lui attribue cette hauteur */
    /* on initialise le fait qu'il soit porté à faux */
    public FieldObject(Field f, int w, double x, double y) {
	    this.field = f;

	    if(w <= 0) this.weight = 1;
	    else this.weight = w;

	    if(x < 0) x = 0.0;
        if(x >= f.width) x = f.width;
        this.x = x;

        if(y < 0) y = 0.0;
	    if(y >= f.heigth) y = f.heigth;
	    this.y = y;

	    this.lifted = false;
    }

    /**
     * Renvoie le poids de l'objet.
     *
     * @return Poids
     */
    public int getWeight() {
	    return this.weight;
    }

    /**
     * Définit la position de l'objet.
     *
     * @param x  Abscisse
     * @param y  Ordonnée
     */
    public void unsafeSetPosition(double x, double y) {
	    this.x = x;
	    this.y = y;
    }

}
