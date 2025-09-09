package de.uni_tuebingen.ub.nppm.db;

import java.util.*;

/**
 * This class is used for queries that are typically used for
 * internal maintenance queries, data migrations, and so on.
 */
public class MaintenanceDB extends AbstractBase {
    public static List<Object[]> getBelegformByGeschlecht() throws Exception {

        String sql = "SELECT einzelbeleg.Belegform AS Belegform,"
                   + " GROUP_CONCAT(DISTINCT CASE WHEN selektion_geschlecht.Bezeichnung IN ('m','f') THEN selektion_geschlecht.Bezeichnung END ORDER BY selektion_geschlecht.Bezeichnung DESC SEPARATOR ',') AS Geschlechter,"
                   + " GROUP_CONCAT(DISTINCT CASE WHEN selektion_grammatikgeschlecht.Bezeichnung IN ('m','f') THEN selektion_grammatikgeschlecht.Bezeichnung END ORDER BY selektion_geschlecht.Bezeichnung DESC SEPARATOR ',') AS Grammatikgeschlechter"
                   + " FROM einzelbeleg"
                   + " LEFT JOIN selektion_geschlecht ON einzelbeleg.GeschlechtID = selektion_geschlecht.ID"
                   + " LEFT JOIN selektion_grammatikgeschlecht ON einzelbeleg.GrammatikGeschlechtID = selektion_grammatikgeschlecht.ID"
                   + " GROUP BY Belegform"
                   + " ORDER BY Belegform ASC";

        // Note: getMappedList might not work with GROUP_CONCAT, so we use getListNative instead.
        return getListNative(sql);
    }
}
