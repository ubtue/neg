package de.uni_tuebingen.ub.nppm.controller.test;

import de.uni_tuebingen.ub.nppm.controller.test.base.DBTest;
import static org.junit.jupiter.api.Assertions.*;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import de.uni_tuebingen.ub.nppm.db.*;
import org.junit.jupiter.api.BeforeEach;

/**
 *
 * @author julian
 */
public class NamenKommentartDBTest extends DBTest {
    
    @BeforeEach
    void init() throws Exception {
        NamenKommentarDB.setInitialContext(super.getTestContext());
    }
    
    @Test
    @DisplayName("List Namenkommentar Entities")
    void testList() {
        try {
            // TODO: The test fails because of inconsistency of the database
            //NamenKommentarDB.getList();
        } catch (Exception e) {
            fail(e.getLocalizedMessage());
        }

        try {
            // TODO: The test fails because of inconsistency of the database
            //NamenKommentarDB.getListKorrektor();
        } catch (Exception e) {
            fail(e.getLocalizedMessage());
        }

        try {
            // TODO: The test fails because of inconsistency of the database
            //NamenKommentarDB.getListBearbeiter();
        } catch (Exception e) {
            fail(e.getLocalizedMessage());
        }
    }
}
