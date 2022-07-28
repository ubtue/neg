<%@ page import="java.sql.Connection" isThreadSafe="false"%>
<%@ page import="java.sql.DriverManager" isThreadSafe="false"%>
<%@ page import="java.sql.ResultSet" isThreadSafe="false"%>
<%@ page import="java.sql.SQLException" isThreadSafe="false"%>
<%@ page import="java.sql.Statement" isThreadSafe="false"%>

<%@ include file="../configuration.jsp"%>
<%@ include file="../functions.jsp" %>

<jsp:include page="../dolanguage.jsp" />
<jsp:include page="../dofilter.jsp" />

<%
  if (session.getAttribute("BenutzerID")==null) {
     Connection cn = null;
    Statement st = null;
    ResultSet rs = null;

    if (request.getParameter("language") != null) {
      session = request.getSession(true);
      session.setAttribute("Sprache", request.getParameter("language"));
      session.setMaxInactiveInterval(sessionTimeout);
    }

      String login = "Gast";
      String password = "gast";

      // Passwort verschlÃ¼sseln
      MessageDigest m = MessageDigest.getInstance("MD5");
      m.update(password.getBytes(), 0, password.length());
      String passwordMD5 = (new BigInteger(1, m.digest()).toString(16));

      try {
        Class.forName( sqlDriver );
        cn = DriverManager.getConnection( sqlURL, sqlUser, sqlPassword );
        st = cn.createStatement();
        rs = st.executeQuery("SELECT ID, Login, GruppeID, IstAdmin, Sprache, IstGast FROM benutzer WHERE Login='"+login+"' AND Password ='"+passwordMD5+"'");

        if (rs.next()) {
          // Falls Session vorhanden, lÃ¶schen
          if (session != null) {
            session.invalidate();
          }

          // Neue Session erzeugen
          session = request.getSession(true);
          session.setAttribute("BenutzerID", new Integer(rs.getInt("ID")));
          session.setAttribute("GruppeID", new Integer(rs.getInt("GruppeID")));
          session.setAttribute("Benutzername", rs.getString("Login"));
          session.setAttribute("Administrator", new Boolean((rs.getInt("IstAdmin")==1?true:false)));
          session.setAttribute("Gast", new Boolean((rs.getInt("IstGast")==1?true:false)));
          session.setAttribute("Sprache", rs.getString("Sprache"));
          session.setMaxInactiveInterval(sessionTimeout);
     } }     finally {
        try { if( null != rs ) rs.close(); } catch( Exception ex ) {}
        try { if( null != st ) st.close(); } catch( Exception ex ) {}
        try { if( null != cn ) cn.close(); } catch( Exception ex ) {}
      }

  }
	if (session.getAttribute("BenutzerID") != null
			&& ((Integer) session.getAttribute("BenutzerID"))
					.intValue() > 0) {

	                          session.setAttribute("filter", 0);
        session.setAttribute("filterParameter", "");
		int id = -2;
		int filter = 0;
		String formular = "person";

		try {
			id = Integer.parseInt(request.getParameter("ID"));
		} catch (Exception e) {
		}
		try {
			filter = ((Integer) session.getAttribute("filter"))
					.intValue();
		} catch (Exception e) {
		}

			Connection cn = null;
			Statement st = null;
			ResultSet rs = null;
			String sql = "";
			try {
				Class.forName(sqlDriver);
				cn = DriverManager.getConnection(sqlURL, sqlUser,
						sqlPassword);
				st = cn.createStatement();
				rs = st
						.executeQuery("SELECT * FROM datenbank_filter WHERE Formular='gast_"
								+ formular
								+ "' AND Nummer='"
								+ filter
								+ "';");
				if (rs.next()) {
					sql = rs.getString("SQLString");
				}
				sql = sql.replace("*", "min(" + formular + ".ID) m");
				String filterParameter = (String) session
						.getAttribute("filterParameter");
				if (filterParameter != null)
					sql = sql.replace("###", filterParameter);
				sql = sql.replace("#userid#",
						""
								+ ((Integer) session
										.getAttribute("BenutzerID"))
										.intValue());
				sql = sql.replace("#groupid#", ""
						+ ((Integer) session.getAttribute("GruppeID"))
								.intValue());
        if(id>-1)rs = st.executeQuery(sql+(sql.contains("WHERE")?" AND ":" WHERE ")+formular+".ID = "+id);
        else rs = st.executeQuery(sql);
        if (rs.next() && id>-1 && rs.getString("m")==null){
           out.println("ID nicht vorhanden. <a href=\"javascript:history.back();\">Zur&uuml;ck zur vorherigen Seite</a>");
           return;
        }
        else id = rs.getInt("m");
			} catch (Exception e) {
           out.println("ID nicht vorhanden. <a href=\"javascript:history.back();\">Zur&uuml;ck zur vorherigen Seite</a>");
           return;
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
%>

<jsp:include page="../dojump.jsp">
	<jsp:param name="form" value="gast_person" />
</jsp:include>

<HTML>
<HEAD>
<TITLE>Nomen et Gens | <jsp:include
	page="../inc.erzeugeBeschriftung.jsp">
	<jsp:param name="Formular" value="person" />
	<jsp:param name="Textfeld" value="Titel" />
</jsp:include></TITLE>
<link rel="icon" href="layout/images/nomen_et_gens_icon.gif" type="image/gif">
<link rel="stylesheet" href="layout/layout.css" type="text/css">
<link href='https://fonts.googleapis.com/css?family=Open+Sans:400,300,700' rel='stylesheet' type='text/css'>
<link href='https://fonts.googleapis.com/css?family=Alegreya+Sans+SC:400,700' rel='stylesheet' type='text/css'>
<script src="../javascript/funktionen.js" type="text/javascript"></script>
<script src="../javascript/jquery-1.11.1.min.js" type="text/javascript"></script>
<script src="../javascript/javascript.js" type="text/javascript"></script>
<noscript></noscript>
</HEAD>

<BODY onLoad="urlRewrite(<%=id%>);">
 <jsp:include page="layout/header.inc.jsp">
        <jsp:param name="current" value="person" />
</jsp:include>
<!--<jsp:include page="layout/image.inc.html" />-->
<jsp:include page="layout/titel.inc.jsp">
	<jsp:param name="title" value="Person" />
	<jsp:param name="ID" value="<%= id %>" />
	<jsp:param name="size" value="" />
	<jsp:param name="Formular" value="person" />
</jsp:include>
<jsp:include page="../inc.erzeugeFormular.jsp">
	<jsp:param name="ID" value="<%= id %>" />
	<jsp:param name="Formular" value="person" />
	<jsp:param name="Datenfeld" value="ID" />
	<jsp:param name="size" value="11" />
</jsp:include>


<div id="content">

<!----------ID---------->
  <div id="id">
    <jsp:include page="../forms/id.jsp">
      <jsp:param name="ID" value="<%=id%>"/>
      <jsp:param name="title" value="gast_person"/>
    </jsp:include>
  </div>

  <!----------Prosopographisches---------->
  <h3> Prosopographisches </h3>
  <table id="personen-table" class="content-table">
	<tbody>
		<tr>
			<th>
              <jsp:include page="../inc.erzeugeBeschriftung.jsp">
				<jsp:param name="Formular" value="person" />
				<jsp:param name="Textfeld" value="Person" />
              </jsp:include>
			</th>
			<td><jsp:include page="../inc.erzeugeFormular.jsp">
				<jsp:param name="ID" value="<%= id %>" />
				<jsp:param name="Formular" value="person" />
				<jsp:param name="Datenfeld" value="Standardname" />
				<jsp:param name="size" value="50" />
				<jsp:param name="Readonly" value="yes" />
			</jsp:include>
              <span style="float:right;display:block;font-weight:bold;">
              </span></td>
		</tr>
		<tr>
			<th>
                <jsp:include page="../inc.erzeugeBeschriftung.jsp">
				  <jsp:param name="Formular" value="person" />
				  <jsp:param name="Datenfeld" value="Varianten" />
			   </jsp:include>
			</th>
			<td>
              <jsp:include page="../inc.erzeugeFormular.jsp">
				<jsp:param name="ID" value="<%= id %>" />
				<jsp:param name="Formular" value="person" />
				<jsp:param name="Datenfeld" value="Varianten" />
				<jsp:param name="size" value="50" />
				<jsp:param name="Readonly" value="yes" />
              </jsp:include></span></td>
		</tr>
		<tr>
			<th>
              <jsp:include page="../inc.erzeugeBeschriftung.jsp">
				<jsp:param name="Formular" value="person" />
				<jsp:param name="Datenfeld" value="Geschlecht" />
              </jsp:include>
			</th>
			<td>
              <jsp:include page="../inc.erzeugeFormular.jsp">
				<jsp:param name="ID" value="<%= id %>" />
				<jsp:param name="Formular" value="person" />
				<jsp:param name="Datenfeld" value="Geschlecht" />
				<jsp:param name="Readonly" value="yes" />
			 </jsp:include></td>
		</tr>
		<tr>
			<th>Kommentar</th>
			<td>
              <jsp:include page="../inc.erzeugeFormular.jsp">
				<jsp:param name="ID" value="<%= id %>" />
				<jsp:param name="Formular" value="person" />
				<jsp:param name="Datenfeld" value="Identifizierungsproblem" />
				<jsp:param name="cols" value="40" />
				<jsp:param name="rows" value="5" />
				<jsp:param name="Readonly" value="yes" />
			 </jsp:include>
            </td>
                </tr>
		<tr>
			<th>
              <jsp:include page="../inc.erzeugeBeschriftung.jsp">
                <jsp:param name="Formular" value="person" />
                <jsp:param name="Datenfeld" value="Stand" />
              </jsp:include>
            </th>
			<td>
              <jsp:include page="../inc.erzeugeFormular.jsp">
				<jsp:param name="ID" value="<%= id %>" />
				<jsp:param name="Formular" value="person" />
				<jsp:param name="Datenfeld" value="Stand" />
				<jsp:param name="Readonly" value="yes" />
			</jsp:include>
          </td>
		</tr>
		<tr>
			<th>
              <jsp:include page="../inc.erzeugeBeschriftung.jsp">
				<jsp:param name="Formular" value="person" />
				<jsp:param name="Textfeld" value="Aemter" />
              </jsp:include>
            </th>
			<td><jsp:include page="../inc.erzeugeFormular.jsp">
				<jsp:param name="ID" value="<%= id %>" />
				<jsp:param name="Formular" value="person" />
				<jsp:param name="Datenfeld" value="AmtWeihe" />
				<jsp:param name="Readonly" value="yes" />
			</jsp:include></td>
		</tr>
		<tr>
			<th>
              <jsp:include page="../inc.erzeugeBeschriftung.jsp">
				<jsp:param name="Formular" value="person" />
				<jsp:param name="Datenfeld" value="Ethnie" />
              </jsp:include>
            </th>
			<td>
              <jsp:include page="../inc.erzeugeFormular.jsp">
				<jsp:param name="ID" value="<%= id %>" />
				<jsp:param name="Formular" value="person" />
				<jsp:param name="Datenfeld" value="Ethnie" />
				<jsp:param name="Readonly" value="yes" />
			  </jsp:include>
            </td>
		</tr>
		<tr>
			<th>
              <jsp:include page="../inc.erzeugeBeschriftung.jsp">
                <jsp:param name="Formular" value="person" />
                <jsp:param name="Textfeld" value="TabVerwandte" />
			  </jsp:include>
            </th>
          <td>
            <jsp:include page="../inc.modul.jsp">
              <jsp:param name="ID" value="<%= id %>" />
              <jsp:param name="Formular" value="person" />
              <jsp:param name="Modul" value="Verwandte" />
              <jsp:param name="Readonly" value="yes" />
            </jsp:include>
          </td>
		</tr>
        <tr>
			<td>
              <jsp:include page="../inc.erzeugeBeschriftung.jsp">
                <jsp:param name="Formular" value="person" />
                <jsp:param name="Datenfeld" value="CMLink" />
              </jsp:include>
            </td>
			<td>
              <jsp:include page="../inc.erzeugeFormular.jsp">
                <jsp:param name="ID" value="<%= id %>" />
                <jsp:param name="Formular" value="person" />
                <jsp:param name="Datenfeld" value="CMLink" />
              </jsp:include>
            </td>
		</tr>
	</tbody>
  </table>

<!----------Einzelbelege---------->
  <h3>
    <jsp:include page="../inc.erzeugeBeschriftung.jsp">
      <jsp:param name="Formular" value="person" />
      <jsp:param name="Textfeld" value="TabEinzelbelege" />
    </jsp:include>
  </h3>
  <jsp:include page="../inc.modul.jsp">
    <jsp:param name="ID" value="<%= id %>" />
    <jsp:param name="Formular" value="person" />
    <jsp:param name="Modul" value="nachweiseRO" />
  </jsp:include>

</div>
    <jsp:include page="layout/footer.inc.jsp" />
</BODY>
</HTML>
<%
	} else {
%>
<p><jsp:include page="../inc.erzeugeBeschriftung.jsp">
	<jsp:param name="Formular" value="error" />
	<jsp:param name="Textfeld" value="Zugriff" />
</jsp:include></p>
<a href="index.jsp"> <jsp:include page="../inc.erzeugeBeschriftung.jsp">
	<jsp:param name="Formular" value="all" />
	<jsp:param name="Textfeld" value="Startseite" />
</jsp:include> </a>
<%
	}
%>
