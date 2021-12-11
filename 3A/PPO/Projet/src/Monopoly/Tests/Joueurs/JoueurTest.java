package Monopoly.Tests.Joueurs;

import static org.junit.Assert.*;

import org.junit.*;

import Monopoly.Cases.*;
import Monopoly.Joueurs.*;

public abstract class JoueurTest {

	protected Joueur joueur;
	protected Joueur j2;
	protected Case repos;
	protected Investissement invMin;
	protected Investissement invInter;
	protected Investissement invMax;
	
	@Before
	public void init() {
		this.repos = new Repos(0);
		this.j2 = new Prudent(1, this.repos, 10);
		Etat etat = new Etat(0, this.repos, 1000);
		this.invMin = new Investissement(1, 100, 20, etat);
		this.invInter = new Investissement(2, 200, 20, etat);
		this.invMax = new Investissement(3, 300, 20, etat);
	}

	public void addLiquideSuccedTest() {
		int init = this.joueur.getLiquide();
		this.joueur.addLiquide(1999);
		assertEquals(init + 1999, this.joueur.getLiquide());
	}

	public void addLiquideFailTest() {
		int init = this.joueur.getLiquide();
		this.joueur.addLiquide(1999);
		assertNotEquals(init + 1000, this.joueur.getLiquide());
	}

	public void removeLiquideSuccedTest() {
		int init = this.joueur.getLiquide();
		this.joueur.removeLiquide(1999);
		assertEquals(init - 1999, this.joueur.getLiquide());
	}

	public void removeLiquideFailTest() {
		int init = this.joueur.getLiquide();
		this.joueur.removeLiquide(1999);
		assertNotEquals(init - 1000, this.joueur.getLiquide());
	}

	public void addInvestissementSuccedTest() {
		int nbInv = this.joueur.getInvestissements().size();
		Investissement i = new Investissement(1, 100, 20, this.j2);
		this.joueur.addInvestissement(i);
		assertEquals(i, this.joueur.getInvestissements().get(nbInv));
	}

	public void addInvestissementFailTest() {
		int nbInv = this.joueur.getInvestissements().size();
		Investissement i = new Investissement(1, 100, 20, this.j2);
		this.joueur.addInvestissement(i);
		assertEquals(i, this.joueur.getInvestissements().get(nbInv));
	}

	public void removeInvestissementTest() {
		this.joueur.removeInvestissement(this.invInter);
		assertFalse(this.joueur.getInvestissements().contains(this.invInter));
	}

	public void payeAntitrustJoueurTest() {
		int liquide = this.joueur.getLiquide();
		this.joueur.payeAntitrust(100, new Etat(0, new Repos(0), 0));
		assertEquals(liquide + 100, this.joueur.getLiquide());
	}

	public void payeAntitrustEtatTest() {
		Etat etat = new Etat(0, new Repos(0), 0);
		int liquide = etat.getLiquide();
		this.joueur.payeAntitrust(100, etat);
		assertEquals(liquide - 100, etat.getLiquide());
	}

	public void payeJoueurTest() {
		int liquide = this.joueur.getLiquide();
		this.joueur.paye(new Etat(0, new Repos(0), 0), 100);
		assertEquals(liquide - 100, this.joueur.getLiquide());
	}

	public void payeEtatTest() {
		Etat etat = new Etat(0, new Repos(0), 0);
		int liquide = etat.getLiquide();
		this.joueur.paye(etat, 100);
		assertEquals(liquide + 100, etat.getLiquide());
	}
}
