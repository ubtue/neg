package de.uni_tuebingen.ub.nppm.db;

import java.util.List;
import de.uni_tuebingen.ub.nppm.model.*;

public class SchlagwortDB extends AbstractBase {

    public static List getListArealgens() throws Exception {
        return getList(SchlagwortArealgens.class);
    }
    
    public static List getListMorphologie() throws Exception {
        return getList(SchlagwortMorphologie.class);
    }
    
    public static List getListMotivation() throws Exception {
        return getList(SchlagwortMotivation.class);
    }
    
    public static List getListNamenLexikon() throws Exception {
        return getList(SchlagwortNamenLexikon.class);
    }
    
    public static List getListPhongraph() throws Exception {
        return getList(SchlagwortPhongraph.class);
    }
    
    public static List getListSprachherkunft() throws Exception {
        return getList(SchlagwortSprachherkunft.class);
    }
}