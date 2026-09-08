package de.uni_tuebingen.ub.nppm.cli.importer;

import de.uni_tuebingen.ub.nppm.cli.AbstractBase;
import de.uni_tuebingen.ub.nppm.db.*;
import de.uni_tuebingen.ub.nppm.model.*;
import org.hibernate.Session;
import com.opencsv.*;
import java.io.FileReader;
import java.nio.file.Path;
import java.util.*;
import java.util.regex.Pattern;

public class Csv extends AbstractBase {
    protected static Path csvPath;
    protected static ImportMode mode = ImportMode.TEST;

    protected static List<Map<String,Map<String,String>>> csvRows = new ArrayList<>();

    // Custom Quelle to be overridden by child class
    protected static Quelle quelleDefault = null;

    // This can be used to override CSV header mappings by child classes
    // e.g. ("EB Belegform" => "einzelbeleg.Belegform")
    protected static Map<String,String> customHeadersMap = new HashMap<>();

    // Which field has been used for the unique key of each table?
    protected static Map<String,String> foreignKeyFields = new HashMap<>();

    // Which foreign entity with which unique value is mapped to which foreign key id?
    protected static Map<String,Map<String,Integer>> foreignKeyIDs = new HashMap<>();

    protected static boolean createMissingLemma = false;

    protected static String SELEKTION_PROVENANCE_ID_SPLIT_PATTERN = Pattern.quote(" ");
    protected static String ENTITY_PROPERTY_SPLIT_PATTERN = Pattern.quote(".");

    protected static char CSV_SEPARATOR = ';';
    protected static char CSV_QUOTE_CHAR = '"';


    public static void main (String[] args) throws Exception
    {
        LoadArgs(args);
        LoadProperties();
        LoadCsv();
        ProcessCsv();
    }

    protected static void LoadArgs(String[] args)
    {
        // Process args
        switch (args.length) {
            case 2:
                csvPath = Path.of(args[0]);
                mode = ImportMode.valueOf(args[1].toUpperCase());
                break;
            default:
                Usage("Usage: <Importer> csv_path TEST|LIVE");
        }

        switch (mode) {
            case TEST:
                Log("Running in TEST mode: DB will not be updated!");
                break;
            case LIVE:
                Log("Running in LIVE mode: DB WILL be updated!!!");
                break;
        }
    }

    protected static void LoadCsv() throws Exception
    {
        var csvParser = new CSVParserBuilder().withSeparator(CSV_SEPARATOR).withQuoteChar(CSV_QUOTE_CHAR).build();
        try (var reader = new CSVReaderBuilder(new FileReader(csvPath.toString())).withCSVParser(csvParser).build()) {
            String[] headers = reader.readNext();
            if (headers == null) {
                throw new IllegalArgumentException("CSV file contains no headers!");
            }

            ArrayList<String> actualHeaders = new ArrayList<>(Arrays.asList(headers));

            // all headers either must point to an existing column in the database
            // like e.g. "einzelbeleg.Belegform"
            // or be mapped to exactly that via the customHeadersMap class property
            // which can be overridden in the child class.
            actualHeaders.replaceAll(header -> customHeadersMap.containsKey(header) ? customHeadersMap.get(header) : header);

            String[] row;
            while ((row = reader.readNext()) != null)
            {
                Map<String, String> values = new LinkedHashMap<>();
                for (int i = 0; i < actualHeaders.size(); i++) {
                    String value = i < row.length ? row[i] : null;
                    values.put(actualHeaders.get(i), value);
                }
                csvRows.add(LoadCsvRow(values));
            }
        }
    }

    protected static Map<String,Map<String,String>> LoadCsvRow(final Map<String,String> values) throws Exception
    {
        // Group all fields together that belong to the same entity in the database
        // e.g. all "einzelbeleg.Belegform", "einzelbeleg.provenance_id", etc.
        Map<String,Map<String,String>> groups = new LinkedHashMap<>();
        for (var entry : values.entrySet()) {
            String[] parts = entry.getKey().split(ENTITY_PROPERTY_SPLIT_PATTERN);
            if (parts.length != 2) {
                throw new Exception("Unknown table.column in CSV header: " + entry.getKey());
            }
            String entity = parts[0];
            String field = parts[1];
            if (!groups.containsKey(entity)) {
                groups.put(entity, new HashMap<>());
            }

            String value = entry.getValue();
            if (value != null) {
                value = value.trim();
                if (value.length() > 0) {
                    groups.get(entity).put(field, value);
                }
            }
        }

        // Remove empty groups
        groups.entrySet().removeIf(entry -> entry.getValue().isEmpty());

        return groups;
    }

    protected static void ProcessCsv() throws Exception {
        Log("Processing " + csvRows.size() + " CSV rows...");
        for (var csvRow : csvRows) {
            Log(csvRow.toString());
            ProcessCsvRow(csvRow);
        }
    }

    protected static void ProcessCsvRow(final Map<String,Map<String,String>> entities) throws Exception
    {
        // Process entities parsed from this row.
        // Each row should represent a main entity ("einzelbeleg")
        // and multiple other entities being attached to that (e.g. selektionen, lemma, ...)
        // First we should check whether selektionen, lemma, ... are already present, and create them if they dont exist.
        // second we should add each Einzelbeleg and set proper foreign keys.

        // Note: It is not always wanted to create something that doesn't yet exist
        //       or even possible to create if mandatory fields are missing.
        //       Maybe at a later point we might add configuration in the profile
        //       whether to add field, throw error, set default values, ...
        for (String entityName : entities.keySet()) {
            var entityFields = entities.get(entityName);
            if (entityName.startsWith("selektion_")) {
                ProcessEntitySelektion(entityName, entityFields);
            }
        }

        // Process after all the rest, not inside FOR loop! Foreign keys must exist first!!!
        ProcessEntityLemma(entities);
        ProcessEntityEinzelbeleg(entities);
    }

    protected static void ProcessEntityEinzelbeleg(final Map<String,Map<String,String>> entities) throws Exception {
        try (Session session = EinzelbelegDB.getSession()) {
            var einzelbelegFields = entities.get("einzelbeleg");

            // Do we need a transaction around this?
            // Do we need a transaction across everything?
            Einzelbeleg eb = new Einzelbeleg();

            // REQUIRED
            eb.setQuelle(quelleDefault);
            eb.setBelegform(einzelbelegFields.get("Belegform"));

            // FOREIGN KEYs (optional)
            for (String entityName : entities.keySet()) {
                if (!entityName.equals("einzelbeleg")) {
                    // Check which column the unique key is taken from
                    // Link proper foreign key value
                    String foreignKeyUniqueField = foreignKeyFields.get(entityName);
                    var entityFields = entities.get(entityName);
                    String foreignKeyUniqueValue = entityFields.get(foreignKeyUniqueField);
                    Integer foreignKeyID = foreignKeyIDs.get(entityName).get(foreignKeyUniqueValue);

                    if (entityName.equals("MGHLemma")) {
                        Log("Setting MGHLemma foreign key " + foreignKeyID.toString());
                        //eb.setMghLemma(Set.of(foreignKeyID));
                    }
                }
            }

            // DATA FIELDS (optional)
            if (einzelbelegFields.containsKey("seite")) {
                eb.setSeite(einzelbelegFields.get("seite"));
            }
            if (einzelbelegFields.containsKey("nr_in_strukt")) {
                eb.setNummerInStruktur(einzelbelegFields.get("nr_in_strukt"));
            }
            if (einzelbelegFields.containsKey("pal_abgrenzung")) {
                eb.setPalaeografischeAbgrenzung(einzelbelegFields.get("pal_abgrenzung"));
            }

            Log("Inserting Einzelbeleg: " + eb.getJSON());
            switch (mode) {
                case TEST:
                    Log("TEST mode: Skipping insert");
                    break;
                case LIVE:
                    Log("LIVE mode: Executing insert");
                    session.persist(eb);
                    break;
            }

            // relations (optional)
            var amtWeiheFields = entities.get("selektion_amtweihe");
            if (amtWeiheFields != null && amtWeiheFields.containsKey("provenance_id")) {
                for (String provenanceId : amtWeiheFields.get("provenance_id").split(SELEKTION_PROVENANCE_ID_SPLIT_PATTERN)) {
                    var ehaw = new EinzelbelegHatAmtWeihe_MM();
                    ehaw.setEinzelbeleg(eb);
                    ehaw.setAmtWeihe((SelektionAmtWeihe)SelektionDB.getByProvenance("selektion_amtweihe", provenanceId));
                    session.persist(ehaw);
                }
            }
        }
    }

    protected static void ProcessEntityLemma(final Map<String,Map<String,String>> entities) throws Exception {
        if (entities.containsKey("mgh_lemma")) {
            var lemmaFields = entities.get("mgh_lemma");

            if (lemmaFields.containsKey("MGHLemma")) {
                String lemmaString = lemmaFields.get("MGHLemma");
                var lemma = LemmaDB.getByLemma(lemmaString);
                try (Session session = LemmaDB.getSession()) {
                    if (lemma == null) {
                        if (!createMissingLemma) {
                            throw new Exception("Lemma could not be found: " + lemmaString);
                        } else {
                            lemma = new MghLemma();
                            lemma.setMghLemma(lemmaString);
                            session.persist(lemma);
                        }
                    }

                    // Make sure Sprachherkunft is set correctly in both cases (insert / exists)
                    if (entities.containsKey("selektion_sprachherkunft")) {
                        var sprachherkunftFields = entities.get("selektion_sprachherkunft");
                        if (sprachherkunftFields.containsKey("provenance_id")) {
                            lemma.setSprachherkunft(
                                (SelektionSprachherkunft)SelektionDB.getByProvenance("selektion_sprachherkunft", sprachherkunftFields.get("provenance_id"))
                            );
                        }
                    }
                }
                StoreForeignKeyInfo("mgh_lemma", "MGHLemma", lemmaString, lemma.getId());
            }
        }
    }

    protected static void ProcessEntitySelektion(final String entityName, final Map<String,String> entityFields) throws Exception {
        // First, check whether we can find it via Provenance, if given
        if (entityFields.containsKey("provenance_id")) {
            for (var provenance_id : entityFields.get("provenance_id").split(SELEKTION_PROVENANCE_ID_SPLIT_PATTERN)) {
                // Omit provenance_source on purpose! (Some might still be from DMP!)
                var selektion = SelektionDB.getByProvenance(entityName, provenance_id);
                if (selektion == null) {
                    throw new Exception(entityName + " with provenance_id " + provenance_id + " does not exist!");
                }
                StoreForeignKeyInfo(entityName, "provenance_id", provenance_id, selektion.getId());
            }
        }
        // Alternatively, we can implement logic for "Bezeichnung" later if necessary.
    }



    protected static void StoreForeignKeyInfo(final String entityName, final String usedColumn, final String uniqueValue, final Integer ID) {
        foreignKeyIDs.computeIfAbsent(entityName, k -> new HashMap<>())
                     .computeIfAbsent(uniqueValue, k -> ID);
        foreignKeyFields.computeIfAbsent(entityName, k -> usedColumn);
    }
}