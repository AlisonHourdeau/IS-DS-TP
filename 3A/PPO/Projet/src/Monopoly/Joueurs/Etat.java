package Monopoly.Joueurs;

import Monopoly.Cases.*;

public class Etat extends Joueur {
	
	public Etat(int id, Case sortie, int liquide) {
		super(id, sortie, liquide);
	}
	
	public String toString() {
		return "Joueur Etat - liquide - " + this.liquide;
    }
}

