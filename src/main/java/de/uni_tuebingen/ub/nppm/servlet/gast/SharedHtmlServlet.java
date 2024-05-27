package de.uni_tuebingen.ub.nppm.servlet.gast;

import de.uni_tuebingen.ub.nppm.db.ContentDB;
import de.uni_tuebingen.ub.nppm.model.Content;
import java.io.OutputStream;
import java.io.PrintWriter;

import javax.persistence.NoResultException;
import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class SharedHtmlServlet extends AbstractGastServlet {

    @Override
    protected String getTitle() {

        return "ziele";
    }

    @Override
    protected void generatePage(HttpServletRequest request, HttpServletResponse response) throws Exception {

        // Überprüfen, ob eine neue Sprache ausgewählt wurde und in der Session speichern
        String newLanguage = request.getParameter("language");
        if (newLanguage != null && !newLanguage.isEmpty()) {
            request.getSession().setAttribute("Sprache", newLanguage);
        }

        // Sprache aus der Session holen
        String selectedLanguage = (String) request.getSession().getAttribute("Sprache");

        // Wenn keine Sprache in der Session gespeichert ist, eine Standardsprache setzen
        if (selectedLanguage == null) {
            selectedLanguage = "de"; // Standard: Deutsch
            request.getSession().setAttribute("Sprache", selectedLanguage);
        }

        // HTML-Dateiname aus der Anfrage holen und .html anhängen, wenn nötig
        String myFile = request.getParameter("sharedHtml");
        if (myFile != null && !myFile.endsWith(".html")) {
            myFile += ".html";
        }

        try {
            // Inhalt aus der Datenbank basierend auf dem Dateinamen und der Sprache holen
            Content content = ContentDB.getByNameAndLanguage(myFile, selectedLanguage);

            if (content != null) {
                response.setContentType("text/html; charset=UTF-8");

                // Inhalt senden
                PrintWriter writer = response.getWriter();
                byte[] htmlBytes = content.getContent();
                writer.write(new String(htmlBytes, "UTF-8"));
                writer.flush();
            }

        } catch (Exception e) {
            // Fehlerbehandlung benutze Standard Sprache Deutsch, da für nicht alle wie Hilfe.html eine Englische Version Vorhanden ist
            Content content = ContentDB.getByNameAndLanguage(myFile, "de");

            response.setContentType("text/html; charset=UTF-8");
            PrintWriter writer = response.getWriter();
            byte[] htmlBytes = content.getContent();
            writer.write(new String(htmlBytes, "UTF-8"));
            writer.flush();
        }
    }

}