package Monopoly.Tests.Joueurs;

import static org.junit.Assert.*;

import org.junit.Before;
import org.junit.Test;

import Monopoly.Cases.Investissement;
import Monopoly.Joueurs.*;

public class PrudentTest extends JoueurTest {
	
	@Before
	public void init() {
		super.init();
		this.joueur = new Prudent(2, this.repos, 10000);
		this.joueur.addInvestissement(this.invMin);
		this.joueur.addInvestissement(this.invInter);
		this.joueur.addInvestissement(this.invMax);
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

	@Test
	public void addInvestissementFailTest() {
		super.addInvestissementSuccedTest();
	}
	
	@Test
	public void removeInvestissementTest() {
		super.removeInvestissementTest();
	}

	@Test
	public void payeAntitrustJoueurTest() {
		super.payeAntitrustJoueurTest();
	}

	@Test
	public void payeAntitrustEtatTest() {
		super.payeAntitrustEtatTest();
	}

	@Test
	public void payeJoueurTest() {
		super.payeJoueurTest();
	}

	@Test
	public void payeEtatTest() {
		super.payeEtatTest();
	}
	
	@Test
	public void antitrustInvestissementARevendreTest() {
		Investissement inv = this.joueur.antitrustInvestissementARevendre();
		assertEquals(this.invMax.getId(), inv.getId()); 
	}

	@Test
	public void acheteOuPasOuiTest() {
		Etat etat = (Etat)this.invInter.getProprietaire();
		this.invInter = new Investissement(1, 200, 20, etat);
		boolean achete = this.joueur.acheteOuPas(this.invInter);
		assertTrue(achete);
	}
	
	@Test
	public void acheteOuPasNonTest() {
		Etat etat = (Etat)this.invInter.getProprietaire();
		this.invInter = new Investissement(1, 201, 20, etat);
		boolean achete = this.joueur.acheteOuPas(this.invInter);
		assertFalse(achete);
	}

}
