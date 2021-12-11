package math;

import org.junit.After;
import org.junit.Before;
import org.junit.Test;
import static org.junit.Assert.*;

import static org.junit.jupiter.api.Assertions.*;

public class DivisionTest {
    protected Division op;

    @Before
    public void setUp() {
        op = new Division();
    }

    @After
    public void tearDown() {
    }

    @Test
    public void testCalculer() throws Exception {
        assertEquals(new Long(5),
                op.calculer(new Long(10), new Long(2)));
    }

    @Test
    public void testLireSymbole() throws Exception {
        assertEquals((Character)'/', op.lireSymbole());
    }
}