<%@page import="de.uni_tuebingen.ub.nppm.db.*"%>
<%@page import="de.uni_tuebingen.ub.nppm.model.*"%>
<%@ page import="java.sql.*" isThreadSafe="false"%>
<%@ page import="de.uni_tuebingen.ub.nppm.util.Language" isThreadSafe="false" %>
<%@ page import="de.uni_tuebingen.ub.nppm.exception.*" isThreadSafe="false" %>
<%@ include file="../configuration.jsp"%>
<%@ include file="../functions.jsp"%>

<jsp:include page="../dofilter.jsp" />

<style>
    .flex-header {
        position: relative;
        display: flex; /* Optional, falls du Flexbox verwenden möchtest */
        align-items: center; /* Stellt sicher, dass die Kinder (Button und h3) vertikal ausgerichtet sind */
    }

    #toggleButton {
        position: absolute;
        right: 0;
        top: 50%;
        transform: translateY(-50%);
        height: auto; /* Optional, wenn der Button eine flexible Höhe haben soll */
    }

    h3.ut-heading {
        margin: 0;
        line-height: 1.5;
    }
</style>

<%    int id = 1;
    id = Integer.parseInt(request.getParameter("ID"));
    boolean buttonOnOff = "true".equals(request.getParameter("allfields"));

    Quelle quelle = QuelleDB.getById(id);
    if (quelle == null) {
        if (session.getAttribute("Sprache").equals("de")) {
            throw new IdNotFoundException("Quellen ID Q" + String.valueOf(id) + " ist nicht vorhanden");
        } else {
            throw new IdNotFoundException("Source ID Q" + String.valueOf(id) + " does not exist");
        }
    }

    if (quelle.getZuVeroeffentlichen() != 1) {
        if (session.getAttribute("Sprache").equals("de")) {
            throw new IdNotPublicException("Quellen ID Q" + id + " ist nicht zu veröffentlichen");
        } else {
            throw new IdNotFoundException("Source ID Q" + String.valueOf(id) + " is not to be published");
        }
    }

    String formular = "quelle";
    Urkunde urkunde = quelle.getUrkunde();
%>

<h1 class="ut-heading ut-heading--h1">
    <a class="ut-link" href="<%=Utils.getBaseUrl(request)%>/gast/quelle?page=stat">
        <jsp:include page="../inc.erzeugeBeschriftung.jsp">
            <jsp:param name="Formular" value="stat"/>
            <jsp:param name="Textfeld" value="Titel"/>
        </jsp:include>
    </a>
</h1>

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
<div class="flex-header">
    <h3 class="ut-heading ut-heading--h3">
        <% Language.printTextfield(out, session, "quelle", "Bezeichnung");%>
        <jsp:include page="../inc.erzeugeFormular.jsp">
        <jsp:param name="ID" value="<%= id%>"/>
        <jsp:param name="Formular" value="quelle"/>
        <jsp:param name="Datenfeld" value="Bezeichnung"/>
        <jsp:param name="size" value="50"/>
        <jsp:param name="Readonly" value="yes"/>
    </jsp:include>
    </h3>
    <button class="ut-btn ut-btn--color-primary-4" id="toggleButton" style="margin-top: -8px;" onclick="toggleAllFields()">
        <% Language.getTextfield(session, "fields", "On"); %>
    </button>
</div>

<table class="ut-table ut-table--striped ut-table--striped--color-primary-3">
    <tbody class="ut-table__body ">

        <jsp:include page="../inc.erzeugeFormular.jsp">
            <jsp:param name="ID" value="<%= id%>"/>
            <jsp:param name="Formular" value="gast_quelle"/>
            <jsp:param name="Datenfeld" value="Datierung"/>
            <jsp:param name="Readonly" value="yes"/>
            <jsp:param name="Darstellung" value="Tabellenzeile"/>
            <jsp:param name="Label" value="<%=Language.getTextfield(session, "quelle", "Datierung")%>"/>
            <jsp:param name="allfields" value="<%= request.getParameter("allfields") %>"/>
        </jsp:include>

        <jsp:include page="../inc.erzeugeFormular.jsp">
            <jsp:param name="ID" value="<%= id%>"/>
            <jsp:param name="Formular" value="quelle"/>
            <jsp:param name="Datenfeld" value="KommentarDatierung"/>
            <jsp:param name="cols" value="40"/>
            <jsp:param name="rows" value="5"/>
            <jsp:param name="Readonly" value="yes"/>
            <jsp:param name="Darstellung" value="Tabellenzeile"/>
            <jsp:param name="Label" value="<%=Language.getDatafield(session, "quelle", "KommentarDatierung")%>"/>
            <jsp:param name="allfields" value="<%= request.getParameter("allfields") %>"/>
        </jsp:include>

        <%
            List<Object[]> resultListStandardEdition = ModulIncDB.getListGastQuelleEditionen("1", String.valueOf(id));

            List<Object[]> resultListWeitereEdition = ModulIncDB.getListGastQuelleEditionen("0", String.valueOf(id));

            if (buttonOnOff || (resultListStandardEdition != null && !resultListStandardEdition.isEmpty() || resultListWeitereEdition != null && !resultListWeitereEdition.isEmpty())) {
        %>

        <tr class="ut-table__row">
            <td class="ut-table__item ut-table__body__item" colspan="2">
                <jsp:include page="../inc.modul.jsp">
                    <jsp:param name="ID" value="<%= id%>"/>
                    <jsp:param name="Formular" value="quelle"/>
                    <jsp:param name="Modul" value="edition"/>
                </jsp:include>
            </td>
        </tr>

        <%
            }
        %>

    </tbody>
</table>

<!----------Einzelbelege---------->
<h1 class="ut-heading ut-heading--h1">
    <a class="ut-link" href="<%= Utils.getBaseUrl(request)%>/gast/suchergebnis?Quellenliste=<%= id%>&form=freie_suche&NeGID=&Belegform=&Kontext=&Namenkommentar=-1&Namenkommentar2=-1&MGHLemma=&Personenname=&Geschlecht=-1&PersonZeitraum=&AmtWeihePerson=-1&StandPerson=-1&EthniePerson=-1&AmtWeiheEinzelbeleg=-1&EthnieEinzelbeleg=-1&Quelle=&QuelleGattung=-1&QuelleZeitraum=&Seite=&Ausgabe_Einzelbeleg_Belegform=on&Ausgabe_Einzelbeleg_Belegstelle=on&Ausgabe_Einzelbeleg_Kontext=on&Ausgabe_Einzelbeleg_Datierung=on&Ausgabe_Einzelbeleg_lebend=on&Ausgabe_Einzelbeleg_Varianten=on&Ausgabe_Einzelbeleg_Quellengattung=on&order1=-1&order1ASCDESC=ASC&order1zeit=&order2=-1&order2ASCDESC=ASC&order2zeit=&order3=-1&order3ASCDESC=ASC&order3zeit="><% Language.printTextfield(out, session, "einzelbeleg", "Titel");%></a>
</h1>

<%
    List<Object[]> resultList = ModulIncDB.getListQuelleEditionen(String.valueOf(id));

    if (buttonOnOff || (resultList != null && !resultList.isEmpty())) {
%>

<!----------Ueberlieferung---------->
<h3 class="ut-heading ut-heading--h3"><% Language.printTextfield(out, session, "quelle", "TabUeberlieferung");%></h3>
<jsp:include page="../inc.modul.jsp">
    <jsp:param name="ID" value="<%= id%>" />
    <jsp:param name="Formular" value="quelle" />
    <jsp:param name="Modul" value="ueberlieferungRO" />
</jsp:include>

<%
    }
%>

<!----------Bei Urkunden---------->
<% if (urkunde != null) { %>
<% int urkundeid = urkunde.getId(); %>

<h3 class="ut-heading ut-heading--h3" id="headline" style="display: none;"><% Language.printTextfield(out, session, "quelle", "TabUrkunde");%></h3>
<div class="container" id="urkunden">
    <table class="ut-table ut-table--striped ut-table--striped--color-primary-3">
        <tbody class="ut-table__body ">
            <jsp:include page="../inc.erzeugeFormular.jsp">
                <jsp:param name="ID" value="<%= urkundeid%>" />
                <jsp:param name="Formular" value="urkunde" />
                <jsp:param name="Datenfeld" value="Actumort" />
                <jsp:param name="size" value="50" />
                <jsp:param name="Readonly" value="yes" />
                <jsp:param name="Darstellung" value="Tabellenzeile"/>
                <jsp:param name="Label" value="<%=Language.getDatafield(session, "urkunde", "Actumort")%>"/>
                <jsp:param name="allfields" value="<%= request.getParameter("allfields") %>"/>
            </jsp:include>

            <jsp:include page="../inc.erzeugeFormular.jsp">
                <jsp:param name="ID" value="<%= urkundeid%>" />
                <jsp:param name="Formular" value="urkunde" />
                <jsp:param name="Datenfeld" value="Betreff" />
                <jsp:param name="size" value="50" />
                <jsp:param name="Readonly" value="yes" />
                <jsp:param name="Darstellung" value="Tabellenzeile"/>
                <jsp:param name="Label" value="<%=Language.getDatafield(session, "urkunde", "Betreff")%>"/>
                <jsp:param name="allfields" value="<%= request.getParameter("allfields") %>"/>
            </jsp:include>

            <jsp:include page="../inc.erzeugeFormular.jsp">
                <jsp:param name="ID" value="<%= urkundeid%>" />
                <jsp:param name="Formular" value="urkunde" />
                <jsp:param name="Datenfeld" value="Aussteller" />
                <jsp:param name="Readonly" value="yes" />
                <jsp:param name="Darstellung" value="Tabellenzeile"/>
                <jsp:param name="Label" value="<%=Language.getDatafield(session, "urkunde", "Aussteller")%>"/>
                <jsp:param name="allfields" value="<%= request.getParameter("allfields") %>"/>
            </jsp:include>

            <jsp:include page="../inc.erzeugeFormular.jsp">
                <jsp:param name="ID" value="<%= urkundeid%>" />
                <jsp:param name="Formular" value="urkunde" />
                <jsp:param name="Datenfeld" value="Empfaenger" />
                <jsp:param name="Readonly" value="yes" />
                <jsp:param name="Darstellung" value="Tabellenzeile"/>
                <jsp:param name="Label" value="<%=Language.getDatafield(session, "urkunde", "Empfaenger")%>"/>
                <jsp:param name="allfields" value="<%= request.getParameter("allfields") %>"/>
            </jsp:include>

            <jsp:include page="../inc.erzeugeFormular.jsp">
                <jsp:param name="ID" value="<%= urkundeid%>" />
                <jsp:param name="Formular" value="urkunde" />
                <jsp:param name="Datenfeld" value="Dorsalnotiz" />
                <jsp:param name="size" value="50" />
                <jsp:param name="Readonly" value="yes" />
                <jsp:param name="Darstellung" value="Tabellenzeile"/>
                <jsp:param name="Label" value="<%=Language.getDatafield(session, "urkunde", "Dorsalnotiz")%>"/>
                <jsp:param name="allfields" value="<%= request.getParameter("allfields") %>"/>
            </jsp:include>
        </tbody>
    </table>
</div>

<% }%>

<script>

    function toggleAllFields() {
        let url = new URL(window.location.href);
        let params = url.searchParams;

        if (params.get("allfields") === "true") {
            params.delete("allfields");
        } else {
            params.set("allfields", "true");
        }

        window.location.href = url.toString();
    }

    window.onload = function () {
        var urkundenDiv = document.getElementById("urkunden");
        // überprüfen, ob das div sichtbaren Inhalt enthält
        if (urkundenDiv && urkundenDiv.innerText.trim() !== "") {
            // Falls Inhalte vorhanden sind, die Überschrift und das div anzeigen
            document.getElementById("headline").style.display = "block";

        }

        let params = new URLSearchParams(window.location.search);
        let button = document.getElementById("toggleButton");
        let on = '<%= Language.getTextfield(session, "fields", "Off") %>';
        let off = '<%= Language.getTextfield(session, "fields", "On") %>';

        if (params.get("allfields") === "true") {
            button.textContent = on;
        } else {
            button.textContent = off;
        }
    };
</script>
