<%@ page import="java.sql.Connection" isThreadSafe="false" %>
<%@ page import="java.sql.DriverManager" isThreadSafe="false" %>
<%@ page import="java.sql.ResultSet" isThreadSafe="false" %>
<%@ page import="java.sql.SQLException" isThreadSafe="false" %>
<%@ page import="java.sql.Statement" isThreadSafe="false" %>

<%@ include file="../configuration.jsp" %>
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

      // Passwort verschlüsseln
      MessageDigest m = MessageDigest.getInstance("MD5");
      m.update(password.getBytes(), 0, password.length());
      String passwordMD5 = (new BigInteger(1, m.digest()).toString(16));

      try {
        Class.forName( sqlDriver );
        cn = DriverManager.getConnection( sqlURL, sqlUser, sqlPassword );
        st = cn.createStatement();
        rs = st.executeQuery("SELECT ID, Login, GruppeID, IstAdmin, Sprache, IstGast FROM benutzer WHERE Login='"+login+"' AND Password ='"+passwordMD5+"'");

        if (rs.next()) {
          // Falls Session vorhanden, löschen
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

  if (session.getAttribute("BenutzerID")!=null && ((Integer) session.getAttribute("BenutzerID")).intValue() > 0) {

                          session.setAttribute("filter", 0);
        session.setAttribute("filterParameter", "");


    int id = -2;
    int filter = 0;
    String formular = "einzelbeleg";

    try {
      id = Integer.parseInt(request.getParameter("ID"));
    }
    catch (Exception e) {}
    try {
      filter = ((Integer)session.getAttribute("filter")).intValue();
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
//        out.println(sql+(sql.contains("WHERE")?" AND ":" WHERE ")+formular+".ID = "+id);
        if(id>-1)rs = st.executeQuery(sql+(sql.contains("WHERE")?" AND ":" WHERE ")+formular+".ID = "+id);
        else rs = st.executeQuery(sql);
        if (rs.next() && id>-1 && rs.getString("m")==null){
           out.println("ID nicht vorhanden. <a href=\"javascript:history.back();\">Zur&uuml;ck zur vorherigen Seite</a>");
           return;
        }
        else id = rs.getInt("m");
      }
      catch (Exception e) {out.println(e);}
      finally {
        try { if( null != rs ) rs.close(); } catch( Exception ex ) {}
        try { if( null != st ) st.close(); } catch( Exception ex ) {}
        try { if( null != cn ) cn.close(); } catch( Exception ex ) {}
      }

%>


<jsp:include page="../dojump.jsp">
  <jsp:param name="form" value="gast_einzelbeleg" />
</jsp:include>

<HTML>
  <HEAD>
    <TITLE>Nomen et Gens - Impressum
    </TITLE>
    <link rel="icon" href="layout/images/nomen_et_gens_icon.gif" type="image/gif">
    <link rel="stylesheet" href="layout/layout.css" type="text/css">
    <link href='https://fonts.googleapis.com/css?family=Open+Sans:400,300,700' rel='stylesheet' type='text/css'>
    <link href='https://fonts.googleapis.com/css?family=Alegreya+Sans+SC:400,700' rel='stylesheet' type='text/css'>
    <script src="../javascript/funktionen.js" type="text/javascript"></script>
    <script src="../javascript/jquery-1.11.1.min.js" type="text/javascript"></script>
    <script src="../javascript/javascript.js" type="text/javascript"></script>
    <noscript></noscript>
  </HEAD>

  <BODY>
    <FORM method="POST" action="einfaches_ergebnis.jsp">
        <jsp:include page="layout/header.inc.jsp">
          <jsp:param name="current" value="" />
        </jsp:include>
      <div id="content">
        <h1>Impressum</h1>
        <h2>Angaben gem&auml;&szlig; &sect; 5 TMG:</h2>
        <p>Seminar f&uuml;r mittelalterliche Geschichte, Universit&auml;t T&uuml;bingen<br />
        Wilhelmstr. 36<br />
        72074 T&uuml;bingen
        </p>
        <h2>Vertreten durch:</h2>
        <p>Steffen Patzold</p>
        <h2>Kontakt:</h2>
        <table><tr>
        <td>Telefon:</td>
        <td>070712972990</td></tr>
        <tr><td>E-Mail:</td>
        <td>neg@uni-tuebingen.de</td>
        </tr></table>
        <p> </p>
        <p>Quelle: <em><a rel="nofollow" href="http://www.e-recht24.de/impressum-generator.html">http://www.e-recht24.de</a></em></p>

      </div>
<jsp:include page="layout/footer.inc.jsp" />
</FORM>
  </BODY>
</HTML>
<%
  }
  else {
  %>
    <p>
      <jsp:include page="../inc.erzeugeBeschriftung.jsp">
        <jsp:param name="Formular" value="error"/>
        <jsp:param name="Textfeld" value="Zugriff"/>
      </jsp:include>
    </p>
    <a href="index.jsp">
      <jsp:include page="../inc.erzeugeBeschriftung.jsp">
        <jsp:param name="Formular" value="all"/>
        <jsp:param name="Textfeld" value="Startseite"/>
      </jsp:include>
    </a>
  <%
  }
%>
