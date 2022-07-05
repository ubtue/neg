package de.uni_tuebingen.ub.nppm.db;

import java.util.List;
import de.uni_tuebingen.ub.nppm.model.*;

public class LiteraturDB extends AbstractBase {

    public static List getList() throws Exception {
        return getList(Literatur.class);
    }
}