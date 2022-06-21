package de.uni_tuebingen.ub.nppm.controller.test;

import static org.junit.jupiter.api.Assertions.*;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import de.uni_tuebingen.ub.nppm.db.*;

/**
 *
 * @author julian
 */
public class SchlagwortDBTest {
    
    @Test                                               
    @DisplayName("List Schlagwort Entities")   
    void testList() {
        try {
            SchlagwortDB.getListArealgens();
        } catch (Exception e) {
            fail(e.getLocalizedMessage());
        }
        try {
            SchlagwortDB.getListMorphologie();
        } catch (Exception e) {
            fail(e.getLocalizedMessage());
        }
        try {
            SchlagwortDB.getListMotivation();
        } catch (Exception e) {
            fail(e.getLocalizedMessage());
        }
        try {
            SchlagwortDB.getListNamenLexikon();
        } catch (Exception e) {
            fail(e.getLocalizedMessage());
        }
        try {
            SchlagwortDB.getListPhongraph();
        } catch (Exception e) {
            fail(e.getLocalizedMessage());
        }
        try {
            SchlagwortDB.getListSprachherkunft();
        } catch (Exception e) {
            fail(e.getLocalizedMessage());
        }
    }
}
