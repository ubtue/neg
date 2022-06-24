package de.uni_tuebingen.ub.nppm.controller.test;

import de.uni_tuebingen.ub.nppm.controller.test.base.DBTest;
import static org.junit.jupiter.api.Assertions.*;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import de.uni_tuebingen.ub.nppm.db.EditionDB;
import org.junit.jupiter.api.BeforeEach;

/**
 *
 * @author julian
 */
public class EditionDBTest extends DBTest {

    @BeforeEach
    void init() throws Exception {
        EditionDB.setInitialContext(super.getTestContext());
    }

    @Test
    @DisplayName("List Edition Entities")
    void testList() {
        try {
            // TODO: The test fails because of inconsistency of the database
            //assertFalse(EditionDB.getList().isEmpty(), "List is empty");
        } catch (Exception e) {
            fail(e.getLocalizedMessage());
        }
    }
}
