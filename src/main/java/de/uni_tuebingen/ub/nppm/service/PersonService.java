package de.uni_tuebingen.ub.nppm.service;

import java.util.*;
import de.uni_tuebingen.ub.nppm.model.*;

public interface PersonService {

    public void addPerson(Person p);

    public void updatePerson(Person p);

    public List<Person> listPersons();

    public Person getPersonById(int id);

    public void removePerson(int id);
    
    public List<PersonAmtStandWeihe_MM> listPersonAmtStandWeihe();
    
    public List<PersonQuiet> listPersonQuiet();
    
    public List<PersonVariante> listPersonVariante();
    
    public List<SelektionGeschlecht> listPersonGeschlecht();
}
