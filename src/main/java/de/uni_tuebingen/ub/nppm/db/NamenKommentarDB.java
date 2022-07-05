package de.uni_tuebingen.ub.nppm.db;

import java.util.List;
import de.uni_tuebingen.ub.nppm.model.*;

public class NamenKommentarDB extends AbstractBase {

    public static List getList() throws Exception {
        return getList(NamenKommentar.class);
    }
    
    public static List getListBearbeiter() throws Exception {
        return getList(NamenKommentarBearbeiter.class);
    }
    
    public static List getListKorrektor() throws Exception {
        return getList(NamenKommentarKorrektor.class);
    }
}