package Monopoly.Tests.Cases;

import static org.junit.Assert.*;

import org.junit.Before;
import org.junit.Test;

import Monopoly.Cases.*;
import Monopoly.Joueurs.*;

public class BureauFinancesPubliquesTest extends CaseTest {
	
	@Before
	public void init() {
		super.init();
		this.c = new BureauFinancesPubliques(1, Impot.FONCIER, 1001, 20, this.etat);
	}

	@Test
	public void actionAgressifDepassePasSeuilTest() {
		int liquide = this.joueurA.getLiquide();
		this.c.action(joueurA);
		assertEquals(liquide, this.joueurA.getLiquide());
	}

	@Test
	public void actionAgressifDepasseSeuilTest() {
		this.joueurA = new Agressif(5, new Repos(0), 1001);
		int liquide = this.joueurA.getLiquide();
		this.c.action(joueurA);
		assertNotEquals(liquide, this.joueurA.getLiquide());
	}

	@Test
	public void actionPrudentDepassePasSeuilTest() {
		int liquide = this.joueurP.getLiquide();
		assertEquals(liquide, this.joueurP.getLiquide());
	}

	@Test
	public void actionPrudentDepasseSeuilTest() {
		this.joueurP = new Prudent(5, new Repos(0), 1001);
		int liquide = this.joueurP.getLiquide();
		this.c.action(joueurP);
		assertNotEquals(liquide, this.joueurP.getLiquide());
	}

	@Test
	public void actionPrudentDepasseSeuilEgalAAgressifDepasseSeuilTest() {
		this.joueurA = new Agressif(5, new Repos(0), 1001);
		this.joueurP = new Prudent(5, new Repos(0), 1001);
		this.c.action(joueurA);
		this.c.action(joueurP);
		assertEquals(this.joueurP.getLiquide(), this.joueurA.getLiquide());
	}

	@Test
	public void actionAgressifReturnFalseZeroTest() {
		this.joueurA = new Agressif(5, new Repos(0), 0);
		boolean perd = this.c.action(joueurA);
		assertFalse(perd); // un joueur ne donnera qu'une partie de son argent, il ne risque donc jamais de passer en dessous de 0
	}

	@Test
	public void actionAgressifReturnFalseTest() {
		this.joueurA = new Agressif(5, new Repos(0), 1000);
		boolean perd = this.c.action(joueurA);
		assertFalse(perd);
	}

	@Test
	public void actionPrudentReturnFalseZeroTest() {
		this.joueurP = new Prudent(5, new Repos(0), 1);
		boolean perd = this.c.action(joueurP);
		assertFalse(perd); // un joueur ne donnera qu'une partie de son argent, il ne risque donc jamais de passer en dessous de 0
	}

	@Test
	public void actionPrudentReturnFalseTest() {
		this.joueurP = new Prudent(5, new Repos(0), 1000);
		boolean perd = this.c.action(joueurP);
		assertFalse(perd);
	}

}
