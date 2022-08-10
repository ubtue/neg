package de.uni_tuebingen.ub.nppm.db;

import static de.uni_tuebingen.ub.nppm.db.AbstractBase.getList;
import static de.uni_tuebingen.ub.nppm.db.AbstractBase.getSession;
import java.util.List;
import de.uni_tuebingen.ub.nppm.model.*;
import org.hibernate.Session;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Repository;

@Repository
@Component
public class HandschriftDAOImpl extends AbstractBase implements HandschriftDAO {

    @Override
    public void addHandschrift(Handschrift h) {
        getSession().persist(h);
    }

    @Override
    public void updateHandschrift(Handschrift h) {
        getSession().update(h);
    }

    @Override
    public List<Handschrift> listHandschriften() {
        return getList(Handschrift.class);
    }

    @Override
    public Handschrift getHandschriftById(int id) {
        Session s = getSession();
        Handschrift e = (Handschrift) s.load(Handschrift.class, id);
        return e;
    }

    @Override
    public void removeHandschrift(int id) {
        Session session = getSession().getSession();
        Handschrift h = (Handschrift) session.load(Handschrift.class, id);
        if (null != h) {
            session.delete(h);
        }
    }
}
