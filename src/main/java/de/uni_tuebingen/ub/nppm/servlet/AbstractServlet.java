package de.uni_tuebingen.ub.nppm.servlet;

import de.uni_tuebingen.ub.nppm.db.DatenbankDB;
import de.uni_tuebingen.ub.nppm.exception.IdInvalidException;
import de.uni_tuebingen.ub.nppm.util.*;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public abstract class AbstractServlet extends HttpServlet {

    protected HttpServletRequest currentRequest;
    protected HttpServletResponse currentResponse;

    protected void initRequest(HttpServletRequest request) throws Exception {
        Language.setLanguage(request);
    }

    protected void addResponseHeader(HttpServletRequest request, HttpServletResponse response) throws Exception {
        RequestDispatcher rd = request.getRequestDispatcher(getHeaderTemplate());
        request.setAttribute("title", DatenbankDB.getLabel(Language.getLanguage(request), getTitle(), "Titel"));
       // request.setAttribute("navigationTitle", getNavigationTitle());
       request.setAttribute("navigationTitle", getDynamicNavigationTitle(request, response));

        // Zugriff auf ServletContext für Dateipfade
        ServletContext context = request.getServletContext();

        List<String> cssList = getAdditionalCss();
        StringBuilder additionalCss = new StringBuilder();

        for (String cssPath : cssList) {
            String fullHref;

            if (cssPath.startsWith("http")) {
                // Externe CSS-Dateien ohne Modifikation übernehmen
                fullHref = cssPath;
            } else {
                // Interner CSS-Pfad Cache-Busting über Timestamp

                String resolvedPath;

                // Wenn Pfad mit "/" beginnt, ist er bereits absolut
                if (cssPath.startsWith("/")) {
                    resolvedPath = cssPath;
                } else {
                    // Relativer Pfad in Kontextpfad umwandeln
                    String currentPath = request.getServletPath(); // z. B. /seite/index.jsp
                    resolvedPath = currentPath.replaceAll("/[^/]*$", "/") + cssPath;
                }

                // Timestamp ermitteln (echter lastModified oder aktueller Fallback)
                long timestamp = Utils.getLastModifiedTimestampForCSS(context, resolvedPath);

                // URL mit Base-Pfad und Versionstimestamp aufbauen
                fullHref = Utils.getBaseUrl(request) + resolvedPath + "?v=" + timestamp;
            }

            // <link>-Tag hinzufügen
            additionalCss.append("<link rel=\"stylesheet\" href=\"");
            additionalCss.append(fullHref);
            additionalCss.append("\" type=\"text/css\">\n");
        }

        request.setAttribute("additionalCss", additionalCss.toString());

        List<String> js_list = getAdditionalJavaScript();
        String additional_js = "";
        for (String js : js_list) {
            additional_js += "<script src=\"" + js + "\" type=\"text/javascript\"></script>";
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

    // Methode mit Parametern benoetigt für dynamische Titel angabe bei sharedHtmlServlet
    protected String getTitle(HttpServletRequest request, HttpServletResponse response) {
        return getTitle();
    }

    protected String getNavigationTitle() {
        return "";
    }

   protected String getNavigationTitle(HttpServletRequest request, HttpServletResponse response) {
    // Standardmäßig rufen wir die einfache Methode auf
    return getNavigationTitle();
}

   // Wird im Header-Aufbau benutzt
protected String getDynamicNavigationTitle(HttpServletRequest request, HttpServletResponse response) {
    return getNavigationTitle(request, response);
}

    abstract protected void generatePage(HttpServletRequest request, HttpServletResponse response) throws Exception, IdInvalidException;

    abstract protected String getHeaderTemplate();

    abstract protected String getFooterTemplate();

    protected void processRequest(HttpServletRequest request, HttpServletResponse response) throws Exception, IdInvalidException {

        this.currentRequest = request;
        this.currentResponse = response;
        // Since the header is very large using the UB navigation,
        // we need to increase the buffer size so no packages will be sent
        // during rendering the navigation. Else it would not be possible to
        // send a redirect when rendering the content, e.g. if "gast/einzelbeleg" page is called
        // without an ID.
        response.setBufferSize(1024*1024);
        request.setCharacterEncoding("UTF-8");
        initRequest(request);
        response.setContentType("text/html; charset=UTF-8");
        response.setCharacterEncoding("UTF-8");
        addResponseHeader(request, response);
        generatePage(request, response);
        addResponseFooter(request, response);
    }

   protected void doHelper(HttpServletRequest request, HttpServletResponse response) throws ServletException {
    try {
        processRequest(request, response);
    } catch (IdInvalidException e) {
        throw new ServletException(e);
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
