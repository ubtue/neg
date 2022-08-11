package de.uni_tuebingen.ub.nppm.dao;

import java.util.List;
import de.uni_tuebingen.ub.nppm.model.*;
import org.springframework.stereotype.Repository;
import org.hibernate.Session;
import org.springframework.stereotype.Component;

@Repository
@Component
public class EditionDAOImpl extends AbstractBase implements EditionDAO  {

    @Override
    public void addEdition(Edition e) {
        getSession().persist(e);
    }

    @Override
    public void updateEdition(Edition e) {
        getSession().update(e);
    }

    @Override
    public List<Edition> listEditions() {
        return getList(Edition.class);
    }

    @Override
    public Edition getEditionById(int id) {
        Session s = getSession();
        Edition e = (Edition) s.load(Edition.class, id);
        return e;
    }

    @Override
    public void removeEdition(int id) {
        Session session = getSession().getSession();
        Edition e = (Edition) session.load(Edition.class, id);
        if (null != e) {
            session.delete(e);
        }
    }
}