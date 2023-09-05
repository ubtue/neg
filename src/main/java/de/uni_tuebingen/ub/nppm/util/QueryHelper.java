package de.uni_tuebingen.ub.nppm.util;

public class QueryHelper {
    public static String getFieldAlias(String field) {
        /* If you have e.g. selektion_amtweihe.Bezeichnung and selektion_stand.Bezeichnung
        *  in the same query, this usually causes an exception in hibernate due to duplicate field "Bezeichnung".
        *  The idea is to generate aliases automatically in complex search queries, e.g.
        *  "selektion_amtweihe.Bezeichnung" => "selektion_amtweihe_Bezeichnung"
        *  And correctly apply this the query.
        */
        String alias = field.replace('.', '_');
        if (!alias.equals(field)) {
            alias = field + " AS " + alias;
        }
        return alias;
    }
}
