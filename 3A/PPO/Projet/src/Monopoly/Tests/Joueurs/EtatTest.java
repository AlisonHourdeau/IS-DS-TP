package Monopoly.Tests.Joueurs;

import org.junit.Before;
import org.junit.Test;

import Monopoly.Joueurs.*;

public class EtatTest extends JoueurTest {
	
	@Before
	public void init() {
		super.init();
		this.joueur = new Etat(0, this.repos, 10000);
	}


	@Test
	public void addLiquideSuccedTest() {
		super.addLiquideSuccedTest();
	}


	@Test
	public void addLiquideFailTest() {
		super.addLiquideFailTest();
	}


	@Test
	public void removeLiquideSuccedTest() {
		super.removeLiquideSuccedTest();
	}


	@Test
	public void removeLiquideFailTest() {
		super.removeLiquideFailTest();
	}

	@Test
	public void addInvestissementSuccedTest() {
		super.addInvestissementSuccedTest();
	}

}
