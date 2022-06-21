package de.uni_tuebingen.ub.nppm.controller.test;

import static org.junit.jupiter.api.Assertions.*;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import de.uni_tuebingen.ub.nppm.db.EditionDB;

/**
 *
 * @author julian
 */
public class EditionDBTest {
    
    @Test
    @DisplayName("List Edition Entities")
    void testList() {
        try {
            assertFalse(EditionDB.getList().isEmpty(), "List is empty");
        } catch (Exception e) {
            fail(e.getLocalizedMessage());
        }
    }
}
