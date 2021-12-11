package Monopoly.Configurations;


public class Socialiste extends Configuration {

    public Socialiste(int nbJoueursA, int nbJoueursP) {
        super();
        
    	this.setNbJoueursA(nbJoueursA);
    	this.setNbJoueursP(nbJoueursP);
        
		this.defaultJoueurLiquideMax = 1000;
		this.defaultJoueurLiquideMin = 1000;
		this.defaultBureauFinancesPubliquesValeur = 500;
		this.defaultBureauFinancesPubliquesPourcentageMax = 90;
		this.defaultBureauFinancesPubliquesPourcentageMin = 70;
	}
}
