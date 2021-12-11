package Monopoly.Joueurs;

import java.util.*;


import Monopoly.Cases.*;

public abstract class Joueur implements Comparable<Joueur> {
    protected int id;
	protected Case position;
	protected int liquide;
	protected List<Investissement> investissements;
	protected int totalInvestissements;

	protected int aPerdu;
	
	public Joueur(int id, Case sortie, int liquide) {
        this.id = id;
		this.position = sortie;
		this.liquide = liquide;
		this.investissements = new ArrayList<Investissement>();
		this.totalInvestissements = 0;
		this.aPerdu = 0;
	}
	public int getAPerdu() {
		return this.aPerdu;
	}

	public void setAPerdu(int aPerdu) {
		this.aPerdu = aPerdu;
	}
	
	public int getId() {
        return this.id;
	}
	
	public Case getPosition() {
        return this.position;
	}
	
	public int getLiquide() {
        return this.liquide;
	}
	
	public int getTotalInvestissements() {
        return this.totalInvestissements;
	}
	
	public List<Investissement> getInvestissements() {
        return this.investissements;
	}
	
	public void addLiquide(int liquide) {
        this.liquide += liquide;
	}
	
	public void removeLiquide(int liquide) {
        this.liquide -= liquide;
	}
	
	public void addInvestissement(Investissement investissement) {
        this.investissements.add(investissement);
        investissement.changeProprietaire(this);
        this.totalInvestissements += investissement.getValeurNominale();
	}
	
	public void removeInvestissement(Investissement investissement) {
        this.investissements.remove(investissement);
        this.totalInvestissements -= investissement.getValeurNominale();
	}
	
	public void payeAntitrust(int somme, Etat etat) {
        this.addLiquide(somme);
        etat.removeLiquide(somme);
	}
	
	public void paye(Joueur joueur, int somme) {
        joueur.addLiquide(somme);
        this.removeLiquide(somme);
	}
	
	public boolean joue(Case c) {
        return this.liquide < 0;
    }
	
	public boolean acheteOuPas(Investissement i) {
        return false;
	}
	
	public Investissement antitrustInvestissementARevendre() {
        return null;
	}
	
	public int compareTo(Joueur joueur) {
		return this.aPerdu > joueur.getAPerdu() ? 1 : -1;
	}
	
	public boolean equals(Object o) {
		if (o instanceof Joueur) {
			Joueur j = (Joueur)o;
			if (this.id == j.getId()) {
				return true;
			}
		}
		return false;
	}
	
	public String toString() {
        return this.id + " position : " + this.position + " _ liquide : " + this.liquide + " totalInvestissements : " + this.totalInvestissements;
        
    }
}
