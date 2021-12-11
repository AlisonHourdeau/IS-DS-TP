package math;

import org.junit.After;
import org.junit.Before;
import org.junit.Test;
import static org.junit.Assert.*;

import static org.junit.jupiter.api.Assertions.*;

public class AdditionTest {
    protected Addition op;

    @Before
    public void setUp() {
        op = new Addition();
    }

    @After
    public void tearDown() {
    }

    @Test
    public void testCalculer() throws Exception {
        assertEquals(new Long(4),
            op.calculer(new Long(1), new Long(3)));
    }

    @Test
    public void testLireSymbole() throws Exception {
        assertEquals((Character)'+', op.lireSymbole());
    }
}