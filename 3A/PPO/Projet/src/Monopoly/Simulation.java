package Monopoly;

import java.util.Collections;
import java.util.LinkedList;
import java.util.Random;
import java.util.Scanner;
import java.util.List;

import Monopoly.Cases.*;
import Monopoly.Joueurs.*;
import Monopoly.Plateaux.*;
import Monopoly.Configurations.*;


public class Simulation {
    
	public static boolean assezJoueursEnLice(List<Joueur> joueurs) {
		int cpt = 0;
		for (Joueur j : joueurs) {
			if (j.getAPerdu() == 0 && j.getId() != 0) {
				cpt += 1;
				if (cpt > 1) {
					return true;
				}
			}
		}
		return false;
	}
	
	public static String displayTransitivState(List<Joueur> joueurs) {
		String res = "";
		String resPerdus = "";
		List<Joueur> joueursTries = new LinkedList<Joueur>();
		joueursTries.addAll(joueurs);
		Collections.sort(joueursTries);
		boolean enJeu = true;
		res += "--------------- Joueurs en jeu ---------------\n";
		for (Joueur joueur : joueursTries) {
			
			
			if (enJeu && joueur.getAPerdu() != 0) {
				res += "--------------- Joueurs ayant perdus ---------------\n";
				enJeu = false;
			}
			if (joueur.getId() == 0) {
				res = "--------------- État ---------------\n" + joueur + "\n" + res;
			}
			else {
				if (joueur.getAPerdu() == 0) {
					res += joueur;
					res += "\n";
				}
				else {
					resPerdus = joueur + "\n" + resPerdus;
				}
				
			}
		}
		res += resPerdus;
		return res;
	}

	@SuppressWarnings("resource")
	public static void main(String[] args) {
        int taillePlateau = 32;
        Plateau plateau = new Plateau(taillePlateau);
        List<Joueur> joueurs = new LinkedList<Joueur>();
        
        Configuration c;
        Scanner in = new Scanner(System.in);
        
        int nbJoueursA = -1;
        int nbJoueursP = -1;
        
        boolean joueurPerd = false;
        boolean etatPerd = false;
        int arreter = 1;
        int lancerDuDe;
        
        System.out.println("Bienvenue sur cette variante de Monopoly proposant une simulation de jeu.\nDans un premier temps, veuillez indiquer si vous souhaitez que le jeu se déroule dans un environnement :\n\t1) NeoLiberale\n\t2) Socialiste\n\t3) Capitaliste\n\t4) Progressiste\n\t5) EuropeApresCovid19");

        System.out.print("Indiquez le plateau choisi : ");
        int donneesEntrees = in.nextInt();
        System.out.print("Vous avez choisi le mode : ");
        if (donneesEntrees == 1) {
        	System.out.println("NeoLiberale\n");
        	System.out.println("Deux typantitrustInvestissementARevendrees de joueurs peuvent participer à ce mode du Monopoly : les joueurs Agressifs et les joueurs Prudents");
        	System.out.print("Combien de joueurs Agressifs souhaitez vous au lancement du jeu ?\n-> ");
        	nbJoueursA = in.nextInt();
        	System.out.print("Combien de joueurs Prudents souhaitez vous au lancement du jeu ?\n-> ");
        	nbJoueursP = in.nextInt();
            c = new NeoLiberale(nbJoueursA, nbJoueursP);
        }
        else if (donneesEntrees == 2) {
        	System.out.println("Socialiste\n");
        	System.out.println("Deux types de joueurs peuvent participer à ce mode du Monopoly : les joueurs Agressifs et les joueurs Prudents");
        	System.out.print("Combien de joueurs Agressifs souhaitez vous au lancement du jeu ?\n-> ");
        	nbJoueursA = in.nextInt();
        	System.out.print("Combien de joueurs Prudents souhaitez vous au lancement du jeu ?\n-> ");
        	nbJoueursP = in.nextInt();
            c = new Socialiste(nbJoueursA, nbJoueursP);
        }
        else if (donneesEntrees == 3) {
        	System.out.println("Capitaliste\n");
        	System.out.println("Ce mode de jeu n'implique que des joueurs agressifs.");
        	System.out.print("Combien de joueurs souhaitez vous au lancement du jeu ?\n-> ");
        	nbJoueursA = in.nextInt();
        	nbJoueursP = 0;
            c = new Capitaliste(nbJoueursA, nbJoueursP);
        }
        else if (donneesEntrees == 4) {
        	System.out.println("Progressiste\n");
        	System.out.println("Deux types de joueurs peuvent participer à ce mode du Monopoly : les joueurs Agressifs et les joueurs Prudents");
        	System.out.println("Ce mode de jeu demande un nombre de participants élevé (au moins 20 au total).");
        	System.out.print("Combien de joueurs Agressifs souhaitez vous au lancement du jeu ?\n-> ");
        	nbJoueursA = in.nextInt();
        	System.out.print("Combien de joueurs Prudents souhaitez vous au lancement du jeu ?\n-> ");
        	nbJoueursP = in.nextInt();
        	while (nbJoueursA + nbJoueursP < 20) {
        		System.out.println("Le nombre de participants renseignés ne sont pas suffisant (il en faut au moins 20 au total), veuillez recommencer la saisie :");
            	System.out.print("Combien de joueurs Agressifs souhaitez vous au lancement du jeu ?\n-> ");
            	nbJoueursA = in.nextInt();
            	System.out.print("Combien de joueurs Prudents souhaitez vous au lancement du jeu ?\n-> ");
            	nbJoueursP = in.nextInt();
        	}
            c = new Progressiste(nbJoueursA, nbJoueursP);
        }
        else {
        	System.out.println("EuropeApresCovid19\n");
        	System.out.println("Deux types de joueurs peuvent participer à ce mode du Monopoly : les joueurs Agressifs et les joueurs Prudents");
        	System.out.println("Ce mode de jeu demande un nombre de participants Prudents plus élevé que le nombre de participants Agressifs.");
        	System.out.print("Combien de joueurs Agressifs souhaitez vous au lancement du jeu ?\n-> ");
        	nbJoueursA = in.nextInt();
        	System.out.print("Combien de joueurs Prudents souhaitez vous au lancement du jeu ?\n-> ");
        	nbJoueursP = in.nextInt();
        	while (nbJoueursA >nbJoueursP) {
        		System.out.println("Le nombre de participants Prudents n'est pas supérieur à celui des participants Agressifs, veuillez recommencer la saisie :");
            	System.out.print("Combien de joueurs Agressifs souhaitez vous au lancement du jeu ?\n-> ");
            	nbJoueursA = in.nextInt();
            	System.out.print("Combien de joueurs Prudents souhaitez vous au lancement du jeu ?\n-> ");
            	nbJoueursP = in.nextInt();
        	}
            c = new EuropeApresCovid19(nbJoueursA, nbJoueursP);
        }
        System.out.println();
    	System.out.println("Il y a " + nbJoueursA + " joueurs agressifs et " + nbJoueursP + " joueurs prudents dans ce jeu");
        System.out.println();
        
        c.initJeu(plateau, joueurs);
        Joueur etat = joueurs.get(0);
        Case depart = plateau.getPlateau().get(0);
        
        int newPosJoueur;
        int ordreDepart = 1;
        boolean tourJoueurEnMoins = false;
        
        int cpt = 0;
        
        while (!etatPerd && arreter == 1 && Simulation.assezJoueursEnLice(joueurs)) {
        	cpt += 1;
            if (tourJoueurEnMoins) {
            	ordreDepart += 1;
            	tourJoueurEnMoins = false;
            }
            
            for (Joueur j : joueurs) {
            	if (j.getAPerdu() == 0 && j.getId() != 0) {
            		            	
	            	lancerDuDe = new Random().nextInt(6 - 0) + 1;
	                newPosJoueur = j.getPosition().getId() + lancerDuDe;
	                joueurPerd = j.joue(plateau.getPlateau().get(newPosJoueur % taillePlateau));
	                
	                
	                if (joueurPerd) {
		                j.setAPerdu(ordreDepart);
		                tourJoueurEnMoins = true;
		                List<Investissement> inv = new LinkedList<Investissement>();
		                inv.addAll(j.getInvestissements());
		                for (Investissement i : inv) {
		                	etat.addInvestissement(i);
		                	i.changeProprietaire(etat);
		                	j.removeInvestissement(i);
		                }
	                }
	                
	                etatPerd = etat.joue(depart);
                
            	}
                
            }
            System.out.println("> " + cpt + " tours de table ont déjà été joués.");
            System.out.println(Simulation.displayTransitivState(joueurs));
            if (cpt % 1000 == 0) {
            	arreter = 0;
            	System.out.println("Souhaitez-vous :\n\t1) Poursuivre le jeu\n\t2) Arrêter le jeu");
        		System.out.print("-> ");
	            arreter = in.nextInt();
            	while (arreter != 1 && arreter != 2) {
            		System.out.println("Veuillez entrer soit le chiffre 1 soit le chiffre 2");
            		System.out.print("-> ");
    	            arreter = in.nextInt();
				}
            }
        }
        System.out.println("##########################################################");
        System.out.println("#################### -- Fin du jeu -- ####################");
        System.out.println("##########################################################");
        if (etatPerd) {
        	System.out.println("L'État a perdu.");
        }
        if (arreter != 1) {
        	System.out.println("Vous avez demandé l'arrêt du jeu.");
        }
        if (! Simulation.assezJoueursEnLice(joueurs)) {
        	for (Joueur j : joueurs) {
        		if (j.getAPerdu() == 0) {
        			System.out.println("Le joueur " + j.getId() + " a gagné la partie en " + cpt + " tours !");
        		}
        	}
        }
        System.out.println(Simulation.displayTransitivState(joueurs));
    }
}
