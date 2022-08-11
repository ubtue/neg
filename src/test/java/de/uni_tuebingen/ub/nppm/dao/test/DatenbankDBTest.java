package de.uni_tuebingen.ub.nppm.dao.test;

import de.uni_tuebingen.ub.nppm.dao.DatenbankDAO;
import de.uni_tuebingen.ub.nppm.dao.DatenbankDAOImpl;
import de.uni_tuebingen.ub.nppm.dao.test.base.DBTest;
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
public class DatenbankDBTest extends DBTest {

    private ApplicationContext c = new AnnotationConfigApplicationContext(DatenbankDAOImpl.class);
    private DatenbankDAO dao = null;
   
    @BeforeEach
    void init() throws Exception {
        dao = c.getBean(DatenbankDAOImpl.class);
        ((DatenbankDAOImpl)dao).setInitialContext(super.getTestContext());
    }

    @Test
    @DisplayName("List Datenbank Entities")
    void testList() {
        try {
            dao.listDatenbankFilter();
        } catch (Exception e) {
            fail(e.getLocalizedMessage());
        }
        try {
            dao.listDatenbankMapping();
        } catch (Exception e) {
            fail(e.getLocalizedMessage());
        }
        try {
            dao.listDatenbankSelektion();
        } catch (Exception e) {
            fail(e.getLocalizedMessage());
        }
        try {
            dao.listDatenbankSprachen();
        } catch (Exception e) {
            fail(e.getLocalizedMessage());
        }
        try {
            dao.listDatenbankTexte();
        } catch (Exception e) {
            fail(e.getLocalizedMessage());
        }
    }
}
