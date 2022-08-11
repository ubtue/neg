package de.uni_tuebingen.ub.nppm.dao;

import java.util.List;
import org.hibernate.Session;
import de.uni_tuebingen.ub.nppm.model.*;
import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Root;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Repository;

@Repository
@Component
public class BenutzerDAOImpl extends AbstractBase implements BenutzerDAO {

    @Override
    public void addBenutzer(Benutzer b) {
        getSession().persist(b);
    }

    @Override
    public void updateBenutzer(Benutzer b) {
        getSession().update(b);
    }

    @Override
    public Benutzer getBenutzerById(int id) {
        Session s = getSession();
        Benutzer e = (Benutzer) s.load(Benutzer.class, id);
        return e;
    }

    @Override
    public void removeBenutzer(int id) {
        Session session = getSession().getSession();
        Benutzer e = (Benutzer) session.load(Benutzer.class, id);
        if (null != e) {
            session.delete(e);
        }
    }
    
    @Override
    public List<Benutzer> listBenutzer() {
        Session session = getSession();

        CriteriaBuilder builder = session.getCriteriaBuilder();
        CriteriaQuery<Benutzer> criteria = builder.createQuery(Benutzer.class);
        Root benutzer = criteria.from(Benutzer.class);
        criteria.select(benutzer);
        criteria.orderBy(builder.asc(benutzer.get(Benutzer_.Nachname)), builder.asc(benutzer.get(Benutzer_.Vorname)));

        return session.createQuery(criteria).getResultList();
    }

    @Override
    public List<Benutzer> listBenutzerAktiv() {
        Session session = getSession();

        CriteriaBuilder builder = session.getCriteriaBuilder();
        CriteriaQuery<Benutzer> criteria = builder.createQuery(Benutzer.class);
        Root benutzer = criteria.from(Benutzer.class);
        criteria.select(benutzer);
        criteria.where(builder.isTrue(benutzer.get(Benutzer_.IstAktiv)));
        criteria.orderBy(builder.asc(benutzer.get(Benutzer_.Nachname)), builder.asc(benutzer.get(Benutzer_.Vorname)));

        return session.createQuery(criteria).getResultList();
    }

    @Override
    public List<Benutzer> listBenutzerInaktiv() {
        Session session = getSession();

        CriteriaBuilder builder = session.getCriteriaBuilder();
        CriteriaQuery<Benutzer> criteria = builder.createQuery(Benutzer.class);
        Root benutzer = criteria.from(Benutzer.class);
        criteria.select(benutzer);
        criteria.where(builder.isFalse(benutzer.get(Benutzer_.IstAktiv)));
        criteria.orderBy(builder.asc(benutzer.get(Benutzer_.Nachname)), builder.asc(benutzer.get(Benutzer_.Vorname)));

        return session.createQuery(criteria).getResultList();
    }
}
