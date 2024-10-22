package de.uni_tuebingen.ub.nppm.servlet;

import de.uni_tuebingen.ub.nppm.db.*;
import de.uni_tuebingen.ub.nppm.model.Einzelbeleg;
import de.uni_tuebingen.ub.nppm.model.MghLemma;
import de.uni_tuebingen.ub.nppm.model.NamenKommentar;
import de.uni_tuebingen.ub.nppm.util.Language;
import org.json.*;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class AjaxServlet extends HttpServlet {

    protected void autocomplete(HttpServletRequest request, HttpServletResponse response) {
        try {
            String query = request.getParameter("query");
            String form = request.getParameter("form");
            String field = request.getParameter("field");

            if (query == null || form == null || field == null) {
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            } else {
                response.setContentType("application/json; charset=UTF-8");

                JSONObject jsonObject = new JSONObject();
                JSONArray jsonArray = new JSONArray();
                List<String> matches = SucheDB.getAutocompleteText(field, form, query);
                for (String match : matches) {
                    jsonArray.put(match);
                }
                jsonObject.put("suggestions", jsonArray);
                response.getWriter().print(jsonObject.toString());
            }
        } catch (Exception e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }

    protected void detectZusatzNamenKommentar(HttpServletRequest request, HttpServletResponse response) {
        try {
            String EinzelbelegID = request.getParameter("EinzelbelegID");
            if (EinzelbelegID == null) {
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            } else {
                ArrayList<String> outputList = new ArrayList<>();
                Einzelbeleg lastEinzelbeleg = EinzelbelegDB.getById(Integer.parseInt(EinzelbelegID));
                String belegform = lastEinzelbeleg.getBelegform();

                List<Einzelbeleg> einzelbelege = EinzelbelegDB.getListByBelegform(belegform);

                Map<Integer, List<Integer>> namenkommentarIdToEinzelbelegIdsMap = new HashMap<>();
                Map<Integer, String> namenkommentarIdToPlemmaMap = new HashMap<>();

                for (Einzelbeleg eb : einzelbelege) {
                    int einzelbelegId = eb.getId();

                    for (NamenKommentar namenKommentar : eb.getNamenKommentar()) {
                        if (namenKommentar != null) {
                            int namenkommentarID = namenKommentar.getId();
                            String plemma = namenKommentar.getpLemma();

                            if (!namenkommentarIdToEinzelbelegIdsMap.containsKey(namenkommentarID)) {
                                namenkommentarIdToEinzelbelegIdsMap.put(namenkommentarID, new ArrayList<>());
                            }
                            namenkommentarIdToEinzelbelegIdsMap.get(namenkommentarID).add(einzelbelegId);

                            if (!namenkommentarIdToPlemmaMap.containsKey(namenkommentarID)) {
                                namenkommentarIdToPlemmaMap.put(namenkommentarID, plemma);
                            }
                        }
                    }
                }

                if (!namenkommentarIdToEinzelbelegIdsMap.isEmpty()) {
                    String language = Language.getLanguage(request);
                    StringBuilder sb = new StringBuilder();
                    int save_namenkommentarID = -1;

                    for (Map.Entry<Integer, List<Integer>> entry : namenkommentarIdToEinzelbelegIdsMap.entrySet()) {
                        int namenkommentarID = entry.getKey();
                        List<Integer> einzelbelegIDs = entry.getValue();
                        String plemma = namenkommentarIdToPlemmaMap.get(namenkommentarID);

                        String einzelbelegIDsString = einzelbelegIDs.toString();

                        String s = DatenbankDB.getLabel(language, "einzelbeleg", "foundZusatznamenkommentar");

                        String result = String.format(s, belegform, plemma, String.valueOf(namenkommentarID), einzelbelegIDsString);

                        sb.append(result).append("\n\n");

                        if (namenkommentarIdToEinzelbelegIdsMap.size() == 1) {
                            save_namenkommentarID = namenkommentarID;
                        }
                    }

                    if (namenkommentarIdToEinzelbelegIdsMap.size() == 1) {
                        sb.append(DatenbankDB.getLabel(language, "einzelbeleg", "replaceZusatznamenkommentar"));
                    } else {
                        sb.append(DatenbankDB.getLabel(language, "einzelbeleg", "cleanData"));
                    }

                    outputList.add(sb.toString());

                    response.setContentType("application/json; charset=UTF-8");

                    JSONObject jsonObject = new JSONObject();
                    jsonObject.put("EinzelbelegID", EinzelbelegID);
                    jsonObject.put("outputListZ", outputList);

                    if (save_namenkommentarID != -1) {
                        jsonObject.put("namenkommentarID", save_namenkommentarID);
                    }

                    response.getWriter().print(jsonObject.toString());
                } else {
                    response.setStatus(HttpServletResponse.SC_NO_CONTENT);
                }
            }
        } catch (Exception e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }

    protected void confirmZusatzNamenKommentar(HttpServletRequest request, HttpServletResponse response) {
        try {
            String EinzelbelegID = request.getParameter("EinzelbelegID");
            String namenkommentarID = request.getParameter("namenkommentarID");

            if (EinzelbelegID == null || namenkommentarID == null) {
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            } else {
                // Logik zum Speichern des Zusatznamen-Kommentars
                EinzelbelegDB.insertNamenkommentar(EinzelbelegID, namenkommentarID);

                response.setContentType("application/json; charset=UTF-8");
                JSONObject jsonObject = new JSONObject();
                response.getWriter().print(jsonObject.toString());
            }
        } catch (Exception e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }

    protected void detectLemma(HttpServletRequest request, HttpServletResponse response) {
        try {
            String EinzelbelegID = request.getParameter("EinzelbelegID");
            if (EinzelbelegID == null) {
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            } else {
                ArrayList<String> outputList = new ArrayList<>();
                Einzelbeleg lastEinzelbeleg = EinzelbelegDB.getById(Integer.parseInt(EinzelbelegID));
                String belegform = lastEinzelbeleg.getBelegform();

                List<Einzelbeleg> einzelbelege = EinzelbelegDB.getListByBelegform(belegform);

                Map<Integer, List<Integer>> lemmaIdToEinzelbelegIdsMap = new HashMap<>();
                Map<Integer, String> lemmaIdToLemmaMap = new HashMap<>();

                for (Einzelbeleg eb : einzelbelege) {
                    int einzelbelegId = eb.getId();

                    // 5. Überprüfe, ob Einträge gefunden wurden
                    for (MghLemma lemmakommentar : eb.getMghLemma()) {
                        if (lemmakommentar != null) {
                            int lemmaID = lemmakommentar.getId();
                            String plemma = lemmakommentar.getMghLemma();

                            // Füge EinzelbelegID zur entsprechenden Liste in der Map hinzu
                            if (!lemmaIdToEinzelbelegIdsMap.containsKey(lemmaID)) {
                                lemmaIdToEinzelbelegIdsMap.put(lemmaID, new ArrayList<>());
                            }
                            lemmaIdToEinzelbelegIdsMap.get(lemmaID).add(einzelbelegId);

                            // Speichere die plemma-Strings in der Map
                            if (!lemmaIdToLemmaMap.containsKey(lemmaID)) {
                                lemmaIdToLemmaMap.put(lemmaID, plemma);
                            }
                        }
                    }

                }

                if (!lemmaIdToEinzelbelegIdsMap.isEmpty()) {
                    String language = Language.getLanguage(request);
                    StringBuilder sb = new StringBuilder();
                    int save_lemmaID = -1;

                    for (Map.Entry<Integer, List<Integer>> entry : lemmaIdToEinzelbelegIdsMap.entrySet()) {
                        int lemmaID = entry.getKey();
                        List<Integer> einzelbelegIDs = entry.getValue();
                        String lemma = lemmaIdToLemmaMap.get(lemmaID);

                        String einzelbelegIDsString = einzelbelegIDs.toString();

                        String s = DatenbankDB.getLabel(language, "einzelbeleg", "foundLemma");

                        String result = String.format(s, belegform, lemma, String.valueOf(lemmaID), einzelbelegIDsString);

                        sb.append(result).append("\n\n");

                        if (lemmaIdToEinzelbelegIdsMap.size() == 1) {
                            save_lemmaID = lemmaID;
                        }
                    }

                    if (lemmaIdToEinzelbelegIdsMap.size() == 1) {
                         sb.append(DatenbankDB.getLabel(language, "einzelbeleg", "replaceLemma"));
                    } else {
                        sb.append(DatenbankDB.getLabel(language, "einzelbeleg", "cleanData"));
                    }

                    outputList.add(sb.toString());

                    response.setContentType("application/json; charset=UTF-8");

                    JSONObject jsonObject = new JSONObject();
                    jsonObject.put("EinzelbelegID", EinzelbelegID);
                    jsonObject.put("outputListL", outputList);

                    if (save_lemmaID != -1) {
                        jsonObject.put("lemmaID", save_lemmaID);
                    }

                    response.getWriter().print(jsonObject.toString());
                } else {
                    response.setStatus(HttpServletResponse.SC_NO_CONTENT);
                }
            }
        } catch (Exception e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }

    protected void confirmLemma(HttpServletRequest request, HttpServletResponse response) {
        try {
            String EinzelbelegID = request.getParameter("EinzelbelegID");
            String lemmaID = request.getParameter("lemmaID");

            if (EinzelbelegID == null || lemmaID == null) {
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            } else {
                // Logik zum Speichern des Zusatznamen-Kommentars
              // EinzelbelegDB.insertFunktion(EinzelbelegID, lemmaID);
              EinzelbelegDB.insertLemma(EinzelbelegID, lemmaID);

                response.setContentType("application/json; charset=UTF-8");
                JSONObject jsonObject = new JSONObject();
                response.getWriter().print(jsonObject.toString());
            }
        } catch (Exception e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }

     private void newParentNode(HttpServletRequest request, HttpServletResponse response) throws IOException {
        try {
            // This method is called via AJAX to change the parent ID.
            Integer id = Integer.parseInt(request.getParameter("id")); // Hier die ID des verschobenen Nodes
            String table = request.getParameter("Tabelle");
            Integer parentId = null;
            String temp = request.getParameter("parentId");
            if (temp != null && !temp.isEmpty()) {
                parentId = Integer.parseInt(temp); // Hier die neue Parent-ID
            }           
                SelektionDB.updateParentId(table, id, parentId);
           
        } catch (Exception ex) {
            Logger.getLogger(AjaxServlet.class.getName()).log(Level.SEVERE, null, ex);
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("An error occurred while processing your request.");
        }

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if ("confirmLemma".equals(action)) {
            confirmLemma(request, response);
        } else if ("confirmZusatzNamenKommentar".equals(action)) {
            confirmZusatzNamenKommentar(request, response);
        } else if ("newParentNode".equals(action)) {
             newParentNode(request, response);
        }
    }
    

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        if (action != null) {
            if (action.equals("autocomplete")) {
                autocomplete(request, response);
            } else if (action.equals("detectZusatzNamenKommentar")) {
                detectZusatzNamenKommentar(request, response);
            } else if (action.equals("detectLemma")) {
                detectLemma(request, response);
            } else {
                response.setStatus(HttpServletResponse.SC_NOT_IMPLEMENTED);
            }
            return;
        }

        response.setStatus(HttpServletResponse.SC_NOT_IMPLEMENTED);
    }
}
