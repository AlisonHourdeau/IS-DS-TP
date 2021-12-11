package Monopoly.Configurations;

import java.util.*;

import Monopoly.Cases.*;
import Monopoly.Joueurs.*;
import Monopoly.Plateaux.*;


public abstract class Configuration {
	protected int nbJoueursA;
	protected int nbJoueursP;
	
	protected int pourcentageCasesLoiAntitrust;
	protected int pourcentageCasesBureauFinancesPubliques;
	protected int pourcentageCasesInvestissement;
	protected int pourcentageCasesSubvention;
	protected int pourcentageCasesRepos;
	
	
	protected int defaultJoueurLiquideMax;
	protected int defaultJoueurLiquideMin;
	protected int defaultLoiAntitrustSeuil;
	protected int defaultBureauFinancesPubliquesValeur;
	protected int defaultBureauFinancesPubliquesPourcentageMax;
	protected int defaultBureauFinancesPubliquesPourcentageMin;
	protected int defaultInvestissementValeurMax;
	protected int defaultInvestissementValeurMin;
	protected int defaultInvestissementPourcentageMax;
	protected int defaultInvestissementPourcentageMin;
	protected int defaultSubventionMontantMax;
	protected int defaultSubventionMontantMin;
    
    public Configuration() {
    	this.nbJoueursA = -1;
    	this.nbJoueursP = -1;
        
        this.pourcentageCasesLoiAntitrust = 8;
        this.pourcentageCasesBureauFinancesPubliques = 26;
        this.pourcentageCasesInvestissement = 76;
        this.pourcentageCasesSubvention = 82;
        this.pourcentageCasesRepos = 99;

        this.defaultJoueurLiquideMax = 20000;
        this.defaultJoueurLiquideMin = 10;
        this.defaultLoiAntitrustSeuil = 500;
        this.defaultBureauFinancesPubliquesValeur = 1000;
        this.defaultBureauFinancesPubliquesPourcentageMax = 50;
        this.defaultBureauFinancesPubliquesPourcentageMin = 20;
        this.defaultInvestissementValeurMax = 500;
        this.defaultInvestissementValeurMin = 10;
        this.defaultInvestissementPourcentageMax = 70;
        this.defaultInvestissementPourcentageMin = 50;
        this.defaultSubventionMontantMax = 700;
        this.defaultSubventionMontantMin = 90;
        
    }
    
	public void initJeu(Plateau plateau, List<Joueur> joueurs) {
    	Case c;
        c = new Repos(0);
        Joueur j = new Etat(0, c, 1000000);
    	
    	this.initPlateau(plateau, c, j);
    	
        joueurs.add(j); // l'État
    	
        this.initJoueurs(joueurs, c);
	}
	
    public void initPlateau(Plateau plateau, Case c, Joueur etat) {
        
    	int nbCases = plateau.getNbCases();
    	
    	List<Case> listeCases = new ArrayList<Case>();
    	
    	plateau.addCase(c);
    	
    	int id = 0;
    	int random1;
    	int random2;
    	
    	int loiAntitrust = (int) (this.pourcentageCasesLoiAntitrust * nbCases) / 100;
    	int bureauFinancesPubliques = (int) (this.pourcentageCasesBureauFinancesPubliques * nbCases) / 100;
    	int investissement = (int) (this.pourcentageCasesInvestissement * nbCases) / 100;
    	int subvention = (int) (this.pourcentageCasesSubvention * nbCases) / 100;
    	int repos = (int) (this.pourcentageCasesRepos * nbCases) / 100;
    	
    	
        while (id < loiAntitrust) {
            id += 1;
            
            listeCases.add(new LoiAntitrust(id, this.defaultLoiAntitrustSeuil, etat));
        }
        
        while (id < bureauFinancesPubliques) {
            id += 1;
            
            random2 = new Random().nextInt(2);
            
            random1 = new Random().nextInt(this.defaultBureauFinancesPubliquesPourcentageMax - this.defaultBureauFinancesPubliquesPourcentageMin)+this.defaultBureauFinancesPubliquesPourcentageMin;
            
            if (random2 == 0) {
                
                listeCases.add(new BureauFinancesPubliques(id, Impot.SUR_LE_REVENU, this.defaultBureauFinancesPubliquesValeur, random1, etat));
            }
            
            else {
                
                listeCases.add(new BureauFinancesPubliques(id, Impot.FONCIER, this.defaultBureauFinancesPubliquesValeur, random1, etat));
            }
        }
        
        while (id < investissement/*nbCasesRestant*/) {
            id += 1;
            
            
            random2 = new Random().nextInt(this.defaultInvestissementPourcentageMax - this.defaultInvestissementPourcentageMin)+this.defaultInvestissementPourcentageMin;
            random1 = new Random().nextInt(this.defaultInvestissementValeurMax - this.defaultInvestissementValeurMin)+this.defaultInvestissementValeurMin;
            
            listeCases.add(new Investissement(id, random1, random2, etat));
        }
    	
        while (id < subvention) {
            id += 1;
            
            random1 = new Random().nextInt(this.defaultSubventionMontantMax - this.defaultSubventionMontantMin)+this.defaultSubventionMontantMin;

            listeCases.add(new Subvention(id, random1, etat));
        }
    	
        while (id < repos) {
            id += 1;
            
            listeCases.add(new Repos(id));
    	}
    	
    	Collections.shuffle(listeCases);
    	Collections.shuffle(listeCases);
    	Collections.shuffle(listeCases);
    	Collections.shuffle(listeCases);
    	Collections.shuffle(listeCases);
    	
    	for (Case c2 : listeCases) {
            plateau.addCase(c2);
    	}
    }
    
	public void initJoueurs(List<Joueur> joueurs, Case c) {
		List<Joueur> j = new LinkedList<Joueur>();
		
		int i = 1;
    	int random;
		
		while (i <= this.nbJoueursA) {
			random = new Random().nextInt(this.defaultJoueurLiquideMax - this.defaultJoueurLiquideMin + 1)+this.defaultJoueurLiquideMin;
			j.add(new Agressif(i, c, random));
			i += 1;
		}
		
		while (i <= this.nbJoueursA + this.nbJoueursP) {
			random = new Random().nextInt(this.defaultJoueurLiquideMax - this.defaultJoueurLiquideMin + 1)+this.defaultJoueurLiquideMin;
			j.add(new Prudent(i, c, random));
			i += 1;
		}
    	
    	Collections.shuffle(j);
    	Collections.shuffle(j);
    	Collections.shuffle(j);
    	Collections.shuffle(j);
    	Collections.shuffle(j);

    	
    	for (Joueur jou : j) {
            joueurs.add(jou);
    	}
	}
	
	
	
	
	/* --------------------- Getters & CaseSetters --------------------- */
	
	
	// Joueurs
	
    public void setNbJoueursA(int nbJoueursA) {
		this.nbJoueursA = nbJoueursA;
	}
    
    public void setNbJoueursP(int nbJoueursP) {
		this.nbJoueursP = nbJoueursP;
	}

	public int getNbJoueursA() {
		return this.nbJoueursA;
	}

	public int getNbJoueursP() {
		return this.nbJoueursP;
	}
	
	
	// Defaults

	public int getDefaultJoueurLiquideMax() {
		return this.defaultJoueurLiquideMax;
	}

	public int getDefaultJoueurLiquideMin() {
		return this.defaultJoueurLiquideMin;
	}

	public int getDefaultLoiAntitrustSeuil() {
		return this.defaultLoiAntitrustSeuil;
	}

	public int getDefaultBureauFinancesPubliquesValeur() {
		return this.defaultBureauFinancesPubliquesValeur;
	}

	public int getDefaultBureauFinancesPubliquesPourcentageMax() {
		return this.defaultBureauFinancesPubliquesPourcentageMax;
	}

	public int getDefaultBureauFinancesPubliquesPourcentageMin() {
		return this.defaultBureauFinancesPubliquesPourcentageMin;
	}

	public int getDefaultInvestissementValeurMax() {
		return this.defaultInvestissementValeurMax;
	}

	public int getDefaultInvestissementValeurMin() {
		return this.defaultInvestissementValeurMin;
	}

	public int getDefaultInvestissementPourcentageMax() {
		return this.defaultInvestissementPourcentageMax;
	}

	public int getDefaultInvestissementPourcentageMin() {
		return this.defaultInvestissementPourcentageMin;
	}

	public int getDefaultSubventionMontantMax() {
		return this.defaultSubventionMontantMax;
	}

	public int getDefaultSubventionMontantMin() {
		return this.defaultSubventionMontantMin;
	}
	
	
	// Pourcentages

	public int getPourcentageCasesLoiAntitrust() {
		return this.pourcentageCasesLoiAntitrust;
	}

	public int getPourcentageCasesBureauFinancesPubliques() {
		return this.pourcentageCasesBureauFinancesPubliques;
	}

	public int getPourcentageCasesInvestissement() {
		return this.pourcentageCasesInvestissement;
	}

	public int getPourcentageCasesSubvention() {
		return this.pourcentageCasesSubvention;
	}

	public int getPourcentageCasesRepos() {
		return this.pourcentageCasesRepos;
	}
}
