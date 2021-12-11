package Monopoly.Configurations;


public class Progressiste extends Configuration {
	
	public Progressiste(int nbJoueursA, int nbJoueursP) {
        super();
        
    	this.setNbJoueursA(nbJoueursA);
    	this.setNbJoueursP(nbJoueursP);
        
		this.defaultLoiAntitrustSeuil = 100;
		this.defaultInvestissementValeurMax = 2000;
		this.defaultInvestissementValeurMin = 10;
		this.defaultInvestissementPourcentageMax = 80;
		this.defaultInvestissementPourcentageMin = 0;
		this.defaultSubventionMontantMax = 5000;
		this.defaultSubventionMontantMin = 1000;
	}
}
