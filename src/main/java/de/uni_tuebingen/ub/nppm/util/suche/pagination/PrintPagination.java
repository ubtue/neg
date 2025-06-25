package de.uni_tuebingen.ub.nppm.util.suche.pagination;

import de.uni_tuebingen.ub.nppm.db.EinzelbelegDB;
import de.uni_tuebingen.ub.nppm.db.LemmaDB;
import de.uni_tuebingen.ub.nppm.db.PersonDB;
import de.uni_tuebingen.ub.nppm.db.QuelleDB;
import de.uni_tuebingen.ub.nppm.util.Language;
import static de.uni_tuebingen.ub.nppm.util.Utils.urlEncode;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.util.Enumeration;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.jsp.JspWriter;

public class PrintPagination {

    // Hauptfunktion: erkennt Modus anhand von Parametern
    public static void printPageNavigation(JspWriter out, HttpServletRequest request, Integer pageoffset, Integer pageLimit, Integer linecount, String export, String title) throws Exception {
        if (!"liste".equals(export) && !"browse".equals(export)) {
            return;
        }

        List<Integer> publicIds = null;
        Integer currentId = null;
        int totalPages = 0;
        int currentIndex = 0;
        boolean useIdMode = false;

        // Modus 1: Navigation nach IDs (title != null)
        if (title != null) {
            useIdMode = true;
            switch (title) {
                case "person":
                    publicIds = PersonDB.getAllPublicPersonIds();
                    break;
                case "einzelbeleg":
                    publicIds = EinzelbelegDB.getAllPublicEinzelbelegIds();
                    break;
                case "quelle":
                    publicIds = QuelleDB.getAllPublicQuellenIds();
                    break;
                case "mgh_lemma":
                    publicIds = LemmaDB.getAllPublicLemmaIds();
                    break;
                default:
                    return;
            }
            totalPages = publicIds.size();
            try {
                currentId = Integer.parseInt(request.getParameter("ID"));
            } catch (Exception e) {
                currentId = publicIds.get(0);
            }
            currentIndex = publicIds.indexOf(currentId);
            if (currentIndex == -1) {
                currentIndex = 0;
            }
        } // Modus 2: Navigation nach Seitenoffset
        else if (pageoffset != null && pageLimit != null && linecount != null) {
            totalPages = (linecount + pageLimit - 1) / pageLimit;
            currentIndex = pageoffset;
        } else {
            return;
        }

        out.println("<div class=\"resultlistnavigation\" align=\"center\">");

        // Previous Button
        if (currentIndex > 0) {
            String prev = Language.getTextfield(request.getSession(), "pagination", "Prev");
            if (useIdMode) {
                int prevID = publicIds.get(currentIndex - 1);
                out.print("<button class=\"ut-btn ut-btn--color-primary-3 prev-button\" onclick=\"window.location.href='?ID=" + prevID + "';\">" + prev + "</button>&nbsp;");
            } else {
                String prevUrl = buildPageUrl(request, currentIndex - 1);
                out.print("<button class=\"ut-btn ut-btn--color-primary-3 prev-button\" onclick=\"window.location.href='" + prevUrl + "';\">" + prev + "</button>&nbsp;");
            }
        }

        // Page Number Buttons
        for (int i = 0; i < totalPages; i++) {
            boolean showFirstDots = i == 0 && i <= currentIndex - 10;
            boolean showLastDots = i == totalPages - 1 && i >= currentIndex + 10;
            boolean inWindow = i < currentIndex + 10 && i > currentIndex - 10;

            if (showFirstDots) {
                if (useIdMode) {
                    int pageID = publicIds.get(i);
                    out.print("<button class=\"ut-btn ut-btn--color-primary-2 page-button\" onclick=\"window.location.href='?ID=" + pageID + "';\">1</button>&nbsp;...&nbsp;");
                } else {
                    String pageUrl = buildPageUrl(request, i);
                    out.print("<button class=\"ut-btn ut-btn--color-primary-2 page-button\" onclick=\"window.location.href='" + pageUrl + "';\">1</button>&nbsp;...&nbsp;");
                }
            }

            if (inWindow) {
                if (i == currentIndex) {
                    out.print("<button class=\"ut-btn ut-btn--color-primary-1 current-button\" disabled>");
                    out.print((i + 1));
                    out.print("</button>&nbsp;");
                } else {
                    if (useIdMode) {
                        int pageID = publicIds.get(i);
                        out.print("<button class=\"ut-btn ut-btn--color-primary-2 page-button\" onclick=\"window.location.href='?ID=" + pageID + "';\">" + (i + 1) + "</button>&nbsp;");
                    } else {
                        String pageUrl = buildPageUrl(request, i);
                        out.print("<button class=\"ut-btn ut-btn--color-primary-2 page-button\" onclick=\"window.location.href='" + pageUrl + "';\">" + (i + 1) + "</button>&nbsp;");
                    }
                }
            }

            if (showLastDots) {
                if (useIdMode) {
                    int pageID = publicIds.get(i);
                    out.print("...&nbsp;<button class=\"ut-btn ut-btn--color-primary-2 page-button\" onclick=\"window.location.href='?ID=" + pageID + "';\">" + (i + 1) + "</button>&nbsp;");
                } else {
                    String pageUrl = buildPageUrl(request, i);
                    out.print("...&nbsp;<button class=\"ut-btn ut-btn--color-primary-2 page-button\" onclick=\"window.location.href='" + pageUrl + "';\">" + (i + 1) + "</button>&nbsp;");
                }
            }
        }

        // Next Button
        if (currentIndex < totalPages - 1) {
            String next = Language.getTextfield(request.getSession(), "pagination", "Next");
            if (useIdMode) {
                int nextID = publicIds.get(currentIndex + 1);
                out.print("<button class=\"ut-btn ut-btn--color-primary-3 next-button\" onclick=\"window.location.href='?ID=" + nextID + "';\">" + next + "</button>");
            } else {
                String nextUrl = buildPageUrl(request, currentIndex + 1);
                out.print("<button class=\"ut-btn ut-btn--color-primary-3 next-button\" onclick=\"window.location.href='" + nextUrl + "';\">" + next + "</button>");
            }
        }

        out.println("</div>");
    }

    // Komfortüberladung: klassischer Seitenmodus
    public static void printPageNavigation(JspWriter out, HttpServletRequest request, int pageoffset, int pageLimit, int linecount, String export) throws Exception {
        printPageNavigation(out, request, pageoffset, pageLimit, linecount, export, null);
    }

    // Komfortüberladung: klassischer ID-Modus
    public static void printPageNavigation(JspWriter out, HttpServletRequest request, String export, String title) throws Exception {
        printPageNavigation(out, request, null, null, null, export, title);
    }

    // Hilfsfunktion: baut Seiten-URL basierend auf Request und Ziel-Seitennummer
    private static String buildPageUrl(HttpServletRequest request, int pageoffset) {
        StringBuilder url = new StringBuilder("?pageoffset=" + pageoffset);
        for (Enumeration<String> e = request.getParameterNames(); e.hasMoreElements();) {
            String paramName = e.nextElement();
            if (!paramName.equals("pageoffset")) {
                url.append("&").append(paramName).append("=").append(URLEncoder.encode(request.getParameter(paramName), StandardCharsets.UTF_8));
            }
        }
        return url.toString();
    }
}
