/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package de.uni_tuebingen.ub.nppm.controller.test;

import static org.junit.jupiter.api.Assertions.*;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import de.uni_tuebingen.ub.nppm.db.BenutzerDB;

/**
 *
 * @author julian
 */
public class BenutzerControllerTest {
    
    @Test                                               
    @DisplayName("List active Users")   
    void testListActiveUsers() {
        try{
            assertFalse(BenutzerDB.getListAktiv().isEmpty(),"List is empty");  
        }catch(Exception e){
            fail(e.getLocalizedMessage());
        }
    }
    
    @Test                                               
    @DisplayName("List inactive Users")   
    void testListInactiveUsers() {
        try{
            assertFalse(BenutzerDB.getListInaktiv().isEmpty(),"List is empty");  
        }catch(Exception e){
            fail(e.getLocalizedMessage());
        }
    }
}
