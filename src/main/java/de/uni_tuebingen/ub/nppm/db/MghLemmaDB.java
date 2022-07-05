package de.uni_tuebingen.ub.nppm.db;

import java.util.List;
import de.uni_tuebingen.ub.nppm.model.*;

public class MghLemmaDB extends AbstractBase {

    public static List getList() throws Exception {
        return getList(MghLemma.class);
    }
    
    public static List getListBearbeiter() throws Exception {
        return getList(MghLemmaBearbeiter.class);
    }
    
    public static List getListKorrektor() throws Exception {
        return getList(MghLemmaKorrektor.class);
    }
}