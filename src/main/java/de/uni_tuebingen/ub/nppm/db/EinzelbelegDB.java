package de.uni_tuebingen.ub.nppm.db;

import java.util.List;
import de.uni_tuebingen.ub.nppm.model.*;

public class EinzelbelegDB extends AbstractBase {

    public static List getList() throws Exception {
        return getList(Einzelbeleg.class);
    }
    
    public static List getListFunktion() throws Exception {
        return getList(EinzelbelegHatFunktion_MM.class);
    }
    
    public static List getListTextKritik() throws Exception {
        return getList(EinzelbelegTextkritik.class);
    }
}