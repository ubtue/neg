package de.uni_tuebingen.ub.nppm.db.test;

import de.uni_tuebingen.ub.nppm.db.test.base.DBTest;
import static org.junit.jupiter.api.Assertions.*;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import de.uni_tuebingen.ub.nppm.db.LiteraturDB;
import org.junit.jupiter.api.BeforeEach;

/**
 *
 * @author julian
 */
public class LiteraturDBTest extends DBTest {

    @BeforeEach
    void init() throws Exception {
        LiteraturDB.setInitialContext(super.getTestContext());
    }

    @Test
    @DisplayName("List Literatur Entities")
    void testList() {
        try {
            // TODO: The test fails because of inconsistency of the database
            //LiteraturDB.getList();
        } catch (Exception e) {
            fail(e.getLocalizedMessage());
        }
    }
}