package de.uni_tuebingen.ub.nppm.servlet;

import de.uni_tuebingen.ub.nppm.db.LemmaDB;
import de.uni_tuebingen.ub.nppm.model.Einzelbeleg;
import de.uni_tuebingen.ub.nppm.model.MghLemma;
import de.uni_tuebingen.ub.nppm.model.NamenKommentar;
import de.uni_tuebingen.ub.nppm.model.Person;
import de.uni_tuebingen.ub.nppm.model.Quelle;
import de.uni_tuebingen.ub.nppm.util.IdentifierMapper;
import java.io.IOException;
import java.util.List;
import javax.servlet.RequestDispatcher;
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
             Show Help Page
             -> http://localhost:8080/neg/rest
                http://localhost:8080/neg/rest/
 */
public class RESTServlet extends HttpServlet {
    
    @Override
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        try {
            // Extrahiere die Identifier aus der URL
            String pathInfo = request.getPathInfo(); // Holt den Pfad (/items/N2,N3,N4)
            if (pathInfo != null) {
                String[] parts = pathInfo.split("/"); // Teilt den Pfad

                if (parts.length >= 2) {
                    String action = parts[1]; // "item" oder "items"
                    if (("item".equals(action) || "items".equals(action) || "lemma".equals(action) || "lemmas".equals(action)) && parts.length >= 3) {
                        String[] identifiers = parts[2].split(","); // IDs aufteilen

                        if ("item".equals(action) && identifiers.length == 1) {
                            processSingleIdentifier(identifiers[0], response);
                        } else if ("items".equals(action)) {
                            processMultipleIdentifiers(identifiers, response);
                        } else if ("lemma".equals(action) && identifiers.length == 1) {
                            processSingleLemma(identifiers[0], response);
                        } else if ("lemmas".equals(action)) {
                            processMultipleLemmas(identifiers, response);
                        } else {
                            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid request format: " + pathInfo);
                        }
                    } else {
                        response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid request path format: " + pathInfo);
                    }
                } else {
                    RequestDispatcher rd = request.getRequestDispatcher("../resthelp.jsp");
                    rd.include(request, response);
                }
            } else {
                RequestDispatcher rd = request.getRequestDispatcher("resthelp.jsp");
                rd.include(request, response);
            }
        } catch (Exception e) {
            throw new ServletException(e);
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
                        jsonObject = lemma.getJSON();
                    }else{
                        jsonObject.put("error", "Lemma not found with ID " + id);
                    }
                } else if (id.startsWith("N")) {
                    NamenKommentar nk = (NamenKommentar) IdentifierMapper.getModelByIdentifier(id);
                    if (nk != null) {
                        jsonObject = nk.getJSON();
                    }else{
                        jsonObject.put("error", "Namenkommentar not found with ID " + id);
                    }
                } else if (id.startsWith("B")) {
                    Einzelbeleg einzelbeleg = (Einzelbeleg) IdentifierMapper.getModelByIdentifier(id);
                    if (einzelbeleg != null) {
                        jsonObject = einzelbeleg.getJSON();
                    }else{
                        jsonObject.put("error", "Einzelbeleg not found with ID " + id);
                    }
                } else if(id.startsWith("P")) {
                    Person person = (Person) IdentifierMapper.getModelByIdentifier(id);
                    if (person != null) {
                        jsonObject = person.getJSON();
                    }else {
                        jsonObject.put("error", "Person not found with ID " + id);
                    }
                } else if(id.startsWith("Q")) {
                    Quelle quelle = (Quelle) IdentifierMapper.getModelByIdentifier(id);
                    if (quelle != null) {
                        jsonObject = quelle.getJSON();
                    }else{
                        jsonObject.put("error", "Quelle not found with ID " + id);
                    }
                }
                jsonArray.put(jsonObject);
            }
        }
        
        JSONObject finalJson = null;
        if (jsonArray.length() == 1) {
            // Nur ein Element, daher direkt das JSON-Objekt zurückgeben
            finalJson = jsonArray.getJSONObject(0);
        } else {
            // Mehrere Elemente, daher als Array zurückgeben
            finalJson = new JSONObject();
            finalJson.put("items", jsonArray);
        }
        // JSON als Antwort senden
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        if(finalJson != null)
            response.getWriter().println(finalJson.toString(2));
    }

    private void processSingleLemma(String lemmaText, HttpServletResponse response) throws Exception {
        String[] lemmas = new String[1];
        lemmas[0] = lemmaText;
        processMultipleLemmas(lemmas, response);
    }

    private void processMultipleLemmas(String[] lemmaTexts, HttpServletResponse response) throws Exception {
        JSONArray jsonArray = new JSONArray();

        for (String lemmaText : lemmaTexts) {
            if (lemmaText != null) {
                JSONObject jsonObject = new JSONObject();
                // Suche nach dem passenden Lemma anhand der Belegform
                List<MghLemma> lemma = LemmaDB.getLemmaByBelegform(lemmaText);
                if (lemma.size() == 1) {
                    // Rückgabe des Lemmas
                    int lemmaId = lemma.get(0).getId();
                    String lemmaStr = lemma.get(0).getMghLemma();
                    jsonObject.put("ID", lemmaId);
                    jsonObject.put("Lemma", lemmaStr);
                } else if(lemma.size() == 0) {
                    // Falls kein Lemma gefunden wird, entsprechendes Error-Handling
                    jsonObject.put("error", "Lemma not found for Belegform: " + lemmaText);
                } else if(lemma.size() > 1){
                    // Falls mehr als 1 Lemma gefunden wird, entsprechendes Error-Handling
                    jsonObject.put("error", "More than one Lemma found for Belegform: " + lemmaText);
                }
                jsonArray.put(jsonObject);
            }
        }

        JSONObject finalJson = null;
        if (jsonArray.length() == 1) {
            finalJson = jsonArray.getJSONObject(0);
        } else {
            finalJson = new JSONObject();
            finalJson.put("LemmaArray", jsonArray);
        }

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        if (finalJson != null) {
            response.getWriter().println(finalJson.toString(2));
        }
    }
}
