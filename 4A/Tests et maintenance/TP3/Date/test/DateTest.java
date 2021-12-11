import org.junit.After;
import org.junit.Before;
import org.junit.Test;

import static org.junit.Assert.*;

public class DateTest {
    protected Date date;
    protected Date date_jour_faux;
    protected Date date_mois_faux;
    protected Date date_fevrier_bissextile;
    protected Date date_fevrier_non_bissextile;
    protected Date date_mois_31;
    protected Date date_mois_30;
    protected Date date_fin_annee;



    @Before
    public void setUp() {
        date = new Date(2,12,2020);
        date_jour_faux = new Date(33, 11, 2021);
        date_mois_faux = new Date(12,14,2012);

        date_fevrier_bissextile = new Date(28, 2, 2020);
        date_fevrier_non_bissextile = new Date(28, 2, 2021);
        date_mois_31 = new Date(31, 1, 2020);
        date_mois_30 = new Date(30, 4, 2020);

        date_fin_annee = new Date(31, 12, 2020);
    }

    @After
    public void tearDown() {
    }

    @Test
    public void checkDataTest(){
        assertTrue(date.checkData());
        assertFalse(date_jour_faux.checkData());
        assertFalse(date_mois_faux.checkData());
    }

    @Test
    public void nextDayTest(){
        assertEquals(date.nextDay().getDay(), 3);
        assertEquals(date.nextDay().getMonth(), 12);
        assertEquals(date.nextDay().getYear(), 2020);

        assertEquals(date_fevrier_bissextile.nextDay().getDay(), 29);
        assertEquals(date_fevrier_bissextile.nextDay().getMonth(), 2);
        assertEquals(date_fevrier_bissextile.nextDay().getYear(), 2020);

        assertEquals(date_fevrier_non_bissextile.nextDay().getDay(), 1);
        assertEquals(date_fevrier_non_bissextile.nextDay().getMonth(), 3);
        assertEquals(date_fevrier_non_bissextile.nextDay().getYear(), 2021);

        assertEquals(date_mois_31.nextDay().getDay(), 1);
        assertEquals(date_mois_31.nextDay().getMonth(), 2);
        assertEquals(date_mois_31.nextDay().getYear(), 2020);

        assertEquals(date_mois_30.nextDay().getDay(), 1);
        assertEquals(date_mois_30.nextDay().getMonth(), 5);
        assertEquals(date_mois_30.nextDay().getYear(), 2020);

        assertEquals(date_fin_annee.nextDay().getDay(), 1);
        assertEquals(date_fin_annee.nextDay().getMonth(), 1);
        assertEquals(date_fin_annee.nextDay().getYear(), 2021);

    }
}