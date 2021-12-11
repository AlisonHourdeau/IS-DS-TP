package Monopoly.Plateaux;

import java.util.*;

import Monopoly.Cases.*;

public class Plateau {
    protected List<Case> plateau;
    protected int nbCases;
    
    public Plateau(int nbCases) {
        this.nbCases = nbCases;
        this.plateau = new LinkedList<Case>();
    }
    
    public List<Case> getPlateau() {
        return this.plateau;
    }
    
    public int getNbCases() {
        return this.nbCases;
    }
    
    public void addCase(Case c) {
        this.plateau.add(c);
    }
    
    
    public String toString() {
        String res = "";
        for (Case c : plateau) {
            res += c.toString();
        }
        return res;
    }
}
