package de.uni_tuebingen.ub.nppm.db.test;

import de.uni_tuebingen.ub.nppm.db.test.base.DBTest;
import static org.junit.jupiter.api.Assertions.*;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import de.uni_tuebingen.ub.nppm.db.HandschriftDB;
import org.junit.jupiter.api.BeforeEach;

public class HandschriftDBTest extends DBTest {

    @BeforeEach
    void init() throws Exception {
        HandschriftDB.setInitialContext(super.getTestContext());
    }

    @Test
    @DisplayName("List Handschrift Entities")
    void testList() {
        try {
            HandschriftDB.getList();
        } catch (Exception e) {
            fail(e.getLocalizedMessage());
        }
    }
}
