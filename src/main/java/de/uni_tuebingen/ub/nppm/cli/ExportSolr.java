package de.uni_tuebingen.ub.nppm.cli;

import de.uni_tuebingen.ub.nppm.db.*;
import de.uni_tuebingen.ub.nppm.model.*;
import java.io.PrintWriter;
import java.util.List;
import org.json.*;

/**
 * Solr JSON Export Example
 *
 * This is just a first simple mass export to generate sample data that can be used
 * for importing into the Solr index.
 */
public class ExportSolr extends AbstractBase {
    public static void main (String[] args) throws Exception {
        System.out.println("Export");

        System.out.println("Loading Properties file...");
        LoadProperties();
        System.out.println("Finished Loading Properties file");

        List einzelbelege = EinzelbelegDB.getList();
        JSONArray jsonArray = new JSONArray();
        for (Object einzelbelegObject : einzelbelege) {
            Einzelbeleg einzelbeleg = (Einzelbeleg)einzelbelegObject;

            if (einzelbeleg.getQuelle().getZuVeroeffentlichen() > 0) {
                JSONObject jsonObject = new JSONObject();

                // Required
                jsonObject.put("id", einzelbeleg.getId().toString());
                jsonObject.put("belegform", einzelbeleg.getBelegform());
                jsonObject.put("quelle", einzelbeleg.getQuelle().getBezeichnung());

                // Optional
                jsonObject.put("kontext", einzelbeleg.getKontext());

                jsonArray.put(jsonObject);
            }
        }

        String outPath = "/tmp/export.json";
        System.out.println("Writing outfile: " + outPath);
        PrintWriter out = new PrintWriter(outPath);
        out.println(jsonArray.toString(4));
        out.flush();

        // Without this line, the program will just hang and never terminate
        System.exit(0);
    }
}
