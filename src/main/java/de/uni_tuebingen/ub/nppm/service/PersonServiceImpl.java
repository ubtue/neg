package de.uni_tuebingen.ub.nppm.service;

import de.uni_tuebingen.ub.nppm.db.PersonDAO;
import de.uni_tuebingen.ub.nppm.model.Person;
import de.uni_tuebingen.ub.nppm.model.PersonAmtStandWeihe_MM;
import de.uni_tuebingen.ub.nppm.model.PersonQuiet;
import de.uni_tuebingen.ub.nppm.model.PersonVariante;
import java.util.List;
import org.springframework.stereotype.Service;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.beans.factory.annotation.Autowired;

@Service
@Component
public class PersonServiceImpl implements PersonService {
    
    @Autowired
    private PersonDAO personDB;

    @Override
    @Transactional
    public void addPerson(Person p) {
        personDB.addPerson(p);
    }

    @Override
    @Transactional
    public void updatePerson(Person p) {
        personDB.updatePerson(p);
    }

    @Override
    @Transactional
    public List<Person> listPersons() {
        return personDB.getListPerson();
    }

    @Override
    @Transactional
    public Person getPersonById(int id) {
        return personDB.getPersonById(id);
    }

    @Override
    @Transactional
    public void removePerson(int id) {
        personDB.removePerson(id);
    }

    @Override
    @Transactional
    public List<PersonAmtStandWeihe_MM> listPersonAmtStandWeihe() {
        return personDB.getListPersonAmtStandWeihe();
    }

    @Override
    @Transactional
    public List<PersonQuiet> listPersonQuiet() {
        return personDB.getListPersonQuiet();
    }

    @Override
    @Transactional
    public List<PersonVariante> listPersonVariante() {
        return personDB.getListPersonVariante();
    }
    
    
}
