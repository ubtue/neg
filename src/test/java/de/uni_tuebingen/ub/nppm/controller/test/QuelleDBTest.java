package de.uni_tuebingen.ub.nppm.controller.test;

import de.uni_tuebingen.ub.nppm.controller.test.base.DBTest;
import static org.junit.jupiter.api.Assertions.*;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import de.uni_tuebingen.ub.nppm.db.QuelleDB;
import org.junit.jupiter.api.BeforeEach;

public class QuelleDBTest extends DBTest {

    @BeforeEach
    void init() throws Exception {
        QuelleDB.setInitialContext(super.getTestContext());
    }

    @Test
    @DisplayName("List Quelle Entities")
    void testList() {
        try {
            assertFalse(QuelleDB.getList().isEmpty(), "List is empty");
        } catch (Exception e) {
            fail(e.getLocalizedMessage());
        }
    }
}
