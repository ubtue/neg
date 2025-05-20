<%@page import="de.uni_tuebingen.ub.nppm.db.*"%>
<%@page import="de.uni_tuebingen.ub.nppm.model.*"%>
<%@page import="de.uni_tuebingen.ub.nppm.util.*"%>
<%@page import="java.util.*"%>

<link rel="stylesheet" href="<%=Utils.getVersionedHref(request, application, "/gast/layout/stat.css")%>" type="text/css">

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
    if (jumpToID != null && jumpToID.length() > 0) {
        rows = 1;
    }

    int nOfPages = rows / recordsPerPage;

    if (nOfPages % recordsPerPage > 0) {
        nOfPages++;
    }

    List<Quelle> lst = QuelleDB.getList(currentPage, recordsPerPage, filterTitle, sort, jumpToID);
%>
<%!

    /*
    Functions that helps to print pagination
     */
    public String html_prev_button(String filterTitle, String recordsPerPage, Integer currentPage, String sort, String jumpToID) {
        String url = "?jumpToID=" + jumpToID + "&sort=" + sort + "&page=stat&filterTitle=" + filterTitle + "&recordsPerPage=" + recordsPerPage + "&currentPage=" + (currentPage - 1);

        return "<li class=\"ut-nav__item\">"
                + "<button class=\"ut-btn ut-btn--color-primary-3 prev-button\" onclick=\"window.location.href='" + url + "';\">Previous</button>"
                + "<a class=\"ut-link page-link prev-link\" href=\"" + url + "\" style=\"display: none;\"><</a>"
                + "</li>"
                + "<script>"
                + "function togglePrevButton() {"
                + "    if (window.innerWidth <= 650) {"
                + "        document.querySelector('.prev-button').style.display = 'none';"
                + "        document.querySelector('.prev-link').style.display = 'inline-block';"
                + "    } else {"
                + "        document.querySelector('.prev-button').style.display = 'inline-block';"
                + "        document.querySelector('.prev-link').style.display = 'none';"
                + "    }"
                + "}"
                + "togglePrevButton();"
                + "window.addEventListener('resize', togglePrevButton);"
                + "</script>";
    }

    public String html_next_button(String filterTitle, String recordsPerPage, Integer currentPage, String sort, String jumpToID) {
        String url = "?jumpToID=" + jumpToID + "&sort=" + sort + "&page=stat&filterTitle=" + filterTitle + "&recordsPerPage=" + recordsPerPage + "&currentPage=" + (currentPage + 1);

        return "<li class=\"ut-nav__item\">"
                + "<button class=\"ut-btn ut-btn--color-primary-3 next-button\" onclick=\"window.location.href='" + url + "';\">Next</button>"
                + "<a class=\"ut-link page-link next-link\" href=\"" + url + "\" style=\"display: none;\">></a>"
                + "</li>"
                + "<script>"
                + "function toggleNextButton() {"
                + "    if (window.innerWidth <= 650) {"
                + "        document.querySelector('.next-button').style.display = 'none';"
                + "        document.querySelector('.next-link').style.display = 'inline-block';"
                + "    } else {"
                + "        document.querySelector('.next-button').style.display = 'inline-block';"
                + "        document.querySelector('.next-link').style.display = 'none';"
                + "    }"
                + "}"
                + "toggleNextButton();"
                + "window.addEventListener('resize', toggleNextButton);"
                + "</script>";
    }

    public String html_page_item_current(int page) {
        String pageUrl = "?page=" + page;  // Hier kannst du die URL anpassen, je nach deinen Parametern

        return "<li class=\"ut-nav__item\">"
                + "<button class=\"ut-btn ut-btn--color-primary-1 current-button\">" + page + "</button>"
                + "<a class=\"ut-link page-link active current-link\" href=\"" + pageUrl + "\" style=\"display: none;\">" + page + "</a>"
                + "</li>"
                + "<script>"
                + "function toggleCurrentPageButton() {"
                + "    if (window.innerWidth <= 650) {"
                + "        document.querySelector('.current-button').style.display = 'none';"
                + "        document.querySelector('.current-link').style.display = 'inline-block';"
                + "    } else {"
                + "        document.querySelector('.current-button').style.display = 'inline-block';"
                + "        document.querySelector('.current-link').style.display = 'none';"
                + "    }"
                + "}"
                + "toggleCurrentPageButton();"
                + "window.addEventListener('resize', toggleCurrentPageButton);"
                + "</script>";
    }

    public String html_page_item(int page, String filterTitle, int recordsPerPage, String sort, String jumpToID) {
        String pageUrl = "?jumpToID=" + jumpToID + "&sort=" + sort + "&page=stat&filterTitle=" + filterTitle + "&recordsPerPage=" + recordsPerPage + "&currentPage=" + page;

        return "<li class=\"ut-nav__item statistica\">"
                + "<button class=\"ut-btn ut-btn--color-primary-2 page-button\" onclick=\"window.location.href='" + pageUrl + "';\">" + page + "</button>"
                + "<a class=\"ut-link page-link\" href=\"" + pageUrl + "\" style=\"display: none;\">" + page + "</a>"
                + "</li>"
                + "<script>"
                + "function togglePageButton() {"
                + "    var pageButtons = document.querySelectorAll('.page-button');" // Alle Page-Buttons abrufen
                + "    var pageLinks = document.querySelectorAll('.page-link');" // Alle Page-Links abrufen"
                + "    if (window.innerWidth <= 650) {"
                + "        pageButtons.forEach(function(pageButton) {"
                + "            pageButton.style.display = 'none';" // Alle Buttons ausblenden"
                + "        });"
                + "        pageLinks.forEach(function(pageLink) {"
                + "            pageLink.style.display = 'inline-block';" // Alle Links anzeigen"
                + "        });"
                + "    } else {"
                + "        pageButtons.forEach(function(pageButton) {"
                + "            pageButton.style.display = 'inline-block';" // Alle Buttons anzeigen"
                + "        });"
                + "        pageLinks.forEach(function(pageLink) {"
                + "            pageLink.style.display = 'none';" // Alle Links ausblenden"
                + "        });"
                + "    }"
                + "}"
                + "togglePageButton();"
                + "window.addEventListener('resize', togglePageButton);"
                + "</script>";
    }

    public String html_sort_title_up(int page, String filterTitle, int recordsPerPage, String jumpToID, HttpSession session) throws Exception {
        return "<a class=\"ut-link sort-link \" href=\"?jumpToID=" + jumpToID + "&sort=titleUp&page=stat&filterTitle=" + filterTitle + "&recordsPerPage=" + recordsPerPage + "&currentPage=" + page + "\">" + Language.getTextfield(session, "stat", "SortAZ") + "</a>";
    }

    public String html_sort_belege_up(int page, String filterTitle, int recordsPerPage, String jumpToID, HttpSession session) throws Exception {
        return "<a class=\"ut-link sort-link \" href=\"?jumpToID=" + jumpToID + "&sort=belegeUp&page=stat&filterTitle=" + filterTitle + "&recordsPerPage=" + recordsPerPage + "&currentPage=" + page + "\">" + Language.getTextfield(session, "stat", "SortUp") + "</a>";
    }

    public String html_sort_belege_down(int page, String filterTitle, int recordsPerPage, String jumpToID, HttpSession session) throws Exception {
        return "<a class=\"ut-link sort-link \" href=\"?jumpToID=" + jumpToID + "&sort=belegeDown&page=stat&filterTitle=" + filterTitle + "&recordsPerPage=" + recordsPerPage + "&currentPage=" + page + "\">" + Language.getTextfield(session, "stat", "SortDown") + "</a>";
    }

    public String html_sort_title_down(int page, String filterTitle, int recordsPerPage, String jumpToID, HttpSession session) throws Exception {
        return "<a class=\"ut-link sort-link \" href=\"?jumpToID=" + jumpToID + "&sort=titleDown&page=stat&filterTitle=" + filterTitle + "&recordsPerPage=" + recordsPerPage + "&currentPage=" + page + "\">" + Language.getTextfield(session, "stat", "SortZA") + "</a>";
    }

    public void print_pagination(JspWriter out, int currentPage, int recordsPerPage, String filterTitle, int nOfPages, String sort, String jumpToID) throws Exception {
        out.println("<div class=\"statistica\">"); // Wrapper hinzufügen
        out.println("<nav aria-label=\"Navigation for rows\">");
        //out.println("<ul class=\"pagination\">");
        out.println("<ul class=\"ut-nav__list\">");


        /*Print Previous Button*/
        if (currentPage != 1) {
            out.println(html_prev_button(filterTitle, String.valueOf(recordsPerPage), currentPage, sort, jumpToID));
        }

        /*Print Pages and highlight current page*/
        for (int i = 1; i <= nOfPages; i++) {
            if (currentPage == i) {
                out.println(html_page_item_current(i));
            } else {
                out.println(html_page_item(i, filterTitle, recordsPerPage, sort, jumpToID));
            }
        }

        /*Print Next Button*/
        if (currentPage < nOfPages) {
            out.println(html_next_button(filterTitle, String.valueOf(recordsPerPage), currentPage, sort, jumpToID));
        }
        out.println("</ul>");
        out.println("</nav>");
        out.println("</div>"); // Wrapper schließen
    }
%>
<div class="statistica">
    <p>
    <h3 class="ut-heading ut-heading--h3"><% Language.printTextfield(out, session, "stat", "ListeDerQuellenAnzahl");%></h3>
    <%
        print_pagination(out, currentPage, recordsPerPage, filterTitle, nOfPages, sort, jumpToID);
    %>
    <table id="stat1" class="ut-table ut-table--striped ut-table--striped--color-primary-3 statTable">
        <thead class="ut-table__header ">
        <th class="ut-table__item ut-table__header__item" scope="col">
            <b><% Language.printTextfield(out, session, "stat", "QuellenTitel");%></b>
            <form method="GET" style="display: flex; align-items: center;">
                <input class="ut-form__input ut-form__field" name="filterTitle" type="text" size="40" value="<%=filterTitle%>" placeholder="<% Language.printTextfield(out, session, "stat", "TitelFilter");%>" aria-required="true" style="width: 400px; margin-right: 2px;"/>
                <input name="page" type="hidden" value="stat"/>
                <input name="sort" type="hidden" value="<%=sort%>"/>
                <button class="ut-btn ut-btn--color-primary-2" type="submit" style="margin-left: 2px;">
                    <% Language.printTextfield(out, session, "jump", "Los");%>
                </button>
            </form>

            <%
                out.println(html_sort_title_up(currentPage, filterTitle, recordsPerPage, jumpToID, session));
                out.println(html_sort_title_down(currentPage, filterTitle, recordsPerPage, jumpToID, session));
            %>
        </th>
        <th class="ut-table__item ut-table__header__item" scope="col">
            <b><% Language.printTextfield(out, session, "stat", "AnzahlBelege");%></b>
            <br>
            <%
                out.println(html_sort_belege_up(currentPage, filterTitle, recordsPerPage, jumpToID, session));
                out.println(html_sort_belege_down(currentPage, filterTitle, recordsPerPage, jumpToID, session));
            %>
        </th>
        </thead>
        <tbody class="ut-table__body ">
            <%
                for (Quelle q : lst) {
                    out.print("<tr class=\"ut-table__row\">");
                    out.print("<td class=\"ut-table__item ut-table__body__item\" width='80%'>");
                    out.print("<a class=\"ut-link\" href=\"" + Utils.getBaseUrl(request) + "/gast/quelle?ID=" + String.valueOf(q.getId()) + "\">");
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
        print_pagination(out, currentPage, recordsPerPage, filterTitle, nOfPages, sort, jumpToID);
    %>
</p>
</div>
