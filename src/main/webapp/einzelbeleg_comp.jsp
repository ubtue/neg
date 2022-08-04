<%@ page import="java.sql.Connection" isThreadSafe="false"%>
<%@ page import="java.sql.DriverManager" isThreadSafe="false"%>
<%@ page import="java.sql.ResultSet" isThreadSafe="false"%>
<%@ page import="java.sql.SQLException" isThreadSafe="false"%>
<%@ page import="java.sql.Statement" isThreadSafe="false"%>

<%@ include file="configuration.jsp"%>
<%@ include file="functions.jsp"%>
<%
	if (session.getAttribute("BenutzerID") != null
			&& ((Integer) session.getAttribute("BenutzerID"))
					.intValue() > 0) {

		int id = -1;
		try {
			id = Integer.parseInt(request.getParameter("ID"));
		} catch (NumberFormatException e) {
			Connection cn = null;
			Statement st = null;
			ResultSet rs = null;
			try {
				Class.forName(sqlDriver);
				cn = DriverManager.getConnection(sqlURL, sqlUser,
						sqlPassword);
				st = cn.createStatement();
				rs = st
						.executeQuery("SELECT min(ID) m FROM einzelbeleg"
								+ " ");
				if (rs.next())
					id = rs.getInt("m");
			} finally {
				try {
					if (null != rs)
						rs.close();
				} catch (Exception ex) {
				}
				try {
					if (null != st)
						st.close();
				} catch (Exception ex) {
				}
				try {
					if (null != cn)
						cn.close();
				} catch (Exception ex) {
				}
			}
		}
%>

<jsp:include page="dosave.jsp">
	<jsp:param name="form" value="einzelbeleg" />
	<jsp:param name="ID" value="<%= id %>" />
</jsp:include>
<jsp:include page="dojump.jsp">
	<jsp:param name="form" value="einzelbeleg" />
</jsp:include>

<HTML>
<HEAD>
<TITLE>Nomen et Gens - <jsp:include
	page="inc.erzeugeBeschriftung.jsp">
	<jsp:param name="Formular" value="einzelbeleg" />
	<jsp:param name="Textfeld" value="Titel" />
</jsp:include></TITLE>
<link rel="stylesheet" href="layout/layout.css" type="text/css">
<script src="javascript/funktionen.js" type="text/javascript"></script>
<noscript></noscript>
</HEAD>

<BODY>
<FORM method="POST"><jsp:include page="layout/navigation.inc.jsp" />
<jsp:include page="layout/image.inc.jsp" /> <jsp:include
	page="layout/titel.inc.jsp">
	<jsp:param name="title" value="Einzelbeleg" />
	<jsp:param name="ID" value="<%= id %>" />
	<jsp:param name="size" value="" />
	<jsp:param name="Formular" value="einzelbeleg" />
</jsp:include> <jsp:include page="inc.erzeugeFormular.jsp">
	<jsp:param name="ID" value="<%= id %>" />
	<jsp:param name="Formular" value="einzelbeleg" />
	<jsp:param name="Datenfeld" value="ID" />
	<jsp:param name="size" value="11" />
</jsp:include>



<div id="form"><a href="einzelbeleg.jsp?ID=<%=id%>"> <jsp:include
	page="inc.erzeugeBeschriftung.jsp">
	<jsp:param name="Formular" value="einzelbeleg" />
	<jsp:param name="Textfeld" value="AusfuehrlicheSicht" />
</jsp:include></a>
<div style="visibility: hidden"><jsp:include
	page="inc.erzeugeFormular.jsp">
	<jsp:param name="ID" value="<%= id %>" />
	<jsp:param name="Formular" value="einzelbeleg" />
	<jsp:param name="Datenfeld" value="Belegnummer" />
	<jsp:param name="size" value="25" />
</jsp:include> <jsp:include page="inc.erzeugeFormular.jsp">
	<jsp:param name="ID" value="<%= id %>" />
	<jsp:param name="Formular" value="einzelbeleg" />
	<jsp:param name="Datenfeld" value="generiereBelegnummer" />
</jsp:include></div>


<table>
	<tbody>
		<tr>
			<td width="200"><jsp:include page="inc.erzeugeBeschriftung.jsp">
				<jsp:param name="Formular" value="einzelbeleg" />
				<jsp:param name="Datenfeld" value="Belegform" />
			</jsp:include></td>
			<td width="450"><jsp:include page="inc.erzeugeFormular.jsp">
				<jsp:param name="ID" value="<%= id %>" />
				<jsp:param name="Formular" value="einzelbeleg" />
				<jsp:param name="Datenfeld" value="Belegform" />
				<jsp:param name="size" value="50" />
			</jsp:include></td>
		</tr>
		<tr>
			<td width="200" valign="top"></td>
			<td width="450"></td>
		</tr>
		<tr>
			<td width="200" valign="top"><jsp:include
				page="inc.erzeugeBeschriftung.jsp">
				<jsp:param name="Formular" value="einzelbeleg" />
				<jsp:param name="Datenfeld" value="Kontext" />
			</jsp:include></td>
			<td width="450"><jsp:include page="inc.erzeugeFormular.jsp">
				<jsp:param name="ID" value="<%= id %>" />
				<jsp:param name="Formular" value="einzelbeleg" />
				<jsp:param name="Datenfeld" value="Kontext" />
				<jsp:param name="cols" value="40" />
				<jsp:param name="rows" value="5" />
			</jsp:include></td>
		</tr>
	</tbody>
</table>
<br>



<table class="date">
	<tbody>
		<tr>
			<td width="200"><jsp:include page="inc.erzeugeBeschriftung.jsp">
				<jsp:param name="Formular" value="einzelbeleg" />
				<jsp:param name="Datenfeld" value="Quellennummer" />
			</jsp:include></td>
			<td><jsp:include page="inc.erzeugeFormular.jsp">
				<jsp:param name="ID" value="<%= id %>" />
				<jsp:param name="Formular" value="einzelbeleg" />
				<jsp:param name="Datenfeld" value="Quellennummer" />
				<jsp:param name="size" value="20" />
			</jsp:include> <jsp:include page="inc.erzeugeFormular.jsp">
				<jsp:param name="ID" value="<%= id %>" />
				<jsp:param name="Formular" value="einzelbeleg" />
				<jsp:param name="Datenfeld" value="QuelleSuchen" />
			</jsp:include> <jsp:include page="inc.erzeugeFormular.jsp">
				<jsp:param name="ID" value="<%= id %>" />
				<jsp:param name="Formular" value="einzelbeleg" />
				<jsp:param name="Datenfeld" value="QuelleLink" />
			</jsp:include></td>
		</tr>
		<tr>
			<td width="200"><jsp:include page="inc.erzeugeBeschriftung.jsp">
				<jsp:param name="Formular" value="einzelbeleg" />
				<jsp:param name="Datenfeld" value="Edition" />
			</jsp:include></td>
			<td><jsp:include page="inc.erzeugeFormular.jsp">
				<jsp:param name="ID" value="<%= id %>" />
				<jsp:param name="Formular" value="einzelbeleg" />
				<jsp:param name="Datenfeld" value="Edition" />
			</jsp:include></td>
		</tr>
		<tr>
			<td width="200"><jsp:include page="inc.erzeugeBeschriftung.jsp">
				<jsp:param name="Formular" value="einzelbeleg" />
				<jsp:param name="Datenfeld" value="EditionKapitel" />
			</jsp:include></td>
			<td><jsp:include page="inc.erzeugeFormular.jsp">
				<jsp:param name="ID" value="<%= id %>" />
				<jsp:param name="Formular" value="einzelbeleg" />
				<jsp:param name="Datenfeld" value="EditionKapitel" />
				<jsp:param name="size" value="20" />
			</jsp:include></td>
		</tr>
		<tr>
			<td width="200"><jsp:include page="inc.erzeugeBeschriftung.jsp">
				<jsp:param name="Formular" value="einzelbeleg" />
				<jsp:param name="Datenfeld" value="EditionSeite" />
			</jsp:include></td>
			<td><jsp:include page="inc.erzeugeFormular.jsp">
				<jsp:param name="ID" value="<%= id %>" />
				<jsp:param name="Formular" value="einzelbeleg" />
				<jsp:param name="Datenfeld" value="EditionSeite" />
				<jsp:param name="size" value="20" />
			</jsp:include></td>
		</tr>
		<tr>
			<td width="200"><jsp:include page="inc.erzeugeBeschriftung.jsp">
				<jsp:param name="Formular" value="einzelbeleg" />
				<jsp:param name="Datenfeld" value="QuelleDatierung" />
			</jsp:include></td>
			<td><jsp:include page="inc.erzeugeFormular.jsp">
				<jsp:param name="Formular" value="einzelbeleg" />
				<jsp:param name="ID" value="<%= id %>" />
				<jsp:param name="Datenfeld" value="QuelleDatumVon" />
			</jsp:include> <jsp:include page="inc.erzeugeFormular.jsp">
				<jsp:param name="Formular" value="einzelbeleg" />
				<jsp:param name="ID" value="<%= id %>" />
				<jsp:param name="Datenfeld" value="QuelleDatumBis" />
			</jsp:include> <jsp:include page="inc.erzeugeFormular.jsp">
				<jsp:param name="ID" value="<%= id %>" />
				<jsp:param name="Formular" value="einzelbeleg" />
				<jsp:param name="Datenfeld" value="QuelleDatierung" />
				<jsp:param name="Visibility" value="hidden" />
				<jsp:param name="size" value="20" />
			</jsp:include></td>
		</tr>
	</tbody>
</table>
<p></p>

<table class="date">
	<tbody>

		<tr>
			<td width="200" valign="top"><jsp:include
				page="inc.erzeugeBeschriftung.jsp">
				<jsp:param name="Formular" value="einzelbeleg" />
				<jsp:param name="Datenfeld" value="Textkritik" />
			</jsp:include></td>
			<td width="450"><jsp:include page="inc.erzeugeFormular.jsp">
				<jsp:param name="ID" value="<%= id %>" />
				<jsp:param name="Formular" value="einzelbeleg" />
				<jsp:param name="Datenfeld" value="Textkritik" />
			</jsp:include></td>
		</tr>
	</tbody>
</table>
<p></p>


<table class="date">
	<tbody>
		<tr>
			<th width="200" valign="top"><jsp:include
				page="inc.erzeugeBeschriftung.jsp">
				<jsp:param name="Formular" value="einzelbeleg" />
				<jsp:param name="Datenfeld" value="LebendVerstorben" />
			</jsp:include></th>
			<td width="450"><jsp:include page="inc.erzeugeFormular.jsp">
				<jsp:param name="ID" value="<%= id %>" />
				<jsp:param name="Formular" value="einzelbeleg" />
				<jsp:param name="Datenfeld" value="LebendVerstorben" />
			</jsp:include></td>
		</tr>
		<tr>
			<th width="200" valign="top"><jsp:include
				page="inc.erzeugeBeschriftung.jsp">
				<jsp:param name="Formular" value="einzelbeleg" />
				<jsp:param name="Datenfeld" value="AmtWeihe" />
			</jsp:include></th>
			<td><jsp:include page="inc.erzeugeFormular.jsp">
				<jsp:param name="ID" value="<%= id %>" />
				<jsp:param name="Formular" value="einzelbeleg" />
				<jsp:param name="Datenfeld" value="AmtWeihe" />
			</jsp:include></td>
		</tr>
		<tr>
			<td colspan="2"><jsp:include page="inc.erzeugeFormular.jsp">
				<jsp:param name="ID" value="<%= id %>" />
				<jsp:param name="Formular" value="einzelbeleg" />
				<jsp:param name="Datenfeld" value="PersonID" />
			</jsp:include></td>
		</tr>
	</tbody>
</table>

<div id="tab5">
<div id="header">
<ul id="primary">
	<li><a href="javascript:onoff('tab1','tab5');">Textkritik</a></li>
	<li><a href="javascript:onoff('tab2','tab5');">Belegstelle</a></li>
	<li><a href="javascript:onoff('tab3','tab5');">Zum Namen</a></li>
	<li><a href="javascript:onoff('tab4','tab5');">Zur Person</a></li>
	<li><span>Bemerkungen</span></li>
</ul>
</div>
<div id="main">
<table>
	<tbody>
		<tr>
			<td valign="top" width="200"><jsp:include
				page="inc.erzeugeBeschriftung.jsp">
				<jsp:param name="Formular" value="einzelbeleg" />
				<jsp:param name="Datenfeld" value="BemerkungAlle" />
			</jsp:include></td>
			<td width="450"><jsp:include page="inc.erzeugeFormular.jsp">
				<jsp:param name="ID" value="<%= id %>" />
				<jsp:param name="Formular" value="einzelbeleg" />
				<jsp:param name="Datenfeld" value="BemerkungAlle" />
				<jsp:param name="cols" value="40" />
				<jsp:param name="rows" value="5" />
			</jsp:include></td>
		</tr>
		<tr>
			<td valign="top" width="200"><jsp:include
				page="inc.erzeugeBeschriftung.jsp">
				<jsp:param name="Formular" value="einzelbeleg" />
				<jsp:param name="Datenfeld" value="BemerkungGruppe" />
			</jsp:include></td>
			<td width="450"><jsp:include page="inc.erzeugeFormular.jsp">
				<jsp:param name="ID" value="<%= id %>" />
				<jsp:param name="Formular" value="einzelbeleg" />
				<jsp:param name="Datenfeld" value="BemerkungGruppe" />
				<jsp:param name="cols" value="40" />
				<jsp:param name="rows" value="5" />
			</jsp:include></td>
		</tr>
		<tr>
			<td valign="top" width="200"><jsp:include
				page="inc.erzeugeBeschriftung.jsp">
				<jsp:param name="Formular" value="einzelbeleg" />
				<jsp:param name="Datenfeld" value="BemerkungPrivat" />
			</jsp:include></td>
			<td width="450"><jsp:include page="inc.erzeugeFormular.jsp">
				<jsp:param name="ID" value="<%= id %>" />
				<jsp:param name="Formular" value="einzelbeleg" />
				<jsp:param name="Datenfeld" value="BemerkungPrivat" />
				<jsp:param name="cols" value="40" />
				<jsp:param name="rows" value="5" />
			</jsp:include></td>
		</tr>
		<tr>
			<td width="200" valign="top"><jsp:include
				page="inc.erzeugeBeschriftung.jsp">
				<jsp:param name="Formular" value="einzelbeleg" />
				<jsp:param name="Datenfeld" value="Bearbeitungsstatus" />
			</jsp:include></td>
			<td width="450"><jsp:include page="inc.erzeugeFormular.jsp">
				<jsp:param name="ID" value="<%= id %>" />
				<jsp:param name="Formular" value="einzelbeleg" />
				<jsp:param name="Datenfeld" value="Bearbeitungsstatus" />
			</jsp:include></td>
		</tr>
		<tr>
			<td valign="top" width="200"><jsp:include
				page="inc.erzeugeBeschriftung.jsp">
				<jsp:param name="Formular" value="einzelbeleg" />
				<jsp:param name="Datenfeld" value="LetzteAenderung" />
			</jsp:include></td>
			<td width="450"><jsp:include page="inc.erzeugeFormular.jsp">
				<jsp:param name="ID" value="<%= id %>" />
				<jsp:param name="Formular" value="einzelbeleg" />
				<jsp:param name="Datenfeld" value="LetzteAenderung" />
			</jsp:include></td>
		</tr>
		<tr>
			<td valign="top" width="200"><jsp:include
				page="inc.erzeugeBeschriftung.jsp">
				<jsp:param name="Formular" value="einzelbeleg" />
				<jsp:param name="Datenfeld" value="LetzteAenderungVon" />
			</jsp:include></td>
			<td><jsp:include page="inc.erzeugeFormular.jsp">
				<jsp:param name="ID" value="<%= id %>" />
				<jsp:param name="Formular" value="einzelbeleg" />
				<jsp:param name="Datenfeld" value="LetzteAenderungVon" />
			</jsp:include></td>
		</tr>
		<tr>
			<td valign="top" width="200"><jsp:include
				page="inc.erzeugeBeschriftung.jsp">
				<jsp:param name="Formular" value="einzelbeleg" />
				<jsp:param name="Datenfeld" value="Erstellt" />
			</jsp:include></td>
			<td width="450"><jsp:include page="inc.erzeugeFormular.jsp">
				<jsp:param name="ID" value="<%= id %>" />
				<jsp:param name="Formular" value="einzelbeleg" />
				<jsp:param name="Datenfeld" value="Erstellt" />
			</jsp:include></td>
		</tr>
		<tr>
			<td valign="top" width="200"><jsp:include
				page="inc.erzeugeBeschriftung.jsp">
				<jsp:param name="Formular" value="einzelbeleg" />
				<jsp:param name="Datenfeld" value="ErstelltVon" />
			</jsp:include></td>
			<td><jsp:include page="inc.erzeugeFormular.jsp">
				<jsp:param name="ID" value="<%= id %>" />
				<jsp:param name="Formular" value="einzelbeleg" />
				<jsp:param name="Datenfeld" value="ErstelltVon" />
			</jsp:include></td>
		</tr>
	</tbody>
</table>
</div>
</div>
</div>
<jsp:include page="inc.erzeugeFormular.jsp">
	<jsp:param name="ID" value="<%= id %>" />
	<jsp:param name="Formular" value="einzelbeleg" />
	<jsp:param name="Datenfeld" value="DatumVon" />
	<jsp:param name="Visibility" value="hidden" />
</jsp:include> <jsp:include page="inc.erzeugeFormular.jsp">
	<jsp:param name="ID" value="<%= id %>" />
	<jsp:param name="Formular" value="einzelbeleg" />
	<jsp:param name="Datenfeld" value="GenauigkeitTag" />
	<jsp:param name="Visibility" value="hidden" />
</jsp:include> <jsp:include page="inc.erzeugeFormular.jsp">
	<jsp:param name="ID" value="<%= id %>" />
	<jsp:param name="Formular" value="einzelbeleg" />
	<jsp:param name="Datenfeld" value="GenauigkeitMonat" />
	<jsp:param name="Visibility" value="hidden" />
</jsp:include> <jsp:include page="inc.erzeugeFormular.jsp">
	<jsp:param name="ID" value="<%= id %>" />
	<jsp:param name="Formular" value="einzelbeleg" />
	<jsp:param name="Datenfeld" value="GenauigkeitJahr" />
	<jsp:param name="Visibility" value="hidden" />
</jsp:include> <jsp:include page="inc.erzeugeFormular.jsp">
	<jsp:param name="ID" value="<%= id %>" />
	<jsp:param name="Formular" value="einzelbeleg" />
	<jsp:param name="Datenfeld" value="GenauigkeitJahrhundert" />
	<jsp:param name="Visibility" value="hidden" />
</jsp:include> <jsp:include page="inc.erzeugeFormular.jsp">
	<jsp:param name="ID" value="<%= id %>" />
	<jsp:param name="Formular" value="einzelbeleg" />
	<jsp:param name="Datenfeld" value="DatumBis" />
	<jsp:param name="Visibility" value="hidden" />
</jsp:include> <jsp:include page="inc.erzeugeFormular.jsp">
	<jsp:param name="ID" value="<%= id %>" />
	<jsp:param name="Formular" value="einzelbeleg" />
	<jsp:param name="Datenfeld" value="DatierungUngewiss" />
	<jsp:param name="Visibility" value="hidden" />
</jsp:include> <jsp:include page="inc.erzeugeFormular.jsp">
	<jsp:param name="ID" value="<%= id %>" />
	<jsp:param name="Formular" value="einzelbeleg" />
	<jsp:param name="Datenfeld" value="KommentarDatierung" />
	<jsp:param name="cols" value="40" />
	<jsp:param name="rows" value="5" />
	<jsp:param name="Visibility" value="hidden" />
</jsp:include> <jsp:include page="inc.erzeugeFormular.jsp">
	<jsp:param name="ID" value="<%= id %>" />
	<jsp:param name="Formular" value="einzelbeleg" />
	<jsp:param name="Datenfeld" value="Lemma" />
	<jsp:param name="Visibility" value="hidden" />
</jsp:include> <jsp:include page="inc.erzeugeFormular.jsp">
	<jsp:param name="ID" value="<%= id %>" />
	<jsp:param name="Formular" value="einzelbeleg" />
	<jsp:param name="Datenfeld" value="Quellengattung" />
	<jsp:param name="Visibility" value="hidden" />
</jsp:include> <jsp:include page="inc.erzeugeFormular.jsp">
	<jsp:param name="ID" value="<%= id %>" />
	<jsp:param name="Formular" value="einzelbeleg" />
	<jsp:param name="Datenfeld" value="Echtheit" />
	<jsp:param name="Visibility" value="hidden" />
</jsp:include> <jsp:include page="inc.erzeugeFormular.jsp">
	<jsp:param name="ID" value="<%= id %>" />
	<jsp:param name="Formular" value="einzelbeleg" />
	<jsp:param name="Datenfeld" value="Griechisch" />
	<jsp:param name="size" value="50" />
	<jsp:param name="Visibility" value="hidden" />
</jsp:include> <jsp:include page="inc.erzeugeFormular.jsp">
	<jsp:param name="ID" value="<%= id %>" />
	<jsp:param name="Formular" value="einzelbeleg" />
	<jsp:param name="Datenfeld" value="Diakritisch" />
	<jsp:param name="size" value="50" />
	<jsp:param name="Visibility" value="hidden" />
</jsp:include> <jsp:include page="inc.erzeugeFormular.jsp">
	<jsp:param name="ID" value="<%= id %>" />
	<jsp:param name="Formular" value="einzelbeleg" />
	<jsp:param name="Datenfeld" value="GrammatikGeschlecht" />
	<jsp:param name="Visibility" value="hidden" />
</jsp:include> <jsp:include page="inc.erzeugeFormular.jsp">
	<jsp:param name="ID" value="<%= id %>" />
	<jsp:param name="Formular" value="einzelbeleg" />
	<jsp:param name="Visibility" value="hidden" />
	<jsp:param name="Datenfeld" value="Kasus" />
</jsp:include> <jsp:include page="inc.erzeugeFormular.jsp">
	<jsp:param name="ID" value="<%= id %>" />
	<jsp:param name="Formular" value="einzelbeleg" />
	<jsp:param name="Datenfeld" value="KommentarEthnie" />
	<jsp:param name="cols" value="40" />
	<jsp:param name="Visibility" value="hidden" />
	<jsp:param name="rows" value="5" />
</jsp:include> <jsp:include page="inc.erzeugeFormular.jsp">
	<jsp:param name="ID" value="<%= id %>" />
	<jsp:param name="Formular" value="einzelbeleg" />
	<jsp:param name="Datenfeld" value="KommentarAreal" />
	<jsp:param name="cols" value="40" />
	<jsp:param name="rows" value="5" />
	<jsp:param name="Visibility" value="hidden" />
</jsp:include> <jsp:include page="inc.erzeugeFormular.jsp">
	<jsp:param name="ID" value="<%= id %>" />
	<jsp:param name="Formular" value="einzelbeleg" />
	<jsp:param name="Datenfeld" value="KommentarVerwandtschaft" />
	<jsp:param name="cols" value="40" />
	<jsp:param name="Visibility" value="hidden" />
	<jsp:param name="rows" value="5" />
</jsp:include> <jsp:include page="inc.erzeugeFormular.jsp">
	<jsp:param name="ID" value="<%= id %>" />
	<jsp:param name="Formular" value="einzelbeleg" />
	<jsp:param name="Datenfeld" value="Funktion" />
	<jsp:param name="Visibility" value="hidden" />
</jsp:include> <jsp:include page="inc.erzeugeFormular.jsp">
	<jsp:param name="ID" value="<%= id %>" />
	<jsp:param name="Formular" value="einzelbeleg" />
	<jsp:param name="Datenfeld" value="UeberlieferungDatierung" />
	<jsp:param name="size" value="20" />
	<jsp:param name="Visibility" value="hidden" />
</jsp:include></FORM>
</BODY>
</HTML>
<%
	} else {
%>
<p><jsp:include page="inc.erzeugeBeschriftung.jsp">
	<jsp:param name="Formular" value="error" />
	<jsp:param name="Textfeld" value="Zugriff" />
</jsp:include></p>
<a href="index.jsp"> <jsp:include page="inc.erzeugeBeschriftung.jsp">
	<jsp:param name="Formular" value="all" />
	<jsp:param name="Textfeld" value="Startseite" />
</jsp:include> </a>
<%
	}
%>
