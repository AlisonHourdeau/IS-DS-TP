package Monopoly.Tests.Cases;

import static org.junit.Assert.*;

import org.junit.Before;

import Monopoly.Cases.*;

import org.junit.Test;

public class SubventionTest extends CaseTest {
	
	@Before
	public void init() {
		super.init();
		this.c = new Subvention(3, 100, this.etat);
	}

	@Test
	public void actionAgressifDepasseTest() {
		int liquide = this.joueurA.getLiquide();
		this.c.action(this.joueurA);
		assertNotEquals(liquide, this.joueurA.getLiquide());
	}

	@Test
	public void actionPrudentDepasseTest() {
		int liquide = this.joueurP.getLiquide();
		this.c.action(this.joueurP);
		assertNotEquals(liquide, this.joueurP.getLiquide());
	}

}
