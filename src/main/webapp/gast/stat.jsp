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
    /*
    Calcualtion for pagination of source rows
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
    
    List<Quelle> lst = QuelleDB.getList(currentPage, recordsPerPage,filterTitle);
%>
<%!
        
    /*
    Functions that helps to print pagination
     */
    public String html_prev_button(String filterTitle, String recordsPerPage, Integer currentPage) {
        return "<li class=\"page-item\"><a class=\"page-link\" href=\"?page=anzahl_belege&filterTitle=" + filterTitle + "&recordsPerPage=" + recordsPerPage + "&currentPage=" + (currentPage - 1) + "\">Previous</a></li>";
    }

    public String html_next_button(String filterTitle, String recordsPerPage, Integer currentPage) {
        return "<li class=\"page-item\"><a class=\"page-link\"href=\"?page=anzahl_belege&filterTitle=" + filterTitle + "&recordsPerPage=" + recordsPerPage + "&currentPage=" + (currentPage + 1) + "\">Next</a></li>";
    }

    public String html_page_item_current(int page) {
        return "<li class=\"page-item active\"><a class=\"page-link\">" + page + "</a></li>";
    }

    public String html_page_item(int page, String filterTitle, int recordsPerPage) {
        return "<li class=\"page-item\"><a class=\"page-link\"href=\"?page=anzahl_belege&filterTitle=" + filterTitle + "&recordsPerPage=" + recordsPerPage + "&currentPage=" + page + "\">" + page + "</a></li>";
    }

    public void print_pagination(JspWriter out, int currentPage, int recordsPerPage, String filterTitle, int nOfPages) throws Exception {
        out.println("<nav aria-label=\"Navigation for rows\">");
        out.println("<ul class=\"pagination\">");

        /*Print Previous Button*/
        if (currentPage != 1) {
            out.println(html_prev_button(filterTitle, String.valueOf(recordsPerPage), currentPage));
        }

        /*Print Pages and highlight current page*/
        for (int i = 1; i <= nOfPages; i++) {
            if (currentPage == i) {
                out.println(html_page_item_current(i));
            } else {
                out.println(html_page_item(i, filterTitle, recordsPerPage));
            }
        }

        /*Print Next Button*/
        if (currentPage < nOfPages) {
            out.println(html_next_button(filterTitle, String.valueOf(recordsPerPage), currentPage));
        }
        out.println("</ul>");
        out.println("</nav>");
    }
%>
<p>
        
    <h1>Statistik</h1>
    <a href="/neg/gast/stat">Übersicht</a>
    <br>
    <h3>Liste der Quellen mit Anzahl der Belege
    </h3>
    <br>
    <%
        print_pagination(out, currentPage, recordsPerPage, filterTitle, nOfPages);
    %> 
    <table id="stat1" class="table">
        <thead>        
            <th>
                <b>ID</b>
            </th>
            <th>
                <b>Titel der Quelle</b>
                <form method="GET">
                    <input name="filterTitle" type="text" size="40" value="<%=filterTitle %>" placeholder="Titel Filter"/>
                    <input type="submit" />
                </form>
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
        print_pagination(out, currentPage, recordsPerPage, filterTitle, nOfPages);
    %>
</p>