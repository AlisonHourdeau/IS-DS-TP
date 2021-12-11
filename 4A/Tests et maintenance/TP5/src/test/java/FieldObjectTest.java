import static org.junit.Assert.*;
import org.junit.*;

public class FieldObjectTest {

    Field f;
    FieldObject o;

    @Before
    public void initField() {
	f = new Field(8, 10);
	o = new FieldObject(f, 3, 2.0, 2.0);
    }

    // Méthode getWeight.
    @Test
    public void getWeightSimple() {
	int w = o.getWeight();
	assertEquals(3, w);
    }

    // Méthode unsageSetPosition.
    @Test
    public void unsafeSetPositionValid() {
	o.unsafeSetPosition(4, 5);
	assertEquals(4, o.x, 0.0);
	assertEquals(5, o.y, 0.0);	
    }

    @Test
    public void unsafeSetPositionNeg() {
	o.unsafeSetPosition(-3, 5);
	assertEquals(-3, o.x, 0.0);
	assertEquals(5, o.y, 0.0);	
    }

    @Test
    public void unsafeSetPositionBig() {
	o.unsafeSetPosition(4, 15);
	assertEquals(4, o.x, 0.0);
	assertEquals(15, o.y, 0.0);	
    }

    // Tests du constructeur.
    // Création d'un objet dans ou hors des limites du terrain.
    @Test
    public void createFieldObjectIn() {
	FieldObject m = new FieldObject(f, 2, 3, 4);
	assertEquals(2, m.weight);
	assertEquals(3, m.x, 0.0);
	assertEquals(4, m.y, 0.0);
    }

    @Test
    public void createFieldObjectIn2() {
	FieldObject m = new FieldObject(f, 2, 10, 4);
	assertEquals(2, m.weight);
	assertEquals(10, m.x, 0.0);
	assertEquals(4, m.y, 0.0);
    }

    @Test
    public void createFieldObjectIn3() {
	FieldObject m = new FieldObject(f, 2, 3, 8);
	assertEquals(2, m.weight);
	assertEquals(3, m.x, 0.0);
	assertEquals(8, m.y, 0.0);
    }

    // si le poids de l'objet est de 0 on l'initialise à 1
    @Test
    public void createFieldObjectNullWeight() {
	FieldObject m = new FieldObject(f, 0, 3, 4);
	assertEquals(1, m.weight);
	assertEquals(3, m.x, 0.0);
	assertEquals(4, m.y, 0.0);
    }

	//si le poids de l'objet est négatif on l'initialise à 1
    @Test
    public void createFieldObjectNegWeight() {
	FieldObject m = new FieldObject(f, -4, 3, 4);
	assertEquals(1, m.weight);
	assertEquals(3, m.x, 0.0);
	assertEquals(4, m.y, 0.0);
    }
	//si l'abscisse de l'objet est négatif on l'initialise à 0
    @Test
    public void createFieldObjectWest() {
	FieldObject m = new FieldObject(f, 2, -3, 4);
	assertEquals(2, m.weight);
	assertEquals(0, m.x, 0.0);
	assertEquals(4, m.y, 0.0);
    }

	//si l'ordonnée de l'objet est négatif on l'initialise à 0
    @Test
    public void createFieldObjectSouth() {
	FieldObject m = new FieldObject(f, 2, 3, -4);
	assertEquals(2, m.weight);
	assertEquals(3, m.x, 0.0);
	assertEquals(0, m.y, 0.0);
    }

	//si l'abscisse de l'objet est supérieure à la largeur du plateau on l'initialise à cette largeur
	@Test
    public void createFieldObjectEast() {
	FieldObject m = new FieldObject(f, 2, 12, 4);
	assertEquals(2, m.weight);
	assertEquals(10, m.x, 0.0);
	assertEquals(4, m.y, 0.0);
    }

    //même chose
    @Test
    public void createFieldObjectEastLimit() {
	FieldObject m = new FieldObject(f, 2, 11, 4);
	assertEquals(2, m.weight);
	assertEquals(10, m.x, 0.0);
	assertEquals(4, m.y, 0.0);
    }

	//si l'ordonnée de l'objet est supérieure à la hauteur du plateau on l'initialise à cette hauteur
    @Test
    public void createFieldObjectNorth() {
	FieldObject m = new FieldObject(f, 2, 3, 12);
	assertEquals(2, m.weight);
	assertEquals(3, m.x, 0.0);
	assertEquals(8, m.y, 0.0);
    }

}
