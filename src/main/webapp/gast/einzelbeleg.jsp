<%@ page import="de.uni_tuebingen.ub.nppm.util.Language" isThreadSafe="false" %>
<%@ include file="../configuration.jsp" %>
<%@ include file="../functions.jsp" %>

<jsp:include page="../dofilter.jsp" />


<%    int id = Integer.parseInt(request.getParameter("ID"));
%>


<jsp:include page="../dojump.jsp">
    <jsp:param name="form" value="gast_einzelbeleg" />
</jsp:include>

<jsp:include page="layout/titel.inc.jsp">
    <jsp:param name="title" value="Einzelbeleg" />
    <jsp:param name="ID" value="<%= id%>" />
    <jsp:param name="size" value="" />
    <jsp:param name="Formular" value="einzelbeleg" />
</jsp:include>

<jsp:include page="../inc.erzeugeFormular.jsp">
    <jsp:param name="ID" value="<%= id%>"/>
    <jsp:param name="Formular" value="einzelbeleg"/>
    <jsp:param name="Datenfeld" value="ID"/>
    <jsp:param name="size" value="11"/>
</jsp:include>

<!----------ID---------->
<div id="id">
    <jsp:include page="../forms/id.jsp">
        <jsp:param name="ID" value="<%=id%>"/>
        <jsp:param name="title" value="gast_einzelbeleg"/>
    </jsp:include>
</div>

<!----------Belegstelle---------->
<h3><% Language.printTextfield(out, session, "einzelbeleg", "TabBelegstelle");%></h3>

<table class="content-table">
    <tbody>

        <jsp:include page="../inc.erzeugeFormular.jsp">
            <jsp:param name="ID" value="<%= id%>"/>
            <jsp:param name="Formular" value="einzelbeleg"/>
            <jsp:param name="Datenfeld" value="PersonRO"/>
            <jsp:param name="Readonly" value="yes"/>
            <jsp:param name="Darstellung" value="Tabellenzeile"/>
            <jsp:param name="Label" value="<%=Language.getDatafield(session, "einzelbeleg", "PersonRO")%>"/>
        </jsp:include>

        <tr>
            <th><% Language.printDatafield(out, session, "einzelbeleg", "Belegform");%></th>
            <td>
                <div style="display: flex; align-items: center;">
                    <jsp:include page="../inc.erzeugeFormular.jsp">
                        <jsp:param name="ID" value="<%= id%>"/>
                        <jsp:param name="Formular" value="einzelbeleg"/>
                        <jsp:param name="Datenfeld" value="Belegform"/>
                        <jsp:param name="size" value="50"/>
                        <jsp:param name="Readonly" value="yes"/>
                    </jsp:include>
                </div>
                <jsp:include page="../inc.erzeugeFormular.jsp">
                    <jsp:param name="ID" value="<%= id%>"/>
                    <jsp:param name="Formular" value="einzelbeleg"/>
                    <jsp:param name="Datenfeld" value="Griechisch"/>
                    <jsp:param name="size" value="50"/>
                    <jsp:param name="Readonly" value="yes"/>
                </jsp:include>
            </td>
        </tr>

        <jsp:include page="../inc.erzeugeFormular.jsp">
            <jsp:param name="ID" value="<%= id%>"/>
            <jsp:param name="Formular" value="einzelbeleg"/>
            <jsp:param name="Datenfeld" value="LemmaRO"/>
            <jsp:param name="Readonly" value="yes"/>
            <jsp:param name="Darstellung" value="Tabellenzeile"/>
            <jsp:param name="Label" value="<%=Language.getDatafield(session, "einzelbeleg", "LemmaRO")%>"/>
        </jsp:include>

        <jsp:include page="../inc.erzeugeFormular.jsp">
            <jsp:param name="ID" value="<%= id%>"/>
            <jsp:param name="Formular" value="einzelbeleg"/>
            <jsp:param name="Datenfeld" value="MGHLemmaRO"/>
            <jsp:param name="Readonly" value="yes"/>
            <jsp:param name="Darstellung" value="Tabellenzeile"/>
            <jsp:param name="Label" value="<%=Language.getDatafield(session, "einzelbeleg", "MGHLemmaRO")%>"/>
        </jsp:include>

        <jsp:include page="../inc.erzeugeFormular.jsp">
            <jsp:param name="ID" value="<%= id%>"/>
            <jsp:param name="Formular" value="einzelbeleg"/>
            <jsp:param name="Datenfeld" value="Kontext"/>
            <jsp:param name="cols" value="40"/>
            <jsp:param name="rows" value="5"/>
            <jsp:param name="Readonly" value="yes"/>
            <jsp:param name="Darstellung" value="Tabellenzeile"/>
            <jsp:param name="Label" value="<%=Language.getDatafield(session, "einzelbeleg", "Kontext")%>"/>
        </jsp:include>

        <jsp:include page="../inc.erzeugeFormular.jsp">
            <jsp:param name="ID" value="<%= id%>"/>
            <jsp:param name="Formular" value="einzelbeleg"/>
            <jsp:param name="Datenfeld" value="KontextSelektion"/>
            <jsp:param name="Readonly" value="yes"/>
            <jsp:param name="Darstellung" value="Tabellenzeile"/>
            <jsp:param name="Label" value="<%=Language.getDatafield(session, "einzelbeleg", "KontextSelektion")%>"/>
        </jsp:include>

        <jsp:include page="../inc.erzeugeFormular.jsp">
            <jsp:param name="ID" value="<%= id%>"/>
            <jsp:param name="Formular" value="einzelbeleg"/>
            <jsp:param name="Datenfeld" value="KritikSelektion"/>
            <jsp:param name="Readonly" value="yes"/>
            <jsp:param name="Darstellung" value="Tabellenzeile"/>
            <jsp:param name="Label" value="<%=Language.getDatafield(session, "einzelbeleg", "KritikSelektion")%>"/>
        </jsp:include>

        <jsp:include page="../inc.erzeugeFormular.jsp">
            <jsp:param name="ID" value="<%= id%>"/>
            <jsp:param name="Formular" value="einzelbeleg"/>
            <jsp:param name="Datenfeld" value="LebendVerstorben"/>
            <jsp:param name="Readonly" value="yes"/>
            <jsp:param name="Darstellung" value="Tabellenzeile"/>
            <jsp:param name="Label" value="<%=Language.getDatafield(session, "einzelbeleg", "LebendVerstorben")%>"/>
        </jsp:include>

        <jsp:include page="../inc.erzeugeFormular.jsp">
            <jsp:param name="Formular" value="gast_einzelbeleg"/>
            <jsp:param name="ID" value="<%= id%>"/>
            <jsp:param name="Datenfeld" value="Datierung"/>
            <jsp:param name="Readonly" value="yes"/>
            <jsp:param name="Darstellung" value="Tabellenzeile"/>
            <jsp:param name="Label" value="<%=Language.getTextfield(session, "einzelbeleg", "DatierungNennung")%>"/>
        </jsp:include>

        <%
            // Prüfe das Attribut
            Boolean displayDatierung = (Boolean) request.getAttribute("displayDatierungUngewiss");
            if (displayDatierung != null && displayDatierung) {
        %>

        <jsp:include page="../inc.erzeugeFormular.jsp">
            <jsp:param name="ID" value="<%= id%>"/>
            <jsp:param name="Formular" value="einzelbeleg"/>
            <jsp:param name="Datenfeld" value="DatierungUngewiss"/>
            <jsp:param name="Readonly" value="yes"/>
            <jsp:param name="Darstellung" value="Tabellenzeile"/>
            <jsp:param name="Label" value="<%=Language.getDatafield(session, "einzelbeleg", "DatierungUngewiss")%>"/>
        </jsp:include>

        <%
            }
        %>

        <jsp:include page="../inc.erzeugeFormular.jsp">
            <jsp:param name="ID" value="<%= id%>"/>
            <jsp:param name="Formular" value="einzelbeleg"/>
            <jsp:param name="Datenfeld" value="KommentarDatierung"/>
            <jsp:param name="cols" value="40"/>
            <jsp:param name="rows" value="5"/>
            <jsp:param name="Readonly" value="yes"/>
            <jsp:param name="Darstellung" value="Tabellenzeile"/>
            <jsp:param name="Label" value="<%=Language.getDatafield(session, "einzelbeleg", "KommentarDatierung")%>"/>
        </jsp:include>

        <jsp:include page="../inc.erzeugeFormular.jsp">
            <jsp:param name="ID" value="<%= id%>"/>
            <jsp:param name="Formular" value="einzelbeleg"/>
            <jsp:param name="Datenfeld" value="Konvent"/>
            <jsp:param name="Readonly" value="yes"/>
            <jsp:param name="Darstellung" value="Tabellenzeile"/>
            <jsp:param name="Label" value="<%=Language.getDatafield(session, "einzelbeleg", "Konvent")%>"/>
        </jsp:include>

        <jsp:include page="../inc.erzeugeFormular.jsp">
            <jsp:param name="ID" value="<%= id%>"/>
            <jsp:param name="Formular" value="einzelbeleg"/>
            <jsp:param name="Datenfeld" value="PalAbgrenzung"/>
            <jsp:param name="Readonly" value="yes"/>
            <jsp:param name="Darstellung" value="Tabellenzeile"/>
            <jsp:param name="Label" value="<%=Language.getDatafield(session, "einzelbeleg", "PalAbgrenzung")%>"/>
        </jsp:include>

        <jsp:include page="../inc.erzeugeFormular.jsp">
            <jsp:param name="ID" value="<%= id%>"/>
            <jsp:param name="Formular" value="einzelbeleg"/>
            <jsp:param name="Datenfeld" value="InhAbgrenzung"/>
            <jsp:param name="Readonly" value="yes"/>
            <jsp:param name="Darstellung" value="Tabellenzeile"/>
            <jsp:param name="Label" value="<%=Language.getDatafield(session, "einzelbeleg", "InhAbgrenzung")%>"/>
        </jsp:include>

        <jsp:include page="../inc.erzeugeFormular.jsp">
            <jsp:param name="ID" value="<%= id%>"/>
            <jsp:param name="Formular" value="einzelbeleg"/>
            <jsp:param name="Datenfeld" value="NrInStrukt"/>
            <jsp:param name="Readonly" value="yes"/>
            <jsp:param name="Darstellung" value="Tabellenzeile"/>
            <jsp:param name="Label" value="<%=Language.getDatafield(session, "einzelbeleg", "NrInStrukt")%>"/>
        </jsp:include>

        <jsp:include page="../inc.erzeugeFormular.jsp">
            <jsp:param name="ID" value="<%= id%>"/>
            <jsp:param name="Formular" value="einzelbeleg"/>
            <jsp:param name="Datenfeld" value="Seite"/>
            <jsp:param name="Readonly" value="yes"/>
            <jsp:param name="Darstellung" value="Tabellenzeile"/>
            <jsp:param name="Label" value="<%=Language.getDatafield(session, "einzelbeleg", "Seite")%>"/>
        </jsp:include>

        <jsp:include page="../inc.erzeugeFormular.jsp">
            <jsp:param name="ID" value="<%= id%>"/>
            <jsp:param name="Formular" value="einzelbeleg"/>
            <jsp:param name="Datenfeld" value="Raster"/>
            <jsp:param name="Readonly" value="yes"/>
            <jsp:param name="Darstellung" value="Tabellenzeile"/>
            <jsp:param name="Label" value="<%=Language.getDatafield(session, "einzelbeleg", "Raster")%>"/>
        </jsp:include>

        <jsp:include page="../inc.erzeugeFormular.jsp">
            <jsp:param name="ID" value="<%= id%>"/>
            <jsp:param name="Formular" value="einzelbeleg"/>
            <jsp:param name="Datenfeld" value="Schreiber"/>
            <jsp:param name="Readonly" value="yes"/>
            <jsp:param name="Darstellung" value="Tabellenzeile"/>
            <jsp:param name="Label" value="<%=Language.getDatafield(session, "einzelbeleg", "Schreiber")%>"/>
        </jsp:include>

    </tbody>
</table>

<!----------Quelle---------->
<h3><% Language.printTextfield(out, session, "einzelbeleg", "BoxQuelle"); %></h3>
<table class="content-table">
    <tr>
        <th><% Language.printTextfield(out, session, "einzelbeleg", "Kurztitel");%></th>
        <td>
            <jsp:include page="../inc.erzeugeFormular.jsp">
                <jsp:param name="ID" value="<%= id%>"/>
                <jsp:param name="Formular" value="einzelbeleg"/>
                <jsp:param name="Datenfeld" value="QuelleLink"/>
            </jsp:include>
        </td>
    </tr>

    <jsp:include page="../inc.erzeugeFormular.jsp">
        <jsp:param name="ID" value="<%= id%>"/>
        <jsp:param name="Formular" value="einzelbeleg"/>
        <jsp:param name="Datenfeld" value="Edition"/>
        <jsp:param name="Readonly" value="yes"/>
        <jsp:param name="Darstellung" value="Tabellenzeile"/>
        <jsp:param name="Label" value="<%=Language.getTextfield(session, "einzelbeleg", "Edition")%>"/>
    </jsp:include>

    <jsp:include page="../inc.erzeugeFormular.jsp">
        <jsp:param name="ID" value="<%= id%>"/>
        <jsp:param name="Formular" value="einzelbeleg"/>
        <jsp:param name="Datenfeld" value="EditionKapitel"/>
        <jsp:param name="size" value="20"/>
        <jsp:param name="Readonly" value="yes"/>
        <jsp:param name="Darstellung" value="Tabellenzeile"/>
        <jsp:param name="Label" value="<%=Language.getTextfield(session, "einzelbeleg", "Kapitel")%>"/>
    </jsp:include>

    <jsp:include page="../inc.erzeugeFormular.jsp">
        <jsp:param name="ID" value="<%= id%>"/>
        <jsp:param name="Formular" value="einzelbeleg"/>
        <jsp:param name="Datenfeld" value="EditionSeite"/>
        <jsp:param name="size" value="20"/>
        <jsp:param name="Readonly" value="yes"/>
        <jsp:param name="Darstellung" value="Tabellenzeile"/>
        <jsp:param name="Label" value="<%=Language.getTextfield(session, "einzelbeleg", "Seite")%>"/>
    </jsp:include>

    <jsp:include page="../inc.erzeugeFormular.jsp">
        <jsp:param name="Formular" value="gast_einzelbeleg"/>
        <jsp:param name="ID" value="<%= id%>"/>
        <jsp:param name="Datenfeld" value="QuelleDatierung"/>
        <jsp:param name="Readonly" value="yes"/>
        <jsp:param name="Darstellung" value="Tabellenzeile"/>
        <jsp:param name="Label" value="<%=Language.getDatafield(session, "einzelbeleg", "QuelleDatierung")%>"/>
    </jsp:include>

</table>

<!----------Textkritik---------->
<div id="textkritik">
    <jsp:include page="../inc.modul.jsp">
        <jsp:param name="ID" value="<%= id%>"/>
        <jsp:param name="Formular" value="einzelbeleg"/>
        <jsp:param name="Modul" value="lesartenRO"/>
        <jsp:param name="Darstellung" value="Tabellenzeile"/>
        <jsp:param name="Label" value="<%=Language.getTextfield(session, "einzelbeleg", "TabTextkritik")%>"/>
    </jsp:include>
</div>
