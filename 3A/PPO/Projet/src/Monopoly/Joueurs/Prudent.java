package Monopoly.Joueurs;

import Monopoly.Cases.*;

public class Prudent extends Joueur {

	public Prudent(int id, Case sortie, int liquide) {
		super(id, sortie, liquide);
	}
	
	public Investissement antitrustInvestissementARevendre() {
        Investissement max = this.investissements.get(0);
        for (Investissement i : this.investissements) {
            if (i.getValeurNominale() > max.getValeurNominale()) {
                max= i;
            }
        }
		return max;
	}
	
	public boolean acheteOuPas(Investissement i) {
		int val = (int)(0.02*(this.liquide));
		return (boolean)(val >= i.getValeurNominale());
	}
    
    public boolean joue(Case c) {
    	this.position = c;
        c.action(this);
        return super.joue(c);
    }
	
	public String toString() {
		return "Joueur Prudent  " + super.toString();
    }
}
