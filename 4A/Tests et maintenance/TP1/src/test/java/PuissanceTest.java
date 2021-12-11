
import org.junit.*;

public class PuissanceTest {

    @Test
    public void checkLengthOfResult() {
        int[] result = Puissance.puissances(2);
        Assert.assertEquals(2 , result.length);
    }

    @Test
    public void checkFirstValue() {
        int[] result = Puissance.puissances(1);
        int expected = (int) Math.pow(2,0);
        Assert.assertEquals(expected, result[0]);
    }

    @Test
    public void checkResultNotNull() {
        Assert.assertNotNull(Puissance.puissances(3));
    }

    @Test(expected = NegativeArraySizeException.class)
    public void throwExceptionIfNegativeInput() {
         Puissance.puissances(-1);
    }

    @Test
    public void checkLastValueOfResult() {
        int expected = (int) Math.pow(2,2);
        Assert.assertEquals( expected , Puissance.puissances(3)[2]);
    }
}
