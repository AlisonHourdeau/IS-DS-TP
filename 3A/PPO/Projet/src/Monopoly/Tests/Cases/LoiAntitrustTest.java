package Monopoly.Tests.Cases;

import static org.junit.Assert.*;

import org.junit.Before;
import org.junit.Test;

import Monopoly.Cases.Investissement;
import Monopoly.Cases.LoiAntitrust;
import Monopoly.Cases.Repos;
import Monopoly.Joueurs.Etat;

public class LoiAntitrustTest extends CaseTest {
	protected Investissement ia1;
	protected Investissement ia2;
	protected Investissement ip1;
	protected Investissement ip2;
	
	@Before
	public void init() {
		super.init();
		this.c = new LoiAntitrust(5, 2000, new Etat(0, new Repos(0), 1000));
		
		ia1 = new Investissement(1, 900, 20, this.joueurA);
		ia2 = new Investissement(1, 1100, 20, this.joueurA);
		this.joueurA.addInvestissement(ia1);
		this.joueurA.addInvestissement(ia2);
		
		ip1 = new Investissement(1, 900, 20, this.joueurP);
		ip2 = new Investissement(1, 1100, 20, this.joueurP);
		this.joueurP.addInvestissement(ip1);
		this.joueurP.addInvestissement(ip2);
	}

	@Test
	public void actionAgressifSansReventeTest() {
		int totalInvestissements = this.joueurA.getTotalInvestissements();
		this.c.action(joueurA);
		assertEquals(totalInvestissements, this.joueurA.getTotalInvestissements());
	}

	@Test
	public void actionAgressifAvecReventeTest() {

		Investissement ia3 = new Investissement(1, 10, 20, this.joueurA);
		this.joueurA.addInvestissement(ia3);
		int totalInvestissements = this.joueurA.getTotalInvestissements();
		this.c.action(joueurA);
		assertNotEquals(totalInvestissements, this.joueurA.getTotalInvestissements());
	}

	@Test
	public void actionAgressifReventeInvestissementMinTest() {

		Investissement ia3 = new Investissement(1, 10, 20, this.joueurA);
		this.joueurA.addInvestissement(ia3);
		this.c.action(joueurA);
		boolean retire = true;
		for (Investissement i : this.joueurA.getInvestissements()) {
			if (i.getId() == ia3.getId()) {
				retire = false;
			}
		}
		assertFalse(retire);
	}

	@Test
	public void actionPrudentSansReventeTest() {
		int totalInvestissements = this.joueurP.getTotalInvestissements();
		this.c.action(joueurP);
		assertEquals(totalInvestissements, this.joueurP.getTotalInvestissements());
	}

	@Test
	public void actionPrudentAvecReventeTest() {
		Investissement ip3 = new Investissement(1, 10, 20, this.joueurP);
		this.joueurP.addInvestissement(ip3);
		int totalInvestissements = this.joueurP.getTotalInvestissements();
		this.c.action(joueurP);
		assertNotEquals(totalInvestissements, this.joueurP.getTotalInvestissements());
	}

	@Test
	public void actionPrudentReventeInvestissementMaxTest() {
		Investissement ip3 = new Investissement(1, 2000, 20, this.joueurP);
		this.joueurA.addInvestissement(ip3);
		this.c.action(joueurP);
		boolean retire = true;
		for (Investissement i : this.joueurP.getInvestissements()) {
			if (i.getId() == ip3.getId()) {
				retire = false;
			}
		}
		assertFalse(retire);
	}

}
