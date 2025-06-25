package de.uni_tuebingen.ub.nppm.servlet.gast;

import java.io.*;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.util.*;

import de.uni_tuebingen.ub.nppm.db.SucheDB;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class ExportCsvServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String query = request.getParameter("query");
        if (query == null || query.trim().length() < 3) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid Query");
            return;
        }

        response.setContentType("text/csv; charset=UTF-8");
        String filename = "suchergebnisse.csv";
        response.setHeader("Content-Disposition", "attachment; filename=\"" + URLEncoder.encode(filename, StandardCharsets.UTF_8) + "\"");

        List<String> fieldNames = Arrays.asList(
                "MGHLemma", "Standardname", "Belegform", "Bezeichnung", "seite",
                "raster", "editionZitierweise", "EditionKapitel", "EditionSeite",
                "quelleVonJahr", "quelleVonJahrhundert", "quelleBisJahr", "quelleBisJahrhundert",
                "VonJahr", "VonJahrhundert", "BisJahr", "BisJahrhundert", "quelleBerJahr"
        );

        List<Map> result;
        try {
            result = SucheDB.getEinfacheSucheResult(query);
        } catch (Exception e) {
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Failed to retrieve search results: " + e.getMessage());
            return;
        }

        try (PrintWriter out = response.getWriter()) {
            // CSV-Kopfzeile
            out.println(String.join(";", fieldNames));

            for (Map row : result) {
                List<String> values = new ArrayList<>();
                for (String field : fieldNames) {
                    Object val = row.get(field);
                    String text = val == null ? "" : val.toString().replace("\"", "\"\"");
                    values.add("\"" + text + "\"");
                }
                out.println(String.join(";", values));
            }
        }
    }
}
