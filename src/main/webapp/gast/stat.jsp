<%@page import="de.uni_tuebingen.ub.nppm.db.*"%>
<%@page import="de.uni_tuebingen.ub.nppm.model.*"%>
<%@page import="de.uni_tuebingen.ub.nppm.util.*"%>
<%@page import="java.util.*"%>
<%
    /*Set filterTitle for Quelle*/
    String filterTitle = "";
    if (request.getParameter("filterTitle") != null) {
       filterTitle = request.getParameter("filterTitle");
    }
    String sort = "";
    if (request.getParameter("sort") != null) {
       sort = request.getParameter("sort");
    }
    /*
    Calcualtion for pagination
     */
    int currentPage = 1;

    if (request.getParameter("currentPage") != null) {
        currentPage = Integer.parseInt(request.getParameter("currentPage"));
    }

    int recordsPerPage = Constants.RECORDS_PER_PAGE;

    if (request.getParameter("recordsPerPage") != null) {
        recordsPerPage = Integer.parseInt(request.getParameter("recordsPerPage"));
    }

    int rows = QuelleDB.countStat(filterTitle).intValue();

    int nOfPages = rows / recordsPerPage;

    if (nOfPages % recordsPerPage > 0) {
        nOfPages++;
    }
    
    List<Quelle> lst = QuelleDB.getList(currentPage, recordsPerPage,filterTitle,sort);
%>
<%!
        
    /*
    Functions that helps to print pagination
     */
    public String html_prev_button(String filterTitle, String recordsPerPage, Integer currentPage, String sort) {
        return "<li class=\"page-item\"><a class=\"page-link\" href=\"?sort="+sort+"&page=anzahl_belege&filterTitle=" + filterTitle + "&recordsPerPage=" + recordsPerPage + "&currentPage=" + (currentPage - 1) + "\">Previous</a></li>";
    }

    public String html_next_button(String filterTitle, String recordsPerPage, Integer currentPage, String sort) {
        return "<li class=\"page-item\"><a class=\"page-link\"href=\"?sort="+sort+"&page=anzahl_belege&filterTitle=" + filterTitle + "&recordsPerPage=" + recordsPerPage + "&currentPage=" + (currentPage + 1) + "\">Next</a></li>";
    }

    public String html_page_item_current(int page) {
        return "<li class=\"page-item active\"><a class=\"page-link\">" + page + "</a></li>";
    }

    public String html_page_item(int page, String filterTitle, int recordsPerPage, String sort) {
        return "<li class=\"page-item\"><a class=\"page-link\"href=\"?sort="+sort+"&page=anzahl_belege&filterTitle=" + filterTitle + "&recordsPerPage=" + recordsPerPage + "&currentPage=" + page + "\">" + page + "</a></li>";
    }

    public String html_sort_title_up(int page, String filterTitle, int recordsPerPage) {
        return "<a class=\"sort-link\"href=\"?sort=titleUp&page=anzahl_belege&filterTitle=" + filterTitle + "&recordsPerPage=" + recordsPerPage + "&currentPage=" + page + "\">sort up</a>";
    }

    public String html_sort_title_down(int page, String filterTitle, int recordsPerPage) {
        return "<a class=\"sort-link\"href=\"?sort=titleDown&page=anzahl_belege&filterTitle=" + filterTitle + "&recordsPerPage=" + recordsPerPage + "&currentPage=" + page + "\">sort down</a>";
    }

    public String html_sort_id_up(int page, String filterTitle, int recordsPerPage) {
        return "<a class=\"sort-link\"href=\"?sort=idUp&page=anzahl_belege&filterTitle=" + filterTitle + "&recordsPerPage=" + recordsPerPage + "&currentPage=" + page + "\">sort up</a>";
    }

    public String html_sort_id_down(int page, String filterTitle, int recordsPerPage) {
        return "<a class=\"sort-link\"href=\"?sort=idDown&page=anzahl_belege&filterTitle=" + filterTitle + "&recordsPerPage=" + recordsPerPage + "&currentPage=" + page + "\">sort down</a>";
    }

    public void print_pagination(JspWriter out, int currentPage, int recordsPerPage, String filterTitle, int nOfPages, String sort) throws Exception {
        out.println("<nav aria-label=\"Navigation for rows\">");
        out.println("<ul class=\"pagination\">");

        /*Print Previous Button*/
        if (currentPage != 1) {
            out.println(html_prev_button(filterTitle, String.valueOf(recordsPerPage), currentPage,sort));
        }

        /*Print Pages and highlight current page*/
        for (int i = 1; i <= nOfPages; i++) {
            if (currentPage == i) {
                out.println(html_page_item_current(i));
            } else {
                out.println(html_page_item(i, filterTitle, recordsPerPage,sort));
            }
        }

        /*Print Next Button*/
        if (currentPage < nOfPages) {
            out.println(html_next_button(filterTitle, String.valueOf(recordsPerPage), currentPage,sort));
        }
        out.println("</ul>");
        out.println("</nav>");
    }
%>
<p>
        
    <h1>Statistik</h1>
    <a href="/neg/gast/stat">Zurück zur Übersicht</a>
    <br><br>
    <h3>Liste der Quellen mit Anzahl der Belege
    </h3>
    <br>
    <%
        print_pagination(out, currentPage, recordsPerPage, filterTitle, nOfPages,sort);
    %> 
    <table id="stat1" class="statTable">
        <thead>        
            <th>
                <b>ID</b><br>
                <%
                    out.println(html_sort_id_up(currentPage, filterTitle, recordsPerPage));
                    out.println(html_sort_id_down(currentPage, filterTitle, recordsPerPage));
                %>
            </th>
            <th>
                <b>Titel der Quelle</b>
                <form method="GET">
                    <input name="filterTitle" type="text" size="40" value="<%=filterTitle %>" placeholder="Titel Filter"/>
                    <input name="page" type="hidden" value="anzahl_belege"/>
                    <input name="sort" type="hidden" value="<%=sort %>"/>
                    <input type="submit" />
                </form>
                <%
                    out.println(html_sort_title_up(currentPage, filterTitle, recordsPerPage));
                    out.println(html_sort_title_down(currentPage, filterTitle, recordsPerPage));
                %>
            </th>
            <th>
                <b>Anzahl Belege</b>
            </th>
        </thead>
       <tbody>
            <%
            for (Quelle q : lst) {
                out.print("<tr>");
                out.print("<td>");
                out.print(Utils.escapeHTML(String.valueOf(q.getId())));
                out.print("</td>");
                out.print("<td>");
                out.print(Utils.escapeHTML(q.getBezeichnung()));
                out.print("</td>");
                out.print("<td>");
                out.print(EinzelbelegDB.countEinzelbelegByQuelleId(q.getId()));
                out.print("</td>");
                out.print("</tr>");
            }
            %>
        </tbody>
    </table>
    
    <%
        print_pagination(out, currentPage, recordsPerPage, filterTitle, nOfPages,sort);
    %>
</p>