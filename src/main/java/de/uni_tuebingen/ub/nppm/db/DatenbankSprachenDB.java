package de.uni_tuebingen.ub.nppm.db;

import de.uni_tuebingen.ub.nppm.model.DatenbankSprache;
import java.util.List;

public class DatenbankSprachenDB extends AbstractBase {
    public static List<DatenbankSprache> getList() throws Exception {
        return getList(DatenbankSprache.class);
    }
}
