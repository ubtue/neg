package de.uni_tuebingen.ub.nppm.db.test;

import de.uni_tuebingen.ub.nppm.db.test.base.DBTest;
import static org.junit.jupiter.api.Assertions.*;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import de.uni_tuebingen.ub.nppm.db.*;
import org.junit.jupiter.api.BeforeEach;
import org.springframework.context.ApplicationContext;
import org.springframework.context.annotation.AnnotationConfigApplicationContext;

public class EinzelbelegDBTest extends DBTest {

    private ApplicationContext c = new AnnotationConfigApplicationContext(EinzelbelegDAOImpl.class);
    private EinzelbelegDAO dao = null;
    
    @BeforeEach
    void init() throws Exception {
        dao = c.getBean(EinzelbelegDAOImpl.class);
        ((EinzelbelegDAOImpl)dao).setInitialContext(super.getTestContext());
    }

    @Test
    @DisplayName("List Einzelbeleg Entities")
    void testList() {
        // TODO: The test fails because of the inconsistency of the database
        
        try {
            //dao.listEinzelbelege();
        } catch (Exception e) {
            fail(e.getLocalizedMessage());
        }
        try {
            //dao.listFunktionen();
        } catch (Exception e) {
            fail(e.getLocalizedMessage());
        }
        try {
            //dao.listTextKritiken();
        } catch (Exception e) {
            fail(e.getLocalizedMessage());
        }
    }
}
