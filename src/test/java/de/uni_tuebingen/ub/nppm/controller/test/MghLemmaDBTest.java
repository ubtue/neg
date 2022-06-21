package de.uni_tuebingen.ub.nppm.controller.test;

import static org.junit.jupiter.api.Assertions.*;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import de.uni_tuebingen.ub.nppm.db.*;

/**
 *
 * @author julian
 */
public class MghLemmaDBTest {
    
    @Test                                               
    @DisplayName("List MghLemma Entities")   
    void testList() {
        try{
            MghLemmaDB.getList();  
        }catch(Exception e){
            fail(e.getLocalizedMessage());
        }
        
        try{
            MghLemmaDB.getListKorrektor();  
        }catch(Exception e){
            fail(e.getLocalizedMessage());
        }
        
        try{
            MghLemmaDB.getListBearbeiter();  
        }catch(Exception e){
            fail(e.getLocalizedMessage());
        }
    }
}
