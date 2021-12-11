package Monopoly.Tests.Plateaux;

import static org.junit.Assert.*;

import org.junit.Before;
import org.junit.Test;

import Monopoly.Cases.*;
import Monopoly.Plateaux.Plateau;

public class PlateauTest {
	
	protected Plateau plateau;
	
	@Before
	public void init() {
		this.plateau = new Plateau(32);
	}

	@Test
	public void addCaseTaillePlateauTest() {
		int taille = this.plateau.getPlateau().size();
		this.plateau.addCase(new Repos(0));
		assertEquals(taille + 1, this.plateau.getPlateau().size());
	}
	
	@Test
	public void addCaseContientCaseTest() {
		Case c = new Repos(0);
		this.plateau.addCase(c);
		assertTrue(this.plateau.getPlateau().contains(c));
	}

}
