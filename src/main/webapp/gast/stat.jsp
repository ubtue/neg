<%@page import="de.uni_tuebingen.ub.nppm.db.*"%>
<%@page import="de.uni_tuebingen.ub.nppm.model.*"%>
<%@page import="de.uni_tuebingen.ub.nppm.util.*"%>
<%@page import="java.util.*"%>

<style>
    .statistica .ut-nav__list {
        display: flex;
        flex-wrap: wrap; /* Erlaubt das Umbrechen der Elemente */
        list-style: none;
        padding: 0;
        margin: 0;
        justify-content: center; /* Zentriert die Paginierung */
        gap: 10px; /* Abstand zwischen den Elementen */
    }

    .statistica .page-link {
        text-decoration: none;
        padding: 5px 10px;
        margin: 0; /* Kein zusätzlicher Außenabstand */
        color: #007bff;
        background-color: #ffffff; /* Standard-Hintergrund */
        transition: all 0.3s ease;
        font-size: 1rem; /* Standard-Schriftgröße */
        border: 1px solid #ddd; /* Optionale Umrandung */
        border-radius: 5px; /* Leicht abgerundete Ecken */
        display: inline-block; /* Behält die Links nebeneinander */
        text-align: center; /* Zentrierter Text */
    }

    /* Hover-Effekt */
    .statistica .page-link:hover {
        background-color: #f0f0f0;
        color: #0056b3;
    }

    /* Aktiver Link (aktuelle Seite) */
    .statistica .page-link.active {
        color: #ffffff; /* Weißer Text */
        background-color: #dc3545; /* Roter Hintergrund für die aktive Seite */
        cursor: default; /* Kein Zeiger für die aktuelle Seite */
    }

    /* Für kleinere Bildschirme */
    @media (max-width: 768px) {
        .statistica .page-link {
            padding: 4px 8px; /* Kleinere Links */
            font-size: 0.9rem;
        }
    }

    /* Für sehr kleine Bildschirme */
    @media (max-width: 480px) {
        .statistica .ut-nav__list {
            justify-content: space-evenly; /* Gleichmäßige Verteilung */
        }

        .statistica .page-link {
            padding: 5px; /* Reduzierte Größe */
            font-size: 0.85rem;
        }
    }
</style>




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
    Calculation for pagination
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
        return "<li class=\"ut-nav__item statistica\"><a class=\"ut-link page-link\" href=\"?jumpToID="+jumpToID+"&sort="+sort+"&page=stat&filterTitle=" + filterTitle + "&recordsPerPage=" + recordsPerPage + "&currentPage=" + (currentPage - 1) + "\">Previous</a></li>";
    }

    public String html_next_button(String filterTitle, String recordsPerPage, Integer currentPage, String sort, String jumpToID) {
        return "<li class=\"ut-nav__item statistica\"><a class=\"ut-link page-link\" href=\"?jumpToID="+jumpToID+"&sort="+sort+"&page=stat&filterTitle=" + filterTitle + "&recordsPerPage=" + recordsPerPage + "&currentPage=" + (currentPage + 1) + "\">Next</a></li>";
    }

    public String html_page_item_current(int page) {
        return "<li class=\"ut-nav__item statistica\"><a class=\"ut-link page-link active\">" + page + "</a></li>";
    }


    public String html_page_item(int page, String filterTitle, int recordsPerPage, String sort, String jumpToID) {
        return "<li class=\"ut-nav__item statistica\"><a class=\"ut-link page-link\" href=\"?jumpToID="+jumpToID+"&sort="+sort+"&page=stat&filterTitle=" + filterTitle + "&recordsPerPage=" + recordsPerPage + "&currentPage=" + page + "\">" + page + "</a></li>";
    }

    public String html_sort_title_up(int page, String filterTitle, int recordsPerPage, String jumpToID,HttpSession session) throws Exception {
        return "<a class=\"ut-link sort-link statistica\" href=\"?jumpToID="+jumpToID+"&sort=titleUp&page=stat&filterTitle=" + filterTitle + "&recordsPerPage=" + recordsPerPage + "&currentPage=" + page + "\">"+Language.getTextfield(session, "stat", "SortUp")+"</a>";
    }

    public String html_sort_belege_up(int page, String filterTitle, int recordsPerPage, String jumpToID,HttpSession session) throws Exception {
        return "<a class=\"ut-link sort-link statistica\" href=\"?jumpToID=" + jumpToID + "&sort=belegeUp&page=stat&filterTitle=" + filterTitle + "&recordsPerPage=" + recordsPerPage + "&currentPage=" + page + "\">"+Language.getTextfield(session, "stat", "SortUp")+"</a>";
    }

    public String html_sort_belege_down(int page, String filterTitle, int recordsPerPage, String jumpToID,HttpSession session) throws Exception {
        return "<a class=\"ut-link sort-link statistica\" href=\"?jumpToID=" + jumpToID + "&sort=belegeDown&page=stat&filterTitle=" + filterTitle + "&recordsPerPage=" + recordsPerPage + "&currentPage=" + page + "\">"+Language.getTextfield(session, "stat", "SortDown")+"</a>";
    }

    public String html_sort_title_down(int page, String filterTitle, int recordsPerPage, String jumpToID,HttpSession session) throws Exception {
        return "<a class=\"ut-link sort-link statistica\" href=\"?jumpToID="+jumpToID+"&sort=titleDown&page=stat&filterTitle=" + filterTitle + "&recordsPerPage=" + recordsPerPage + "&currentPage=" + page + "\">"+Language.getTextfield(session, "stat", "SortDown")+"</a>";
    }

    public void print_pagination(JspWriter out, int currentPage, int recordsPerPage, String filterTitle, int nOfPages, String sort, String jumpToID) throws Exception {
        out.println("<div class=\"statistica\">"); // Wrapper hinzufügen
        out.println("<nav aria-label=\"Navigation for rows\">");
        //out.println("<ul class=\"pagination\">");
        out.println("<ul class=\"ut-nav__list\">");


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
        out.println("</div>"); // Wrapper schließen
    }
%>
<div class="statistica">
    <p>
        <h1 class="ut-heading ut-heading--h1"><% Language.printTextfield(out, session, "stat", "Titel");%></h1>
        <a class="ut-link" href="<%=Utils.getBaseUrl(request)%>/gast/quelle"><% Language.printTextfield(out, session, "einstellungen", "Zurueck");%></a>
        <br><br>
        <h3 class="ut-heading ut-heading--h3"><% Language.printTextfield(out, session, "stat", "ListeDerQuellenAnzahl");%></h3>
        <br>
        <%
            print_pagination(out, currentPage, recordsPerPage, filterTitle, nOfPages,sort,jumpToID);
        %>
        <table id="stat1" class="ut-table ut-table--striped ut-table--striped--color-primary-3 statTable">
            <thead class="ut-table__header ">
                <th class="ut-table__item ut-table__header__item" scope="col">
                    <b><% Language.printTextfield(out, session, "stat", "QuellenTitel");%></b>
                     <form method="GET" style="display: flex; align-items: center;">
                        <input class="ut-form__input ut-form__field" name="filterTitle" type="text" size="40" value="<%=filterTitle %>" placeholder="<% Language.printTextfield(out, session, "stat", "TitelFilter");%>" aria-required="true" style="width: 400px; margin-right: 2px;"/>
                        <input name="page" type="hidden" value="anzahl_belege"/>
                        <input name="sort" type="hidden" value="<%=sort %>"/>
                        <button class="ut-btn ut-btn--color-primary-2" type="submit" style="margin-left: 2px;">
                            <% Language.printTextfield(out, session, "jump", "Los");%>
                        </button>
                    </form>

                    <%
                        out.println(html_sort_title_up(currentPage, filterTitle, recordsPerPage,jumpToID,session));
                        out.println(html_sort_title_down(currentPage, filterTitle, recordsPerPage,jumpToID,session));
                    %>
                </th>
                <th class="ut-table__item ut-table__header__item" scope="col">
                    <b><% Language.printTextfield(out, session, "stat", "AnzahlBelege");%></b>
                    <br>
                    <%
                        out.println(html_sort_belege_up(currentPage, filterTitle, recordsPerPage, jumpToID,session));
                        out.println(html_sort_belege_down(currentPage, filterTitle, recordsPerPage, jumpToID,session));
                    %>
                </th>
            </thead>
           <tbody class="ut-table__body ">
                <%
                for (Quelle q : lst) {
                    out.print("<tr class=\"ut-table__row\">");
                    out.print("<td class=\"ut-table__item ut-table__body__item\" width='80%'>");
                    out.print("<a class=\"ut-link\" href=\""+Utils.getBaseUrl(request)+"/gast/quelle?ID="+String.valueOf(q.getId())+"\">");
                    out.print(Utils.escapeHTML(q.getBezeichnung()));
                    out.print("</a>");
                    out.print("</td>");
                    out.print("<td width='20%'>");
                    out.print(QuelleDB.getEinzelbelegeCount(q.getId()));
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
</div>
