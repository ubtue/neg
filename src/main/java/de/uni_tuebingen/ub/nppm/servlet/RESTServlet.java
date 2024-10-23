package de.uni_tuebingen.ub.nppm.servlet;

import de.uni_tuebingen.ub.nppm.db.EditionDB;
import de.uni_tuebingen.ub.nppm.db.EinzelbelegDB;
import de.uni_tuebingen.ub.nppm.db.MghLemmaDB;
import de.uni_tuebingen.ub.nppm.db.NamenKommentarDB;
import de.uni_tuebingen.ub.nppm.model.Edition;
import de.uni_tuebingen.ub.nppm.model.Einzelbeleg;
import de.uni_tuebingen.ub.nppm.model.MghLemma;
import de.uni_tuebingen.ub.nppm.model.NamenKommentar;
import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.json.*;
/*
    Example of REST implementation with json output
    Call URL -> http://localhost:8080/neg/rest?name=test&entity=mghlemma
    Call URL -> http://localhost:8080/neg/rest?name=test&entity=namenkommentar
 */
public class RESTServlet extends HttpServlet {

    @Override
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        try {   
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
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

        } catch (Exception e) {
            response.getWriter().write(e.getLocalizedMessage());
        }
    }
}
