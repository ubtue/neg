<%@page import="java.util.Set"%>
<%@page import="de.uni_tuebingen.ub.nppm.model.Einzelbeleg"%>
<%@page import="de.uni_tuebingen.ub.nppm.model.Person"%>
<%@ page import="de.uni_tuebingen.ub.nppm.util.Language" isThreadSafe="false" %>
<%@ page import="de.uni_tuebingen.ub.nppm.exception.*" isThreadSafe="false" %>
<%@ include file="../configuration.jsp"%>
<%@ include file="../functions.jsp" %>

<jsp:include page="../dofilter.jsp" />

<%    int id = Integer.parseInt(request.getParameter("ID"));

    Person person = PersonDB.getById(id);
    if (person == null) {
        throw new IdNotFoundException("Person ID P" + String.valueOf(id) + " ist nicht vorhanden");
    } else {
        Set<Einzelbeleg> listEinzelbeleg = person.getEinzelbeleg();

        boolean throwException = true;

        for (Einzelbeleg eb : listEinzelbeleg) {
            if (eb.getQuelle() != null && eb.getQuelle().getZuVeroeffentlichen() == 1) {
                throwException = false;
                break;
            }
        }

        if (throwException) {
            throw new IdNotPublicException("Person ID P" + id + " ist nicht zu veröffentlichen");
        }
    }
%>

<jsp:include page="../dojump.jsp">
    <jsp:param name="form" value="gast_person" />
</jsp:include>

<jsp:include page="layout/titel.inc.jsp">
    <jsp:param name="title" value="Person" />
    <jsp:param name="ID" value="<%= id%>" />
    <jsp:param name="size" value="" />
    <jsp:param name="Formular" value="person" />
</jsp:include>

<jsp:include page="../inc.erzeugeFormular.jsp">
    <jsp:param name="ID" value="<%= id%>" />
    <jsp:param name="Formular" value="person" />
    <jsp:param name="Datenfeld" value="ID" />
    <jsp:param name="size" value="11" />
</jsp:include>

<!---------- schema.org RDFa wrapper ---------->
<div class="container" vocab="https://schema.org/" typeof="Person">

    <!----------ID---------->
    <div class="container" id="id">
        <jsp:include page="../forms/id.jsp">
            <jsp:param name="ID" value="<%=id%>"/>
            <jsp:param name="title" value="gast_person"/>
        </jsp:include>
    </div>

    <!----------Prosopographisches---------->

    <!----------Has to be put inside of database/table: "datenbank_texte" -- (not present till now)---------->
    <h3 class="ut-heading ut-heading--h3"> Prosopographisches </h3>
    <table class="ut-table ut-table--striped ut-table--striped--color-primary-3">
        <tbody class="ut-table__body">
            <tr class="ut-table__row">
                <th style="vertical-align: middle;"><% Language.printTextfield(out, session, "person", "Person");%> </th>
                <td class="ut-table__item ut-table__body__item">
                    <jsp:include page="../inc.erzeugeFormular.jsp">
                        <jsp:param name="ID" value="<%= id%>" />
                        <jsp:param name="Formular" value="person" />
                        <jsp:param name="Datenfeld" value="Standardname" />
                        <jsp:param name="size" value="50" />
                        <jsp:param name="Readonly" value="yes" />
                    </jsp:include>

                    <jsp:include page="../inc.erzeugeFormular.jsp">
                        <jsp:param name="ID" value="<%=id%>" />
                        <jsp:param name="Formular" value="person" />
                        <jsp:param name="Datenfeld" value="GNDLink" />
                    </jsp:include>
                </td>
            </tr>

            <jsp:include page="../inc.erzeugeFormular.jsp">
                <jsp:param name="ID" value="<%= id%>" />
                <jsp:param name="Formular" value="person" />
                <jsp:param name="Datenfeld" value="Varianten" />
                <jsp:param name="size" value="50" />
                <jsp:param name="Readonly" value="yes" />
                <jsp:param name="Darstellung" value="Tabellenzeile"/>
                <jsp:param name="Label" value="<%=Language.getDatafield(session, "person", "Varianten")%>"/>
            </jsp:include>

            <jsp:include page="../inc.erzeugeFormular.jsp">
                <jsp:param name="ID" value="<%= id%>" />
                <jsp:param name="Formular" value="person" />
                <jsp:param name="Datenfeld" value="Geschlecht" />
                <jsp:param name="Readonly" value="yes" />
                <jsp:param name="Darstellung" value="Tabellenzeile"/>
                <jsp:param name="Label" value="<%=Language.getDatafield(session, "person", "Geschlecht")%>"/>
            </jsp:include>

            <jsp:include page="../inc.erzeugeFormular.jsp">
                <jsp:param name="ID" value="<%= id%>" />
                <jsp:param name="Formular" value="person" />
                <jsp:param name="Datenfeld" value="Identifizierungsproblem" />
                <jsp:param name="cols" value="40" />
                <jsp:param name="rows" value="5" />
                <jsp:param name="Readonly" value="yes" />
                <jsp:param name="Darstellung" value="Tabellenzeile"/>
                <jsp:param name="Label" value="<%=Language.getTextfield(session, "person", "Identifizierungsproblem")%>"/>
            </jsp:include>

            <jsp:include page="../inc.erzeugeFormular.jsp">
                <jsp:param name="ID" value="<%= id%>" />
                <jsp:param name="Formular" value="person" />
                <jsp:param name="Datenfeld" value="Stand" />
                <jsp:param name="Readonly" value="yes" />
                <jsp:param name="Darstellung" value="Tabellenzeile"/>
                <jsp:param name="Label" value="<%=Language.getDatafield(session, "person", "Stand")%>"/>
            </jsp:include>

            <jsp:include page="../inc.erzeugeFormular.jsp">
                <jsp:param name="ID" value="<%= id%>" />
                <jsp:param name="Formular" value="person" />
                <jsp:param name="Datenfeld" value="AmtWeihe" />
                <jsp:param name="Readonly" value="yes" />
                <jsp:param name="Darstellung" value="Tabellenzeile"/>
                <jsp:param name="Label" value="<%=Language.getTextfield(session, "person", "Aemter")%>"/>
            </jsp:include>

            <jsp:include page="../inc.erzeugeFormular.jsp">
                <jsp:param name="ID" value="<%= id%>" />
                <jsp:param name="Formular" value="person" />
                <jsp:param name="Datenfeld" value="Ethnie" />
                <jsp:param name="Readonly" value="yes" />
                <jsp:param name="Darstellung" value="Tabellenzeile"/>
                <jsp:param name="Label" value="<%=Language.getDatafield(session, "person", "Ethnie")%>"/>
            </jsp:include>

            <%
                List<Object[]> resultList = ModulIncDB.getListPersonenVerwandte(String.valueOf(id));

                if (resultList != null && !resultList.isEmpty()) {
            %>

            <tr class="ut-table__row">
                <th class="ut-table__item ut-table__header__item" scope="col"><% Language.printTextfield(out, session, "person", "TabVerwandte");%></th>
                <td class="ut-table__item ut-table__body__item">
                    <jsp:include page="../inc.modul.jsp">
                        <jsp:param name="ID" value="<%= id%>" />
                        <jsp:param name="Formular" value="person" />
                        <jsp:param name="Modul" value="Verwandte" />
                        <jsp:param name="Readonly" value="yes" />
                    </jsp:include>
                </td>
            </tr>

            <%
                }
            %>
        </tbody>
    </table>
</div>

<!----------Einzelbelege---------->
<h3 class="ut-heading ut-heading--h3"><% Language.printTextfield(out, session, "person", "TabEinzelbelege");%></h3>
<jsp:include page="../inc.modul.jsp">
    <jsp:param name="ID" value="<%= id%>" />
    <jsp:param name="Formular" value="person" />
    <jsp:param name="Modul" value="nachweiseRO" />
</jsp:include>
