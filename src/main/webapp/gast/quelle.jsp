<%@ page import="java.sql.*" isThreadSafe="false"%>
<%@ page import="de.uni_tuebingen.ub.nppm.util.Language" isThreadSafe="false" %>
<%@ include file="../configuration.jsp"%>
<%@ include file="../functions.jsp"%>

<jsp:include page="../dofilter.jsp" />

<%
    Language.setLanguage(request);
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

  }if (session.getAttribute("BenutzerID") != null
			&& ((Integer) session.getAttribute("BenutzerID"))
					.intValue() > 0) {
                          session.setAttribute("filter", 0);
        session.setAttribute("filterParameter", "");


    int id = -2;
    int urkundeid = -1;
    int filter = 0;
    String formular = "quelle";


    try {
      id = Integer.parseInt(request.getParameter("ID"));
    }
    catch (Exception e) {}


       Connection cn = null;
      Statement st = null;
      ResultSet rs = null;
      String sql = "";
      try {
        Class.forName( sqlDriver );
        cn = DriverManager.getConnection( sqlURL, sqlUser, sqlPassword );
        st = cn.createStatement();
        rs = st.executeQuery("SELECT * FROM datenbank_filter WHERE Formular='gast_"+formular+"' AND Nummer='"+filter+"';");
        if (rs.next()) {
          sql = rs.getString("SQLString");
        }
        sql = sql.replace("*", "min("+formular+".ID) m");
        String filterParameter = (String) session.getAttribute("filterParameter");
        if (filterParameter != null)
          sql = sql.replace("###", filterParameter);
        sql = sql.replace("#userid#", ""+((Integer)session.getAttribute("BenutzerID")).intValue());
        sql = sql.replace("#groupid#", ""+((Integer)session.getAttribute("GruppeID")).intValue());
        if(id>-1)rs = st.executeQuery(sql+(sql.contains("WHERE")?" AND ":" WHERE ")+formular+".ID = "+id);
        else rs = st.executeQuery(sql);
        if (rs.next() && id>-1 && rs.getString("m")==null){
           out.println("ID nicht vorhanden. <a href=\"javascript:history.back();\">Zur&uuml;ck zur vorherigen Seite</a>");
           return;
        }
        else id = rs.getInt("m");
			} catch (Exception e) {
				out.println(e);
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


		 cn = null;
		 st = null;
		 rs = null;
		try {
			Class.forName(sqlDriver);
			cn = DriverManager.getConnection(sqlURL, sqlUser,
					sqlPassword);
			st = cn.createStatement();
			rs = st
					.executeQuery("SELECT ID FROM urkunde WHERE QuelleID ="
							+ id + ";");
			if (rs.next())
				urkundeid = rs.getInt("ID");
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

  <jsp:param name="form" value="gast_quelle" />

</jsp:include>

<HTML>
<HEAD>
<TITLE>Nomen et Gens | <jsp:include
	page="../inc.erzeugeBeschriftung.jsp">
	<jsp:param name="Formular" value="quelle" />
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


  <BODY onLoad="urlRewrite(<%= id %>);">
    <jsp:include page="layout/header.inc.jsp">
        <jsp:param name="current" value="quelle" />
    </jsp:include>
<!--      <jsp:include page="layout/image.inc.html" />-->
      <jsp:include page="layout/titel.inc.jsp">
        <jsp:param name="title" value="Quelle" />
        <jsp:param name="ID" value="<%= id %>" />
        <jsp:param name="size" value="" />
        <jsp:param name="Formular" value="quelle" />
      </jsp:include>
      <jsp:include page="../inc.erzeugeFormular.jsp">
        <jsp:param name="ID" value="<%= id %>"/>
        <jsp:param name="Formular" value="quelle"/>
        <jsp:param name="Datenfeld" value="ID"/>
        <jsp:param name="size" value="11"/>
      </jsp:include>


<div id="content">

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
      <jsp:param name="ID" value="<%= id %>"/>
      <jsp:param name="Formular" value="quelle"/>
      <jsp:param name="Datenfeld" value="Bezeichnung"/>
      <jsp:param name="size" value="50"/>
      <jsp:param name="Readonly" value="yes"/>
    </jsp:include>
  </h3>
        <table id="quelle-table" class="content-table">
          <tbody>
            <tr>
              <th>
                <jsp:include page="../inc.erzeugeBeschriftung.jsp">
                  <jsp:param name="Formular" value="quelle"/>
                  <jsp:param name="Textfeld" value="Datierung"/>
                </jsp:include>
              </th>
              <td>
                <jsp:include page="../inc.erzeugeFormular.jsp">
                  <jsp:param name="ID" value="<%= id %>"/>
                  <jsp:param name="Formular" value="gast_quelle"/>
                  <jsp:param name="Datenfeld" value="Datierung"/>
                  <jsp:param name="Readonly" value="yes"/>
                </jsp:include>
              </td>
            </tr>
            <tr>
              <th>
                <jsp:include page="../inc.erzeugeBeschriftung.jsp">
                  <jsp:param name="Formular" value="quelle"/>
                  <jsp:param name="Datenfeld" value="KommentarDatierung"/>
                </jsp:include>
              </th>
              <td>
                <jsp:include page="../inc.erzeugeFormular.jsp">
                  <jsp:param name="ID" value="<%= id %>"/>
                  <jsp:param name="Formular" value="quelle"/>
                  <jsp:param name="Datenfeld" value="KommentarDatierung"/>
                  <jsp:param name="cols" value="40"/>
                  <jsp:param name="rows" value="5"/>
                      <jsp:param name="Readonly" value="yes"/>
                </jsp:include>
              </td>
            </tr>
             <tr>
              <td colspan="2">
            <jsp:include page="../inc.modul.jsp">
              <jsp:param name="ID" value="<%= id %>"/>
              <jsp:param name="Formular" value="quelle"/>
              <jsp:param name="Modul" value="edition"/>
            </jsp:include>
              </td>
            </tr>
         </tbody>
        </table>

<!----------Ueberlieferung---------->
  <h3>
    <jsp:include page="../inc.erzeugeBeschriftung.jsp">
      <jsp:param name="Formular" value="quelle" />
      <jsp:param name="Textfeld" value="TabUeberlieferung" />
    </jsp:include>
  </h3>

  <jsp:include page="../inc.modul.jsp">
    <jsp:param name="ID" value="<%= id %>" />
    <jsp:param name="Formular" value="quelle" />
    <jsp:param name="Modul" value="ueberlieferungRO" />
  </jsp:include>

<!----------Bei Urkunden---------->
  <h3>
    <jsp:include page="../inc.erzeugeBeschriftung.jsp">
      <jsp:param name="Formular" value="quelle" />
      <jsp:param name="Textfeld" value="TabUrkunde" />
    </jsp:include>
  </h3>
  <div id="urkunden">
    <table class="content-table">
      <tbody>
          <tr>
              <th>
                <jsp:include page="../inc.erzeugeBeschriftung.jsp">
                  <jsp:param name="Formular" value="urkunde" />
                  <jsp:param name="Datenfeld" value="Actumort" />
                </jsp:include>
              </th>
              <td>
                <jsp:include page="../inc.erzeugeFormular.jsp">
                  <jsp:param name="ID" value="<%= urkundeid %>" />
                  <jsp:param name="Formular" value="urkunde" />
                  <jsp:param name="Datenfeld" value="Actumort" />
                  <jsp:param name="size" value="50" />
                  <jsp:param name="Readonly" value="yes" />
               </jsp:include>
              </td>
          </tr>
          <tr>
              <th>
                <jsp:include page="../inc.erzeugeBeschriftung.jsp">
                  <jsp:param name="Formular" value="urkunde" />
                  <jsp:param name="Datenfeld" value="Betreff" />
                </jsp:include>
              </th>
              <td>
                <jsp:include page="../inc.erzeugeFormular.jsp">
                  <jsp:param name="ID" value="<%= urkundeid %>" />
                  <jsp:param name="Formular" value="urkunde" />
                  <jsp:param name="Datenfeld" value="Betreff" />
                  <jsp:param name="size" value="50" />
                  <jsp:param name="Readonly" value="yes" />
                </jsp:include>
              </td>
          </tr>
          <tr>
              <th>
                <jsp:include page="../inc.erzeugeBeschriftung.jsp">
                  <jsp:param name="Formular" value="urkunde" />
                  <jsp:param name="Datenfeld" value="Aussteller" />
                </jsp:include>
              </th>
              <td>
                <jsp:include page="../inc.erzeugeFormular.jsp">
                  <jsp:param name="ID" value="<%= urkundeid %>" />
                  <jsp:param name="Formular" value="urkunde" />
                  <jsp:param name="Datenfeld" value="Aussteller" />
                  <jsp:param name="Readonly" value="yes" />
                </jsp:include>
              </td>
          </tr>
          <tr>
              <th>
                <jsp:include page="../inc.erzeugeBeschriftung.jsp">
                  <jsp:param name="Formular" value="urkunde" />
                  <jsp:param name="Datenfeld" value="Empfaenger" />
                </jsp:include>
              </th>
              <td>
                <jsp:include page="../inc.erzeugeFormular.jsp">
                  <jsp:param name="ID" value="<%= urkundeid %>" />
                  <jsp:param name="Formular" value="urkunde" />
                  <jsp:param name="Datenfeld" value="Empfaenger" />
                  <jsp:param name="Readonly" value="yes" />
                </jsp:include>
              </td>
          </tr>
          <tr>
              <th>
                <jsp:include page="../inc.erzeugeBeschriftung.jsp">
                  <jsp:param name="Formular" value="urkunde" />
                  <jsp:param name="Datenfeld" value="Dorsalnotiz" />
                </jsp:include>
              </th>
              <td>
                <jsp:include page="../inc.erzeugeFormular.jsp">
                  <jsp:param name="ID" value="<%= urkundeid %>" />
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

</div>
<jsp:include page="layout/footer.inc.jsp" />
</BODY>
</HTML>
<%
  }
  else {
  %>
    <p>
      <jsp:include page="inc.erzeugeBeschriftung.jsp">
        <jsp:param name="Formular" value="error"/>
        <jsp:param name="Textfeld" value="Zugriff"/>
      </jsp:include>
    </p>
    <a href="index.jsp">
      <jsp:include page="inc.erzeugeBeschriftung.jsp">
        <jsp:param name="Formular" value="all"/>
        <jsp:param name="Textfeld" value="Startseite"/>
      </jsp:include>
    </a>
  <%
  }

%>
