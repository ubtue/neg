package de.uni_tuebingen.ub.nppm.servlet;

import de.uni_tuebingen.ub.nppm.db.EditionDB;
import de.uni_tuebingen.ub.nppm.db.EinzelbelegDB;
import de.uni_tuebingen.ub.nppm.model.Edition;
import de.uni_tuebingen.ub.nppm.model.Einzelbeleg;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.json.*;
/*
    Example of REST implementation with json output
    Call URL -> http://localhost:8080/neg/rest?id=1&entity=einzelbeleg
 */
public class RESTServlet extends HttpServlet {

    @Override
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        try {
            String entity = request.getParameter("entity");
            Integer id = Integer.valueOf(request.getParameter("id"));
            if(entity == null || entity.isEmpty()){
                response.getOutputStream().println("Please specify entity parameter");
            }
            /*eval entity*/
            if (entity.compareTo("einzelbeleg") == 0) {
                Einzelbeleg eb = null;                
                try {
                    eb = EinzelbelegDB.getById(id);
                } catch (Exception ex) {
                    response.getOutputStream().println(ex.getLocalizedMessage());
                }

                if (eb != null) {
                    try {
                        String json = "{\n";
                        json += "\"AswQuellenzitat\": " + JSONObject.quote(eb.getAswQuellenzitat()) + ",\n";
                        json += "\"Belegform\": " + JSONObject.quote(eb.getBelegform()) + ",\n";
                        json += "\"Bemerkung\": " + JSONObject.quote(eb.getBemerkung()) + ",\n";
                        json += "\"BisJahrhundert\": " + JSONObject.quote(eb.getBisJahrhundert()) + ",\n";
                        json += "\"getDiakritisch\": " + JSONObject.quote(eb.getDiakritisch()) + ",\n";
                        json += "\"EditionKapitel\": " + JSONObject.quote(eb.getEditionKapitel()) + ",\n";
                        json += "\"EditionSeite\": " + JSONObject.quote(eb.getEditionSeite()) + ",\n";
                        json += "\"Griechisch\": " + JSONObject.quote(eb.getGriechisch()) + ",\n";
                        json += "\"KommentarAreal\": " + JSONObject.quote(eb.getKommentarAreal()) + ",\n";
                        json += "\"KommentarDatierung\": " + JSONObject.quote(eb.getKommentarDatierung()) + ",\n";
                        json += "\"KommentarEthnie\": " + JSONObject.quote(eb.getKommentarEthnie()) + ",\n";
                        json += "\"KommentarPerson\": " + JSONObject.quote(eb.getKommentarPerson()) + ",\n";
                        json += "\"KommentarVerwandtschaft\": " + JSONObject.quote(eb.getKommentarVerwandtschaft()) + ",\n";
                        json += "\"Kontext\": " + JSONObject.quote(eb.getKontext()) + ",\n";
                        json += "\"QuelleBisJahrhundert\": " + JSONObject.quote(eb.getQuelleBisJahrhundert()) + ",\n";
                        json += "\"QuelleDatierung\": " + JSONObject.quote(eb.getQuelleDatierung()) + ",\n";
                        json += "\"QuelleVonJahrhundert\": " + JSONObject.quote(eb.getQuelleVonJahrhundert()) + ",\n";
                        json += "\"UeberlieferungDatierung\": " + JSONObject.quote(eb.getUeberlieferungDatierung()) + ",\n";
                        json += "\"VonJahrhundert\": " + JSONObject.quote(eb.getVonJahrhundert()) + ",\n";
                        if(eb.getBearbeitungsstatus() != null)
                            json += "\"Bearbeitungsstatus\": " + JSONObject.quote(eb.getBearbeitungsstatus().getBezeichnung()) + ",\n";
                        json += "\"BisJahr\": " + eb.getBisJahr() + ",\n";
                        json += "\"BisMonat\": " + eb.getBisMonat() + ",\n";
                        json += "\"BisTag\": " + eb.getBisTag() + ",\n";
                        json += "\"DatierungUngewiss\": " + eb.getDatierungUngewiss() + ",\n";
                        if(eb.getEdition() != null)
                            json += "\"Edition\": " + JSONObject.quote(String.valueOf(eb.getEdition().getTitel())) + ",\n";
                        json += "\"Eindeutig\": " + eb.getEindeutig() + ",\n";
                        json += "\"Erstellt\": " + JSONObject.quote(String.valueOf(eb.getErstellt())) + ",\n";
                        if(eb.getErstelltVon() != null)
                            json += "\"ErstelltVon\": " + JSONObject.quote(String.valueOf(eb.getErstelltVon().getNachname())) + ",\n";
                        if(eb.getGehoertGruppe() != null)
                            json += "\"GehoertGruppe\": " + JSONObject.quote(String.valueOf(eb.getGehoertGruppe().getBezeichnung())) + ",\n";
                        json += "}";
                        response.getOutputStream().println(json);
                    } catch (Exception e) {
                        response.getOutputStream().println(e.getLocalizedMessage());
                    }
                }
            }else if(entity.compareTo("edition") == 0){
                Edition ed = null;                
                try {
                    ed = EditionDB.getById(id);
                    if (ed != null) {
                        try {
                            String json = "{\n";
                            json += "\"BandNummer\": " + ed.getBandNummer() + ",\n";
                            json += "\"Jahr\": " + ed.getJahr() + ",\n";
                            json += "\"Titel\": " + JSONObject.quote(ed.getTitel()) + ",\n";
                            json += "\"Zitierweise\": " + JSONObject.quote(ed.getZitierweise()) + ",\n";
                            if(ed.getErstelltVon() != null)
                                json += "\"ErstelltVon\": " + JSONObject.quote(ed.getErstelltVon().getNachname()) + ",\n";
                            if(ed.getLetzteAenderungVon() != null)
                                json += "\"LetzteAenderungVon\": " + JSONObject.quote(ed.getLetzteAenderungVon().getNachname()) + ",\n";
                            json += "}";
                            response.getOutputStream().println(json);
                        } catch (Exception e) {
                            response.getOutputStream().println(e.getLocalizedMessage());
                        }
                    }
                    
                } catch (Exception ex) {
                    response.getOutputStream().println(ex.getLocalizedMessage());
                }
            }

        } catch (Exception e) {
            response.getOutputStream().println(e.getLocalizedMessage());
        }
    }
}
