package Monopoly.Cases;

import Monopoly.Joueurs.*;

public abstract class Case {
	private int id;
	
	public Case(int id) {
		this.id = id;
	}
	
	public int getId() {
        return this.id;
	}
	
	public String toString() {
        return "Case : " + this.id;
	}
	
	public abstract boolean action(Joueur j);
}
