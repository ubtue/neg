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
public class EinzelbelegDAOImpl extends AbstractBase implements EinzelbelegDAO {

    @Override
    public void addEinzelbeleg(Einzelbeleg e) {
        getSession().persist(e);
    }

    @Override
    public void updateEinzelbeleg(Einzelbeleg e) {
        getSession().update(e);
    }

    @Override
    public Einzelbeleg getEinzelbelegById(int id) {
        Session s = getSession();
        Einzelbeleg e = (Einzelbeleg) s.load(Einzelbeleg.class, id);
        return e;
    }

    @Override
    public void removeEinzelbeleg(int id) {
        Session session = getSession().getSession();
        Einzelbeleg e = (Einzelbeleg) session.load(Einzelbeleg.class, id);
        if (null != e) {
            session.delete(e);
        }
    }
    
    @Override
    public List<Einzelbeleg> listEinzelbelege() {
        return getList(Einzelbeleg.class);
    }
    
    @Override
    public List<EinzelbelegHatFunktion_MM> listFunktionen() {
        return getList(EinzelbelegHatFunktion_MM.class);
    }
    
    @Override
    public List<EinzelbelegTextkritik> listTextKritiken() {
        return getList(EinzelbelegTextkritik.class);
    }
}