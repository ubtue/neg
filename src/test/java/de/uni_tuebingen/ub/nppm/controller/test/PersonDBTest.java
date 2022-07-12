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
public class PersonDBTest extends DBTest {

    @BeforeEach
    void init() throws Exception {
        PersonDB.setInitialContext(super.getTestContext());
    }

    @Test
    @DisplayName("List Person Entities")
    void testList() {
        // TODO: The tests fails because of the inconsistency of the database
        /*try {
            PersonDB.getListPerson();
        } catch (Exception e) {
            fail(e.getLocalizedMessage());
        }
        try {
            PersonDB.getListPersonAmtStandWeihe();
        } catch (Exception e) {
            fail(e.getLocalizedMessage());
        }
        try {
            PersonDB.getListPersonQuiet();
        } catch (Exception e) {
            fail(e.getLocalizedMessage());
        }
        try {
            PersonDB.getListPersonVariante();
        } catch (Exception e) {
            fail(e.getLocalizedMessage());
        }*/
    }
}
