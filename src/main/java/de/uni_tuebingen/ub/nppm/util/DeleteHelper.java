package de.uni_tuebingen.ub.nppm.util;

import de.uni_tuebingen.ub.nppm.db.*;
import de.uni_tuebingen.ub.nppm.model.*;
import java.io.IOException;
import javax.servlet.http.*;
import javax.servlet.jsp.JspWriter;

public class DeleteHelper {

    public static boolean deleteEntity(HttpServletRequest request, HttpServletResponse response, JspWriter out) {
        if (request.getParameter("table") == null
                || request.getParameter("ID") == null
                || request.getParameter("returnpage") == null
                || request.getParameter("returnid") == null) {
            //wrong request parameters
            return false;
        } else {
            try {
                int id = Integer.valueOf(request.getParameter("ID"));
                switch (request.getParameter("table")) {
                    case "edition_hateditor":
                        EinzelbelegDB.remove(EditionEditor.class, id);
                        break;
                    case "einzelbeleg_hatamtweihe":
                        EinzelbelegDB.remove(EinzelbelegHatAmtWeihe_MM.class, id);
                        break;
                    case "einzelbeleg_hatethnie":
                        EinzelbelegDB.remove(EinzelbelegHatEthnie_MM.class, id);
                        break;
                    case "einzelbeleg_hatfunktion":
                        EinzelbelegDB.remove(EinzelbelegHatFunktion_MM.class, id);
                        break;
                    case "einzelbeleg_hatmghlemma":
                        EinzelbelegDB.remove(EinzelbelegMghLemma_MM.class, id);
                        break;
                    case "einzelbeleg_hatnamenkommentar":
                        EinzelbelegDB.remove(EinzelbelegNamenkommentar_MM.class, id);
                        break;
                    case "einzelbeleg_hatperson":
                        EinzelbelegDB.remove(EinzelbelegHatPerson_MM.class, id);
                        break;
                    case "einzelbeleg_hatstand":
                        EinzelbelegDB.remove(EinzelbelegHatStand.class, id);
                        break;
                    case "einzelbeleg_textkritik":
                        EinzelbelegDB.remove(EinzelbelegTextkritik.class, id);
                        break;
                    case "handschrift_ueberlieferung":
                        EinzelbelegDB.remove(HandschriftUeberlieferung.class, id);
                        break;
                    case "person_hatamtstandweihe":
                        PersonDB.remove(PersonAmtStandWeihe_MM.class, id);
                        break;
                    case "person_hatareal":
                        PersonDB.remove(PersonAreal_MM.class, id);
                        break;
                    case "person_hatethnie":
                        PersonDB.remove(PersonEthnie_MM.class, id);
                        break;
                    case "person_hatstand":
                        PersonDB.remove(PersonHatStand.class, id);
                        break;
                    case "person_quiet":
                        PersonDB.remove(PersonQuiet.class, id);
                        break;
                    case "person_variante":
                        PersonDB.remove(PersonVariante.class, id);
                        break;
                    case "person_verwandtmit":
                        PersonDB.remove(PersonVerwandtMit_MM.class, id);
                        break;
                    case "quelle_inedition":
                        EinzelbelegDB.remove(QuelleInEdition_MM.class, id);
                        break;
                    case "urkunde_hataussteller":
                        EinzelbelegDB.remove(UrkundeAussteller.class, id);
                        break;
                    case "urkunde_betreff":
                        EinzelbelegDB.remove(UrkundeBetreff.class, id);
                        break;
                    case "urkunde_hatempfaenger":
                        EinzelbelegDB.remove(UrkundeEmpfaenger.class, id);
                        break;
                    default:
                        return false;
                }
            } catch (Exception ex) {
                try {
                    //print error message
                    out.println(ex.getLocalizedMessage());
                } catch (IOException ex1) {
                    ex1.printStackTrace();
                }
                return false;
            }
        }
        return true;
    }
}