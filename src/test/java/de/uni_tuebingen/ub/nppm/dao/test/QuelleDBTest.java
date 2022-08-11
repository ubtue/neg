package de.uni_tuebingen.ub.nppm.dao.test;

import de.uni_tuebingen.ub.nppm.dao.QuelleDAO;
import de.uni_tuebingen.ub.nppm.dao.QuelleDAOImpl;
import de.uni_tuebingen.ub.nppm.dao.test.base.DBTest;
import static org.junit.jupiter.api.Assertions.*;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import de.uni_tuebingen.ub.nppm.dao.QuelleDAOImpl;
import org.junit.jupiter.api.BeforeEach;
import org.springframework.context.ApplicationContext;
import org.springframework.context.annotation.AnnotationConfigApplicationContext;

public class QuelleDBTest extends DBTest {

    private ApplicationContext c = new AnnotationConfigApplicationContext(QuelleDAOImpl.class);
    private QuelleDAO dao = null;
   
    @BeforeEach
    void init() throws Exception {
        dao = c.getBean(QuelleDAOImpl.class);
        ((QuelleDAOImpl)dao).setInitialContext(super.getTestContext());
    }

    @Test
    @DisplayName("List Quelle Entities")
    void testList() {
        try {
            dao.listQuellen();
        } catch (Exception e) {
            fail(e.getLocalizedMessage());
        }
    }
}
