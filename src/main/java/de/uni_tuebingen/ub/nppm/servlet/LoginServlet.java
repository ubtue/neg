package de.uni_tuebingen.ub.nppm.servlet;

import java.io.IOException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import de.uni_tuebingen.ub.nppm.db.BenutzerDB;
import de.uni_tuebingen.ub.nppm.model.Benutzer;
import de.uni_tuebingen.ub.nppm.util.AuthHelper;
import de.uni_tuebingen.ub.nppm.util.SaltHash;
import de.uni_tuebingen.ub.nppm.util.Utils;

public class LoginServlet extends HttpServlet {

    protected void processLoginAction(HttpServletRequest request, HttpServletResponse response) throws Exception {
        String login = request.getParameter("username");
        String password = request.getParameter("password");

        if (login == null || login.isEmpty() || !BenutzerDB.hasLogin(login)) {
            response.sendError(HttpServletResponse.SC_UNAUTHORIZED, "Benutzer existiert nicht");
        } else {
            Benutzer benutzer = BenutzerDB.getByLogin(login);
            String saltString = benutzer.getSalt();
            if (saltString == null || saltString.isEmpty()) {
                response.sendError(HttpServletResponse.SC_UNAUTHORIZED, "Die Sicherheit der Datenbank wurde verbessert. Das Password muss neu gesetzt werden. <a href=\"" + Utils.getBaseUrl(request) + "/forgotPassword\">Neuen Link generieren</a>");
            } else {
                byte[] saltBytes = SaltHash.Base64StringToBytes(saltString);
                String passwordSalted = SaltHash.GenerateHash(password, AuthHelper.getPasswordHashingAlgorithm(), saltBytes);
                if (!passwordSalted.equals(benutzer.getPassword())) {
                    response.sendError(HttpServletResponse.SC_UNAUTHORIZED, "Ungültiges Passwort.");
                } else {
                    // Falls Session vorhanden, löschen
                    HttpSession session = request.getSession();
                    if (session != null) {
                        session.invalidate();
                    }

                    // Neue Session erzeugen
                    session = request.getSession(true);
                    session.setAttribute("BenutzerID", benutzer.getID());
                    session.setAttribute("GruppeID", benutzer.getGruppe().getID());
                    session.setAttribute("Benutzername", benutzer.getLogin());
                    session.setAttribute("Administrator", benutzer.isAdmin());
                    session.setAttribute("Gast", benutzer.isGast());
                    session.setAttribute("Sprache", benutzer.getSprache());
                    session.setMaxInactiveInterval(AuthHelper.getSessionTimeout());

                    // Weiterleiten
                    if ((Boolean) session.getAttribute("Gast")) {
                        response.sendRedirect("gast/startseite");
                    } else {
                        response.sendRedirect("einzelbeleg");
                    }
                }
            }
        }
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response) throws IOException {
        try {
            if (AuthHelper.isBenutzerLogin(request)) {
                response.sendRedirect("einzelbeleg");
            } else if (AuthHelper.isGastLogin(request)) {
                response.sendRedirect("gast/startseite");
            } else if (request.getParameter("action") != null) {
                if (request.getParameter("action").equals("login")) {
                    processLoginAction(request, response);
                }
            } else {
                if (request.getParameter("language") != null) {
                    HttpSession session = request.getSession(true);
                    session.setAttribute("Sprache", request.getParameter("language"));
                    session.setMaxInactiveInterval(AuthHelper.getSessionTimeout());
                }

                RequestDispatcher rd = request.getRequestDispatcher("login.jsp");
                rd.include(request, response);
            }
        } catch (Exception e) {
            response.sendError(500, e.getMessage());
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        processRequest(request, response);
    }


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        processRequest(request, response);
    }
}
