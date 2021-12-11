import java.text.Normalizer;

import static java.lang.Math.*;

/**
 * Classe pour le terrain où évolueront les objets.
 */

public class Field {

    /**
     * Hauteur et largeur du terrain.
     */
    protected int heigth, width;

    /**
     * Construction d'un terrain de dimensions données.
     *
     * @param h  Hauteur du terrain
     * @param w  Largeur du terrain
     */

    /* Si la hauteur du terrain passée en paramètre est inférieure ou égale à 0 on l'initialise à 1*/
    /* Si la largeur du terrain passée en paramètre est inférieure ou égale à 0 on l'initialise à 1*/
    public Field(int h, int w) {
        if(h<=0) h=1;
        if(w<=0) w=1;
	    this.heigth = h;
	    this.width = w;
    }

    /**
     * Normalisation d'une abscisse.
     *
     * @param x  Abscisse quelconque
     * @return Abscisse normalisée
     */
    /* Si l'abcisse passée en paramètre est inférieur à 0, on retourne 0
    * Si elle est supérieure à la largeur du terrain on retourne la largeur du terrain
    * Sinon, on retourne l'abcisse passée en paramètre
    */
    public double normalizeX(double x) {
	    if(x<0) return 0.0;
	    if(x>width) return width;
	    return x;
    }

    /**
     * Normalisation d'une ordonnée.
     *
     * @param y  Ordonnée quelconque
     * @return Ordonnée normalisée
     */

    /* Si l'ordonnée passée en paramètre est inférieur à 0, on retourne 0
     * Si elle est supérieure à la hauteur du terrain on retourne la hauteur du terrain
     * Sinon, on retourne l'ordonnée passée en paramètre
     */
    public double normalizeY(double y) {
        if(y<0) return 0.0;
        if(y>heigth) return heigth;
        return y;
    }

}
