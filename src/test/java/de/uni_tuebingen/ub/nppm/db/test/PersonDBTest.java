package de.uni_tuebingen.ub.nppm.db.test;

import de.uni_tuebingen.ub.nppm.dao.PersonDAO;
import de.uni_tuebingen.ub.nppm.dao.PersonDAOImpl;
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
public class PersonDBTest extends DBTest {

    private ApplicationContext c = new AnnotationConfigApplicationContext(PersonDAOImpl.class);
    private PersonDAO dao = null;
    
    @BeforeEach
    void init() throws Exception {
        dao = c.getBean(PersonDAOImpl.class);
        ((PersonDAOImpl)dao).setInitialContext(super.getTestContext());
    }

    @Test
    @DisplayName("List Person Entities")
    void testList() {
        // TODO: The tests fails because of the inconsistency of the database
        try {
            dao.getListPerson();
        } catch (Exception e) {
            fail(e.getLocalizedMessage());
        }
        try {
            //dao.getListPersonAmtStandWeihe();
        } catch (Exception e) {
            fail(e.getLocalizedMessage());
        }
        try {
            dao.getListPersonQuiet();
        } catch (Exception e) {
            fail(e.getLocalizedMessage());
        }
        try {
            dao.getListPersonVariante();
        } catch (Exception e) {
            fail(e.getLocalizedMessage());
        }
    }
}
