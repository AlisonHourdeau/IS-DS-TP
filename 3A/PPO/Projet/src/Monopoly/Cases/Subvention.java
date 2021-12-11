package Monopoly.Cases;

import Monopoly.Joueurs.*;

public class Subvention extends Case {
    protected int montant;
    protected Etat etat;

	public Subvention(int id) {
		super(id);
		this.montant = 100;
		this.etat = new Etat(0, new Repos(-1), -1);

	}
	
	public Subvention(int id, int montant, Joueur etat) {
		super(id);
		this.montant = montant;
		this.etat = (Etat)etat;
	}
	
	public int getMontant() {
        return this.montant;
	}
	
	public Etat getEtat() {
        return this.etat;
	}

	@Override
	public boolean action(Joueur j) {
		if (this.getEtat().getLiquide() < this.getMontant()) {
			this.getEtat().removeLiquide(this.getMontant());
		}
		this.getEtat().paye(j, this.getMontant());
		return false;
	}
	
	public String toString() {
        String res;
        res = "(" + super.toString() + " _ montant : " + this.montant + ")";
        return res;
	}
}
