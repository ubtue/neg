package de.uni_tuebingen.ub.nppm.servlet;

import de.uni_tuebingen.ub.nppm.model.Einzelbeleg;
import de.uni_tuebingen.ub.nppm.model.MghLemma;
import de.uni_tuebingen.ub.nppm.model.NamenKommentar;
import de.uni_tuebingen.ub.nppm.util.IdentifierMapper;
import java.io.IOException;
import java.io.PrintWriter;
import java.io.StringWriter;
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
            StringWriter sw = new StringWriter();
            PrintWriter pw = new PrintWriter(sw);
            e.printStackTrace(pw);
            // Stacktrace im Response senden
            response.getWriter().write(sw.toString());
            //response.getWriter().write(e.getLocalizedMessage());
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
                    if(lemma != null){
                        try {
                            jsonObject.put("mghLemma", lemma.getMghLemma());
                            jsonObject.put("id", lemma.getId());
                        } catch (Exception e) {
                            response.getWriter().write(e.getLocalizedMessage());
                        }
                    }
                } else if (id.startsWith("N")) {
                    try {
                        NamenKommentar nk = (NamenKommentar) IdentifierMapper.getModelByIdentifier(id);
                        if(nk != null){
                            jsonObject.put("ELemma", nk.geteLemma());
                            jsonObject.put("PLemma", nk.getpLemma());
                            jsonObject.put("id", nk.getId());
                        }
                    } catch (Exception e) {
                        response.getWriter().write(e.getLocalizedMessage());
                    }
                } else if (id.startsWith("B")) {
                    try {
                        Einzelbeleg einzelbeleg = (Einzelbeleg) IdentifierMapper.getModelByIdentifier(id);
                        if (einzelbeleg != null) {
                            jsonObject.put("id", einzelbeleg.getId());
                            jsonObject.put("belegnummer", einzelbeleg.getBelegnummer());
                            jsonObject.put("kontext", einzelbeleg.getKontext());
                            jsonObject.put("geschlecht", einzelbeleg.getGeschlecht() != null ? einzelbeleg.getGeschlecht().getBezeichnung() : null);
                            jsonObject.put("lebendVerstorben", einzelbeleg.getLebendVerstorben() != null ? einzelbeleg.getLebendVerstorben().getBezeichnung() : null);
                            jsonObject.put("editionId", einzelbeleg.getEdition() != null ? "E"+einzelbeleg.getEdition().getId() : null);
                            jsonObject.put("quelleId", einzelbeleg.getQuelle() != null ? "Q"+einzelbeleg.getQuelle().getId() : null);
                            jsonObject.put("handschriftId", einzelbeleg.getHandschrift() != null ? "T"+einzelbeleg.getHandschrift().getId() : null);
                            jsonObject.put("editionKapitel", einzelbeleg.getEditionKapitel());
                            jsonObject.put("editionSeite", einzelbeleg.getEditionSeite());
                            jsonObject.put("quelleGattung", einzelbeleg.getQuelleGattung() != null ? einzelbeleg.getQuelleGattung().getBezeichnung() : null);
                            jsonObject.put("quelleEchtheit", einzelbeleg.getQuelleEchtheit() != null ? einzelbeleg.getQuelleEchtheit().getBezeichnung() : null);
                            jsonObject.put("quelleDatierung", einzelbeleg.getQuelleDatierung());
                            jsonObject.put("ueberlieferungDatierung", einzelbeleg.getUeberlieferungDatierung());
                            jsonObject.put("belegform", einzelbeleg.getBelegform());
                            jsonObject.put("griechisch", einzelbeleg.getGriechisch());
                            jsonObject.put("diakritisch", einzelbeleg.getDiakritisch());
                            jsonObject.put("kasus", einzelbeleg.getKasus() != null ? einzelbeleg.getKasus().getBezeichnung() : null);
                            jsonObject.put("grammatikGeschlecht", einzelbeleg.getGrammatikGeschlecht() != null ? einzelbeleg.getGrammatikGeschlecht().getBezeichnung() : null);
                            jsonObject.put("aswQuellenzitat", einzelbeleg.getAswQuellenzitat());
                            jsonObject.put("bemerkung", einzelbeleg.getBemerkung());
                            jsonObject.put("bearbeitungsstatus", einzelbeleg.getBearbeitungsstatus() != null ? einzelbeleg.getBearbeitungsstatus().getBezeichnung() : null);
                            jsonObject.put("kommentarEthnie", einzelbeleg.getKommentarEthnie());
                            jsonObject.put("kommentarAreal", einzelbeleg.getKommentarAreal());
                            jsonObject.put("kommentarVerwandtschaft", einzelbeleg.getKommentarVerwandtschaft());
                            jsonObject.put("eindeutig", einzelbeleg.getEindeutig());
                            jsonObject.put("vonTag", einzelbeleg.getVonTag());
                            jsonObject.put("vonMonat", einzelbeleg.getVonMonat());
                            jsonObject.put("vonJahr", einzelbeleg.getVonJahr());
                            jsonObject.put("vonJahrhundert", einzelbeleg.getVonJahrhundert());
                            jsonObject.put("bisTag", einzelbeleg.getBisTag());
                            jsonObject.put("bisMonat", einzelbeleg.getBisMonat());
                            jsonObject.put("bisJahr", einzelbeleg.getBisJahr());
                            jsonObject.put("bisJahrhundert", einzelbeleg.getBisJahrhundert());
                            jsonObject.put("datierungUngewiss", einzelbeleg.getDatierungUngewiss());
                            jsonObject.put("kommentarDatierung", einzelbeleg.getKommentarDatierung());
                            jsonObject.put("kommentarPerson", einzelbeleg.getKommentarPerson());
                            jsonObject.put("letzteAenderung", einzelbeleg.getLetzteAenderung());
                            jsonObject.put("erstellt", einzelbeleg.getErstellt());
                            jsonObject.put("letzteAenderungVon", einzelbeleg.getLetzteAenderungVon() != null ? einzelbeleg.getLetzteAenderungVon().getNachname() : null);
                            jsonObject.put("erstelltVon", einzelbeleg.getErstelltVon() != null ? einzelbeleg.getErstelltVon().getNachname() : null);
                            jsonObject.put("gehoertGruppe", einzelbeleg.getGehoertGruppe() != null ? einzelbeleg.getGehoertGruppe().getBezeichnung() : null);

                            // Genauigkeits-Angaben
                            jsonObject.put("genauigkeitBisTag", einzelbeleg.getGenauigkeitBisTag() != null ? einzelbeleg.getGenauigkeitBisTag().getBezeichnung() : null);
                            jsonObject.put("genauigkeitBisMonat", einzelbeleg.getGenauigkeitBisMonat() != null ? einzelbeleg.getGenauigkeitBisMonat().getBezeichnung() : null);
                            jsonObject.put("genauigkeitBisJahr", einzelbeleg.getGenauigkeitBisJahr() != null ? einzelbeleg.getGenauigkeitBisJahr().getBezeichnung() : null);
                            jsonObject.put("genauigkeitBisJahrhundert", einzelbeleg.getGenauigkeitBisJahrhundert() != null ? einzelbeleg.getGenauigkeitBisJahrhundert().getBezeichnung() : null);
                            jsonObject.put("genauigkeitVonTag", einzelbeleg.getGenauigkeitVonTag() != null ? einzelbeleg.getGenauigkeitVonTag().getBezeichnung() : null);
                            jsonObject.put("genauigkeitVonMonat", einzelbeleg.getGenauigkeitVonMonat() != null ? einzelbeleg.getGenauigkeitVonMonat().getBezeichnung() : null);
                            jsonObject.put("genauigkeitVonJahr", einzelbeleg.getGenauigkeitVonJahr() != null ? einzelbeleg.getGenauigkeitVonJahr().getBezeichnung() : null);
                            jsonObject.put("genauigkeitVonJahrhundert", einzelbeleg.getGenauigkeitVonJahrhundert() != null ? einzelbeleg.getGenauigkeitVonJahrhundert().getBezeichnung() : null);
                            jsonObject.put("genauigkeitQuelleBisTag", einzelbeleg.getGenauigkeitQuelleBisTag() != null ? einzelbeleg.getGenauigkeitQuelleBisTag().getBezeichnung() : null);
                            jsonObject.put("genauigkeitQuelleBisMonat", einzelbeleg.getGenauigkeitQuelleBisMonat() != null ? einzelbeleg.getGenauigkeitQuelleBisMonat().getBezeichnung() : null);
                            jsonObject.put("genauigkeitQuelleBisJahr", einzelbeleg.getGenauigkeitQuelleBisJahr() != null ? einzelbeleg.getGenauigkeitQuelleBisJahr().getBezeichnung() : null);
                            jsonObject.put("genauigkeitQuelleBisJahrhundert", einzelbeleg.getGenauigkeitQuelleBisJahrhundert() != null ? einzelbeleg.getGenauigkeitQuelleBisJahrhundert().getBezeichnung() : null);
                            jsonObject.put("genauigkeitQuelleVonTag", einzelbeleg.getGenauigkeitQuelleVonTag() != null ? einzelbeleg.getGenauigkeitQuelleVonTag().getBezeichnung() : null);
                            jsonObject.put("genauigkeitQuelleVonMonat", einzelbeleg.getGenauigkeitQuelleVonMonat() != null ? einzelbeleg.getGenauigkeitQuelleVonMonat().getBezeichnung() : null);
                            jsonObject.put("genauigkeitQuelleVonJahr", einzelbeleg.getGenauigkeitQuelleVonJahr() != null ? einzelbeleg.getGenauigkeitQuelleVonJahr().getBezeichnung() : null);
                            jsonObject.put("genauigkeitQuelleVonJahrhundert", einzelbeleg.getGenauigkeitQuelleVonJahrhundert() != null ? einzelbeleg.getGenauigkeitQuelleVonJahrhundert().getBezeichnung() : null);

                            //Quelle Informationen
                            jsonObject.put("quelleBisTag", einzelbeleg.getQuelleBisTag());
                            jsonObject.put("quelleBisMonat", einzelbeleg.getQuelleBisMonat());
                            jsonObject.put("quelleBisJahr", einzelbeleg.getQuelleBisJahr());
                            jsonObject.put("quelleBisJahrhundert", einzelbeleg.getQuelleBisJahrhundert());
                            jsonObject.put("quelleVonTag", einzelbeleg.getQuelleVonTag());
                            jsonObject.put("quelleVonMonat", einzelbeleg.getQuelleVonMonat());
                            jsonObject.put("quelleVonJahr", einzelbeleg.getQuelleVonJahr());
                            jsonObject.put("quelleVonJahrhundert", einzelbeleg.getQuelleVonJahrhundert());

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

/*
String name = request.getParameter("name");
                String entity = request.getParameter("entity");
                if(name == null || name.isEmpty()){
                    response.getWriter().write("Please specify name parameter");
                }
                else if(entity != null && entity.compareTo("mghlemma") == 0) {
                    List<MghLemma> lemmas = null;
                    try {
                        lemmas = MghLemmaDB.getByName(name);
                    } catch (Exception ex) {
                        response.getWriter().write(ex.getLocalizedMessage());
                    }

                    if (lemmas.size() > 0) {
                        try {
                            String json = "\n{\n";
                            json += " [\n";
                            for(MghLemma lemma: lemmas){
                                json += "  {\n";
                                json += "  \"mghLemma\": " + JSONObject.quote(lemma.getMghLemma()) + ",\n";
                                json += "  \"id\": " + JSONObject.quote(String.valueOf(lemma.getId())) + ",\n";
                                json += "  },\n";
                            }
                            json = json.substring(0, json.length() - 1);
                            json += " \n ]\n";
                            json += "}\n";
                            response.getWriter().println(json);
                        } catch (Exception e) {
                            response.getWriter().write(e.getLocalizedMessage());
                        }
                    }
                }else if(entity.compareTo("namenkommentar") == 0){
                    List<NamenKommentar> namenkommentare = null;
                    try {
                        namenkommentare = NamenKommentarDB.getByName(name);
                    } catch (Exception ex) {
                        response.getWriter().write(ex.getLocalizedMessage());
                    }

                    if (namenkommentare.size() > 0) {
                        try {
                            String json = "\n{\n";
                            json += " [\n";
                            for(NamenKommentar nk: namenkommentare){
                                json += "  {\n";
                                json += "  \"ELemma\": " + JSONObject.quote(nk.geteLemma()) + ",\n";
                                json += "  \"PLemma\": " + JSONObject.quote(nk.getpLemma()) + ",\n";
                                json += "  \"id\": " + JSONObject.quote(String.valueOf(nk.getId())) + ",\n";
                                json += "  },\n";
                            }
                            json = json.substring(0, json.length() - 1);
                            json += "\n ]\n";
                            json += "}\n";
                            response.getWriter().println(json);
                        } catch (Exception e) {
                            response.getWriter().write(e.getLocalizedMessage());
                        }
                    }
                }
*/
