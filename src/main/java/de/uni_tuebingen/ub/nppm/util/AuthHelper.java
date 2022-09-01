package de.uni_tuebingen.ub.nppm.util;

import java.io.*;
import javax.servlet.http.*;
import javax.servlet.ServletException;

public class AuthHelper {
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
    
    
}
