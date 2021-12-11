package Monopoly.Tests.Configurations;

import org.junit.Before;

import Monopoly.Configurations.*;

public class NeoLiberaleTest extends ConfigurationTest {
	
	@Before
	public void init() {
		super.init();
		this.configuration = new NeoLiberale(10, 0);
	}
}
