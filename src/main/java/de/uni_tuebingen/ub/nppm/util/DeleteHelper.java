package de.uni_tuebingen.ub.nppm.util;

import de.uni_tuebingen.ub.nppm.db.*;
import de.uni_tuebingen.ub.nppm.model.*;
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
                        ret = EinzelbelegDB.remove(EinzelbelegMghLemma_MM.class,id);                  
                        break;
                    case "einzelbeleg_hatnamenkommentar":
                        ret = EinzelbelegDB.remove(EinzelbelegNamenkommentar_MM.class,id);                  
                        break;
                    case "person_hatamtstandweihe":
                        ret = PersonDB.remove(PersonAmtStandWeihe_MM.class,id);
                        break;
                    case "person_hatareal":
                        ret = PersonDB.remove(PersonAreal_MM.class,id);
                        break;
                    case "person_hatethnie":
                        ret = PersonDB.remove(PersonEthnie_MM.class,id);
                        break;
                    case "person_verwandtmit":
                        ret = PersonDB.remove(PersonVerwandtMit_MM.class,id);
                        break;                                                            
                    case "einzelbeleg_hatperson":
                        ret = EinzelbelegDB.remove(EinzelbelegHatPerson_MM.class,id);
                        break;
                    case "quelle_inedition":
                        ret = EinzelbelegDB.remove(QuelleInEdition_MM.class,id);
                        break;
                    case "urkunde_betreff":
                        ret = EinzelbelegDB.remove(UrkundeBetreff.class,id);
                        break;
                    case "urkunde_hatempfaenger":
                        ret = EinzelbelegDB.remove(UrkundeEmpfaenger.class,id);
                        break;
                    case "edition_hateditor":
                        ret = EinzelbelegDB.remove(EditionEditor.class,id);
                        break;
                    case "handschrift_ueberlieferung":    
                        ret = EinzelbelegDB.remove(HandschriftUeberlieferung.class,id);
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
