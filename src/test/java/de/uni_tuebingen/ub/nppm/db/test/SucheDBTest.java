package de.uni_tuebingen.ub.nppm.db.test;

import de.uni_tuebingen.ub.nppm.db.test.base.DBTest;
import static org.junit.jupiter.api.Assertions.*;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import de.uni_tuebingen.ub.nppm.db.*;
import org.junit.jupiter.api.BeforeEach;

public class SucheDBTest extends DBTest {

    @BeforeEach
    void init() throws Exception {
        SucheDB.setInitialContext(super.getTestContext());
    }

    @Test
    @DisplayName("List Suche Entities")
    void testList() {
        try {
            SucheDB.getFavoriten();
        } catch (Exception e) {
            fail(e.getLocalizedMessage());
        }
    }
}
