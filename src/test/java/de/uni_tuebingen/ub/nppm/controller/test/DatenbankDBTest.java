package de.uni_tuebingen.ub.nppm.controller.test;

import de.uni_tuebingen.ub.nppm.controller.test.base.DBTest;
import static org.junit.jupiter.api.Assertions.*;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import de.uni_tuebingen.ub.nppm.db.*;
import org.junit.jupiter.api.BeforeEach;

/**
 *
 * @author julian
 */
public class DatenbankDBTest extends DBTest {

    @BeforeEach
    void init() throws Exception {
        DatenbankDB.setInitialContext(super.getTestContext());
    }

    @Test
    @DisplayName("List Datenbank Entities")
    void testList() {
        try {
            DatenbankDB.getListFilter();
        } catch (Exception e) {
            fail(e.getLocalizedMessage());
        }
        try {
            DatenbankDB.getListMapping();
        } catch (Exception e) {
            fail(e.getLocalizedMessage());
        }
        try {
            DatenbankDB.getListSelektion();
        } catch (Exception e) {
            fail(e.getLocalizedMessage());
        }
        try {
            DatenbankDB.getListSprache();
        } catch (Exception e) {
            fail(e.getLocalizedMessage());
        }
        try {
            DatenbankDB.getListTexte();
        } catch (Exception e) {
            fail(e.getLocalizedMessage());
        }
    }
}
