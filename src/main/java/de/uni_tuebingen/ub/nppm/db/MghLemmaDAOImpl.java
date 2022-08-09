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
public class MghLemmaDAOImpl extends AbstractBase implements MghLemmaDAO {

    @Override
    public void addMghLemma(MghLemma mghLemma) {
        getSession().persist(mghLemma);
    }

    @Override
    public void updateMghLemma(MghLemma mghLemma) {
        getSession().update(mghLemma);
    }

    @Override
    public List<MghLemma> listMghLemma() {
        return getList(MghLemma.class);
    }

    @Override
    public MghLemma getMghLemmaById(int id) {
        Session s = getSession();
        MghLemma e = (MghLemma) s.load(MghLemma.class, id);
        return e;
    }

    @Override
    public void removeMghLemma(int id) {
        Session session = getSession().getSession();
        MghLemma e = (MghLemma) session.load(MghLemma.class, id);
        if (null != e) {
            session.delete(e);
        }
    }

    @Override
    public List<MghLemmaBearbeiter> listMghLemmaBearbeiter() {
        return getList(MghLemmaBearbeiter.class);
    }

    @Override
    public List<MghLemmaKorrektor> listMghLemmaKorrektor() {
        return getList(MghLemmaKorrektor.class);
    }
    
    
}