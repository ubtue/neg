package de.uni_tuebingen.ub.nppm.util;

import de.uni_tuebingen.ub.nppm.db.*;
import java.io.IOException;
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
            //wrong request parameters
            return ret;
        }else{            
            try {
                int id = Integer.valueOf(request.getParameter("ID"));
                switch(request.getParameter("table")){
                    case "einzelbeleg_hatmghlemma":
                        ret = EinzelbelegDB.removeMghLemmaFromEinzelbeleg(id,out);                  
                        break;
                    case "einzelbeleg_hatnamenkommentar":
                        ret = EinzelbelegDB.removeNamenKommentarFromEinzelbeleg(id,out);                  
                        break;
                    case "person_hatamtstandweihe":
                        ret = PersonDB.removeAmtStandWeiheFromPerson(id, out);
                        break;
                    case "person_hatareal":
                        ret = PersonDB.removeArealFromPerson(id, out);
                        break;
                    case "person_hatethnie":
                        ret = PersonDB.removeEthnieFromPerson(id, out);
                        break;
                    case "person_verwandtmit":
                        ret = PersonDB.removeVerwandtMitFromPerson(id, out);
                        break;                                                            
                    case "einzelbeleg_hatperson":
                        ret = EinzelbelegDB.removePersonFromEinzelbeleg(id, out);
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
                    //print error message
                    out.println(ex.getLocalizedMessage());
                } catch (IOException ex1) {
                    ex1.printStackTrace();
                }
            }
        }
        return ret;
    }
}
