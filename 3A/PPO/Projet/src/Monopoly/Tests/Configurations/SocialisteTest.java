package Monopoly.Tests.Configurations;


import org.junit.Before;

import Monopoly.Configurations.*;

public class SocialisteTest extends ConfigurationTest {
	
	@Before
	public void init() {
		super.init();
		this.configuration = new Socialiste(10, 0);
	}
}
