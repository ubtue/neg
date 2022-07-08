package de.uni_tuebingen.ub.nppm.db;

import java.util.List;
import de.uni_tuebingen.ub.nppm.model.*;

public class DatenbankDB extends AbstractBase {

    public static List getListFilter() throws Exception {
        return getList(DatenbankFilter.class);
    }
    
    public static List getListMapping() throws Exception {
        return getList(DatenbankMapping.class);
    }
    
    public static List getListSelektion() throws Exception {
        return getList(DatenbankSelektion.class);
    }
    
    public static List getListSprache() throws Exception {
        return getList(DatenbankSprache.class);
    }
    
    public static List getListTexte() throws Exception {
        return getList(DatenbankTexte.class);
    }
}