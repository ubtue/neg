package de.uni_tuebingen.ub.nppm.util;

import de.uni_tuebingen.ub.nppm.db.EinzelbelegDB;
import de.uni_tuebingen.ub.nppm.db.MghLemmaDB;
import de.uni_tuebingen.ub.nppm.db.NamenKommentarDB;
import de.uni_tuebingen.ub.nppm.model.Einzelbeleg;
import de.uni_tuebingen.ub.nppm.model.MghLemma;
import de.uni_tuebingen.ub.nppm.model.NamenKommentar;

public class IdentifierMapper {
    public static Object getModelByIdentifier(String identifier) throws Exception {
        // Map identifier to Model Class
        if (identifier.startsWith("P")) {
            return MghLemmaDB.getById(Integer.valueOf(identifier.substring(1)),MghLemma.class);
        } else if (identifier.startsWith("N")) {
            return NamenKommentarDB.getById(Integer.valueOf(identifier.substring(1)),NamenKommentar.class);
        } else if (identifier.startsWith("B")) {
            return EinzelbelegDB.getById(Integer.valueOf(identifier.substring(1)),Einzelbeleg.class);
        }
        // Füge weitere Bedingungen für andere Identifier hinzu
        throw new Exception("Invalid Identifier: " + identifier);
    }
}
