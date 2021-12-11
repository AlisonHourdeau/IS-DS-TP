package Monopoly.Cases;

import Monopoly.Joueurs.*;

public class Repos extends Case {

	public Repos(int id) {
		super(id);
	}

	@Override
	public boolean action(Joueur j) {
		return false;
	}
	
	@Override
	public String toString() {
		return "(" + super.toString() + ")";
	}
}
