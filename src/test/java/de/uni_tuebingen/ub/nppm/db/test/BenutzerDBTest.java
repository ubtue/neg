package de.uni_tuebingen.ub.nppm.db.test;

import de.uni_tuebingen.ub.nppm.db.test.base.DBTest;
import static org.junit.jupiter.api.Assertions.*;
import org.junit.jupiter.api.*;
import de.uni_tuebingen.ub.nppm.db.BenutzerDB;

/**
 *
 * @author julian
 */
public class BenutzerDBTest extends DBTest {

    @BeforeEach
    void init() throws Exception {
        BenutzerDB.setInitialContext(super.getTestContext());
    }

    @Test
    @DisplayName("List active Users")
    void testListActiveUsers() {
        try {
            BenutzerDB.getListAktiv();
        } catch (Exception e) {
            fail(e.getLocalizedMessage());
        }
    }

    @Test
    @DisplayName("List inactive Users")
    void testListInactiveUsers() {
        try {
            BenutzerDB.getListInaktiv();
        } catch (Exception e) {
            fail(e.getLocalizedMessage());
        }
    }
}
