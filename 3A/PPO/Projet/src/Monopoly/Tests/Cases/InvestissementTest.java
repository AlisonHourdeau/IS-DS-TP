package Monopoly.Tests.Cases;

import static org.junit.Assert.*;

import java.util.List;

import org.junit.Before;

import Monopoly.Cases.*;

import org.junit.Test;

public class InvestissementTest extends CaseTest {
	
	@Before
	public void init() {
		super.init();
		this.c = new Investissement(6, 500, 35, this.etat);
	}

	@Test
	public void changeProprietaireAgressifJoueurDifferentTest() {
		Investissement inv = new Investissement(6, this.joueurA.getLiquide(), 35, this.etat);
		
		inv.changeProprietaire(this.joueurA);
		
		assertEquals(this.joueurA.getId(), inv.getProprietaire().getId());
	}

	@Test
	public void changeProprietaireProprietaireJoueurMemeTest() {
		Investissement inv = new Investissement(6, (int)(0.02*(this.joueurP.getLiquide())) + 1, 35, this.joueurP);
		
		inv.changeProprietaire(this.joueurP);
		
		assertEquals(this.joueurP.getId(), inv.getProprietaire().getId());
	}

	@Test
	public void changeProprietairePrudentJoueurDifferentTest() {
		Investissement inv = new Investissement(6, (int)(0.02*(this.joueurP.getLiquide())), 35, this.etat);
		
		inv.changeProprietaire(this.joueurP);
		
		assertEquals(this.joueurP.getId(), inv.getProprietaire().getId());
	}

	@Test
	public void changeProprietairePrudentJoueurMemeTest() {
		Investissement inv = new Investissement(6, (int)(0.02*(this.joueurP.getLiquide())) + 1, 35, this.joueurP);
		
		inv.changeProprietaire(this.joueurP);
		
		assertEquals(this.joueurP.getId(), inv.getProprietaire().getId());
	}

	@Test
	public void actionAgressifInvestissementDejaAcheteInvestissementPasEnPlusTest() {
		this.c = new Investissement(6, 1500, 5, this.joueurP);
		List<Investissement> investissements = this.joueurA.getInvestissements();
		
		this.c.action(this.joueurA);
		
		assertEquals(investissements.size(), this.joueurA.getInvestissements().size());
	}

	@Test
	public void actionAgressifInvestissementDejaAcheteAugmentePasTotalInvestissementTest() {
		this.c = new Investissement(6, 500, 35, this.joueurP);
		int totalInvestissements = this.joueurA.getTotalInvestissements();
		
		this.c.action(this.joueurA);
				
		assertEquals(totalInvestissements, this.joueurA.getTotalInvestissements());
	}

	@Test
	public void actionAgressifInvestissementDejaAcheteDonneLiquideTest() {
		this.c = new Investissement(6, 1500, 35, this.joueurP);
		int liquide = this.joueurA.getLiquide();
		
		this.c.action(this.joueurA);

		assertNotEquals(liquide, this.joueurA.getLiquide());
	}

	@Test
	public void actionAgressifInvestissementVaAcheterInvestissementEnPlusTest() {
		int tailleInvestissements = this.joueurA.getInvestissements().size();
		
		this.c.action(this.joueurA);
		
		assertEquals(tailleInvestissements + 1, this.joueurA.getInvestissements().size());
	}

	@Test
	public void actionAgressifInvestissementVaAcheterAugmenteTotalInvestissementTest() {
		int totalInvestissements = this.joueurA.getTotalInvestissements();
		
		this.c.action(this.joueurA);
				
		assertTrue(totalInvestissements < this.joueurA.getTotalInvestissements());
	}

	@Test
	public void actionAgressifInvestissementVaAcheterDonneLiquideTest() {
		int liquide = this.joueurA.getLiquide();
		
		this.c.action(this.joueurA);
		
		assertNotEquals(liquide, this.joueurA.getLiquide());
	}

	@Test
	public void actionAgressifInvestissementVaPasAcheterTest() {
		this.c = new Investissement(6, 1001, 20, this.etat);
		int liquide = this.joueurA.getLiquide();
		
		this.c.action(this.joueurA);
		
		assertEquals(liquide, this.joueurA.getLiquide());
	}

	@Test
	public void actionAgressifChangeProprietaireJoueurDifferentTest() {
		
	}

	@Test
	public void actionAgressifChangeProprietaireJoueurMemeTest() {
		
	}
	
	@Test
	public void actionPrudentInvestissementDejaAcheteInvestissementPasEnPlusTest() {
		this.c = new Investissement(6, 1500, 35, this.joueurA);
		List<Investissement> investissements = this.joueurP.getInvestissements();
		
		this.c.action(this.joueurP);
		
		assertEquals(investissements.size(), this.joueurP.getInvestissements().size());
	}

	@Test
	public void actionPrudentInvestissementDejaAcheteAugmentePasTotalInvestissementTest() {
		this.c = new Investissement(6, 500, 35, this.joueurA);
		int totalInvestissements = this.joueurP.getTotalInvestissements();
		
		this.c.action(this.joueurP);
				
		assertEquals(totalInvestissements, this.joueurP.getTotalInvestissements());
	}

	@Test
	public void actionPrudentInvestissementDejaAcheteDonneLiquideTest() {
		this.c = new Investissement(6, 1500, 35, this.joueurA);
		int liquide = this.joueurP.getLiquide();
		
		this.c.action(this.joueurP);
		
		assertNotEquals(liquide, this.joueurP.getLiquide());
	}

	@Test
	public void actionPrudentInvestissementVaAcheterInvestissementEnPlusTest() {
		this.c = new Investissement(6, (int)(0.02*(this.joueurP.getLiquide())), 35, this.etat);
		int tailleInvestissements = this.joueurP.getInvestissements().size();
		
		this.c.action(this.joueurP);
		
		assertEquals(tailleInvestissements + 1, this.joueurP.getInvestissements().size());
	}

	@Test
	public void actionPrudentInvestissementVaAcheterAugmenteTotalInvestissementTest() {
		this.c = new Investissement(6, (int)(0.02*(this.joueurP.getLiquide())), 35, this.etat);
		int totalInvestissements = this.joueurP.getTotalInvestissements();
		
		this.c.action(this.joueurP);
				
		assertTrue(totalInvestissements < this.joueurP.getTotalInvestissements());
	}

	@Test
	public void actionPrudentInvestissementVaAcheterDonneLiquideTest() {
		this.c = new Investissement(6, (int)(0.02*(this.joueurP.getLiquide())), 35, this.etat);
		int liquide = this.joueurP.getLiquide();
		
		this.c.action(this.joueurP);
		
		assertNotEquals(liquide, this.joueurP.getLiquide());
	}

	@Test
	public void actionPrudentInvestissementVaPasAcheterTest() {
		this.c = new Investissement(6, (int)(0.02*(this.joueurP.getLiquide())) + 1, 35, this.etat);
		int liquide = this.joueurP.getLiquide();
		
		this.c.action(this.joueurP);
		
		assertEquals(liquide, this.joueurP.getLiquide());
	}

	@Test
	public void actionPrudentChangeProprietaireJoueurDifferentTest() {
		Investissement inv = new Investissement(6, (int)(0.02*(this.joueurP.getLiquide())), 35, this.etat);

		inv.action(this.joueurP);

		assertEquals(this.joueurP.getId(), inv.getProprietaire().getId());
	}

	@Test
	public void actionPrudentChangeProprietaireJoueurMemeTest() {
		Investissement inv = new Investissement(6, (int)(0.02*(this.joueurP.getLiquide())) + 1, 35, this.etat);
		
		inv.action(this.joueurP);
		
		assertNotEquals(this.joueurP.getId(), inv.getProprietaire().getId());
	}
	
	@Test
	public void actionAgressifReturnTrueTest() {
		this.c = new Investissement(6, 5000, 100, this.joueurA);
		
		boolean perdu = this.c.action(this.joueurP);
		
		assertTrue(perdu);
	}
	
	@Test
	public void actionAgressifDejaAcheteReturnFalseTest() {
		this.c = new Investissement(6, 1500, 35, this.joueurP);
		
		boolean perdu = this.c.action(this.joueurA);
		
		assertFalse(perdu);
	}
	
	@Test
	public void actionAgressifVaAcheterReturnFalseTest() {		
		boolean perdu = this.c.action(this.joueurP);
		
		assertFalse(perdu);
	}
	
	@Test
	public void actionAgressifVaPasAcheterReturnFalseTest() {
		this.c = new Investissement(6, 1001, 20, this.etat);

		boolean perdu = this.c.action(this.joueurP);
		
		assertFalse(perdu);
	}
	
	@Test
	public void actionPrudentReturnTrueTest() {
		this.c = new Investissement(6, 5000, 100, this.joueurA);
		
		boolean perdu = this.c.action(this.joueurP);
		
		assertTrue(perdu);
	}
	
	@Test
	public void actionPrudentDejaAcheteReturnFalseTest() {
		this.c = new Investissement(6, 1500, 35, this.joueurA);
		
		boolean perdu = this.c.action(this.joueurP);
		
		assertFalse(perdu);
	}
	
	@Test
	public void actionPrudentVaAcheterReturnFalseTest() {		
		this.c = new Investissement(6, (int)(0.02*(this.joueurP.getLiquide())), 35, this.etat);
		
		boolean perdu = this.c.action(this.joueurP);
		
		assertFalse(perdu);
	}
	
	@Test
	public void actionPrudentVaPasAcheterReturnFalseTest() {
		this.c = new Investissement(6, (int)(0.02*(this.joueurP.getLiquide())) + 1, 35, this.etat);

		boolean perdu = this.c.action(this.joueurP);
		
		assertFalse(perdu);
	}
}
