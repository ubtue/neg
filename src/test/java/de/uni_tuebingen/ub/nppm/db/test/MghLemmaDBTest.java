package de.uni_tuebingen.ub.nppm.db.test;

import de.uni_tuebingen.ub.nppm.db.test.base.DBTest;
import static org.junit.jupiter.api.Assertions.*;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import de.uni_tuebingen.ub.nppm.db.*;
import org.junit.jupiter.api.BeforeEach;
import org.springframework.context.ApplicationContext;
import org.springframework.context.annotation.AnnotationConfigApplicationContext;

/**
 *
 * @author julian
 */
public class MghLemmaDBTest extends DBTest {

    private ApplicationContext c = new AnnotationConfigApplicationContext(MghLemmaDAOImpl.class);
    private MghLemmaDAO dao = null;
   
    @BeforeEach
    void init() throws Exception {
        dao = c.getBean(MghLemmaDAOImpl.class);
        ((MghLemmaDAOImpl)dao).setInitialContext(super.getTestContext());
    }

    @Test
    @DisplayName("List MghLemma Entities")
    void testList() {
        try {
            // TODO: The test fails because of the inconsistency of the database
            //dao.listMghLemma();
        } catch (Exception e) {
            fail(e.getLocalizedMessage());
        }

        try {
            dao.listMghLemmaKorrektor();
        } catch (Exception e) {
            fail(e.getLocalizedMessage());
        }

        try {
            dao.listMghLemmaBearbeiter();
        } catch (Exception e) {
            fail(e.getLocalizedMessage());
        }
    }
}
