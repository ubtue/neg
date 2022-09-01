package de.uni_tuebingen.ub.nppm.util;

import java.io.*;
import javax.servlet.http.*;

public class Language {

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
}
