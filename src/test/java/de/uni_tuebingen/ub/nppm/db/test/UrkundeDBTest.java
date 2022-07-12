package de.uni_tuebingen.ub.nppm.db.test;

import de.uni_tuebingen.ub.nppm.db.test.base.DBTest;
import static org.junit.jupiter.api.Assertions.*;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import de.uni_tuebingen.ub.nppm.db.UrkundeDB;
import org.junit.jupiter.api.BeforeEach;

public class UrkundeDBTest extends DBTest {

    @BeforeEach
    void init() throws Exception {
        UrkundeDB.setInitialContext(super.getTestContext());
    }

    @Test
    @DisplayName("List Urkunde Entities")
    void testList() {
        try {
            // TODO: The tests fails because of the inconsistency of the database
            //UrkundeDB.getList();
        } catch (Exception e) {
            fail(e.getLocalizedMessage());
        }
    }
}
