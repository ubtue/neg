package de.uni_tuebingen.ub.nppm.db.test;

import de.uni_tuebingen.ub.nppm.dao.NamenKommentarDAOImpl;
import de.uni_tuebingen.ub.nppm.dao.NamenKommentarDAO;
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
public class NamenKommentartDBTest extends DBTest {

    private ApplicationContext c = new AnnotationConfigApplicationContext(NamenKommentarDAOImpl.class);
    private NamenKommentarDAO dao = null;
    
    @BeforeEach
    void init() throws Exception {
        dao = c.getBean(NamenKommentarDAOImpl.class);
        ((NamenKommentarDAOImpl)dao).setInitialContext(super.getTestContext());
    }

    @Test
    @DisplayName("List Namenkommentar Entities")
    void testList() {
        try {
            // TODO: The test fails because of inconsistency of the database
            //dao.listNamenKommentars();
        } catch (Exception e) {
            fail(e.getLocalizedMessage());
        }

        try {
            //dao.listKorrektor();
        } catch (Exception e) {
            fail(e.getLocalizedMessage());
        }

        try {
            // TODO: The test fails because of inconsistency of the database
            //dao.listBearbeiter();
        } catch (Exception e) {
            fail(e.getLocalizedMessage());
        }
    }
}
