package de.uni_tuebingen.ub.nppm.db;

import java.util.List;
import de.uni_tuebingen.ub.nppm.model.*;

public class PersonDB extends AbstractBase {

    public static List getListPerson() throws Exception {
        return getList(Person.class);
    }
    
    public static List getListPersonAmtStandWeihe() throws Exception {
        return getList(PersonAmtStandWeihe_MM.class);
    }
    
    public static List getListPersonQuiet() throws Exception {
        return getList(PersonQuiet.class);
    }
    
    public static List getListPersonVariante() throws Exception {
        return getList(PersonVariante.class);
    }
}