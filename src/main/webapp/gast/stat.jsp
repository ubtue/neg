<%@page import="de.uni_tuebingen.ub.nppm.db.*"%>
<%@page import="de.uni_tuebingen.ub.nppm.model.*"%>
<%@page import="de.uni_tuebingen.ub.nppm.util.*"%>
<%@page import="java.util.*"%>

<style>

    .ut-nav__list {
        display: flex;
        justify-content: center; /* Zentriert die Paginierung */
        gap: 6px;
    }

    .ut-nav__item {
        display: inline-block;
    }

    .page-link.active {
        color: #ffffff; /* Weißer Text */
        background-color: #dc3545; /* Roter Hintergrund für die aktive Seite */
        cursor: default; /* Kein Zeiger für die aktuelle Seite */
        padding: 5px 10px; /* Etwas Polsterung, damit der Text nicht zu nah am Rand ist */
        border-radius: 5px; /* Abgerundete Ecken für den Button */
        text-decoration: none; /* Kein Unterstrich */
        display: inline-block; /* Damit es wie ein Button aussieht */
        font-size: 20px; /* Schriftgröße anpassen */
        line-height: 1.4; /* Zeilenhöhe für besseren Abstand zwischen Text und Rand */
        vertical-align: middle; /* Verhindert, dass der Text vertikal nicht richtig ausgerichtet ist */
    }


    @media (max-width: 650px) {
        .ut-link.page-link {
            font-size: 20px;  /* Schriftgröße erhöhen */

        }

        .ut-nav__list {
            gap: 14px;
        }
    }
</style>


<%
    PaginationParams params = new PaginationParams();
    
    /*Set filterTitle for Quelle*/
    if (request.getParameter("filterTitle") != null) {
        params.addFilter("filterTitle", request.getParameter("filterTitle"));
    }
    /*Set Sort Type*/
    if (request.getParameter("sort") != null) {
        params.setSort(request.getParameter("sort"));
    }
    /*Set jumpToID for Quelle*/
    if (request.getParameter("jumpToID") != null) {
        params.setJumpToID(request.getParameter("jumpToID"));
    }
    /*
    Calculation for pagination
     */
    if (request.getParameter("currentPage") != null) {
        params.setCurrentPage(Integer.parseInt(request.getParameter("currentPage")));
    }else{
        params.setCurrentPage(1);
    }

    if (request.getParameter("recordsPerPage") != null) {
        params.setRecordsPerPage(Integer.parseInt(request.getParameter("recordsPerPage")));
    }else{
        params.setRecordsPerPage(Constants.RECORDS_PER_PAGE);
    }

    int rows = QuelleDB.countStat(params.getFilter("filterTitle")).intValue();

    //row count is 1 if users performs id search
    if (params.getJumpToID() != null && params.getJumpToID().length() > 0) {
        rows = 1;
    }

    int nOfPages = rows / params.getRecordsPerPage();

    if (nOfPages % params.getRecordsPerPage() > 0) {
        nOfPages++;
    }

    List<Quelle> lst = QuelleDB.getList(params);
%>

<div class="statistica">
    <p>
    <h3 class="ut-heading ut-heading--h3"><% Language.printTextfield(out, session, "stat", "ListeDerQuellenAnzahl");%></h3>
    <% PaginationRenderer.printPagination(out, nOfPages, params, session,request); %>
    <table id="stat1" class="ut-table ut-table--striped ut-table--striped--color-primary-3 statTable">
        <thead class="ut-table__header ">
        <th class="ut-table__item ut-table__header__item" scope="col">
            <b><% Language.printTextfield(out, session, "stat", "QuellenTitel");%></b>
            <form method="GET" style="display: flex; align-items: center;">
                <input class="ut-form__input ut-form__field" name="filterTitle" type="text" size="40" value="<%=params.getFilter("filterTitle")%>" placeholder="<% Language.printTextfield(out, session, "stat", "TitelFilter");%>" aria-required="true" style="width: 400px; margin-right: 2px;"/>
                <input name="page" type="hidden" value="stat"/>
                <input name="sort" type="hidden" value="<%=params.getSort()%>"/>
                <button class="ut-btn ut-btn--color-primary-2" type="submit" style="margin-left: 2px;">
                    <% Language.printTextfield(out, session, "jump", "Los");%>
                </button>
            </form>

            <%= PaginationRenderer.htmlSortTitleUp(params, session,request) %>
            <%= PaginationRenderer.htmlSortTitleDown(params, session,request) %>
        </th>
        <th class="ut-table__item ut-table__header__item" scope="col">
            <b><% Language.printTextfield(out, session, "stat", "AnzahlBelege");%></b>
            <br>
            <%= PaginationRenderer.htmlSortBelegeUp(params, session,request) %>
            <%= PaginationRenderer.htmlSortBelegeDown(params, session,request) %>
        </th>
        </thead>
        <tbody class="ut-table__body">
            <% for (Quelle q : lst) { %>
                <tr class="ut-table__row">
                    <td class="ut-table__item ut-table__body__item" width="80%">
                        <a class="ut-link" href="<%= Utils.getBaseUrl(request) + "/gast/quelle?ID=" + q.getId() %>">
                            <%= Utils.escapeHTML(q.getBezeichnung()) %>
                        </a>
                    </td>
                    <td width="20%">
                        <%= QuelleDB.getEinzelbelegeCount(q.getId()) %>
                    </td>
                </tr>
            <% } %>
        </tbody>
    </table>

    <% PaginationRenderer.printPagination(out, nOfPages, params, session,request); %>
</p>
</div>
