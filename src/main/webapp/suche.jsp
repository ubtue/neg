<%@ page import="de.uni_tuebingen.ub.nppm.util.Language" isThreadSafe="false" %>
<%@ include file="configuration.jsp"%>
<%@ include file="functions.jsp"%>

<div>
<jsp:include page="layout/navigation.inc.jsp" />
<jsp:include page="layout/image.inc.html" />
<jsp:include page="layout/titel.suche.html" />

<div id="form">
<div id="tab1">
<div id="header">
<ul id="primary">
	<li><span>
            <% Language.printTextfield(out,session, "suche","TabLemma");%>
            </span></li>
	<li><a href="javascript:onoff('tab2','tab1');">
            <% Language.printTextfield(out,session, "person","Titel");%>
            </a></li>
	<li><a href="javascript:onoff('tab3','tab1');">
            <% Language.printTextfield(out,session, "quelle","Titel");%>
            </a></li>
	<li><a href="javascript:onoff('tab4','tab1');">
            <% Language.printTextfield(out,session, "edition","Titel");%>
            </a></li>
	<li><a href="javascript:onoff('tab5','tab1');">
            <% Language.printTextfield(out,session, "handschrift","Titel");%>
            </a></li>
	<li><a href="javascript:onoff('tab6','tab1');">
            <% Language.printTextfield(out,session, "namenkommentar","Titel");%>
            </a></li>
	<li><a href="javascript:onoff('tab8','tab1');">
            <% Language.printTextfield(out,session, "suche","TabFavoriten");%>
            </a></li>
</ul>
</div>
<div id="main">
<form method="post" action="suche"><input type="hidden"
	name="form" value="identischesLemma" />
<table>
	<tr>
		<th width="200">Belegform</th>
		<td width="450"><input type="text" size="50" name="Belegform" /></td>
	</tr>
</table>
<br>
<p><input type="reset" value="abbrechen" />&nbsp;&nbsp;<input
	type="submit" value="Suchen" /></p>
</form>

<%
	if (request.getParameter("form") != null
				&& request.getParameter("form").equals(
						"identischesLemma")) {
%>
<%@ include file="suche/identischesLemma.jsp"%>
<%
	}
%>
</div>
</div>

<div id="tab2">
<div id="header">
<ul id="primary">
	<li><a href="javascript:onoff('tab1','tab2');">
            <% Language.printTextfield(out,session, "suche","TabLemma");%>
            </a></li>
	<li><span>
            <% Language.printTextfield(out,session, "person","Titel");%>
            </span></li>
	<li><a href="javascript:onoff('tab3','tab2');">
            <% Language.printTextfield(out,session, "quelle","Titel");%>
            </a></li>
	<li><a href="javascript:onoff('tab4','tab2');">
            <% Language.printTextfield(out,session, "edition","Titel");%>
            </a></li>
	<li><a href="javascript:onoff('tab5','tab2');">
            <% Language.printTextfield(out,session, "handschrift","Titel");%>
            </a></li>
	<li><a href="javascript:onoff('tab6','tab2');">
            <% Language.printTextfield(out,session, "namenkommentar","Titel");%>
            </a></li>
	<li><a href="javascript:onoff('tab8','tab2');">
            <% Language.printTextfield(out,session, "suche","TabFavoriten");%>
            </a></li>
</ul>
</div>
<div id="main">
<form method="post" action="suchergebnis"><input
	type="hidden" name="form" value="person" />
<table>
	<tr>
		<th width="200">PKZ</th>
		<td width="450"><input type="text" size="50" name="PKZ" /></td>
	</tr>
	<tr>
		<th width="200">1. Belegform</th>
		<td width="450"><input type="text" size="50" name="Belegform"
			disabled /></td>
	</tr>
	<tr>
		<th width="200">Personenname</th>
		<td width="450"><input type="text" size="50" name="Person" /></td>
	</tr>
	<tr>
		<th width="200">Amt</th>
		<td width="450"><input type="text" size="50" name="Amt" disabled /></td>
	</tr>
	<tr>
		<th width="200">Stand</th>
		<td width="450"><jsp:include page="inc.suchformular.jsp">
			<jsp:param name="Formular" value="selektion_stand" />
			<jsp:param name="Datenfeld" value="Stand" />
		</jsp:include>
                </td>
	</tr>
	<tr>
		<th width="200">Ethnie</th>
		<td width="450"><jsp:include page="inc.suchformular.jsp">
			<jsp:param name="Formular" value="selektion_ethnie" />
			<jsp:param name="Datenfeld" value="Ethnie" />
		</jsp:include>

                </td>
	</tr>
	<tr>
		<th width="200">Geschlecht</th>
		<td width="450"><jsp:include page="inc.suchformular.jsp">
			<jsp:param name="Formular" value="selektion_geschlecht" />
			<jsp:param name="Datenfeld" value="Geschlecht" />
		</jsp:include></td>
	</tr>
</table>
<br>
<h2>Ausgabefelder</h2>
<table>
	<tr>
		<td><input type="checkbox" name="AusgabePerson" /></td>
		<td width="200">Person</td>
		<td><input type="checkbox" name="AusgabeBeleform" disabled /></td>
		<td width="200">1. Belegform</td>
	</tr>
	<tr>
		<td><input type="checkbox" name="AusgabeZusatz" disabled /></td>
		<td width="200">Zusatz</td>
		<td><input type="checkbox" name="AusgabeAmt" disabled /></td>
		<td width="200">Amt</td>
	</tr>
	<tr>
		<td><input type="checkbox" name="AusgabeStand" /></td>
		<td width="200">Stand</td>
		<td><input type="checkbox" name="AusgabeEthnie" /></td>
		<td width="200">Ethnie</td>
	</tr>
	<tr>
		<td><input type="checkbox" name="AusgabeGeschlecht" /></td>
		<td width="200">Geschlecht</td>
		<td><input type="checkbox" name="AusgabeDatumErste" disabled /></td>
		<td width="200">Datum erste Nennung</td>
	</tr>
	<tr>
		<td><input type="checkbox" name="AusgabeDatumLetzte" disabled /></td>
		<td width="200">Datum letzte Nennung</td>
	</tr>
</table>
<p><input type="reset" value="abbrechen" />&nbsp;&nbsp;<input
	type="submit" value="Suchen" /></p>
</form>
</div>
</div>

<div id="tab3">
<div id="header">
<ul id="primary">
	<li><a href="javascript:onoff('tab1','tab3');">
            <% Language.printTextfield(out,session, "suche","TabLemma");%>
            </a></li>
	<li><a href="javascript:onoff('tab2','tab3');">
            <% Language.printTextfield(out,session, "person","Titel");%>
            </a></li>
	<li><span>
            <% Language.printTextfield(out,session, "quelle","Titel");%>
            </span></li>
	<li><a href="javascript:onoff('tab4','tab3');">
            <% Language.printTextfield(out,session, "edition","Titel");%>
            </a></li>
	<li><a href="javascript:onoff('tab5','tab3');">
            <% Language.printTextfield(out,session, "handschrift","Titel");%>
            </a></li>
	<li><a href="javascript:onoff('tab6','tab3');">
            <% Language.printTextfield(out,session, "namenkommentar","Titel");%>
            </a></li>
	<li><a href="javascript:onoff('tab8','tab3');">
            <% Language.printTextfield(out,session, "suche","Titel");%>
            </a></li>
</ul>
</div>
<div id="main">
<form method="post" action="suchergebnis"><input
	type="hidden" name="form" value="quelle" />
<table>
	<tr>
		<th width="200">Quelle</th>
		<td width="450"><input type="text" size="50" name="Quelle" /></td>
	</tr>
	<tr>
		<th width="200">Handschrift</th>
		<td width="450"><input type="text" size="50" name="Handschrift"
			disabled /></td>
	</tr>
	<tr>
		<th width="200">Edition</th>
		<td width="450"><input type="text" size="50" name="Edition" /></td>
	</tr>
</table>
<br>
<h2>Ausgabefelder</h2>
<table>
	<tr>
		<td><input type="checkbox" name="AusgabeID" checked disabled /></td>
		<td width="200">ID</td>
		<td><input type="checkbox" name="AusgabeKurztitel" /></td>
		<td width="200">Kurztitel</td>
	</tr>
	<tr>
		<td><input type="checkbox" name="AusgabeHandschrift" disabled /></td>
		<td width="200">Handschrift</td>
		<td><input type="checkbox" name="AusgabeEdition" /></td>
		<td width="200">Edition</td>
	</tr>
	<tr>
		<td><input type="checkbox" name="AusgabeBelegform" disabled /></td>
		<td width="200">Belegform</td>
	</tr>
</table>
<p><input type="reset" value="abbrechen" />&nbsp;&nbsp;<input
	type="submit" value="Suchen" /></p>
</form>
</div>
</div>

<div id="tab4">
<div id="header">
<ul id="primary">
	<li><a href="javascript:onoff('tab1','tab4');">
            <% Language.printTextfield(out,session, "suche","TabLemma");%>
            </a></li>
	<li><a href="javascript:onoff('tab2','tab4');">
            <% Language.printTextfield(out,session, "person","Titel");%>
            </a></li>
	<li><a href="javascript:onoff('tab3','tab4');">
            <% Language.printTextfield(out,session, "quelle","Titel");%>
            </a></li>
	<li><span>
            <% Language.printTextfield(out,session, "edition","Titel");%>
            </span></li>
	<li><a href="javascript:onoff('tab5','tab4');">
            <% Language.printTextfield(out,session, "handschrift","Titel");%>
            </a></li>
	<li><a href="javascript:onoff('tab6','tab4');">
            <% Language.printTextfield(out,session, "namenkommentar","Titel");%>
            </a></li>
	<li><a href="javascript:onoff('tab8','tab4');">
            <% Language.printTextfield(out,session, "suche","TabFavoriten");%>
            </a></li>
</ul>
</div>
<div id="main">
<p>folgt!</p>
</div>
</div>

<div id="tab5">
<div id="header">
<ul id="primary">
	<li><a href="javascript:onoff('tab1','tab5');">
            <% Language.printTextfield(out,session, "suche","TabLemma");%>
            </a></li>
	<li><a href="javascript:onoff('tab2','tab5');">
            <% Language.printTextfield(out,session, "person","Titel");%>
            </a></li>
	<li><a href="javascript:onoff('tab3','tab5');">
            <% Language.printTextfield(out,session, "quelle","Titel");%>
            </a></li>
	<li><a href="javascript:onoff('tab4','tab5');">
            <% Language.printTextfield(out,session, "edition","Titel");%>
            </a></li>
	<li><span>
            <% Language.printTextfield(out,session, "handschrift","Titel");%>
            </span></li>
	<li><a href="javascript:onoff('tab6','tab5');">
            <% Language.printTextfield(out,session, "namenkommentar","Titel");%>
            </a></li>
	<li><a href="javascript:onoff('tab8','tab5');">
            <% Language.printTextfield(out,session, "suche","TabFavoriten");%>
            </a></li>
</ul>
</div>
<div id="main">
<p>folgt!</p>
</div>
</div>

<div id="tab6">
<div id="header">
<ul id="primary">
	<li><a href="javascript:onoff('tab1','tab6');">
            <% Language.printTextfield(out,session, "suche","TabLemma");%>
            </a></li>
	<li><a href="javascript:onoff('tab2','tab6');">
            <% Language.printTextfield(out,session, "person","Titel");%>
            </a></li>
	<li><a href="javascript:onoff('tab3','tab6');">
            <% Language.printTextfield(out,session, "quelle","Titel");%>
            </a></li>
	<li><a href="javascript:onoff('tab4','tab6');">
            <% Language.printTextfield(out,session, "edition","Titel");%>
            </a></li>
	<li><a href="javascript:onoff('tab5','tab6');">
            <% Language.printTextfield(out,session, "handschrift","Titel");%>
            </a></li>
	<li><span>
            <% Language.printTextfield(out,session, "namenkommentar","Titel");%>
            </span></li>
	<li><a href="javascript:onoff('tab8','tab6');">
            <% Language.printTextfield(out,session, "suche","TabFavoriten");%>
            </a></li>
</ul>
</div>
<div id="main">
<form method="post" action="suchergebnis"><input
	type="hidden" name="form" value="namenkommentar" />
<table>
	<tr>
		<th width="200">Zwischenlemma</th>
		<td width="450"><input type="text" size="50" name="Zwischenlemma" /></td>
	</tr>
	<tr>
		<th width="200">Namenelement</th>
		<td width="450"><input type="text" size="50" name="Namenelement"
			disabled /></td>
	</tr>
</table>
<br>
<h2>Ausgabefelder</h2>
<table>
	<tr>
		<td><input type="checkbox" name="AusgabeLink" checked disabled /></td>
		<td width="200">Link</td>
		<td><input type="checkbox" name="AusgabeZwischenlemma" checked
			disabled /></td>
		<td width="200">Zwischenlemma</td>
	</tr>
	<tr>
		<td><input type="checkbox" name="AusgabeNamenelement" /></td>
		<td width="200">Namenelement</td>
	</tr>
</table>
<p><input type="reset" value="abbrechen" />&nbsp;&nbsp;<input
	type="submit" value="Suchen" /></p>
</form>
</div>
</div>

<div id="tab8">
<div id="header">
<ul id="primary">
	<li><a href="javascript:onoff('tab1','tab8');">
            <% Language.printTextfield(out,session, "suche","TabLemma");%>
            </a></li>
	<li><a href="javascript:onoff('tab2','tab8');">
            <% Language.printTextfield(out,session, "person","Titel");%>
            </a></li>
	<li><a href="javascript:onoff('tab3','tab8');">
            <% Language.printTextfield(out,session, "quelle","Titel");%>
            </a></li>
	<li><a href="javascript:onoff('tab4','tab8');">
            <% Language.printTextfield(out,session, "edition","Titel");%>
            </a></li>
	<li><a href="javascript:onoff('tab5','tab8');">
            <% Language.printTextfield(out,session, "handschrift","Titel");%>
            </a></li>
	<li><a href="javascript:onoff('tab6','tab8');">
            <% Language.printTextfield(out,session, "namenkommentar","Titel");%>
            </a></li>
	<li><span>
            <% Language.printTextfield(out,session, "suche","TabFavoriten");%>
            </span></li>
</ul>
</div>
<div id="main">
<form method="post" action="suchergebnis"><input
	type="hidden" name="form" value="favorit" />
<p>Testweise gibt es hier eine für die Philologen Interessante Liste
zu <a href="person?ID=21812">dieser Person</a></p>
<p><input type="reset" value="abbrechen" />&nbsp;&nbsp;<input
	type="submit" value="Suchen" /></p>
</form>
</div>
</div>
</div>
</div>