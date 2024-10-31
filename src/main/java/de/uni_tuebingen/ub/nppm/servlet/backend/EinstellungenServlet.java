package de.uni_tuebingen.ub.nppm.servlet.backend;

import de.uni_tuebingen.ub.nppm.db.BenutzerDB;
import de.uni_tuebingen.ub.nppm.db.DatenbankDB;
import de.uni_tuebingen.ub.nppm.model.Benutzer;
import de.uni_tuebingen.ub.nppm.util.AuthHelper;
import de.uni_tuebingen.ub.nppm.util.SaltHash;
import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class EinstellungenServlet extends AbstractBackendServlet {

    String errorMessage = "";
    boolean actionDone = false;
    boolean actionNotDone = false;

    @Override
    protected String getTitle() {
        return "einstellungen";
    }

    @Override
    protected void generatePage(HttpServletRequest request, HttpServletResponse response) throws Exception {
        HttpSession session = request.getSession();

        if (session.getAttribute("BenutzerID") != null && ((Integer) session.getAttribute("BenutzerID")).intValue() > 0) {

            if (request.getParameter("save") != null && request.getParameter("save").equals(DatenbankDB.getLabel((String) session.getAttribute("Sprache"), "navigation", "Speichern"))) {
                settings(request, response, session);
            } else if (request.getParameter("password") != null && request.getParameter("password").equals(DatenbankDB.getLabel((String) session.getAttribute("Sprache"), "navigation", "Speichern"))) {
                changePassword(request, response, session);
            }

            request.setAttribute("errorMessage", errorMessage);
            request.setAttribute("actionDone", actionDone);
            request.setAttribute("actionNotDone", actionNotDone);

            actionDone = false;
            actionNotDone = false;
        }

        RequestDispatcher rd = request.getRequestDispatcher("einstellungen.jsp");
        rd.include(request, response);
    }

    private void settings(HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {

        if (request.getParameter("action") != null) {
            errorMessage = "wrongCall";

            int benutzerID = ((Integer) session.getAttribute("BenutzerID")).intValue();
            Benutzer benutzer = BenutzerDB.getById(benutzerID);
            boolean isAdmin = benutzer.isAdmin();
            if (isAdmin && request.getParameter("ID") != null) {
                benutzerID = Integer.parseInt(request.getParameter("ID"));
                benutzer = BenutzerDB.getById(benutzerID);
            }

            if (request.getParameter("action").equals("Einstellungen")) {

                if (request.getParameter("email").equals("")) {
                    errorMessage = "noEmail";
                    actionNotDone = true;
                } else {
                    benutzer.setEMail(request.getParameter("email"));
                    benutzer.setSprache(request.getParameter("Sprache"));
                    benutzer.setLogin(request.getParameter("Benutzername"));
                    benutzer.setVorname(request.getParameter("Vorname"));
                    benutzer.setNachname(request.getParameter("Nachname"));
                    benutzer.setAdmin("on".equals(request.getParameter("Administrator")));
                    benutzer.setAktiv(request.getParameter("Aktiv") != null && request.getParameter("Aktiv").equals("on"));
                    BenutzerDB.saveOrUpdate(benutzer);
                    actionDone = true;
                }
            }
        }
    }

    private void changePassword(HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {

        if (request.getParameter("action") != null) {

            int benutzerID = ((Integer) session.getAttribute("BenutzerID")).intValue();
            Benutzer benutzer = BenutzerDB.getById(benutzerID);
            boolean isAdmin = benutzer.isAdmin();
            if (isAdmin && request.getParameter("ID") != null) {
                benutzerID = Integer.parseInt(request.getParameter("ID"));
                benutzer = BenutzerDB.getById(benutzerID);
            }

            if (!isAdmin && (request.getParameter("PasswortAlt") == null || request.getParameter("PasswortAlt").equals(""))) {
                errorMessage = "passwordOldEmpty";
                actionNotDone = true;
            } else if (request.getParameter("PasswortNeu") == null || request.getParameter("PasswortNeu").equals("")) {
                errorMessage = "passwordNewEmpty";
                actionNotDone = true;
            } else if (request.getParameter("PasswortNeuWdh") == null || request.getParameter("PasswortNeuWdh").equals("")) {
                errorMessage = "passwordNewReplayEmpty";
                actionNotDone = true;
            } else if (!request.getParameter("PasswortNeu").equals(request.getParameter("PasswortNeuWdh"))) {
                errorMessage = "passwordNewNotEqual";
                actionNotDone = true;
            } else {
                String newPassword = request.getParameter("PasswortNeu");
                String algorithm = AuthHelper.getPasswordHashingAlgorithm();

                boolean isOldPasswordCorrect = false;

                if (!isAdmin) {
                    String oldSaltString = benutzer.getSalt();
                    byte[] oldSaltBytes = SaltHash.Base64StringToBytes(oldSaltString);
                    String oldPassword = request.getParameter("PasswortAlt");
                    String oldPasswordHash = SaltHash.GenerateHash(oldPassword, algorithm, oldSaltBytes);
                    String oldDbPasswordHash = benutzer.getPassword();
                    if (!oldPasswordHash.equals(oldDbPasswordHash)) {

                        errorMessage = "passwordOldWrong";
                        actionNotDone = true;

                    } else {
                        isOldPasswordCorrect = true;
                    }
                }

                if (isAdmin || isOldPasswordCorrect) {
                    byte[] newSaltBytes = SaltHash.GenerateRandomSalt(AuthHelper.getPasswordSaltLength());
                    String newSaltString = SaltHash.BytesToBase64String(newSaltBytes);
                    String newPasswordHash = SaltHash.GenerateHash(newPassword, algorithm, newSaltBytes);
                    benutzer.setPassword(newPasswordHash);
                    benutzer.setSalt(newSaltString);
                    BenutzerDB.saveOrUpdate(benutzer);
                    actionDone = true;
                }
            }
        }
    }
}
