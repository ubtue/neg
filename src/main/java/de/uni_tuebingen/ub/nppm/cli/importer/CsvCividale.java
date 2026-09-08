package de.uni_tuebingen.ub.nppm.cli.importer;

import de.uni_tuebingen.ub.nppm.db.*;
import java.util.Map;

public class CsvCividale extends Csv {
    public static void main (String[] args) throws Exception {
        LoadArgs(args);
        LoadProperties();

        String quelleProvenanceId = "LVCiv";
        quelleDefault = QuelleDB.getByProvenance(quelleProvenanceId, "NPPM");
        if (quelleDefault == null) {
            throw new Exception("Quelle " + quelleProvenanceId + " does not exist!");
        }

        Log("Importing into Quelle: " + quelleProvenanceId + " => " + quelleDefault.getPersistentIdentifier() + " " + quelleDefault.getBezeichnung());

        customHeadersMap = Map.of(
            "Pal. Abgrenzung", "einzelbeleg.pal_abgrenzung",
            "Nr. in Strukt", "einzelbeleg.nr_in_strukt",
            "PN Text Belegform", "einzelbeleg.Belegform",
            "Lemma", "mgh_lemma.MGHLemma",
            "Titel Sigle", "selektion_amtweihe.provenance_id",
            "Seite", "einzelbeleg.seite",
            "Sprachherkunft", "selektion_sprachherkunft.provenance_id"
        );

        createMissingLemma = true;

        LoadCsv();
        ProcessCsv();
    }
}
