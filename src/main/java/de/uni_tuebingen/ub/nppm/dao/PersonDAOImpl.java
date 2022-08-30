package de.uni_tuebingen.ub.nppm.dao;

import static de.uni_tuebingen.ub.nppm.dao.AbstractBase.getSession;
import java.util.List;
import de.uni_tuebingen.ub.nppm.model.*;
import org.hibernate.Session;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Repository;

@Repository
@Component
public class PersonDAOImpl extends AbstractBase implements PersonDAO {

    @Override
    public void addPerson(Person p) {
        getSession().persist(p);
    }

    @Override
    public void updatePerson(Person p) {
        getSession().update(p);
    }

    @Override
    public Person getPersonById(int id) {
        Session s = getSession();
        Person p = (Person) s.load(Person.class, id);
        return p;
    }

    @Override
    public void removePerson(int id) {
        Session session = getSession();
        Person p = (Person) session.load(Person.class, id);
        if (null != p) {
            session.delete(p);
        }
    }
    
    @Override
    public List<Person> getListPerson() {
        return getList(Person.class);
    }
    
    @Override
    public List<PersonAmtStandWeihe_MM> getListPersonAmtStandWeihe() {
        return getList(PersonAmtStandWeihe_MM.class);
    }
    
    @Override
    public List<PersonQuiet> getListPersonQuiet() {
        return getList(PersonQuiet.class);
    }
    
    @Override
    public List<PersonVariante> getListPersonVariante() {
        return getList(PersonVariante.class);
    }
    
    @Override
    public List<SelektionGeschlecht> getListPersonGeschlecht() {
        return getList(SelektionGeschlecht.class);
    }
}