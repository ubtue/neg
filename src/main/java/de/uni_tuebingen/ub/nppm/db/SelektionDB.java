package de.uni_tuebingen.ub.nppm.db;

import java.util.Arrays;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import de.uni_tuebingen.ub.nppm.model.*;

/**
 * Class for functions which can be applied to all Selektion...- tables
 * in a similar way
 */
public class SelektionDB extends AbstractBase {
    // TODO: Can this instead be taken from the Model annotations?
    static protected Map<String, Class> selektionen = Map.ofEntries(
        Map.entry("selektion_amtweihe", SelektionAmtWeihe.class),
        Map.entry("selektion_areal", SelektionAreal.class),
        Map.entry("selektion_autor", SelektionAutor.class),
        Map.entry("selektion_bearbeitungsstatus", SelektionBearbeitungsstatus.class),
        Map.entry("selektion_bewertung", SelektionBewertung.class),
        Map.entry("selektion_bkz", SelektionBkz.class),
        Map.entry("selektion_datgenauigkeit", SelektionDatGenauigkeit.class),
        Map.entry("selektion_dmghband", SelektionDmghBand.class),
        Map.entry("selektion_echtheit", SelektionEchtheit.class),
        Map.entry("selektion_editor", SelektionEditor.class),
        Map.entry("selektion_ethnie", SelektionEthnie.class),
        Map.entry("selektion_ethnienerhalt", SelektionEthnienErhalt.class),
        Map.entry("selektion_funktion", SelektionFunktion.class),
        Map.entry("selektion_geschlecht", SelektionGeschlecht.class),
        Map.entry("selektion_grammatikgeschlecht", SelektionGrammatikgeschlecht.class),
        Map.entry("selektion_janein", SelektionJaNein.class),
        Map.entry("selektion_kasus", SelektionKasus.class),
        Map.entry("selektion_lebendverstorben", SelektionLebendVerstorben.class),
        Map.entry("selektion_ort", SelektionOrt.class),
        Map.entry("selektion_quellengattung", SelektionQuellengattung.class),
        Map.entry("selektion_reihe", SelektionReihe.class),
        Map.entry("selektion_sammelband", SelektionSammelband.class),
        Map.entry("selektion_stand", SelektionStand.class),
        Map.entry("selektion_urkundeausstellerempfaenger", SelektionUrkundeAusstellerEmpfaenger.class),
        Map.entry("selektion_verwandtschaftsgrad", SelektionVerwandtschaftsgrad.class)
    );

    static protected List<String> hierarchies = new ArrayList<>(Arrays.asList("selektion_quellengattung"));

    static public Class getClassByString(String selektion) {
        return selektionen.get(selektion);
    }

    static public List getList(String selektion) throws Exception {
        return getList(getClassByString(selektion));
    }

    static public boolean isHierarchy(String selektion) {
        return hierarchies.contains(selektion);
    }

    static public void updateParentId(String selektion, int id, Integer parentId) throws Exception {
        String intVal = "NULL";
        if (parentId != null)
            intVal = parentId.toString();
        String sql = "UPDATE " + selektion + " SET parentId=" + intVal + " WHERE ID=" + id;
        insertOrUpdate(sql);
    }
}
