public class Puissance {
	static int traiterArguments(String[] args) {
		int res = 0;
		if (args.length != 1) {
			System.err.println("Nombre d’arguments incorrect");
			System.exit(2);
		}
		try {
			res = Integer.parseInt(args[0]);
			if (res < 0) {
				System.err.println("l’argument doit etre un entier naturel");
				System.exit(2);
			}
		} catch (NumberFormatException e) {
			System.err.println("l’argument n’est pas un entier");
			System.exit(2);
		}
		return res;
	}
	
	static int[] puissances(int n) {
		int puiss = 1;
		int[] results= new int[n];
		for (int i = 0; i < n; ++i) {
			results[i]=puiss;
			puiss*=2;
		}
		return results;
	}

	public static void main(String[] args) {
		int n = traiterArguments(args);
		int[] tab= puissances(n);
		for(int i=0; i<tab.length; i++)
			System.out.println(tab[i]);
	}
}
