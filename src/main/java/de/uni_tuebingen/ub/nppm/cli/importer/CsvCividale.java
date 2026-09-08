package de.uni_tuebingen.ub.nppm.cli.importer;

import de.uni_tuebingen.ub.nppm.db.*;
import java.util.Map;

public class CsvCividale extends Csv {
    public static void main (String[] args) throws Exception {
        LoadArgs(args);
        LoadProperties();

        quelleDefault = QuelleDB.getByProvenance("LVCiv", "NPPM");
        customHeadersMap = Map.of(
            "Nr. in Strukt", "einzelbeleg.nr_in_strukt",
            "PN Text Belegform", "einzelbeleg.Belegform",
            "Lemma", "mgh_lemma.MGHLemma",
            "Titel Sigle", "selektion_amtweihe.provenance_id",
            "Seite", "einzelbeleg.seite",
            "Sprachherkunft", "selektion_sprachherkunft.Bezeichnung"
        );

        createMissingLemma = true;

        LoadCsv();
    }
}