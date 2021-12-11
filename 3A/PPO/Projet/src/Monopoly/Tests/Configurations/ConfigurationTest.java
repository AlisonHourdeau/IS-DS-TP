package Monopoly.Tests.Configurations;

import static org.junit.Assert.*;
import java.util.LinkedList;

import org.junit.Before;
import org.junit.Test;

import Monopoly.Plateaux.Plateau;
import Monopoly.Cases.*;
import Monopoly.Configurations.*;
import Monopoly.Joueurs.*;

public abstract class ConfigurationTest {
	protected Case start;
	protected Plateau plateau;
	protected LinkedList<Joueur> joueurs;
	protected Configuration configuration;
	
	@Before
	public void init() {
		this.start = new Repos(0);
		this.plateau = new Plateau(32);
		this.joueurs = new LinkedList<Joueur>();
	}
	
	
	
	/* --------------------- Test Création Plateau --------------------- */
	
	// test taille plateau
	@Test
	public void initTaillePlateauTest() {
		this.configuration.initPlateau(this.plateau, this.start, new Etat(0, this.start, 100000));
		assertEquals(32, this.plateau.getPlateau().size());
	}

	// test nombre de cases antitrust sur le plateau
	@Test
	public void initNbLoiAntitrustTest() {
		this.configuration.initPlateau(this.plateau, this.start, new Etat(0, this.start, 100000));
		
		int actual = 0;
		
		for (Case c : this.plateau.getPlateau()) {
			if (c instanceof LoiAntitrust) {
				actual += 1;
			}
		}

		assertEquals(2, actual);
	}

	// test nombre de cases bureau finances publiques sur le plateau
	@Test
	public void initNbBureauFinancesPubliquesTest() {
		this.configuration.initPlateau(this.plateau, this.start, new Etat(0, this.start, 100000));
		
		int actual = 0;
		
		for (Case c : this.plateau.getPlateau()) {
			if (c instanceof BureauFinancesPubliques) {
				actual += 1;
			}
		}
		
		assertEquals(6, actual);
	}

	// test nombre de cases investissement sur le plateau
	@Test
	public void initNbInvestissementTest() {
		
		this.configuration.initPlateau(this.plateau, this.start, new Etat(0, this.start, 100000));
		
		int actual = 0;
		
		for (Case c : this.plateau.getPlateau()) {
			if (c instanceof Investissement) {
				actual += 1;
			}
		}

		assertEquals(16, actual);
	}

	// test nombre de cases subvention sur le plateau
	@Test
	public void initNbSubventionTest() {
		this.configuration.initPlateau(this.plateau, this.start, new Etat(0, this.start, 100000));
		
		int actual = 0;
		
		for (Case c : this.plateau.getPlateau()) {
			if (c instanceof Subvention) {
				actual += 1;
			}
		}
		assertEquals(2, actual);
	}

	// test nombre de cases repos sur le plateau
	@Test
	public void initNbReposTest() {
		this.configuration.initPlateau(this.plateau, this.start, new Etat(0, this.start, 100000));
		
		
		int actual = 0;
		
		for (Case c : this.plateau.getPlateau()) {
			if (c instanceof Repos) {
				actual += 1;
			}
		}
		
		assertEquals(5+1, actual);
	}

	
	
	/* --------------------- Test Création liste Joueurs --------------------- */
	
	// test 
	@Test
	public void tailleListeJoueursTest() {
		this.configuration.initJeu(plateau, joueurs);

		assertEquals(this.configuration.getNbJoueursA() + this.configuration.getNbJoueursP() + 1, this.joueurs.size());
	}
}
