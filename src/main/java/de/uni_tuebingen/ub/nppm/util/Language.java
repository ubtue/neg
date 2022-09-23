package de.uni_tuebingen.ub.nppm.util;

import javax.servlet.http.*;
import de.uni_tuebingen.ub.nppm.db.DatenbankDB;
import javax.servlet.jsp.JspWriter;
public class Language {

    public static String getLanguage(HttpServletRequest request) {
        HttpSession session = request.getSession(true);

        // Usually setLanguage() is called before getLanguage()
        // so we prioritize the session over the request.
        if (session.getAttribute("Sprache") != null) {
            return (String)session.getAttribute("Sprache");
        } else if (request.getParameter("language") != null) {
            return request.getParameter("language");
        } else {
            return "de";
        }
    }

    public static void setLanguage(HttpServletRequest request) {
        if (request.getParameter("language") != null) {
            HttpSession session = request.getSession(true);
            String language = null;

            try {
                language = (String) session.getAttribute("Sprache");
            } catch (Exception e) {

            }

            // if language is set as parameter, store it in session
            try {
                if ((language == null && request.getParameter("language") != null)
                        || (language != null && !language.equals(request.getParameter("language")))) {
                    session.setAttribute("Sprache", request.getParameter("language"));
                }
            } catch (Exception e) {

            }
        }
    }
    
    public static void printDatafield(JspWriter out,HttpSession session, String formular, String datenfeld) throws Exception{
        out.print("<label for=\""+datenfeld+"\">");
        printLabel(out,session,formular,datenfeld,null);  
        out.print("</label>");
    }
    public static void printTextfield(JspWriter out,HttpSession session, String formular, String textfield) throws Exception{
        printLabel(out,session,formular,null,textfield);   
    }
    
    private static void printLabel(JspWriter out,HttpSession session, String formular, String datenfeld, String textfeld) throws Exception{
        String lang = "de";
        //try to get language from session
        if (session != null && session.getAttribute("Sprache") != null)
            lang = (String)session.getAttribute("Sprache");
        if (datenfeld == null && textfeld != null) {
            out.println(DatenbankDB.getLabel(lang, formular, textfeld));
        }else if (datenfeld != null && textfeld == null) {
            out.println(DatenbankDB.getMapping(lang, formular, datenfeld));
        }        
    }
}
