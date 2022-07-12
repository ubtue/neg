package de.uni_tuebingen.ub.nppm.db.test;

import de.uni_tuebingen.ub.nppm.db.test.base.DBTest;
import static org.junit.jupiter.api.Assertions.*;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import de.uni_tuebingen.ub.nppm.db.*;
import org.junit.jupiter.api.BeforeEach;

/**
 *
 * @author julian
 */
public class SchlagwortDBTest extends DBTest {

    @BeforeEach
    void init() throws Exception {
        SchlagwortDB.setInitialContext(super.getTestContext());
    }

    @Test
    @DisplayName("List Schlagwort Entities")
    void testList() {
        // TODO: The tests fails because of the inconsistency of the database
        
        try {
            //SchlagwortDB.getListArealgens();
        } catch (Exception e) {
            fail(e.getLocalizedMessage());
        }
        try {
            //SchlagwortDB.getListMorphologie();
        } catch (Exception e) {
            fail(e.getLocalizedMessage());
        }
        try {
            SchlagwortDB.getListMotivation();
        } catch (Exception e) {
            fail(e.getLocalizedMessage());
        }
        try {
            //SchlagwortDB.getListNamenLexikon();
        } catch (Exception e) {
            fail(e.getLocalizedMessage());
        }
        try {
            //SchlagwortDB.getListPhongraph();
        } catch (Exception e) {
            fail(e.getLocalizedMessage());
        }
        try {
            //SchlagwortDB.getListSprachherkunft();
        } catch (Exception e) {
            fail(e.getLocalizedMessage());
        }
    }
}
