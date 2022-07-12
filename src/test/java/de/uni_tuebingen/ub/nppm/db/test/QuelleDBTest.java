package de.uni_tuebingen.ub.nppm.db.test;

import de.uni_tuebingen.ub.nppm.db.test.base.DBTest;
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
            QuelleDB.getList().isEmpty();
        } catch (Exception e) {
            fail(e.getLocalizedMessage());
        }
    }
}
