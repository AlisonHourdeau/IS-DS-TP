import static org.junit.Assert.*;
import org.junit.*;

public class MoveableTest {

    Field f;
    Moveable r2d2;

    @Before
    public void initField() {
	f    = new Field(8, 10);
	r2d2 = new Moveable(f, 19, 2.0, 2.0);
    }

    // Tests du constructeur.
    // Création d'un objet mobile dans ou hors des limites du terrain.
    @Test
    public void createMoveableIn() {
	Moveable m = new Moveable(f, 12, 3, 4);
	assertEquals(12, m.weight);
	assertEquals(3, m.x, 0.0);
	assertEquals(4, m.y, 0.0);
	assertEquals(10, m.fuel, 0.0);
    }

    @Test
    public void createMoveableIn2() {
	Moveable m = new Moveable(f, 12, 10, 4);
	assertEquals(12, m.weight);
	assertEquals(10, m.x, 0.0);
	assertEquals(4, m.y, 0.0);
	assertEquals(10, m.fuel, 0.0);
    }

    @Test
    public void createMoveableIn3() {
	Moveable m = new Moveable(f, 12, 3, 8);
	assertEquals(12, m.weight);
	assertEquals(3, m.x, 0.0);
	assertEquals(8, m.y, 0.0);
	assertEquals(10, m.fuel, 0.0);
    }

    @Test
    public void createMoveableWest() {
	Moveable m = new Moveable(f, 12, -3, 4);
	assertEquals(12, m.weight);
	assertEquals(0, m.x, 0.0);
	assertEquals(4, m.y, 0.0);
	assertEquals(10, m.fuel, 0.0);
    }

    @Test
    public void createMoveableSouth() {
	Moveable m = new Moveable(f, 12, 3, -4);
	assertEquals(12, m.weight);
	assertEquals(3, m.x, 0.0);
	assertEquals(0, m.y, 0.0);
	assertEquals(10, m.fuel, 0.0);
    }

    @Test
    public void createMoveableEast() {
	Moveable m = new Moveable(f, 12, 12, 4);
	assertEquals(12, m.weight);
	assertEquals(10, m.x, 0.0);
	assertEquals(4, m.y, 0.0);
	assertEquals(10, m.fuel, 0.0);
    }

    @Test
    public void createMoveableEastLimit() {
	Moveable m = new Moveable(f, 12, 11, 4);
	assertEquals(12, m.weight);
	assertEquals(10, m.x, 0.0);
	assertEquals(4, m.y, 0.0);
	assertEquals(10, m.fuel, 0.0);
    }

    @Test
    public void createMoveableNorth() {
	Moveable m = new Moveable(f, 12, 3, 12);
	assertEquals(12, m.weight);
	assertEquals(3, m.x, 0.0);
	assertEquals(8, m.y, 0.0);
	assertEquals(10, m.fuel, 0.0);
    }

    // Déplacement d'un objet mobile.
    @Test
    public void goToWestSide() {
	r2d2.goTo(0, 2);
	assertEquals(0, r2d2.x, 0.0);
	assertEquals(2, r2d2.y, 0.0);
	assertEquals(8, r2d2.fuel, 0.0);
    }

	//changement de coordonnées selon les déplacements et du carburant
	@Test
    public void goSouth() {
	r2d2.goTo(2, 1);
	assertEquals(2, r2d2.x, 0.0);
	assertEquals(1, r2d2.y, 0.0);
	assertEquals(9, r2d2.fuel, 0.0);
    }

    //changement de coordonnées selon les déplacements et du carburant
    @Test
    public void goToValid() {
	r2d2.goTo(6, 5);
	assertEquals(6, r2d2.x, 0.0);
	assertEquals(5, r2d2.y, 0.0);
	assertEquals(5, r2d2.fuel, 0.0);
    }

    // changement des coordonnées du robot et de son carburant lors de ses déplacements
	// robot reste dans les limites du plateau
    @Test
    public void goNorthOfTheWall() {
	r2d2.goTo(2, 10);
	assertEquals(2, r2d2.x, 0.0);
	assertEquals(8, r2d2.y, 0.0);
	assertEquals(4, r2d2.fuel, 0.0);
    }

    // carburant doit diminuer lors des déplacements, carburant stocker en double
    @Test
    public void goElan() {
	r2d2.goTo(4, 10);
	assertEquals(4, r2d2.x, 0.0);
	assertEquals(8, r2d2.y, 0.0);
	assertEquals(3.7, r2d2.fuel, 0.05);
    }

    // le carburant doit diminuer seulement de la distance parcourue et non de celle entre le point départ
	// et le point d'arrivée voulu (qui est or plateau)
    @Test
    public void goEastBreakTheWall() {
	r2d2.goTo(14, 2);
	assertEquals(10, r2d2.x, 0.0);
	assertEquals(2, r2d2.y, 0.0);
	assertEquals(2, r2d2.fuel, 0.0);
    }

	// carburant doit diminuer lors des déplacements
    @Test
    public void goTwice() {
	r2d2.goTo(6, 2);
	r2d2.goTo(6, 6);
	assertEquals(6, r2d2.x, 0.0);
	assertEquals(6, r2d2.y, 0.0);
	assertEquals(2, r2d2.fuel, 0.0);	
    }
	// déplacement seulement sur l'axe des abscisses avec le carburant qu'il reste
    @Test
    public void outOfGasStraight() {
	r2d2.goTo(8, 2);
	r2d2.goTo(2, 2);
	assertEquals(4, r2d2.x, 0.0);
	assertEquals(2, r2d2.y, 0.0);
	assertEquals(0, r2d2.fuel, 0.0);		
    }

    // pas eu le temps de créer la méthode de distance de pythagore
    @Test
    public void outOfGasPythagore() {
	r2d2.goTo(8, 2);
	r2d2.goTo(4, 5);
	assertEquals(4.8, r2d2.x, 0.0);
	assertEquals(4.4, r2d2.y, 0.0);
	assertEquals(0, r2d2.fuel, 0.0);		
    }

    // mouvement en dehors du plateau, le robot s'arrête au limite du plateau cad sa hauteur et sa largeur
    @Test
    public void outOfAll() {
	r2d2.goTo(14, 11);
	assertEquals(10, r2d2.x, 0.0);
	assertEquals(8, r2d2.y, 0.0);
	assertEquals(0, r2d2.fuel, 0.0);
    }

}
