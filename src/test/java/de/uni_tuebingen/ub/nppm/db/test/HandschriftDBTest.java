package de.uni_tuebingen.ub.nppm.db.test;

import de.uni_tuebingen.ub.nppm.db.HandschriftDAO;
import de.uni_tuebingen.ub.nppm.db.HandschriftDAOImpl;
import de.uni_tuebingen.ub.nppm.db.test.base.DBTest;
import static org.junit.jupiter.api.Assertions.*;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import de.uni_tuebingen.ub.nppm.db.HandschriftDAOImpl;
import org.junit.jupiter.api.BeforeEach;
import org.springframework.context.ApplicationContext;
import org.springframework.context.annotation.AnnotationConfigApplicationContext;

public class HandschriftDBTest extends DBTest {

    private ApplicationContext c = new AnnotationConfigApplicationContext(HandschriftDAOImpl.class);
    private HandschriftDAO dao = null;
   
    @BeforeEach
    void init() throws Exception {
        dao = c.getBean(HandschriftDAOImpl.class);
        ((HandschriftDAOImpl)dao).setInitialContext(super.getTestContext());
    }

    @Test
    @DisplayName("List Handschrift Entities")
    void testList() {
        try {
            dao.listHandschriften();
        } catch (Exception e) {
            fail(e.getLocalizedMessage());
        }
    }
}
