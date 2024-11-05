package de.uni_tuebingen.ub.nppm.servlet;

import de.uni_tuebingen.ub.nppm.model.Einzelbeleg;
import de.uni_tuebingen.ub.nppm.model.MghLemma;
import de.uni_tuebingen.ub.nppm.model.NamenKommentar;
import de.uni_tuebingen.ub.nppm.util.IdentifierMapper;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.json.*;
/*
    Example of REST implementation with json output
    Call URL -> http://localhost:8080/neg/rest/item/M1
                http://localhost:8080/neg/rest/item/N1
                http://localhost:8080/neg/rest/item/B1
             -> http://localhost:8080/neg/rest/items/M1,M2,M3
                http://localhost:8080/neg/rest/items/N1,N2,N3
                http://localhost:8080/neg/rest/items/B1,N2,N3
 */
public class RESTServlet extends HttpServlet {
    
    @Override
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        try {
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");

            // Extrahiere die Identifier aus der URL
            String pathInfo = request.getPathInfo(); // Holt den Pfad (/items/N2,N3,N4)
            if (pathInfo != null) {
                String[] parts = pathInfo.split("/"); // Teilt den Pfad

                if (parts.length >= 2) {
                    String action = parts[1]; // "item" oder "items"

                    if (("item".equals(action) || "items".equals(action)) && parts.length >= 3) {
                        String[] identifiers = parts[2].split(","); // IDs aufteilen

                        if ("item".equals(action) && identifiers.length == 1) {
                            processSingleIdentifier(identifiers[0], response);
                        } else if ("items".equals(action)) {
                            processMultipleIdentifiers(identifiers, response);
                        } else {
                            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid request format");
                        }
                    } else {
                        response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid request path format");
                    }
                } else {
                    response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid path structure");
                }
            } else {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Path cannot be null");
            }
        } catch (Exception e) {
            response.getWriter().write(e.getLocalizedMessage());
        }
    }

    private void processSingleIdentifier(String identifier, HttpServletResponse response) throws Exception {
        String[] ids = new String[1];
        ids[0] = identifier;
        processMultipleIdentifiers(ids, response);
    }

    private void processMultipleIdentifiers(String[] identifiers, HttpServletResponse response) throws Exception {
        JSONArray jsonArray = new JSONArray();

        for (String id : identifiers) {
            if (id != null) {
                JSONObject jsonObject = new JSONObject(); // Jedes Objekt einzeln
                if (id.startsWith("M")) {
                    MghLemma lemma = (MghLemma) IdentifierMapper.getModelByIdentifier(id);
                    if (lemma != null) {
                        try {
                            if (lemma != null) {
                                jsonObject = lemma.getJSON();
                            }
                        } catch (Exception e) {
                            response.getWriter().write(e.getLocalizedMessage());
                        }
                    }
                } else if (id.startsWith("N")) {
                    try {
                        NamenKommentar nk = (NamenKommentar) IdentifierMapper.getModelByIdentifier(id);
                        if(nk != null){
                            jsonObject = nk.getJSON();
                        }
                    } catch (Exception e) {
                        response.getWriter().write(e.getLocalizedMessage());
                    }
                } else if (id.startsWith("B")) {
                    try {
                        Einzelbeleg einzelbeleg = (Einzelbeleg) IdentifierMapper.getModelByIdentifier(id);
                        if (einzelbeleg != null) {
                            jsonObject = einzelbeleg.getJSON();
                        }
                    } catch (Exception e) {
                        response.getWriter().write(e.getLocalizedMessage());
                    }
                }
                jsonArray.put(jsonObject);
            }
        }
        JSONObject finalJson = new JSONObject();
        finalJson.put("items", jsonArray);
        // JSON als Antwort senden
        response.setContentType("application/json");
        response.getWriter().println(finalJson.toString(2));
    }
}
