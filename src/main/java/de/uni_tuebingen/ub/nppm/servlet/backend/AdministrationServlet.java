package de.uni_tuebingen.ub.nppm.servlet.backend;

import de.uni_tuebingen.ub.nppm.db.BenutzerDB;
import de.uni_tuebingen.ub.nppm.model.Benutzer;
import de.uni_tuebingen.ub.nppm.model.BenutzerGruppe;
import de.uni_tuebingen.ub.nppm.util.AuthHelper;
import de.uni_tuebingen.ub.nppm.util.SaltHash;
import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class AdministrationServlet extends AbstractBackendServlet {

    @Override
    protected String getTitle() {
        return "administration";
    }

    @Override
    protected boolean isAdminRequired() {
        return true;
    }

    @Override
    protected void generatePage(HttpServletRequest request, HttpServletResponse response) throws Exception {

        String createMessage = "";
        String errorMessage = "";

        if (request.getParameter("actionCreate") != null && request.getParameter("actionCreate").equals("anlegen")) {

            boolean fehler = false;

            if (request.getParameter("Benutzername").equals("")) {
                errorMessage = "<p><b>Fehler:</b> Benutzername ist leer</p>";
                fehler = true;
            } else if (BenutzerDB.hasLogin(request.getParameter("Benutzername"))) {
                errorMessage = "<p><b>Fehler:</b> Benutzername ist bereits vorhanden</p>";
                fehler = true;
            } else if (request.getParameter("Nachname").equals("")) {
                errorMessage = "<p><b>Fehler:</b> Nachname ist leer</p>";
                fehler = true;
            } else if (request.getParameter("Vorname").equals("")) {
                errorMessage = "<p><b>Fehler:</b> Vorname ist leer</p>";
                fehler = true;
            } else if (request.getParameter("EMail").equals("")) {
                errorMessage = "<p><b>Fehler:</b> E-Mail ist leer</p>";
                fehler = true;
            } else if (request.getParameter("Kennwort").equals("")) {
                errorMessage = "<p><b>Fehler:</b> Kennwort ist leer</p>";
                fehler = true;
            }

            if (fehler) {
                request.setAttribute("errorCreate", fehler);
                request.setAttribute("errorMessage", errorMessage);
            } else {
                String password = request.getParameter("Kennwort");

                byte[] salt = SaltHash.GenerateRandomSalt(AuthHelper.getPasswordSaltLength());
                password = SaltHash.GenerateHash(password, AuthHelper.getPasswordHashingAlgorithm(), salt);
                String saltValue = SaltHash.BytesToBase64String(salt);

                BenutzerGruppe gruppe = BenutzerDB.getGruppeById(Integer.parseInt(request.getParameter("Projektgruppe")));

                Benutzer benutzer = new Benutzer();
                benutzer.setLogin(request.getParameter("Benutzername"));
                benutzer.setNachname(request.getParameter("Nachname"));
                benutzer.setVorname(request.getParameter("Vorname"));
                benutzer.setEMail(request.getParameter("EMail"));
                benutzer.setPassword(password);
                benutzer.setSalt(saltValue);
                benutzer.setSprache(request.getParameter("Sprache"));
                benutzer.setAdmin(request.getParameter("Administrator") != null && request.getParameter("Administrator").equals("on"));
                benutzer.setGruppe(gruppe);
                benutzer.setAktiv(true);

                BenutzerDB.saveOrUpdate(benutzer);
            }

            createMessage = "anlegen";
            request.setAttribute("createMessage", createMessage);
        }

        RequestDispatcher rd = request.getRequestDispatcher("administration.jsp");
        rd.include(request, response);
    }
}
