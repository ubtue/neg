package de.uni_tuebingen.ub.nppm.controller.test;

import static org.junit.jupiter.api.Assertions.*;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import de.uni_tuebingen.ub.nppm.db.*;

/**
 *
 * @author julian
 */
public class NamenKommentartDBTest {
    
    @Test
    @DisplayName("List Namenkommentar Entities")
    void testList() {
        try {
            NamenKommentarDB.getList();
        } catch (Exception e) {
            fail(e.getLocalizedMessage());
        }

        try {
            NamenKommentarDB.getListKorrektor();
        } catch (Exception e) {
            fail(e.getLocalizedMessage());
        }

        try {
            NamenKommentarDB.getListBearbeiter();
        } catch (Exception e) {
            fail(e.getLocalizedMessage());
        }
    }
}
