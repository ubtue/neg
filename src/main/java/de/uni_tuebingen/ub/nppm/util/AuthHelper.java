package de.uni_tuebingen.ub.nppm.util;

import java.io.*;
import javax.servlet.http.*;
import javax.servlet.ServletException;
import de.uni_tuebingen.ub.nppm.model.Benutzer;
import de.uni_tuebingen.ub.nppm.db.BenutzerDB;

public class AuthHelper {
    public static String getPasswordHashingAlgorithm() {
        return "MD5";
    }

    public static int getPasswordSaltLength() {
        return 20;
    }

    public static boolean isBenutzerLogin(HttpServletRequest request) throws ServletException, IOException{
        HttpSession session = request.getSession(true);
        if (session.getAttribute("BenutzerID")!=null && ((Integer) session.getAttribute("BenutzerID")).intValue() > 0 && !((Boolean) session.getAttribute("Gast")).booleanValue()) {
            return true;
        }else{
            return false;
        }
    }

    public static boolean isGastLogin(HttpServletRequest request) throws ServletException, IOException{
        HttpSession session = request.getSession(true);
        if (session!=null && session.getAttribute("BenutzerID")!=null && ((Integer) session.getAttribute("BenutzerID")).intValue() > 0 && ((Boolean) session.getAttribute("Gast"))) {
            return true;
        }else{
            return false;
        }
    }

    public static boolean isAdminLogin(HttpServletRequest request) throws ServletException, IOException {
        HttpSession session = request.getSession(true);
        if (session.getAttribute("BenutzerID") != null && ((Integer) session.getAttribute("BenutzerID")).intValue() > 0 && ((Boolean) session.getAttribute("Administrator")).booleanValue()) {
            return true;
        } else {
            return false;
        }
    }


    public static Benutzer getBenutzer(HttpServletRequest request) throws Exception {
        HttpSession session = request.getSession(true);
        Object BenutzerID_obj = session.getAttribute("BenutzerID");
        if (BenutzerID_obj != null) {
            Integer BenutzerID = ((Integer) session.getAttribute("BenutzerID"));
            if (BenutzerID > 0) {
                return BenutzerDB.getById(BenutzerID);
            }
        }
        return null;
    }

}
