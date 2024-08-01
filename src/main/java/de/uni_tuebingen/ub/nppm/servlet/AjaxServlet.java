package de.uni_tuebingen.ub.nppm.servlet;

import de.uni_tuebingen.ub.nppm.db.*;
import de.uni_tuebingen.ub.nppm.model.Einzelbeleg;
import de.uni_tuebingen.ub.nppm.model.EinzelbelegMghLemma_MM;
import de.uni_tuebingen.ub.nppm.model.EinzelbelegNamenkommentar_MM;
import de.uni_tuebingen.ub.nppm.model.MghLemma;
import de.uni_tuebingen.ub.nppm.model.NamenKommentar;
import org.json.*;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
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

                    List<EinzelbelegNamenkommentar_MM> einzelbeleg_hatnamenkommentar_list = Einzelbeleg.getNamenkommentarByEinzelbelegId(einzelbelegId);

                    for (EinzelbelegNamenkommentar_MM einzelbeleg_hatnamenkommentar : einzelbeleg_hatnamenkommentar_list) {
                        NamenKommentar namenKommentar = einzelbeleg_hatnamenkommentar.getNamenKommentar();
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

                if (namenkommentarIdToEinzelbelegIdsMap.size() != 0) {
                    StringBuilder sb = new StringBuilder();
                    int save_namenkommentarID = -1;

                    for (Map.Entry<Integer, List<Integer>> entry : namenkommentarIdToEinzelbelegIdsMap.entrySet()) {
                        int namenkommentarID = entry.getKey();
                        List<Integer> einzelbelegIDs = entry.getValue();
                        String plemma = namenkommentarIdToPlemmaMap.get(namenkommentarID);

                        sb.append("Für Belegform ").append(belegform).append(" wurde Zusatznamen-Kommentar  ").append(plemma).append(" gefunden. ");
                        sb.append("NamenkommentarID: ").append(namenkommentarID).append(", EinzelbelegIDs: ").append(einzelbelegIDs).append("\n\n");

                        if (namenkommentarIdToEinzelbelegIdsMap.size() == 1) {
                            save_namenkommentarID = namenkommentarID;
                        }
                    }

                    if (namenkommentarIdToEinzelbelegIdsMap.size() == 1) {
                        sb.append("Soll dieser Zusatznamen-Kommentar hier übernommen werden? ");
                    } else {
                        sb.append("Bitte bereinigen sie die Daten");
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
                jsonObject.put("message", "Der Zusatznamen-Kommentar wird übernommen.");
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

                   // List<EinzelbelegMghLemma_MM> einzelbeleg_hatmghlemma_list = EinzelbelegMGHLemmaDB.getByEinzelbelegId(einzelbelegId);
                    List<EinzelbelegMghLemma_MM> einzelbeleg_hatmghlemma_list = Einzelbeleg.getLemmaByEinzelbelegId(einzelbelegId);

                    // 5. Überprüfe, ob Einträge gefunden wurden
                    for (EinzelbelegMghLemma_MM einzelbeleg_hatlemma : einzelbeleg_hatmghlemma_list) {
                        MghLemma lemmakommentar = einzelbeleg_hatlemma.getMghLemma();
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

                if (lemmaIdToEinzelbelegIdsMap.size() != 0) {
                    StringBuilder sb = new StringBuilder();
                    int save_lemmaID = -1;

                    for (Map.Entry<Integer, List<Integer>> entry : lemmaIdToEinzelbelegIdsMap.entrySet()) {
                        int lemmaID = entry.getKey();
                        List<Integer> einzelbelegIDs = entry.getValue();
                        String lemma = lemmaIdToLemmaMap.get(lemmaID);

                        sb.append("Für Belegform ").append(belegform).append(" wurde das Lemma  ").append(lemma).append(" gefunden. ");
                        sb.append("LemmaID: ").append(lemmaID).append(", EinzelbelegIDs: ").append(einzelbelegIDs).append("\n\n");

                        if (lemmaIdToEinzelbelegIdsMap.size() == 1) {
                            save_lemmaID = lemmaID;
                        }
                    }

                    if (lemmaIdToEinzelbelegIdsMap.size() == 1) {
                        sb.append("Soll dieser Zusatznamen-Kommentar hier übernommen werden? ");
                    } else {
                        sb.append("Bitte bereinigen sie die Daten");
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
                EinzelbelegDB.insertLemma(EinzelbelegID, lemmaID);

                response.setContentType("application/json; charset=UTF-8");
                JSONObject jsonObject = new JSONObject();
                jsonObject.put("message", "Das lemma wird übernommen.");
                response.getWriter().print(jsonObject.toString());
            }
        } catch (Exception e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if ("confirmLemma".equals(action)) {
            confirmLemma(request, response);
        }else if ("confirmZusatzNamenKommentar".equals(action)) {
            confirmZusatzNamenKommentar(request, response);
        } else {
            // Andere Aktionen
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
            }else if (action.equals("detectLemma")) {
                detectLemma(request, response);
            }  else {
                response.setStatus(HttpServletResponse.SC_NOT_IMPLEMENTED);
            }
            return;
        }

        response.setStatus(HttpServletResponse.SC_NOT_IMPLEMENTED);
    }
}

