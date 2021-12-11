package Monopoly.Configurations;

public class NeoLiberale extends Configuration {
	
	public NeoLiberale(int nbJoueursA, int nbJoueursP) {
        super();
        
    	this.setNbJoueursA(nbJoueursA);
    	this.setNbJoueursP(nbJoueursP);
        
		this.defaultJoueurLiquideMax = 100000;
		this.defaultJoueurLiquideMin = 10;
		this.defaultLoiAntitrustSeuil = 1000;
	}
}
