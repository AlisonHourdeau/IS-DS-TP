package Monopoly.Tests.Cases;

import org.junit.Before;

import Monopoly.Cases.*;
import Monopoly.Joueurs.*;

public abstract class CaseTest {

	protected Joueur joueurA;
	protected Joueur joueurP;
	protected Case c;
	protected Etat etat;
	
	@Before
	public void init() {
		this.etat = new Etat(0, new Repos(0), 5000);
		this.joueurA = new Agressif(5, new Repos(0), 1000);
		this.joueurP = new Prudent(6, new Repos(0), 1000);
	}
}
