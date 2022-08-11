package de.uni_tuebingen.ub.nppm.dao.test;

import de.uni_tuebingen.ub.nppm.dao.SucheDAOImpl;
import de.uni_tuebingen.ub.nppm.dao.SucheDAO;
import de.uni_tuebingen.ub.nppm.dao.test.base.DBTest;
import static org.junit.jupiter.api.Assertions.*;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.BeforeEach;
import org.springframework.context.ApplicationContext;
import org.springframework.context.annotation.AnnotationConfigApplicationContext;

public class SucheDBTest extends DBTest {

    private ApplicationContext c = new AnnotationConfigApplicationContext(SucheDAOImpl.class);
    private SucheDAO dao = null;
   
    @BeforeEach
    void init() throws Exception {
        dao = c.getBean(SucheDAOImpl.class);
        ((SucheDAOImpl)dao).setInitialContext(super.getTestContext());
    }

    @Test
    @DisplayName("List Suche Entities")
    void testList() {
        try {
            dao.listFavoriten();
        } catch (Exception e) {
            fail(e.getLocalizedMessage());
        }
    }
}
