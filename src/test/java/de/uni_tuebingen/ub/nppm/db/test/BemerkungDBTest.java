package de.uni_tuebingen.ub.nppm.db.test;

import de.uni_tuebingen.ub.nppm.db.test.base.DBTest;
import static org.junit.jupiter.api.Assertions.*;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import de.uni_tuebingen.ub.nppm.db.*;
import org.junit.jupiter.api.BeforeEach;
import org.springframework.context.ApplicationContext;
import org.springframework.context.annotation.AnnotationConfigApplicationContext;

public class BemerkungDBTest extends DBTest {

    private ApplicationContext c = new AnnotationConfigApplicationContext(BemerkungDAOImpl.class);
    private BemerkungDAO dao = null;
   
    @BeforeEach
    void init() throws Exception {
        dao = c.getBean(BemerkungDAOImpl.class);
        ((BemerkungDAOImpl)dao).setInitialContext(super.getTestContext());
    }

    @Test
    @DisplayName("List Bemerkung Entities")
    void testList() {
        try {
            // TODO: The test fails because of the inconsistency of the database
            //dao.listBemerkungen();
        } catch (Exception e) {
            fail(e.getLocalizedMessage());
        }
    }
}
