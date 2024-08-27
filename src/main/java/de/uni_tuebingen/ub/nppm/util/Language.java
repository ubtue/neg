package de.uni_tuebingen.ub.nppm.util;

import javax.servlet.http.*;
import de.uni_tuebingen.ub.nppm.db.DatenbankDB;
import java.io.PrintWriter;
import javax.servlet.jsp.JspWriter;

public class Language {

    public static String getLanguage(HttpServletRequest request) {
        HttpSession session = request.getSession(true);

        // Usually setLanguage() is called before getLanguage()
        // so we prioritize the session over the request.
        if (session.getAttribute("Sprache") != null) {
            return (String) session.getAttribute("Sprache");
        } else if (request.getParameter("language") != null) {
            return request.getParameter("language");
        } else {
            return Constants.DEFAULT_LANG;
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

    public static void printDatafield(JspWriter out, HttpSession session, String formular, String datenfeld) throws Exception {
        String lang = getLanguage(session);
        String[] langArray = {lang, Constants.DEFAULT_LANG};
        boolean isSet = false;
        out.print("<label for=\"" + datenfeld + "\">");
        for (String l : langArray) {
            String print = DatenbankDB.getMapping(l, formular, datenfeld);
            if (print != null) {
                out.println(print);
                isSet = true;
                break;
            }
        }
        out.print("</label>");
        if (!isSet) {
            out.println("no datafield available: " + formular + " " + datenfeld);
        }
    }

    public static String getTextfield(HttpSession session, String formular, String textfield) throws Exception {
        String lang = getLanguage(session);
        String[] langArray = {lang, Constants.DEFAULT_LANG};
        for (String l : langArray) {
            String label = DatenbankDB.getLabel(l, formular, textfield);
            if (label != null) {
                return label;
            }
        }
        return "no translation found";
    }

    public static void printTextfield(JspWriter out, HttpSession session, String formular, String textfield) throws Exception {
        out.println(getTextfield(session, formular, textfield));
    }

    //In order to use this function in a Servlet, I need a PrintWriter there.
    public static void printTextfield(PrintWriter out, HttpSession session, String formular, String textfield) throws Exception {
        out.println(getTextfield(session, formular, textfield));
    }

    private static String getLanguage(HttpSession session) {
        String lang = Constants.DEFAULT_LANG;
        //try to get language from session
        if (session != null && session.getAttribute("Sprache") != null) {
            lang = (String) session.getAttribute("Sprache");
        }
        return lang;
    }
}
