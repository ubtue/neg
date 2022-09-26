package de.uni_tuebingen.ub.nppm.servlet;

import de.uni_tuebingen.ub.nppm.db.DatenbankDB;
import de.uni_tuebingen.ub.nppm.util.*;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public abstract class AbstractServlet extends HttpServlet {
    public void initRequest(HttpServletRequest request) {
        Language.setLanguage(request);
    }

    protected void addResponseHeader(HttpServletRequest request, HttpServletResponse response, String Titel) throws Exception {
        RequestDispatcher rd = request.getRequestDispatcher(getHeaderTemplate());
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
        RequestDispatcher rd = request.getRequestDispatcher(getFooterTemplate());
        rd.include(request, response);
    }

    protected List<String> getAdditionalCss() {
        return new ArrayList<>();
    }

    abstract protected String getTitle();
    abstract protected void processRequest(HttpServletRequest request, HttpServletResponse response) throws Exception;
    abstract protected String getHeaderTemplate();
    abstract protected String getFooterTemplate();

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
