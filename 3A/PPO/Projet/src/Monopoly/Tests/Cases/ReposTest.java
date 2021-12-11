package Monopoly.Tests.Cases;

import static org.junit.Assert.*;

import org.junit.Before;
import org.junit.Test;

import Monopoly.Cases.*;

public class ReposTest extends CaseTest{
	
	@Before
	public void init() {
		super.init();
		this.c = new Repos(0);
	}
	
	@Test
	public void actionAgressifTest() {
		assertEquals(false, c.action(this.joueurA));
	}

	@Test
	public void actionPrudentTest() {
		assertEquals(false, c.action(this.joueurP));
	}

}
