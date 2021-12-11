package Monopoly.Joueurs;

import Monopoly.Cases.*;

public class Agressif extends Joueur {

	public Agressif(int id, Case sortie, int liquide) {
		super(id, sortie, liquide);
	}
	
	public Investissement antitrustInvestissementARevendre() {
        Investissement min = this.investissements.get(0);
        for (Investissement i : this.investissements) {
            if (i.getValeurNominale() < min.getValeurNominale()) {
                min = i;
            }
        }
        return min;
	}
	
	public boolean acheteOuPas(Investissement i) {
		int val = this.liquide;
		return (boolean)(val >= i.getValeurNominale());
	}
    
    public boolean joue(Case c) {
        this.position = c;
        c.action(this);
        return super.joue(c);
    }
	
	public String toString() {
		return "Joueur Agressif " + super.toString();
    }
}
