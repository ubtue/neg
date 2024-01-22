package de.uni_tuebingen.ub.nppm.db;

import java.util.List;
import de.uni_tuebingen.ub.nppm.model.*;

public class EditionDB extends AbstractBase {

    public static List getList() throws Exception {
        return getList(Edition.class);
    }
}
