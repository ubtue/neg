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
    protected void initRequest(HttpServletRequest request) throws Exception {
        Language.setLanguage(request);
    }

    protected void addResponseHeader(HttpServletRequest request, HttpServletResponse response) throws Exception {
        RequestDispatcher rd = request.getRequestDispatcher(getHeaderTemplate());
        request.setAttribute("title", DatenbankDB.getLabel(Language.getLanguage(request), getTitle(), "Titel"));
        request.setAttribute("navigationTitle", getNavigationTitle());

        List<String> css_list = getAdditionalCss();
        String additional_css = "";
        for (String css : css_list) {
            additional_css += "<link rel=\"stylesheet\" href=\"" + css + "\" type=\"text/css\">";
        }
        request.setAttribute("additionalCss", additional_css);

        List<String> js_list = getAdditionalJavaScript();
        String additional_js = "";
        for (String js : js_list) {
            additional_js += "<script src=\""+js+"\" type=\"text/javascript\"></script>";
        }
        request.setAttribute("additionalJs", additional_js);

        rd.include(request, response);
    }

    protected void addResponseFooter(HttpServletRequest request, HttpServletResponse response) throws Exception {
        RequestDispatcher rd = request.getRequestDispatcher(getFooterTemplate());
        rd.include(request, response);
    }

    protected List<String> getAdditionalCss() {
        return new ArrayList<>();
    }

     protected List<String> getAdditionalJavaScript() {
        return new ArrayList<>();
    }

    abstract protected String getTitle();
    protected String getNavigationTitle() {
        return "";
    }

    abstract protected void generatePage(HttpServletRequest request, HttpServletResponse response) throws Exception;
    abstract protected String getHeaderTemplate();
    abstract protected String getFooterTemplate();

    protected void processRequest(HttpServletRequest request, HttpServletResponse response) throws Exception {
        initRequest(request);
        addResponseHeader(request, response);
        generatePage(request, response);
        addResponseFooter(request, response);
    }

    protected void doHelper(HttpServletRequest request, HttpServletResponse response) throws ServletException {
        try {
            processRequest(request, response);
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doHelper(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doHelper(request, response);
    }
}
