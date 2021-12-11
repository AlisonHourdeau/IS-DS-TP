package Monopoly.Tests.Configurations;

import org.junit.Before;

import Monopoly.Configurations.*;

public class ProgressisteTest extends ConfigurationTest {
	
	@Before
	public void init() {
		super.init();
		this.configuration = new Progressiste(10, 0);
	}
}