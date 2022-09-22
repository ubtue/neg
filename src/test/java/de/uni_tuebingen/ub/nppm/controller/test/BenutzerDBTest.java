package de.uni_tuebingen.ub.nppm.controller.test;

import de.uni_tuebingen.ub.nppm.controller.test.base.DBTest;
import static org.junit.jupiter.api.Assertions.*;
import org.junit.jupiter.api.*;
import de.uni_tuebingen.ub.nppm.db.BenutzerDB;
import de.uni_tuebingen.ub.nppm.model.*;
import java.util.List;

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
    
    /*
    *   Update a User and set it back to the original Value
    */
    @Test
    @DisplayName("Update User")
    void testUpdateUser() {
        try {
            List<Benutzer> lst= BenutzerDB.getList();
            if(!lst.isEmpty()){
                Benutzer b = lst.get(0);
                String original = b.getEMail();
                b.setEMail("test@test.de");
                BenutzerDB.saveOrUpdate(b);
                //set to original Mail
                b.setEMail(original);
                BenutzerDB.saveOrUpdate(b);
            }
        } catch (Exception e) {
            fail(e.getLocalizedMessage());
        }
    }
}
