class SortedSquares {


	public int[] sortedSquares(int[] A) {

		assert isSorted(A): "pre-condition: array A must be a sorted one!";  //assertion 1

		int N = A.length;
		int j = 0;
		while (j < N && A[j] < 0)
			j++;
		int i = j-1;

		int[] ans = new int[N];
		int t = 0;

		while (i >= 0 && j < N) {
			if (A[i] * A[i] < A[j] * A[j]) {
				ans[t++] = A[i] * A[i];
				i--;
			} else {
				ans[t++] = A[j] * A[j];
				j++;
			}
		}

		while (i >= 0) {
			ans[t++] = A[i] * A[i];
			i--;
		}
		while (j < N) {
			ans[t++] = A[j] * A[j];
			j++;
		}

		assert isElement(A,ans): "post-condition: the square of each element of A is an element of ans.";  //assertion 2
		assert isSorted(ans): "post-condition: array A must be a sorted one!";  //assertion 3
		assert ans.length==A.length: "post-condition: array A ans ans must have the same size!";  //assertion 4

		return ans;
	}


	private boolean isElement(int[] a, int[] ans) {

		for(int i=0; i< a.length; i++)
			if(!elementOf(a[i]*a[i], ans))
				return false;

		return true;
	}


	private boolean elementOf(int i, int[] ans) {
		for(int j=0; j<ans.length; j++)
			if(ans[j]==i)
				return true;
		return false;
	}


	private boolean isSorted(int[] a) {
		for(int i=0; i<a.length-1; i++)
			if(a[i]>a[i+1])
				return false;
		return true;
	}


	public static void main(String[] args) {


		int[] tab=new SortedSquares().sortedSquares(new int[] {-4,-1,0,3,10});
		for(int i: tab)
			System.out.println(i);
	}
}