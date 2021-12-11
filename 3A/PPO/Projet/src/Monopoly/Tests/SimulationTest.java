package Monopoly.Tests;

import static org.junit.Assert.*;

import java.util.LinkedList;
import java.util.List;

import org.junit.Before;
import org.junit.Test;

import Monopoly.Simulation;
import Monopoly.Cases.*;
import Monopoly.Joueurs.*;

public class SimulationTest {
	
	protected List<Joueur> joueurs;
	
	@Before
	public void init() {
		joueurs = new LinkedList<Joueur>();
		Case repos = new Repos(0);
		Joueur j1 = new Prudent(1, repos, 1000);
		Joueur j2 = new Prudent(2, repos, 1000);
		Joueur j3 = new Prudent(3, repos, 1000);
		joueurs.add(j1);
		joueurs.add(j2);
		joueurs.add(j3);
	}

	@Test
	public void nbJoueursEnLiceSuccedTest() {
		this.joueurs.get(1).setAPerdu(1);
		assertEquals(true, Simulation.assezJoueursEnLice(this.joueurs));
	}

	@Test
	public void nbJoueursEnLiceOneLeftTest() {
		this.joueurs.get(0).setAPerdu(4);
		this.joueurs.get(1).setAPerdu(1);
		assertEquals(false, Simulation.assezJoueursEnLice(this.joueurs));
	}

	@Test
	public void nbJoueursEnLiceFailTest() {
		this.joueurs.get(0).setAPerdu(1);
		this.joueurs.get(1).setAPerdu(4);
		this.joueurs.get(2).setAPerdu(1);
		assertEquals(false, Simulation.assezJoueursEnLice(this.joueurs));
	}
}
