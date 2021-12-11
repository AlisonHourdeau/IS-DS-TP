package Monopoly.Cases;

import Monopoly.Joueurs.*;

public class LoiAntitrust extends Case {
    protected int seuil;
    protected Etat etat;

	public LoiAntitrust(int id) {
		super(id);
		this.seuil = 1000;
		this.etat = new Etat(0, new Repos(0), 10000);
	}
	
	public LoiAntitrust(int id, int seuil, Joueur etat) {
		super(id);
		this.seuil = seuil;
		this.etat = (Etat)etat;
	}
	
	public int getSeuil() {
        return this.seuil;
	}

	@Override
	public boolean action(Joueur j) {
        while (j.getTotalInvestissements() > this.getSeuil()) {
            Investissement i = j.antitrustInvestissementARevendre();
            int somme = (int)(i.getValeurNominale() / 2);
            j.addLiquide(somme);
            this.etat.removeLiquide(somme);
            j.removeInvestissement(i);
        }
		return false;
	}
	
	public String toString() {
        String res;
        res = "(" + super.toString() + " _ seuil : " + this.seuil + ")";
        return res;

	}
}
