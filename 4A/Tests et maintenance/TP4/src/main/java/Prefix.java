
public class Prefix {



	public static void main(String[] args) {

		System.out.println(new Prefix().longestCommonPrefix(new String[] {"test", "test23", "testtesttest"}));
	}


	

	public String longestCommonPrefix(String[] strs) {

		assert true: "no pre-conditions";		// assertion 1
	
		if (strs.length == 0) return "";

		String prefix = strs[0];

		for (int i = 1; i < strs.length; i++)
			while (strs[i].indexOf(prefix) != 0) {

				prefix = prefix.substring(0, prefix.length() - 1);

				if (prefix.isEmpty()) return "";
			}  

		assert isPrefix(strs, prefix): "post-condition using a checker as a method!";	// assertion 2
		assert !((strs.length==0) || (strs.length>=2 && strs[0].charAt(0)!= strs[1].charAt(0))) || (prefix=="") : "post-condition: when prefix must be empty"; // assertion 3
	
		return prefix;
	}


	// checker!

	private boolean isPrefix(String[] strs, String prefix) {

		for(int i=0; i< strs.length; i++)
			if(!strs[i].startsWith(prefix)) return false;
		
		return true;
	}
}
