package de.uni_tuebingen.ub.nppm.servlet.gast;

import de.uni_tuebingen.ub.nppm.db.DatenbankDB;
import de.uni_tuebingen.ub.nppm.servlet.AbstractServlet;
import de.uni_tuebingen.ub.nppm.util.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.RequestDispatcher;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;



public abstract class AbstractGastServlet extends AbstractServlet {
    protected void addResponseHeader(HttpServletRequest request, HttpServletResponse response, String Titel) throws Exception {
        RequestDispatcher rd = request.getRequestDispatcher("servlet/header.jsp");
        request.setAttribute("title", DatenbankDB.getLabel(Language.getLanguage(request), Titel, "Titel"));

        List<String> css_list = getAdditionalCss();
        String additional_css = "";
        for (String css : css_list) {
            additional_css += "<link rel=\"stylesheet\" href=\"" + css + "\" type=\"text/css\">";
        }
        request.setAttribute("additionalCss", additional_css);

        rd.include(request, response);
    }

    protected void addResponseFooter(HttpServletRequest request, HttpServletResponse response) throws Exception {
        RequestDispatcher rd = request.getRequestDispatcher("servlet/footer.jsp");
        rd.include(request, response);
    }

    protected List<String> getAdditionalCss() {
        return new ArrayList<>();
    }

    abstract protected String getTitle();
    abstract protected void processRequest(HttpServletRequest request, HttpServletResponse response) throws Exception;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            this.initRequest(request);
            this.addResponseHeader(request, response, getTitle());
            this.processRequest(request, response);
            this.addResponseFooter(request, response);
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }
}
