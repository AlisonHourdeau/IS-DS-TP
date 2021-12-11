package Monopoly.Cases;

import Monopoly.Joueurs.*;

public class BureauFinancesPubliques extends Case {
    protected Impot nom;
    protected int valeur;
    protected int pourcentage;
    protected Etat etat;

	public BureauFinancesPubliques(int id) {
		super(id);
		this.nom = Impot.SUR_LE_REVENU;
		this.valeur = 100;
		this.pourcentage = 10;
		this.etat = new Etat(0, new Repos(-1), -1);
	}

	public BureauFinancesPubliques(int id, Impot nom, int valeur, int pourcentage, Joueur etat) {
		super(id);
		this.nom = nom;
		this.valeur = valeur;
		this.pourcentage = pourcentage;
		this.etat = (Etat)etat;
	}
	
	public void setValeur(int valeur) {
        this.valeur = valeur;
	}
	
	public int getValeur() {
        return this.valeur;
	}
	
	public int getPourcentage() {
        return this.pourcentage;
	}
	
	public Etat getEtat() {
        return this.etat;
	}

	@Override
	public boolean action(Joueur j) {
        if (j.getLiquide() >= this.getValeur()) {
            if (j.getLiquide() >= (int)(this.getValeur() * this.getPourcentage()) / 100) {
                j.paye(this.getEtat(), (int)(this.getValeur() * this.getPourcentage()) / 100);
                return false;
            }
            else { // ne devrait jamais se produir ... mais on ne sait jamais
                return true;
            }
        }
        return false;
	}
	
	public String toString() {
        String res;
        res = "(" + super.toString() + " _ impot_" + nom.toString().toLowerCase() + " _ valeur : " + this.valeur + " _ pourcentage : " + this.pourcentage + "%)";
        return res;

	}

}
