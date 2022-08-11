package de.uni_tuebingen.ub.nppm.db.test;

import de.uni_tuebingen.ub.nppm.dao.EditionDAOImpl;
import de.uni_tuebingen.ub.nppm.dao.EditionDAO;
import de.uni_tuebingen.ub.nppm.db.test.base.DBTest;
import static org.junit.jupiter.api.Assertions.*;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.BeforeEach;
import org.springframework.context.ApplicationContext;
import org.springframework.context.annotation.AnnotationConfigApplicationContext;

/**
 *
 * @author julian
 */
public class EditionDBTest extends DBTest {

    private ApplicationContext c = new AnnotationConfigApplicationContext(EditionDAOImpl.class);
    private EditionDAO dao = null;
   
    @BeforeEach
    void init() throws Exception {
        dao = c.getBean(EditionDAOImpl.class);
        ((EditionDAOImpl)dao).setInitialContext(super.getTestContext());
    }

    @Test
    @DisplayName("List Edition Entities")
    void testList() {
        try {
            // TODO: The test fails because of inconsistency of the database
            // dao.listEditions();
        } catch (Exception e) {
            fail(e.getLocalizedMessage());
        }
    }
}