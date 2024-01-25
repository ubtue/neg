<%@page import="de.uni_tuebingen.ub.nppm.db.UrkundeDB"%>
<%@page import="de.uni_tuebingen.ub.nppm.model.Urkunde"%>
<%@page import="de.uni_tuebingen.ub.nppm.db.QuelleDB"%>
<%@ page import="java.sql.*" isThreadSafe="false"%>
<%@ page import="de.uni_tuebingen.ub.nppm.util.Language" isThreadSafe="false" %>
<%@ include file="../configuration.jsp"%>
<%@ include file="../functions.jsp"%>

<jsp:include page="../dofilter.jsp" />

<%    int id = 1;
    id = Integer.parseInt(request.getParameter("ID"));
    int urkundeid = -1;
    String formular = "quelle";
    urkundeid = UrkundeDB.getUrkunde(id).getId();
%>
<jsp:include page="../dojump.jsp">
    <jsp:param name="form" value="gast_quelle" />
</jsp:include>

<jsp:include page="layout/titel.inc.jsp">
    <jsp:param name="title" value="Quelle" />
    <jsp:param name="ID" value="<%= id%>" />
    <jsp:param name="size" value="" />
    <jsp:param name="Formular" value="quelle" />
</jsp:include>

<jsp:include page="../inc.erzeugeFormular.jsp">
    <jsp:param name="ID" value="<%= id%>"/>
    <jsp:param name="Formular" value="quelle"/>
    <jsp:param name="Datenfeld" value="ID"/>
    <jsp:param name="size" value="11"/>
</jsp:include>

<!----------ID---------->
<div id="id">
    <jsp:include page="../forms/id.jsp">
        <jsp:param name="ID" value="<%=id%>"/>
        <jsp:param name="title" value="gast_quelle"/>
    </jsp:include>
</div>

<!----------Quelle---------->
<h3 class="ut-heading ut-heading--h3">
    Quelle:
    <jsp:include page="../inc.erzeugeFormular.jsp">
        <jsp:param name="ID" value="<%= id%>"/>
        <jsp:param name="Formular" value="quelle"/>
        <jsp:param name="Datenfeld" value="Bezeichnung"/>
        <jsp:param name="size" value="50"/>
        <jsp:param name="Readonly" value="yes"/>
    </jsp:include>
</h3>
<table class="ut-table ut-table--striped ut-table--striped--color-primary-3">
    <tbody class="ut-table__body ">
        <tr class="ut-table__row">
            <th class="ut-table__item ut-table__header__item"><% Language.printTextfield(out, session, "quelle", "Datierung");%></th>
            <td class="ut-table__item ut-table__body__item">
                <jsp:include page="../inc.erzeugeFormular.jsp">
                    <jsp:param name="ID" value="<%= id%>"/>
                    <jsp:param name="Formular" value="gast_quelle"/>
                    <jsp:param name="Datenfeld" value="Datierung"/>
                    <jsp:param name="Readonly" value="yes"/>
                </jsp:include>
            </td>
        </tr>
        <tr class="ut-table__row">
            <th class="ut-table__item ut-table__header__item"><% Language.printDatafield(out, session, "quelle", "KommentarDatierung");%></th>
            <td class="ut-table__item ut-table__body__item">
                <jsp:include page="../inc.erzeugeFormular.jsp">
                    <jsp:param name="ID" value="<%= id%>"/>
                    <jsp:param name="Formular" value="quelle"/>
                    <jsp:param name="Datenfeld" value="KommentarDatierung"/>
                    <jsp:param name="cols" value="40"/>
                    <jsp:param name="rows" value="5"/>
                    <jsp:param name="Readonly" value="yes"/>
                </jsp:include>
            </td>
        </tr>
        <tr class="ut-table__row">
            <td class="ut-table__item ut-table__body__item" colspan="2">
                <jsp:include page="../inc.modul.jsp">
                    <jsp:param name="ID" value="<%= id%>"/>
                    <jsp:param name="Formular" value="quelle"/>
                    <jsp:param name="Modul" value="edition"/>
                </jsp:include>
            </td>
        </tr>
    </tbody>
</table>

<!----------Ueberlieferung---------->
<h3 class="ut-heading ut-heading--h3"><% Language.printTextfield(out, session, "quelle", "TabUeberlieferung");%></h3>

<jsp:include page="../inc.modul.jsp">
    <jsp:param name="ID" value="<%= id%>" />
    <jsp:param name="Formular" value="quelle" />
    <jsp:param name="Modul" value="ueberlieferungRO" />
</jsp:include>

<!----------Bei Urkunden---------->
<h3 class="ut-heading ut-heading--h3"><% Language.printTextfield(out, session, "quelle", "TabUrkunde"); %></h3>
<div id="urkunden">
    <table class="ut-table ut-table--striped ut-table--striped--color-primary-3">
        <tbody class="ut-table__body ">
            <tr class="ut-table__row">
                <th class="ut-table__item ut-table__header__item"><% Language.printDatafield(out, session, "urkunde", "Actumort");%></th>
                <td class="ut-table__item ut-table__body__item">
                    <jsp:include page="../inc.erzeugeFormular.jsp">
                        <jsp:param name="ID" value="<%= urkundeid%>" />
                        <jsp:param name="Formular" value="urkunde" />
                        <jsp:param name="Datenfeld" value="Actumort" />
                        <jsp:param name="size" value="50" />
                        <jsp:param name="Readonly" value="yes" />
                    </jsp:include>
                </td>
            </tr>
            <tr class="ut-table__row">
                <th class="ut-table__item ut-table__header__item"><% Language.printDatafield(out, session, "urkunde", "Betreff");%> </th>
                <td class="ut-table__item ut-table__body__item">
                    <jsp:include page="../inc.erzeugeFormular.jsp">
                        <jsp:param name="ID" value="<%= urkundeid%>" />
                        <jsp:param name="Formular" value="urkunde" />
                        <jsp:param name="Datenfeld" value="Betreff" />
                        <jsp:param name="size" value="50" />
                        <jsp:param name="Readonly" value="yes" />
                    </jsp:include>
                </td>
            </tr>
            <tr class="ut-table__row">
                <th class="ut-table__item ut-table__header__item"><% Language.printDatafield(out, session, "urkunde", "Aussteller");%></th>
                <td class="ut-table__item ut-table__body__item">
                    <jsp:include page="../inc.erzeugeFormular.jsp">
                        <jsp:param name="ID" value="<%= urkundeid%>" />
                        <jsp:param name="Formular" value="urkunde" />
                        <jsp:param name="Datenfeld" value="Aussteller" />
                        <jsp:param name="Readonly" value="yes" />
                    </jsp:include>
                </td>
            </tr>
            <tr class="ut-table__row">
                <th class="ut-table__item ut-table__header__item"><% Language.printDatafield(out, session, "urkunde", "Empfaenger");%></th>
                <td class="ut-table__item ut-table__body__item">
                    <jsp:include page="../inc.erzeugeFormular.jsp">
                        <jsp:param name="ID" value="<%= urkundeid%>" />
                        <jsp:param name="Formular" value="urkunde" />
                        <jsp:param name="Datenfeld" value="Empfaenger" />
                        <jsp:param name="Readonly" value="yes" />
                    </jsp:include>
                </td>
            </tr>
            <tr class="ut-table__row">
                <th class="ut-table__item ut-table__header__item"><% Language.printDatafield(out, session, "urkunde", "Dorsalnotiz");%> </th>
                <td class="ut-table__item ut-table__body__item">
                    <jsp:include page="../inc.erzeugeFormular.jsp">
                        <jsp:param name="ID" value="<%= urkundeid%>" />
                        <jsp:param name="Formular" value="urkunde" />
                        <jsp:param name="Datenfeld" value="Dorsalnotiz" />
                        <jsp:param name="size" value="50" />
                        <jsp:param name="Readonly" value="yes" />
                    </jsp:include>
                </td>
            </tr>
        </tbody>
    </table>
</div>




