package Monopoly.Tests.Configurations;

import org.junit.Before;

import Monopoly.Configurations.*;

public class EuropeApresCovid19Test extends ConfigurationTest {
	
	@Before
	public void init() {
		super.init();
		this.configuration = new EuropeApresCovid19(10, 0);
	}
}
