package de.uni_tuebingen.ub.nppm.dao;

import de.uni_tuebingen.ub.nppm.model.Person;
import de.uni_tuebingen.ub.nppm.model.PersonAmtStandWeihe_MM;
import de.uni_tuebingen.ub.nppm.model.PersonQuiet;
import de.uni_tuebingen.ub.nppm.model.PersonVariante;
import java.util.List;

public interface PersonDAO {
    public void addPerson(Person p);

    public void updatePerson(Person p);

    public Person getPersonById(int id);

    public void removePerson(int id); 
    
    public List<Person> getListPerson();
    
    public List<PersonAmtStandWeihe_MM> getListPersonAmtStandWeihe();
    
    public List<PersonQuiet> getListPersonQuiet();
    
    public List<PersonVariante> getListPersonVariante();
}