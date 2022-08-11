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
public class NamenKommentarDAOImpl extends AbstractBase implements NamenKommentarDAO {

    @Override
    public void addNamenKommentar(NamenKommentar n) {
        getSession().persist(n);
    }

    @Override
    public void updateNamenKommentar(NamenKommentar n) {
        getSession().update(n);
    }

    @Override
    public List<NamenKommentar> listNamenKommentars() {
        return getList(NamenKommentar.class);
    }

    @Override
    public NamenKommentar getNamenKommentarById(int id) {
        Session s = getSession();
        NamenKommentar e = (NamenKommentar) s.load(NamenKommentar.class, id);
        return e;
    }

    @Override
    public void removeNamenKommentar(int id) {
        Session session = getSession().getSession();
        NamenKommentar e = (NamenKommentar) session.load(NamenKommentar.class, id);
        if (null != e) {
            session.delete(e);
        }
    }
    
    @Override
    public List<NamenKommentarBearbeiter> listBearbeiter() {
        return getList(NamenKommentarBearbeiter.class);
    }
    
    @Override
    public List<NamenKommentarKorrektor> listKorrektor() {
        return getList(NamenKommentarKorrektor.class);
    }
}