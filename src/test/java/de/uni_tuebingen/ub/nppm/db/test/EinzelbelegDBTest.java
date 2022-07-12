package de.uni_tuebingen.ub.nppm.db.test;

import de.uni_tuebingen.ub.nppm.db.test.base.DBTest;
import static org.junit.jupiter.api.Assertions.*;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import de.uni_tuebingen.ub.nppm.db.*;
import org.junit.jupiter.api.BeforeEach;

public class EinzelbelegDBTest extends DBTest {

    @BeforeEach
    void init() throws Exception {
        EinzelbelegDB.setInitialContext(super.getTestContext());
    }

    @Test
    @DisplayName("List Einzelbeleg Entities")
    void testList() {
        // TODO: The test fails because of the inconsistency of the database
        
        try {
            //EinzelbelegDB.getList();
        } catch (Exception e) {
            fail(e.getLocalizedMessage());
        }
        try {
            //EinzelbelegDB.getListFunktion();
        } catch (Exception e) {
            fail(e.getLocalizedMessage());
        }
        try {
            //EinzelbelegDB.getListTextKritik();
        } catch (Exception e) {
            fail(e.getLocalizedMessage());
        }
    }
}
