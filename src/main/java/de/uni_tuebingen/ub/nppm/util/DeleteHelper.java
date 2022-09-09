package de.uni_tuebingen.ub.nppm.util;

import de.uni_tuebingen.ub.nppm.db.EinzelbelegDB;
import java.io.IOException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.http.*;
import javax.servlet.jsp.JspWriter;

public class DeleteHelper {
public static boolean deleteEntity(HttpServletRequest request,HttpServletResponse response,JspWriter out) {
        boolean ret = false;
        if (request.getParameter("table") == null
            || request.getParameter("ID") == null
            || request.getParameter("returnpage") == null
            || request.getParameter("returnid") == null
        ) {
            return ret;
        }else{            
            try {
                int id = Integer.valueOf(request.getParameter("ID"));
                switch(request.getParameter("table")){
                    case "einzelbeleg_hatmghlemma":
                        int redirectId = EinzelbelegDB.getEinzelbelegId(id,out);
                        ret = EinzelbelegDB.removeMghLemma(id,out);                        
                        response.sendRedirect("einzelbeleg.jsp?ID="+redirectId);
                        break;
                    case "einzelbeleg_hatnamenkommentar":
                        break;
                    case "person_hatamtstandweihe":
                        break;
                    case "person_hatareal":
                        break;
                    case "einzelbeleg_hatperson":
                        break;
                    case "quelle_inedition":
                        break;
                    case "urkunde_betreff":
                        break;
                    case "urkunde_hatempfaenger":
                        break;
                    case "edition_hateditor":
                        break;
                    case "handschrift_ueberlieferung":                                        
                        break;
                }
            } catch (Exception ex) {
                try {
                    out.println(ex.getLocalizedMessage());
                } catch (IOException ex1) {
                    ex1.printStackTrace();
                }
            }
        }
        return ret;
    }
}
