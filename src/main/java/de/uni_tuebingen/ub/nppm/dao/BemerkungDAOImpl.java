package de.uni_tuebingen.ub.nppm.dao;

import static de.uni_tuebingen.ub.nppm.dao.AbstractBase.getList;
import static de.uni_tuebingen.ub.nppm.dao.AbstractBase.getSession;
import java.util.List;
import de.uni_tuebingen.ub.nppm.model.*;
import org.hibernate.Session;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Repository;

@Repository
@Component
public class BemerkungDAOImpl extends AbstractBase implements BemerkungDAO {
    @Override
    public void addBemerkung(Bemerkung b) {
        getSession().persist(b);
    }

    @Override
    public void updateBemerkung(Bemerkung b) {
        getSession().update(b);
    }

    @Override
    public List<Bemerkung> listBemerkungen() {
        return getList(Bemerkung.class);
    }

    @Override
    public Bemerkung getBemerkungById(int id) {
        Session s = getSession();
        Bemerkung e = (Bemerkung) s.load(Bemerkung.class, id);
        return e;
    }

    @Override
    public void removeBemerkung(int id) {
        Session session = getSession().getSession();
        Bemerkung e = (Bemerkung) session.load(Bemerkung.class, id);
        if (null != e) {
            session.delete(e);
        }
    }
}
