package Monopoly.Cases;

import Monopoly.Joueurs.*;

public class Investissement extends Case {
	
	protected  int valeurNominale;
	protected int pourcentage;
	protected Joueur proprietaire;

	public Investissement(int id) {
		super(id);
		this.valeurNominale = 100;
		this.pourcentage = 10;
		this.proprietaire = new Etat(0, new Repos(-1), 0);

	}

	public Investissement(int id, int valeurNominale, int pourcentage, Joueur j) {
		super(id);
		this.valeurNominale = valeurNominale;
		this.pourcentage = pourcentage;
		this.proprietaire = j;
	}
	
	public void changeProprietaire(Joueur j) {
        this.proprietaire = j;
	}
	
	public int getValeurNominale() {
        return this.valeurNominale;
	}
	
	public int getPourcentage() {
        return this.pourcentage;
	}
	
	public Joueur getProprietaire() {
        return this.proprietaire;
    }

	@Override
	public boolean action(Joueur j) {
        
        if (this.getProprietaire().getId() == 0) {
        	if (j.acheteOuPas(this)) {
        		j.paye(this.getProprietaire(), this.getValeurNominale());
                j.addInvestissement(this);
                this.changeProprietaire(j);
            }
        }

        else if (this.getProprietaire().getId() != j.getId()) {
        	if (j.getLiquide() >= (int)(this.getValeurNominale() * this.getPourcentage()) / 100)  {
        		j.paye(this.getProprietaire(), (int)(this.getValeurNominale() * this.getPourcentage()) / 100);
        	}
        	else {
        	
        		return true;
        	}
		}
        return false;
	}
	
	public String toString() {
        String res;
        res = "(" + super.toString() + " _ valeur nominale : " + this.valeurNominale + " _ pourcentage : " + this.pourcentage + "%)";
        return res;

	}

}
