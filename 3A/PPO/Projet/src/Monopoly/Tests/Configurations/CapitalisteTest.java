package Monopoly.Tests.Configurations;


import org.junit.Before;

import Monopoly.Configurations.*;

public class CapitalisteTest extends ConfigurationTest {
	
	@Before
	public void init() {
		super.init();
		this.configuration = new Capitaliste(10, 0);
	}
}
