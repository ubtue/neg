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
    /*Set Sort Type*/
    String sort = "";
    if (request.getParameter("sort") != null) {
       sort = request.getParameter("sort");
    }
    /*Set jumpToID for Quelle*/
    String jumpToID = "";
    if (request.getParameter("jumpToID") != null) {
       jumpToID = request.getParameter("jumpToID");
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

    //row count is 1 if users performs id search
    if(jumpToID != null && jumpToID.length() > 0){
        rows = 1;
    }
    
    int nOfPages = rows / recordsPerPage;

    if (nOfPages % recordsPerPage > 0) {
        nOfPages++;
    }
    
    List<Quelle> lst = QuelleDB.getList(currentPage, recordsPerPage,filterTitle,sort, jumpToID);
%>
<%!
        
    /*
    Functions that helps to print pagination
     */
    public String html_prev_button(String filterTitle, String recordsPerPage, Integer currentPage, String sort, String jumpToID) {
        return "<li class=\"page-item\"><a class=\"page-link\" href=\"?jumpToID="+jumpToID+"&sort="+sort+"&page=anzahl_belege&filterTitle=" + filterTitle + "&recordsPerPage=" + recordsPerPage + "&currentPage=" + (currentPage - 1) + "\">Previous</a></li>";
    }

    public String html_next_button(String filterTitle, String recordsPerPage, Integer currentPage, String sort, String jumpToID) {
        return "<li class=\"page-item\"><a class=\"page-link\"href=\"?jumpToID="+jumpToID+"&sort="+sort+"&page=anzahl_belege&filterTitle=" + filterTitle + "&recordsPerPage=" + recordsPerPage + "&currentPage=" + (currentPage + 1) + "\">Next</a></li>";
    }

    public String html_page_item_current(int page) {
        return "<li class=\"page-item active\"><a class=\"page-link\">" + page + "</a></li>";
    }

    public String html_page_item(int page, String filterTitle, int recordsPerPage, String sort, String jumpToID) {
        return "<li class=\"page-item\"><a class=\"page-link\"href=\"?jumpToID="+jumpToID+"&sort="+sort+"&page=anzahl_belege&filterTitle=" + filterTitle + "&recordsPerPage=" + recordsPerPage + "&currentPage=" + page + "\">" + page + "</a></li>";
    }

    public String html_sort_title_up(int page, String filterTitle, int recordsPerPage, String jumpToID) {
        return "<a class=\"sort-link\"href=\"?jumpToID="+jumpToID+"&sort=titleUp&page=anzahl_belege&filterTitle=" + filterTitle + "&recordsPerPage=" + recordsPerPage + "&currentPage=" + page + "\">sort up</a>";
    }

    public String html_sort_title_down(int page, String filterTitle, int recordsPerPage, String jumpToID) {
        return "<a class=\"sort-link\"href=\"?jumpToID="+jumpToID+"&sort=titleDown&page=anzahl_belege&filterTitle=" + filterTitle + "&recordsPerPage=" + recordsPerPage + "&currentPage=" + page + "\">sort down</a>";
    }

    public void print_pagination(JspWriter out, int currentPage, int recordsPerPage, String filterTitle, int nOfPages, String sort, String jumpToID) throws Exception {
        out.println("<nav aria-label=\"Navigation for rows\">");
        out.println("<ul class=\"pagination\">");

        /*Print Previous Button*/
        if (currentPage != 1) {
            out.println(html_prev_button(filterTitle, String.valueOf(recordsPerPage), currentPage,sort,jumpToID));
        }

        /*Print Pages and highlight current page*/
        for (int i = 1; i <= nOfPages; i++) {
            if (currentPage == i) {
                out.println(html_page_item_current(i));
            } else {
                out.println(html_page_item(i, filterTitle, recordsPerPage,sort,jumpToID));
            }
        }

        /*Print Next Button*/
        if (currentPage < nOfPages) {
            out.println(html_next_button(filterTitle, String.valueOf(recordsPerPage), currentPage,sort,jumpToID));
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
        print_pagination(out, currentPage, recordsPerPage, filterTitle, nOfPages,sort,jumpToID);
    %> 
    <table id="stat1" class="statTable">
        <thead>        
            <th>
                <b>Titel der Quelle</b>
                <form method="GET">
                    <input name="filterTitle" type="text" size="40" value="<%=filterTitle %>" placeholder="Titel Filter"/>
                    <input name="page" type="hidden" value="anzahl_belege"/>
                    <input name="sort" type="hidden" value="<%=sort %>"/>
                    <input type="submit" />
                </form>
                <%
                    out.println(html_sort_title_up(currentPage, filterTitle, recordsPerPage,jumpToID));
                    out.println(html_sort_title_down(currentPage, filterTitle, recordsPerPage,jumpToID));
                %>
            </th>
            <th>
                <b>Anzahl Belege</b>
            </th>
        </thead>
       <tbody>
            <%
            for (Quelle q : lst) {
                out.print("<tr onclick= style=\"cursor: pointer;\">");
                out.print("<td>");
                out.println("<a href=\"window.location='"+Utils.getBaseUrl(request)+"/gast/quelle?ID="+String.valueOf(q.getId())+"';\">");
                out.print(Utils.escapeHTML(q.getBezeichnung()));
                out.print("</a>");
                out.print("</td>");
                out.print("<td>");
                out.println("<a href=\"window.location='"+Utils.getBaseUrl(request)+"/gast/quelle?ID="+String.valueOf(q.getId())+"';\">");
                out.print(q.getEinzelbelege().size());
                out.print("</a>");
                out.print("</td>");
                out.print("</tr>");
            }
            %>
        </tbody>
    </table>
    
    <%
        print_pagination(out, currentPage, recordsPerPage, filterTitle, nOfPages,sort,jumpToID);
    %>
</p>
