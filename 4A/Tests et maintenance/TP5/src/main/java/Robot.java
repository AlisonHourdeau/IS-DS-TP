import static java.lang.Math.*;
import java.util.ArrayList;

/**
 * Les robots.
 */
public class Robot extends Moveable {

    /**
     * Charge maximale et objets transportés.
     */
    protected int maxLoad;
    protected ArrayList<FieldObject> cargo;

    /**
     * Constructeur.
     *
     * @param f  Terrain sur lequel vit l'objet.
     * @param w  Poids
     * @param x  Abscisse
     * @param y  Ordonnée
     * @param l  Charge maximale
     */

    /* la charge maximale ne peut pas être négative, si le paramètre l est négatif, on le remplace par O */
    public Robot(Field f, int w, double x, double y, int l) {
	    super(f, w, x, y);
	    if(l <= 0) l = 0;
	    this.maxLoad = l;
	    this.cargo = new ArrayList<>();
    }
    
    /**
     * Calcul de la charge actuelle.
     *
     * @return Charge actuelle
     */

    /* On somme la charge des objets portés par le robot (contenus dans l'attribut cargo) */
    public int cargoWeight() {
	    int weight = 0;
	    for(FieldObject fieldObject : this.cargo) {
	        weight += fieldObject.weight;
        }
        return weight;
    }

    /**
     * Prendre un objet.
     *
     * @param o  Objet à prendre
     */
    /* On ne peut porter un objet que s'il n'est pas porté
    * Si c'est le cas, on l'ajoute à la liste cargo du robot
    * On augmente le poids du robot
    * On place l'attribut lifted de l'objet porté à true
    * De plus, si l'objet porté est un robot, on incrémente la charge maximale du robot portant de celle du robot porté */
    public void lift(FieldObject o) {
	    if( o.lifted == false ) {
	        this.cargo.add(o);
	        this.weight += o.weight;
            o.lifted = true;
            if( o instanceof Robot )this.maxLoad += ((Robot) o).maxLoad;

        }
    }

    /**
     * Déposer un objet.
     *
     * @param o  Objet à déposer
     */

    /* On peut déposer un objet porté par le robot, ou porté par un objet porté par le robot (récursivité)
    * On cherche d'abord si l'objet est porté par le robot ou par un de ses objets porté (récursivement)
    * Si on le trouve, on le dépose en le reirant de la liste cargo du robot
    * En décrémentant son poids, en plaçant l'attribut lifted de l'objet à false
    * En mettant à jour les coordonnées de l'objet déposé par celles actuelles du robot
     */
    public void dropOff(FieldObject o) {
        boolean found = false;
        int i = 0;
        if( this.cargo.contains( o ) ) found = true ;
        else {
            while( !found && i < this.cargo.size()){
                if( this.cargo.get(i) instanceof Robot) {
                    ((Robot) this.cargo.get(i)).dropOff( o );
                }
                i++;
            }
        }
        if(  found && o.lifted == true ) {
            this.cargo.remove(o);
            this.weight -= o.weight;
            o.lifted = false;
            o.x = this.x;
            o.y = this.y;
        }
    }

}
