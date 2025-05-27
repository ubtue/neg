<%@page import="java.io.IOException"%>
<%@page import="java.util.List"%>
<%@page import="de.uni_tuebingen.ub.nppm.db.*"%>
<%@page import="de.uni_tuebingen.ub.nppm.util.Language"%>
<%@ include file="../../configuration.jsp" %>

<%!
public void printPageNavigation(JspWriter out, HttpServletRequest request, int pageoffset, int pageLimit, int linecount, String export, String title) throws Exception, IOException {
    if (!"liste".equals(export) && !"browse".equals(export)) return;

    List<Integer> publicIds;
    if ("person".equals(title)) {
        publicIds = PersonDB.getAllPublicPersonIds();
    } else if("einzelbeleg".equals(title)) {
        publicIds = EinzelbelegDB.getAllPublicEinzelbelegIds();
    } else if("quelle".equals(title)) {
        publicIds = QuelleDB.getAllPublicQuellenIds();
    }  else if("mgh_lemma".equals(title)) {
        publicIds = LemmaDB.getAllPublicLemmaIds();
    }
    else {
        return;
    }

    int totalPages = publicIds.size();
    int currentId = Integer.parseInt(request.getParameter("ID"));

    // Finde die aktuelle Position in der Liste
    int currentIndex = publicIds.indexOf(currentId);
    if (currentIndex == -1) currentIndex = 0;

    out.println("<div class=\"resultlistnavigation\" align=\"center\">");

    // Previous
    if (currentIndex > 0) {
        int prevID = publicIds.get(currentIndex - 1);
        out.print("<button class=\"ut-btn ut-btn--color-primary-3 prev-button\" onclick=\"window.location.href='?ID=" + prevID + "';\">Previous</button>&nbsp;");
    }

    // Page numbers
    for (int i = 0; i < totalPages; i++) {
        if (i == 0 && i <= currentIndex - 10) {
            int pageID = publicIds.get(i);
            out.print("<button class=\"ut-btn ut-btn--color-primary-2 page-button\" onclick=\"window.location.href='?ID=" + pageID + "';\">1</button>&nbsp;...&nbsp;");
        }

        if (i < currentIndex + 10 && i > currentIndex - 10) {
            int pageID = publicIds.get(i);
            if (i == currentIndex) {
                out.print("<button class=\"ut-btn ut-btn--color-primary-1 current-button\" disabled>");
                out.print((i + 1));
                out.print("</button>&nbsp;");
            } else {
                out.print("<button class=\"ut-btn ut-btn--color-primary-2 page-button\" onclick=\"window.location.href='?ID=" + pageID + "';\">");
                out.print((i + 1));
                out.print("</button>&nbsp;");
            }
        }

        if (i == totalPages - 1 && i >= currentIndex + 10) {
            int pageID = publicIds.get(i);
            out.print("...&nbsp;<button class=\"ut-btn ut-btn--color-primary-2 page-button\" onclick=\"window.location.href='?ID=" + pageID + "';\">");
            out.print((i + 1));
            out.print("</button>&nbsp;");
        }
    }

    // Next
    if (currentIndex < totalPages - 1) {
        int nextID = publicIds.get(currentIndex + 1);
        out.print("<button class=\"ut-btn ut-btn--color-primary-3 next-button\" onclick=\"window.location.href='?ID=" + nextID + "';\">Next</button>");
    }

    out.println("</div>");
}
%>

<%    int id = -1;
    String title = "gast_" + request.getParameter("title").toLowerCase();

    String guest = "";
    String sql_max = "";
    String sql_akt = "";

    if (title != null && title.contains("gast_")) {
        title = title.substring(5);
        guest = "gast_";
    }

    int akt = 0;
    int max = 0;

    //Filter berechnen
    session = request.getSession(true);
    int filter = 0;
    String filterParameter = null;
    try {
        filter = ((Integer) session.getAttribute("filter")).intValue();
        filterParameter = (String) session.getAttribute("filterParameter");
    } catch (Exception e) {
    }

    try {
        id = Integer.parseInt(request.getParameter("ID"));
    } catch (NumberFormatException e) {
    }

    if (title != null && !title.equals("") && id > 0) {
        // SQL generieren
        sql_max = DatenbankDB.getFilterSql(guest + title, filter);
        sql_max = sql_max.replace("*", "count(*) c");
        sql_max = sql_max.replace("###", filterParameter != null ? filterParameter : "");

        sql_akt = sql_max + (sql_max.contains("WHERE") ? " AND " : " WHERE ") + title + ".ID < " + id;

        try {
            akt = AbstractBase.getIntNative(sql_akt) + 1;
            max = AbstractBase.getIntNative(sql_max);
        } catch (Exception e) {
            akt = 0;
            max = 0;
        }
    }


    int pageoffset = 0;
    if (request.getParameter("pageoffset") != null) {
        pageoffset = Integer.parseInt(request.getParameter("pageoffset"));
    }

    String export = "browse";

    printPageNavigation(out, request, pageoffset, pageLimit, max, export, title);
%>
