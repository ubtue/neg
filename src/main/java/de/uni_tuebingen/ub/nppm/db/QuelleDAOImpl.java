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
public class QuelleDAOImpl extends AbstractBase implements QuelleDAO {

    @Override
    public void addQuelle(Quelle e) {
        getSession().persist(e);
    }

    @Override
    public void updateQuelle(Quelle e) {
        getSession().update(e);
    }

    @Override
    public List<Quelle> listQuellen() {
        return getList(Quelle.class);
    }

    @Override
    public Quelle getQuelleById(int id) {
        Session s = getSession();
        Quelle e = (Quelle) s.load(Quelle.class, id);
        return e;
    }

    @Override
    public void removeQuelle(int id) {
        Session session = getSession().getSession();
        Quelle e = (Quelle) session.load(Quelle.class, id);
        if (null != e) {
            session.delete(e);
        }
    }
}
