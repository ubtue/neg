package de.uni_tuebingen.ub.nppm.db.test;

import de.uni_tuebingen.ub.nppm.db.test.base.DBTest;
import static org.junit.jupiter.api.Assertions.*;
import org.junit.jupiter.api.*;
import de.uni_tuebingen.ub.nppm.dao.BenutzerDAOImpl;
import de.uni_tuebingen.ub.nppm.dao.BenutzerDAO;
import de.uni_tuebingen.ub.nppm.dao.BenutzerDAOImpl;
import org.springframework.context.ApplicationContext;
import org.springframework.context.annotation.AnnotationConfigApplicationContext;

/**
 *
 * @author julian
 */
public class BenutzerDBTest extends DBTest {

    private ApplicationContext c = new AnnotationConfigApplicationContext(BenutzerDAOImpl.class);
    private BenutzerDAO dao = null;
   
    @BeforeEach
    void init() throws Exception {
        dao = c.getBean(BenutzerDAOImpl.class);
        ((BenutzerDAOImpl)dao).setInitialContext(super.getTestContext());
    }

    @Test
    @DisplayName("List active Users")
    void testListActiveUsers() {
        try {
            dao.listBenutzerAktiv();
        } catch (Exception e) {
            fail(e.getLocalizedMessage());
        }
    }

    @Test
    @DisplayName("List inactive Users")
    void testListInactiveUsers() {
        try {
            dao.listBenutzerInaktiv();
        } catch (Exception e) {
            fail(e.getLocalizedMessage());
        }
    }
}
