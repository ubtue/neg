package de.uni_tuebingen.ub.nppm.controller.test;

import static org.junit.jupiter.api.Assertions.*;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import de.uni_tuebingen.ub.nppm.db.LiteraturDB;

/**
 *
 * @author julian
 */
public class LiteraturDBTest {
    
    @Test
    @DisplayName("List Literatur Entities")
    void testList() {
        try {
            assertFalse(LiteraturDB.getList().isEmpty(), "List is empty");
        } catch (Exception e) {
            fail(e.getLocalizedMessage());
        }
    }
}
