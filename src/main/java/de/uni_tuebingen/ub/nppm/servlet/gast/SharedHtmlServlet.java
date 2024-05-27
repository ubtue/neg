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

       String myFile = request.getParameter("sharedHtml");
       String selectedLanguage = (String) request.getSession().getAttribute("Sprache");


        try {
            // Holen des Inhalts aus der Datenbank basierend auf dem Namen
            Content content = ContentDB.getByNameAndLanguage(myFile, selectedLanguage);

            if (content != null) {
                response.setContentType("text/html; charset=UTF-8");

                // Verwenden des PrintWriter, um den Inhalt zu senden
                PrintWriter writer = response.getWriter();
                byte[] htmlBytes = content.getContent();
                writer.write(new String(htmlBytes, "UTF-8"));
                writer.flush();
            }
            // Setzen des Content-Typs

        } catch (Exception e) {
            // Verwende PrintWriter, um die Fehlermeldung zu senden
            PrintWriter writer = response.getWriter();
            writer.write("Error: " + e.getMessage());
            writer.flush();
        }

    }

}
