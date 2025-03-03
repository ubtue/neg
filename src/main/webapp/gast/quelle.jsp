<%@page import="de.uni_tuebingen.ub.nppm.db.*"%>
<%@page import="de.uni_tuebingen.ub.nppm.model.*"%>
<%@ page import="java.sql.*" isThreadSafe="false"%>
<%@ page import="de.uni_tuebingen.ub.nppm.util.Language" isThreadSafe="false" %>
<%@ page import="de.uni_tuebingen.ub.nppm.exception.*" isThreadSafe="false" %>
<%@ include file="../configuration.jsp"%>
<%@ include file="../functions.jsp"%>

<jsp:include page="../dofilter.jsp" />

<%    int id = 1;
    id = Integer.parseInt(request.getParameter("ID"));

    Quelle quelle = QuelleDB.getById(id);
    if (quelle == null) {
        throw new IdNotFoundException("Quellen ID Q" + String.valueOf(id) + " ist nicht vorhanden");
    }

    if (quelle.getZuVeroeffentlichen() != 1) {
        throw new IdNotPublicException("Quellen ID Q" + id + " ist nicht zu veröffentlichen");
    }

    String formular = "quelle";
    Urkunde urkunde = quelle.getUrkunde();
%>

<a href="<%=Utils.getBaseUrl(request)%>/gast/quelle?page=stat">
    <jsp:include page="../inc.erzeugeBeschriftung.jsp">
        <jsp:param name="Formular" value="stat"/>
        <jsp:param name="Textfeld" value="Titel"/>
    </jsp:include>
</a>
<br>

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
<h3>
    Quelle:
    <jsp:include page="../inc.erzeugeFormular.jsp">
        <jsp:param name="ID" value="<%= id%>"/>
        <jsp:param name="Formular" value="quelle"/>
        <jsp:param name="Datenfeld" value="Bezeichnung"/>
        <jsp:param name="size" value="50"/>
        <jsp:param name="Readonly" value="yes"/>
    </jsp:include>
</h3>
<table id="quelle-table" class="content-table">
    <tbody>

        <jsp:include page="../inc.erzeugeFormular.jsp">
            <jsp:param name="ID" value="<%= id%>"/>
            <jsp:param name="Formular" value="gast_quelle"/>
            <jsp:param name="Datenfeld" value="Datierung"/>
            <jsp:param name="Readonly" value="yes"/>
            <jsp:param name="Darstellung" value="Tabellenzeile"/>
            <jsp:param name="Label" value="<%=Language.getTextfield(session, "quelle", "Datierung")%>"/>
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
        </jsp:include>

        <%
            List<Object[]> resultListStandardEdition = ModulIncDB.getListGastQuelleEditionen("1", String.valueOf(id));

            List<Object[]> resultListWeitereEdition = ModulIncDB.getListGastQuelleEditionen("0", String.valueOf(id));

            if (resultListStandardEdition != null && !resultListStandardEdition.isEmpty() || resultListWeitereEdition != null && !resultListWeitereEdition.isEmpty()) {
        %>

        <tr>
            <td colspan="2">
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
<h1>
    <a href="<%= Utils.getBaseUrl(request)%>/gast/suchergebnis?Quellenliste=<%= id%>&form=freie_suche&NeGID=&Belegform=&Kontext=&Namenkommentar=-1&Namenkommentar2=-1&MGHLemma=&Personenname=&Geschlecht=-1&PersonZeitraum=&AmtWeihePerson=-1&StandPerson=-1&EthniePerson=-1&AmtWeiheEinzelbeleg=-1&EthnieEinzelbeleg=-1&Quelle=&QuelleGattung=-1&QuelleZeitraum=&Seite=&Ausgabe_Einzelbeleg_Belegform=on&Ausgabe_Einzelbeleg_Belegstelle=on&Ausgabe_Einzelbeleg_Kontext=on&Ausgabe_Einzelbeleg_Datierung=on&Ausgabe_Einzelbeleg_lebend=on&Ausgabe_Einzelbeleg_Varianten=on&Ausgabe_Einzelbeleg_Quellengattung=on&order1=-1&order1ASCDESC=ASC&order1zeit=&order2=-1&order2ASCDESC=ASC&order2zeit=&order3=-1&order3ASCDESC=ASC&order3zeit=">Einzelbelege</a>
</h1>

<%
    List<Object[]> resultList = ModulIncDB.getListQuelleEditionen(String.valueOf(id));

    if (resultList != null && !resultList.isEmpty()) {
%>

<!----------Ueberlieferung---------->
<h3><% Language.printTextfield(out, session, "quelle", "TabUeberlieferung");%></h3>
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

<h3 id="headline" style="display: none;"><% Language.printTextfield(out, session, "quelle", "TabUrkunde");%></h3>
<div class="container" id="urkunden">
    <table class="content-table">
        <tbody>
            <jsp:include page="../inc.erzeugeFormular.jsp">
                <jsp:param name="ID" value="<%= urkundeid%>" />
                <jsp:param name="Formular" value="urkunde" />
                <jsp:param name="Datenfeld" value="Actumort" />
                <jsp:param name="size" value="50" />
                <jsp:param name="Readonly" value="yes" />
                <jsp:param name="Darstellung" value="Tabellenzeile"/>
                <jsp:param name="Label" value="<%=Language.getDatafield(session, "urkunde", "Actumort")%>"/>
            </jsp:include>

            <jsp:include page="../inc.erzeugeFormular.jsp">
                <jsp:param name="ID" value="<%= urkundeid%>" />
                <jsp:param name="Formular" value="urkunde" />
                <jsp:param name="Datenfeld" value="Betreff" />
                <jsp:param name="size" value="50" />
                <jsp:param name="Readonly" value="yes" />
                <jsp:param name="Darstellung" value="Tabellenzeile"/>
                <jsp:param name="Label" value="<%=Language.getDatafield(session, "urkunde", "Betreff")%>"/>
            </jsp:include>

            <jsp:include page="../inc.erzeugeFormular.jsp">
                <jsp:param name="ID" value="<%= urkundeid%>" />
                <jsp:param name="Formular" value="urkunde" />
                <jsp:param name="Datenfeld" value="Aussteller" />
                <jsp:param name="Readonly" value="yes" />
                <jsp:param name="Darstellung" value="Tabellenzeile"/>
                <jsp:param name="Label" value="<%=Language.getDatafield(session, "urkunde", "Aussteller")%>"/>
            </jsp:include>

            <jsp:include page="../inc.erzeugeFormular.jsp">
                <jsp:param name="ID" value="<%= urkundeid%>" />
                <jsp:param name="Formular" value="urkunde" />
                <jsp:param name="Datenfeld" value="Empfaenger" />
                <jsp:param name="Readonly" value="yes" />
                <jsp:param name="Darstellung" value="Tabellenzeile"/>
                <jsp:param name="Label" value="<%=Language.getDatafield(session, "urkunde", "Empfaenger")%>"/>
            </jsp:include>

            <jsp:include page="../inc.erzeugeFormular.jsp">
                <jsp:param name="ID" value="<%= urkundeid%>" />
                <jsp:param name="Formular" value="urkunde" />
                <jsp:param name="Datenfeld" value="Dorsalnotiz" />
                <jsp:param name="size" value="50" />
                <jsp:param name="Readonly" value="yes" />
                <jsp:param name="Darstellung" value="Tabellenzeile"/>
                <jsp:param name="Label" value="<%=Language.getDatafield(session, "urkunde", "Dorsalnotiz")%>"/>
            </jsp:include>
        </tbody>
    </table>
</div>

<% }%>

<script>
    window.onload = function() {
        var urkundenDiv = document.getElementById("urkunden");
        // überprüfen, ob das div sichtbaren Inhalt enthält
        if (urkundenDiv && urkundenDiv.innerText.trim() !== "") {
            // Falls Inhalte vorhanden sind, die Überschrift und das div anzeigen
            document.getElementById("headline").style.display = "block";

        }
    };
</script>
