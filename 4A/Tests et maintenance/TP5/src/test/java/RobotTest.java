import static org.junit.Assert.*;
import org.junit.*;

public class RobotTest {

    Field f;
    Robot r2d2;
    Robot c3po;
    FieldObject lightSaber;
    FieldObject deathStarMap;
    FieldObject bolt;

    @Before
    public void initField() {
	f    = new Field(8, 10);
	r2d2 = new Robot(f, 19, 2.0, 2.0, 20);
	c3po = new Robot(f, 16, 3.0, 3.0, 2);
	lightSaber   = new FieldObject(f, 4, 3.0, 2.0);
	deathStarMap = new FieldObject(f, 2, 3.0, 4.0);
	bolt         = new FieldObject(f, 1, 2.0, 4.0);
    }

    // Tests du constructeur.
	//Si l est positif : RAS
    @Test
    public void createRobot() {
	Robot r = new Robot(f, 12, 4.0, 5.0, 3);
	assertEquals(3, r.maxLoad);
    }

    //Si l est négatif, on l'initialise à 0
    @Test
    public void createRobotNegLoad() {
	Robot r = new Robot(f, 12, 4.0, 5.0, -33);
	assertEquals(0, r.maxLoad);
    }

    // Tests de la méthode lift.
	//Un robot peut porter un objet, dans ce cas on l'ajoute à la liste cargo
	// L'attribut lifted de l'objet porté passe à true
    @Test
    public void liftSuccess() {
	r2d2.lift(lightSaber);
	assertTrue(r2d2.cargo.contains(lightSaber));
	assertTrue(lightSaber.lifted);
    }

    // ???
    @Test
    public void liftFailureTooFarDiag() {
	r2d2.lift(c3po);
	assertFalse(r2d2.cargo.contains(c3po));
	assertFalse(c3po.lifted);
    }

    // ???
    @Test
    public void liftFailureTooFarStraight() {
	r2d2.lift(bolt);
	assertFalse(r2d2.cargo.contains(bolt));
	assertFalse(bolt.lifted);
    }

	//Un robot peut porter un objet qui a un poids inférieur à sa charge maximale
    @Test
    public void liftSuccessHeavy() {
	c3po.lift(lightSaber);
	assertTrue(c3po.cargo.contains(lightSaber));
	assertTrue(lightSaber.lifted);
    }

    //Un robot peut porter plusieurs objets, dont des robots
    @Test
    public void liftSuccessMultiple() {
	r2d2.lift(lightSaber);
	r2d2.goTo(2, 3);
	r2d2.lift(c3po);
	assertTrue(r2d2.cargo.contains(lightSaber));
	assertTrue(r2d2.cargo.contains(c3po));
	assertTrue(lightSaber.lifted);
	assertTrue(c3po.lifted);
    }

    //Un robot A peut porter un robot B, on n'ajoute pas les objets portés par B à ceux portés par A
    @Test
    public void liftSuccessNested() {
	r2d2.goTo(2, 3);
	c3po.lift(deathStarMap);
	r2d2.lift(c3po);
	assertFalse(r2d2.cargo.contains(deathStarMap));
	assertTrue(r2d2.cargo.contains(c3po));
	assertTrue(deathStarMap.lifted);
	assertTrue(c3po.lifted);
    }

    // Test de la méthode dropOff.

	//Si l'on dépose un objet, il prend les coordonnées du robot
    @Test
    public void dropOffContains() {
	r2d2.lift(lightSaber);
	r2d2.dropOff(lightSaber);
	assertFalse(lightSaber.lifted);
	assertEquals(2, lightSaber.x, 0.0);
	assertEquals(2, lightSaber.y, 0.0);
    }

    //Si le robot ne porte pas l'objet, on ne peut pas le déposer
    @Test
    public void dropOffEmpty() {
	r2d2.dropOff(lightSaber);
	assertFalse(lightSaber.lifted);
	assertEquals(3, lightSaber.x, 0.0);
	assertEquals(2, lightSaber.y, 0.0);
    }

    //Même chose que les deux précédents
	//LightSaber est porté (lightSaber.lifted == true) par r2d2
	//En revanche on cherche à déposer un objet que r2d2 ne porte pas => bolt.lifted == false et coordonnées non modifiées
    @Test
    public void dropOffOther() {
	r2d2.lift(lightSaber);
	r2d2.dropOff(bolt);
	assertTrue(lightSaber.lifted);
	assertFalse(bolt.lifted);
	assertEquals(2, bolt.x, 0.0);
	assertEquals(4, bolt.y, 0.0);
    }

    //C3po porte lightSaber
	//r2d2 cherche à déposer lightSaber alors qu'il ne le porte pas
	//En revanche, c3po porte tjr lightSaber => lightSaber.lifted == true
    @Test
    public void dropOffDoNotSteal() {
	c3po.lift(lightSaber);
	r2d2.dropOff(lightSaber);
	assertTrue(lightSaber.lifted);
    }

    //c3po porte lightSaber
	//r2d2 va aux coordonnées 2;3
	//r2d2 porte c3po (qui porte lightSaber)
	//c3po dépose lightSaber => correct donc lightSaber.lifted passe à false
    @Test
    public void dropOffFailureLifted() {
	c3po.lift(lightSaber);
	r2d2.goTo(2, 3);
	r2d2.lift(c3po);
	c3po.dropOff(lightSaber);
	assertFalse(lightSaber.lifted);
    }

	//c3po porte lightSaber
	//r2d2 va aux coordonnées 2;3
	//r2d2 porte c3po (qui porte lightSaber)
	//r2d2 dépose lightSaber => correct car lightSaber porté par c3po qui lui même est porté par r2d2
	//Donc c3po est tjr porté, mais pas lightSaber
    @Test
    public void dropOffNestedFailure() {
	c3po.lift(lightSaber);
	r2d2.goTo(2, 3);
	r2d2.lift(c3po);
	r2d2.dropOff(lightSaber);
	assertTrue(c3po.lifted);
	assertFalse(lightSaber.lifted);
    }

    //c3po porte lightSaber
	//r2d2 va aux coordonnées 2;3
	//r2d2 porte c3po (qui porte lightSaber)
	//r2d2 dépose c3po => correct donc c3po.lifted == false
	//Par contre, c3po porte tjr lightSaber
    @Test
    public void dropOffNested() {
	c3po.lift(lightSaber);
	r2d2.goTo(2, 3);
	r2d2.lift(c3po);
	r2d2.dropOff(c3po);
	assertFalse(c3po.lifted);
	assertTrue(lightSaber.lifted);
    }
    

    // Test de la méthode cargoWeight.
	//A l'appel du constructeur de robot, cargo est une liste vide
    @Test
    public void cargoWeightEmpty() {
	int w = c3po.cargoWeight();
	assertEquals(0, w);
    }

    //Si c3po porte un objet alors la méthode cargoWeight appliquée à c3po retourne le poids de l'objet
    @Test
    public void cargoWeightSimple() {
	c3po.lift(lightSaber);
	int w = c3po.cargoWeight();
	assertEquals(4, w);
    }

	//Si c3po porte plusieurs objets alors la méthode cargoWeight appliquée à c3po retourne la somme des poids des objets
	@Test
    public void cargoWeightMultiple() {
	r2d2.lift(lightSaber);
	r2d2.goTo(2, 3);
	r2d2.lift(c3po);
	r2d2.goTo(2, 4);
	r2d2.lift(deathStarMap);
	int w = r2d2.cargoWeight();
	assertEquals(22, w);
    }

    //Si un robot A porte un autre robot B alors la méthode cargoWeight appliqué à A retourne le poids de B
	//A laquelle s'ajoute le poids des objets portés par B
    @Test
    public void cargoWeightNested() {
	c3po.lift(lightSaber);
	r2d2.goTo(2, 3);
	r2d2.lift(c3po);
	int w = r2d2.cargoWeight();
	assertEquals(20, w);
    }

    //Même chose avec plusieurs objets portés par B
    @Test
    public void cargoWeightHybrid() {
	c3po.lift(lightSaber);
	c3po.lift(deathStarMap);
	r2d2.goTo(2, 3);
	r2d2.lift(c3po);
	int w = r2d2.cargoWeight();
	assertEquals(22, w);
    }

    //Même chose, on somme le poids des objets portés par A + le poids des objets portés par les objets portés par A etc etc
    @Test
    public void cargoWeightHybrid2() {
	r2d2.lift(lightSaber);
	c3po.lift(deathStarMap);
	r2d2.goTo(2, 3);
	r2d2.lift(c3po);
	int w = r2d2.cargoWeight();
	assertEquals(22, w);
    }


    // Test de la méthode getWeight.

	//Si un robot ne porte rien, la méthode getWeight retourne le poids du robot
    @Test
    public void getWeightEmpty() {
	int w = c3po.getWeight();
	assertEquals(16, w);
    }

    //Si un robot porte un objet, la méthode getWeight retourne le poids du robot + le poids de l'objet porté
    @Test
    public void getWeightSimple() {
	c3po.lift(lightSaber);
	int w = c3po.getWeight();
	assertEquals(20, w);
    }

    //Même chose avec plusieurs objets
    @Test
    public void getWeightMultiple() {
	r2d2.lift(lightSaber);
	r2d2.goTo(2, 3);
	r2d2.lift(c3po);
	r2d2.goTo(2, 4);
	r2d2.lift(deathStarMap);
	int w = r2d2.getWeight();
	assertEquals(41, w);
    }

    // On somme le poids du robot, le poids des objets portés par ce robot, et des objets portés par les objets portés etc ...
    @Test
    public void getWeightNested() {
	c3po.lift(lightSaber);
	r2d2.goTo(2, 3);
	r2d2.lift(c3po);
	int w = r2d2.getWeight();
	assertEquals(39, w);
    }

    //On somme le poids du robot avec celui des objets portés récursivement
    @Test
    public void getWeightHybrid() {
		c3po.lift(lightSaber);
		c3po.lift(deathStarMap);
		r2d2.goTo(2, 3);
		r2d2.lift(c3po);
		int w = r2d2.getWeight();
		assertEquals(41, w);
    }

    //Même chose
    @Test
    public void getWeightHybrid2() {
	r2d2.lift(lightSaber);
	c3po.lift(deathStarMap);
	r2d2.goTo(2, 3);
	r2d2.lift(c3po);
	int w = r2d2.getWeight();
	assertEquals(41, w);
    }


    // Test de la méthode goTo.
	//Si un objet est porté, il ne peut pas bouger, la méthode goTo n'a aucun effet sur lui
    @Test
    public void goToFailureLifted() {
	r2d2.goTo(2, 3);
	r2d2.lift(c3po);
	c3po.goTo(4, 5);
	assertFalse(4 == c3po.x);
	assertFalse(5 == c3po.y);
	assertEquals(10, c3po.fuel, 0.0);
    }

    //Si un robot porte une charge supérieur à sa charge maximale il ne peut plus avancer
    @Test
    public void goToFailureTooHeavy() {
	c3po.lift(lightSaber);
	c3po.goTo(4, 5);
	assertEquals(3, c3po.x, 0.0);
	assertEquals(3, c3po.y, 0.0);
	assertEquals(10, c3po.fuel, 0.0);
    }

    //Si le robot porte une charge inférieur à sa charge maximale, il peut se déplacer
	//On décrémente la propiété fuel du robot de la distance entre sa postion initiale et sa position finale
	//On modifie les coordonnées du robot
    @Test
    public void goToSuccessMultipleCargo() {
	r2d2.lift(lightSaber);
	r2d2.goTo(2, 3);
	r2d2.lift(c3po);
	r2d2.goTo(5, 3);
	assertEquals(5, r2d2.x, 0.0);
	assertEquals(3, r2d2.y, 0.0);
	assertEquals(6, r2d2.fuel, 0.0);	
    }

    //Même chose, sachant que sa charge prend en compte les objets portés apr les objets...
    @Test
    public void goToSuccessNestedCargo() {
	c3po.lift(lightSaber);
	r2d2.goTo(2, 3);
	r2d2.lift(c3po);
	r2d2.goTo(5, 3);
	assertEquals(5, r2d2.x, 0.0);
	assertEquals(3, r2d2.y, 0.0);
	assertEquals(6, r2d2.fuel, 0.0);
    }

    //Si un robot porte une charge (somme des poids des objets portés) trop élevée (supérieure à sa charge maximale) il ne peut aps bouger
    @Test
    public void goToFailureMultipleTooHeavy() {
	r2d2.lift(lightSaber);
	r2d2.goTo(2, 3);
	r2d2.lift(c3po);
	r2d2.goTo(2, 4);
	r2d2.lift(deathStarMap);
	r2d2.goTo(5, 3);
	assertEquals(2, r2d2.x, 0.0);
	assertEquals(4, r2d2.y, 0.0);
	assertEquals(8, r2d2.fuel, 0.0);	
    }

    //Même chose
    @Test
    public void goToFailureNestedTooHeavy() {
	c3po.lift(lightSaber);
	c3po.lift(deathStarMap);
	r2d2.goTo(2, 3);
	r2d2.lift(c3po);
	r2d2.goTo(5, 3);
	assertEquals(2, r2d2.x, 0.0);
	assertEquals(3, r2d2.y, 0.0);
	assertEquals(9, r2d2.fuel, 0.0);	
    }

    //Meme chose
    @Test
    public void goToFailureHybridTooHeavy() {
	r2d2.lift(lightSaber);
	c3po.lift(deathStarMap);
	r2d2.goTo(2, 3);
	r2d2.lift(c3po);
	r2d2.goTo(5, 3);
	assertEquals(2, r2d2.x, 0.0);
	assertEquals(3, r2d2.y, 0.0);
	assertEquals(9, r2d2.fuel, 0.0);	
    }

}
