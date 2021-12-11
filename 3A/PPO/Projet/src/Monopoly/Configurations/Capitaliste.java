package Monopoly.Configurations;

public class Capitaliste extends Configuration {
    
    public Capitaliste(int nbJoueursA, int nbJoueursP) {
        super();
        
    	this.setNbJoueursA(nbJoueursA);
    	this.setNbJoueursP(nbJoueursP);
        
    	this.defaultInvestissementValeurMax = 3000;
        this.defaultInvestissementValeurMin = 10;
        this.defaultInvestissementPourcentageMax = 90;
        this.defaultInvestissementPourcentageMin = 10;
    }
}
