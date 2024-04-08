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

<jsp:include page="inc.erzeugeFormular.jsp">
    <jsp:param name="ID" value="<%= id%>"/>
    <jsp:param name="Formular" value="einzelbeleg"/>
    <jsp:param name="Datenfeld" value="ID"/>
    <jsp:param name="size" value="11"/>
</jsp:include>

<!----------ID---------->
<div class="container" id="id">
    <jsp:include page="../forms/id.jsp">
        <jsp:param name="ID" value="<%=id%>"/>
        <jsp:param name="title" value="gast_einzelbeleg"/>
    </jsp:include>
</div>

<!----------Belegstelle---------->
<h3 class="ut-heading ut-heading--h3"><% Language.printTextfield(out, session, "einzelbeleg", "TabBelegstelle"); %></h3>

<table class="ut-table ut-table--striped ut-table--striped--color-primary-3">
    <tbody class="ut-table__body">
        <tr class="ut-table__row">
            <td class="ut-table__item ut-table__body__item">
                <% Language.printDatafield(out, session, "einzelbeleg", "PersonRO");%>
            </td>
            <td class="ut-table__item ut-table__body__item">
                <jsp:include page="inc.erzeugeFormular.jsp">
                    <jsp:param name="ID" value="<%= id%>"/>
                    <jsp:param name="Formular" value="einzelbeleg"/>
                    <jsp:param name="Datenfeld" value="PersonRO"/>
                    <jsp:param name="Readonly" value="yes"/>
                </jsp:include>
            </td>
        </tr>
        <tr class="ut-table__row">
            <td class="ut-table__item ut-table__body__item">
                <% Language.printDatafield(out, session, "einzelbeleg", "Belegform");%>
            </td>
            <td class="ut-table__item ut-table__body__item">
                <jsp:include page="inc.erzeugeFormular.jsp">
                    <jsp:param name="ID" value="<%= id%>"/>
                    <jsp:param name="Formular" value="einzelbeleg"/>
                    <jsp:param name="Datenfeld" value="Belegform"/>
                    <jsp:param name="size" value="50"/>
                    <jsp:param name="Readonly" value="yes"/>
                </jsp:include>
            </td>
        </tr>
        <tr class="ut-table__row">
            <td class="ut-table__item ut-table__body__item">
                <% Language.printDatafield(out, session, "einzelbeleg", "LemmaRO");%>
            </td>
            <td class="ut-table__item ut-table__body__item">
                <jsp:include page="inc.erzeugeFormular.jsp">
                    <jsp:param name="ID" value="<%= id%>"/>
                    <jsp:param name="Formular" value="einzelbeleg"/>
                    <jsp:param name="Datenfeld" value="LemmaRO"/>
                    <jsp:param name="Readonly" value="yes"/>
                </jsp:include>
            </td>
        </tr>

        <tr class="ut-table__row">
            <td class="ut-table__item ut-table__body__item">
                <% Language.printDatafield(out, session, "einzelbeleg", "MGHLemmaRO");%>
            </td>
            <td class="ut-table__item ut-table__body__item">
                <jsp:include page="inc.erzeugeFormular.jsp">
                    <jsp:param name="ID" value="<%= id%>"/>
                    <jsp:param name="Formular" value="einzelbeleg"/>
                    <jsp:param name="Datenfeld" value="MGHLemmaRO"/>
                    <jsp:param name="Readonly" value="yes"/>
                </jsp:include>
            </td>
        </tr>


        <tr class="ut-table__row">
            <td class="ut-table__item ut-table__body__item">
                <% Language.printDatafield(out, session, "einzelbeleg", "Kontext");%>
            </td>
            <td class="ut-table__item ut-table__body__item">
                <jsp:include page="inc.erzeugeFormular.jsp">
                    <jsp:param name="ID" value="<%= id%>"/>
                    <jsp:param name="Formular" value="einzelbeleg"/>
                    <jsp:param name="Datenfeld" value="Kontext"/>
                    <jsp:param name="cols" value="40"/>
                    <jsp:param name="rows" value="5"/>
                    <jsp:param name="Readonly" value="yes"/>
                </jsp:include>
            </td>
        </tr>
        <tr class="ut-table__row">
            <td class="ut-table__item ut-table__body__item">
                <% Language.printDatafield(out, session, "einzelbeleg", "KontextSelektion");%>
            </td>
            <td class="ut-table__item ut-table__body__item">
                <jsp:include page="inc.erzeugeFormular.jsp">
                    <jsp:param name="ID" value="<%= id%>"/>
                    <jsp:param name="Formular" value="einzelbeleg"/>
                    <jsp:param name="Datenfeld" value="KontextSelektion"/>
                    <jsp:param name="Readonly" value="yes"/>
                </jsp:include>
            </td>
        </tr>
        <tr class="ut-table__row">
            <td class="ut-table__item ut-table__body__item">
                <% Language.printDatafield(out, session, "einzelbeleg", "KritikSelektion");%>
            </td>
            <td class="ut-table__item ut-table__body__item">
                <jsp:include page="inc.erzeugeFormular.jsp">
                    <jsp:param name="ID" value="<%= id%>"/>
                    <jsp:param name="Formular" value="einzelbeleg"/>
                    <jsp:param name="Datenfeld" value="KritikSelektion"/>
                    <jsp:param name="Readonly" value="yes"/>
                </jsp:include>
            </td>
        </tr>
        <tr class="ut-table__row">
            <td class="ut-table__item ut-table__body__item">
                <% Language.printDatafield(out, session, "einzelbeleg", "LebendVerstorben");%>
            </td>
            <td class="ut-table__item ut-table__body__item">
                <jsp:include page="inc.erzeugeFormular.jsp">
                    <jsp:param name="ID" value="<%= id%>"/>
                    <jsp:param name="Formular" value="einzelbeleg"/>
                    <jsp:param name="Datenfeld" value="LebendVerstorben"/>
                    <jsp:param name="Readonly" value="yes"/>
                </jsp:include>
            </td>
        </tr>
        <tr class="ut-table__row">
            <td class="ut-table__item ut-table__body__item">
                <% Language.printTextfield(out, session, "einzelbeleg", "DatierungNennung");%>
            </td>
            <td class="ut-table__item ut-table__body__item">
                <jsp:include page="inc.erzeugeFormular.jsp">
                    <jsp:param name="Formular" value="gast_einzelbeleg"/>
                    <jsp:param name="ID" value="<%= id%>"/>
                    <jsp:param name="Datenfeld" value="Datierung"/>
                    <jsp:param name="Readonly" value="yes"/>
                </jsp:include>
            </td>
        </tr>
        <tr class="ut-table__row">
            <td class="ut-table__item ut-table__body__item">
                <% Language.printDatafield(out, session, "einzelbeleg", "DatierungUngewiss");%>
            </td>
            <td class="ut-table__item ut-table__body__item">
                <jsp:include page="inc.erzeugeFormular.jsp">
                    <jsp:param name="ID" value="<%= id%>"/>
                    <jsp:param name="Formular" value="einzelbeleg"/>
                    <jsp:param name="Datenfeld" value="DatierungUngewiss"/>
                    <jsp:param name="Readonly" value="yes"/>
                </jsp:include>
            </td>
        </tr>
        <tr class="ut-table__row">
            <td class="ut-table__item ut-table__body__item">
                <% Language.printDatafield(out, session, "einzelbeleg", "KommentarDatierung");%>
            </td>
            <td class="ut-table__item ut-table__body__item">
                <jsp:include page="inc.erzeugeFormular.jsp">
                    <jsp:param name="ID" value="<%= id%>"/>
                    <jsp:param name="Formular" value="einzelbeleg"/>
                    <jsp:param name="Datenfeld" value="KommentarDatierung"/>
                    <jsp:param name="cols" value="40"/>
                    <jsp:param name="rows" value="5"/>
                    <jsp:param name="Readonly" value="yes"/>
                </jsp:include>
            </td>
        </tr>
        <tr class="ut-table__row">
            <td class="ut-table__item ut-table__body__item">
                <% Language.printDatafield(out, session, "einzelbeleg", "Konvent");%>
            </td>
            <td class="ut-table__item ut-table__body__item">
                <jsp:include page="inc.erzeugeFormular.jsp">
                    <jsp:param name="ID" value="<%= id%>"/>
                    <jsp:param name="Formular" value="einzelbeleg"/>
                    <jsp:param name="Datenfeld" value="Konvent"/>
                    <jsp:param name="Readonly" value="yes"/>
                </jsp:include>
            </td>
        </tr>
        <tr class="ut-table__row">
            <td class="ut-table__item ut-table__body__item">
                <% Language.printDatafield(out, session, "einzelbeleg", "PalAbgrenzung");%>
            </td>
            <td class="ut-table__item ut-table__body__item">
                <jsp:include page="inc.erzeugeFormular.jsp">
                    <jsp:param name="ID" value="<%= id%>"/>
                    <jsp:param name="Formular" value="einzelbeleg"/>
                    <jsp:param name="Datenfeld" value="PalAbgrenzung"/>
                    <jsp:param name="Readonly" value="yes"/>
                </jsp:include>
            </td>
        </tr>
        <tr class="ut-table__row">
            <td class="ut-table__item ut-table__body__item">
                <% Language.printDatafield(out, session, "einzelbeleg", "InhAbgrenzung");%>
            </td>
            <td class="ut-table__item ut-table__body__item">
                <jsp:include page="inc.erzeugeFormular.jsp">
                    <jsp:param name="ID" value="<%= id%>"/>
                    <jsp:param name="Formular" value="einzelbeleg"/>
                    <jsp:param name="Datenfeld" value="InhAbgrenzung"/>
                    <jsp:param name="Readonly" value="yes"/>
                </jsp:include>
            </td>
        </tr>
        <tr class="ut-table__row">
            <td class="ut-table__item ut-table__body__item">
                <% Language.printDatafield(out, session, "einzelbeleg", "NrInStrukt");%>
            </td>
            <td class="ut-table__item ut-table__body__item">
                <jsp:include page="inc.erzeugeFormular.jsp">
                    <jsp:param name="ID" value="<%= id%>"/>
                    <jsp:param name="Formular" value="einzelbeleg"/>
                    <jsp:param name="Datenfeld" value="NrInStrukt"/>
                    <jsp:param name="Readonly" value="yes"/>
                </jsp:include>
            </td>
        </tr>
        <tr class="ut-table__row">
            <td class="ut-table__item ut-table__body__item">
                <% Language.printDatafield(out, session, "einzelbeleg", "Seite");%>
            </td>
            <td class="ut-table__item ut-table__body__item">
                <jsp:include page="inc.erzeugeFormular.jsp">
                    <jsp:param name="ID" value="<%= id%>"/>
                    <jsp:param name="Formular" value="einzelbeleg"/>
                    <jsp:param name="Datenfeld" value="Seite"/>
                    <jsp:param name="Readonly" value="yes"/>
                </jsp:include>
            </td>
        </tr>
        <tr class="ut-table__row">
            <td class="ut-table__item ut-table__body__item">
                <% Language.printDatafield(out, session, "einzelbeleg", "Raster");%>
            </td>
            <td class="ut-table__item ut-table__body__item">
                <jsp:include page="inc.erzeugeFormular.jsp">
                    <jsp:param name="ID" value="<%= id%>"/>
                    <jsp:param name="Formular" value="einzelbeleg"/>
                    <jsp:param name="Datenfeld" value="Raster"/>
                    <jsp:param name="Readonly" value="yes"/>
                </jsp:include>
            </td>
        </tr>
        <tr class="ut-table__row">
            <td class="ut-table__item ut-table__body__item">
                <% Language.printDatafield(out, session, "einzelbeleg", "Schreiber");%>
            </td>
            <td class="ut-table__item ut-table__body__item">
                <jsp:include page="inc.erzeugeFormular.jsp">
                    <jsp:param name="ID" value="<%= id%>"/>
                    <jsp:param name="Formular" value="einzelbeleg"/>
                    <jsp:param name="Datenfeld" value="Schreiber"/>
                    <jsp:param name="Readonly" value="yes"/>
                </jsp:include>
            </td>
        </tr>
    </tbody>
</table>

<!----------Quelle---------->
<h3 class="ut-heading ut-heading--h3"><% Language.printTextfield(out, session, "einzelbeleg", "BoxQuelle"); %></h3>
<table class="ut-table ut-table--striped ut-table--striped--color-primary-3">
    <tbody class="ut-table__body">
        <tr class="ut-table__row">
            <td class="ut-table__item ut-table__body__item">
                <% Language.printTextfield(out, session, "einzelbeleg", "Kurztitel");%>
            </td>
            <td class="ut-table__item ut-table__body__item">
                <jsp:include page="inc.erzeugeFormular.jsp">
                    <jsp:param name="ID" value="<%= id%>"/>
                    <jsp:param name="Formular" value="einzelbeleg"/>
                    <jsp:param name="Datenfeld" value="QuelleLink"/>
                </jsp:include>
            </td>
        </tr>
        <tr class="ut-table__row">
            <td class="ut-table__item ut-table__body__item">
                <% Language.printTextfield(out, session, "einzelbeleg", "Edition");%>
            </td>
            <td class="ut-table__item ut-table__body__item">
                <jsp:include page="inc.erzeugeFormular.jsp">
                    <jsp:param name="ID" value="<%= id%>"/>
                    <jsp:param name="Formular" value="einzelbeleg"/>
                    <jsp:param name="Datenfeld" value="Edition"/>
                    <jsp:param name="Readonly" value="yes"/>
                </jsp:include>
            </td>
        </tr>
        <tr class="ut-table__row">
            <td class="ut-table__item ut-table__body__item">
                <% Language.printTextfield(out, session, "einzelbeleg", "Kapitel");%>
            </td>
            <td class="ut-table__item ut-table__body__item">
                <jsp:include page="inc.erzeugeFormular.jsp">
                    <jsp:param name="ID" value="<%= id%>"/>
                    <jsp:param name="Formular" value="einzelbeleg"/>
                    <jsp:param name="Datenfeld" value="EditionKapitel"/>
                    <jsp:param name="size" value="20"/>
                    <jsp:param name="Readonly" value="yes"/>
                </jsp:include>
            </td>
        </tr>
        <tr class="ut-table__row">
            <td class="ut-table__item ut-table__body__item">
                <% Language.printTextfield(out, session, "einzelbeleg", "Seite");%>
            </td>
            <td class="ut-table__item ut-table__body__item">
                <jsp:include page="inc.erzeugeFormular.jsp">
                    <jsp:param name="ID" value="<%= id%>"/>
                    <jsp:param name="Formular" value="einzelbeleg"/>
                    <jsp:param name="Datenfeld" value="EditionSeite"/>
                    <jsp:param name="size" value="20"/>
                    <jsp:param name="Readonly" value="yes"/>
                </jsp:include>
            </td>
        </tr>
        <tr class="ut-table__row">
            <td class="ut-table__item ut-table__body__item">
                <% Language.printDatafield(out, session, "einzelbeleg", "QuelleDatierung");%>
            </td>
            <td class="ut-table__item ut-table__body__item">
                <jsp:include page="inc.erzeugeFormular.jsp">
                    <jsp:param name="Formular" value="gast_einzelbeleg"/>
                    <jsp:param name="ID" value="<%= id%>"/>
                    <jsp:param name="Datenfeld" value="QuelleDatierung"/>
                    <jsp:param name="Readonly" value="yes"/>
                </jsp:include>
            </td>
        </tr>
    </tbody>
</table>

<!----------Textkritik---------->
<div class="container">
    <h3 class="ut-heading ut-heading--h3"><% Language.printTextfield(out, session, "einzelbeleg", "TabTextkritik");%></h3>
    <jsp:include page="../inc.modul.jsp">
        <jsp:param name="ID" value="<%= id%>"/>
        <jsp:param name="Formular" value="einzelbeleg"/>
        <jsp:param name="Modul" value="lesartenRO"/>
    </jsp:include>
</div>
