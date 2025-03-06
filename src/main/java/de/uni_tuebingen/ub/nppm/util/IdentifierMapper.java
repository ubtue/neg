package de.uni_tuebingen.ub.nppm.util;

import de.uni_tuebingen.ub.nppm.db.EinzelbelegDB;
import de.uni_tuebingen.ub.nppm.db.LemmaDB;
import de.uni_tuebingen.ub.nppm.db.NamenKommentarDB;
import de.uni_tuebingen.ub.nppm.exception.IdNotFoundException;
import de.uni_tuebingen.ub.nppm.exception.IdNotPublicException;
import de.uni_tuebingen.ub.nppm.model.Einzelbeleg;
import de.uni_tuebingen.ub.nppm.model.MghLemma;
import de.uni_tuebingen.ub.nppm.model.NamenKommentar;
import de.uni_tuebingen.ub.nppm.model.Quelle;

public class IdentifierMapper {
    public static Object getModelByIdentifier(String identifier) throws Exception {
        Object ret = null;
        // Map identifier to Model Class
        if (identifier.startsWith("M")) {
            ret = LemmaDB.getById(Integer.valueOf(identifier.substring(1)),MghLemma.class);
        } else if (identifier.startsWith("N")) {
            ret = NamenKommentarDB.getById(Integer.valueOf(identifier.substring(1)),NamenKommentar.class);
        } else if (identifier.startsWith("B")) {
            ret = EinzelbelegDB.getById(Integer.valueOf(identifier.substring(1)),Einzelbeleg.class);
            //check if einzelbeleg is zuVeröffentlichen
            if(ret != null){
                Quelle q = ((Einzelbeleg)ret).getQuelle();
                if(q != null){
                    if(q.getZuVeroeffentlichen() == null || q.getZuVeroeffentlichen() != 1){
                        throw new Exception(new IdNotPublicException("Einzelbeleg ID " + identifier + " ist nicht zu veröffentlichen"));
                    }
                }
            }
        }

        if(ret == null){
            throw new Exception(new IdNotFoundException("ID " + String.valueOf(identifier) + " ist nicht vorhanden"));
        }
        return ret;
    }
}
