/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
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
        try{
            assertFalse(LiteraturDB.getList().isEmpty(),"List is empty");  
        }catch(Exception e){
            fail(e.getLocalizedMessage());
        }
    }
}
