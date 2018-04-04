<%@ page import="java.sql.Connection" isThreadSafe="false" %>
<%@ page import="java.sql.DriverManager" isThreadSafe="false" %>
<%@ page import="java.sql.ResultSet" isThreadSafe="false" %>
<%@ page import="java.sql.SQLException" isThreadSafe="false" %>
<%@ page import="java.sql.Statement" isThreadSafe="false" %>

<%@ include file="configuration.jsp" %>
<%@ include file="functions.jsp" %>

<%
  if (session.getAttribute("BenutzerID")!=null
      && ((Integer) session.getAttribute("BenutzerID")).intValue() > 0
     ) {

    if(request.getParameter("action") == null
      ) {
      out.println("<p>Falscher Aufruf!</p>");
      out.println("<a href=\"index.jsp\">Zur&uuml;ck zur Startseite</a>");
    }
    else {
    
     Connection cn = null;
  Statement st = null;
  ResultSet rs = null;
  String email = "";

    boolean isAdmin = false;
    int benutzerID=((Integer)session.getAttribute("BenutzerID")).intValue();
  try {
  
  
    Class.forName( sqlDriver );
    cn = DriverManager.getConnection( sqlURL, sqlUser, sqlPassword );
    st = cn.createStatement();
    rs = st.executeQuery("SELECT * FROM benutzer WHERE ID="+benutzerID+";");
    rs.next();
    
    isAdmin = rs.getString("IstAdmin").equals("1");
    
    if(isAdmin && request.getParameter("ID")!=null){
       benutzerID=Integer.parseInt(request.getParameter("ID"));
       rs = st.executeQuery("SELECT * FROM benutzer WHERE ID="+benutzerID+";");
       rs.next();
    
    }
          }
      catch (Exception e) {
        out.println(e);
      }
      finally {
        try { if( null != rs ) rs.close(); } catch( Exception ex ) {}
        try { if( null != st ) st.close(); } catch( Exception ex ) {}
        try { if( null != cn ) cn.close(); } catch( Exception ex ) {}
      }
    
    

%>

<HTML>
  <HEAD>
    <TITLE>Nomen et Gens - 
      <jsp:include page="inc.erzeugeBeschriftung.jsp">
        <jsp:param name="Formular" value="einstellungen"/>
        <jsp:param name="Textfeld" value="Titel"/>
      </jsp:include>
    </TITLE>
    <link rel="stylesheet" href="layout/layout.css" type="text/css">
    <script src="../javascript/funktionen.js" type="text/javascript"></script>
    <noscript></noscript>
  </HEAD>

  <BODY>
    <jsp:include page="layout/navigation.inc.jsp" />
    <jsp:include page="layout/image.inc.html" />
    <jsp:include page="layout/titel.einstellungen.jsp" />
    <div id="form">

<%
  String sql = "";
  boolean fehler = true;
    
  if (request.getParameter("action").equals("Einstellungen")) {
    if (request.getParameter("email").equals("")) {
%>
      <jsp:include page="inc.erzeugeBeschriftung.jsp">
        <jsp:param name="Formular" value="einstellungen"/>
        <jsp:param name="Textfeld" value="FehlerEmailLeer"/>
      </jsp:include>
<%
    }
    else {
      String admin ="0";
      if(isAdmin && request.getParameter("Administrator")!=null && request.getParameter("Administrator").equals("on")) admin="1";
      String aktiv ="";
       if(isAdmin) 
          if(request.getParameter("Aktiv")!=null && request.getParameter("Aktiv").equals("on")) aktiv="1";
          else aktiv="0";
       
    //  out.println(aktiv);
      sql = "UPDATE benutzer SET EMail='"+request.getParameter("email")+"', Sprache='"+request.getParameter("Sprache")+"', Login='"+request.getParameter("Benutzername")+"', Vorname='"+request.getParameter("Vorname")+"', Nachname='"+request.getParameter("Nachname")+"', IstAdmin="+admin+ (!aktiv.equals("")?(", IstAktiv="+aktiv):"") + " WHERE ID="+benutzerID+";";
      fehler = false;
    }
  }

  else if (request.getParameter("action").equals("Passwort")) {
    if (!isAdmin && (request.getParameter("PasswortAlt")==null || request.getParameter("PasswortAlt").equals(""))) {
%>
      <jsp:include page="inc.erzeugeBeschriftung.jsp">
        <jsp:param name="Formular" value="einstellungen"/>
        <jsp:param name="Textfeld" value="FehlerPasswortAltLeer"/>
      </jsp:include>
<%
    }
    else if (request.getParameter("PasswortNeu")==null || request.getParameter("PasswortNeu").equals("")) {
%>
      <jsp:include page="inc.erzeugeBeschriftung.jsp">
        <jsp:param name="Formular" value="einstellungen"/>
        <jsp:param name="Textfeld" value="FehlerPasswortNeuLeer"/>
      </jsp:include>
<%
    }
    else if (request.getParameter("PasswortNeuWdh")==null || request.getParameter("PasswortNeuWdh").equals("")) {
%>
      <jsp:include page="inc.erzeugeBeschriftung.jsp">
        <jsp:param name="Formular" value="einstellungen"/>
        <jsp:param name="Textfeld" value="FehlerPasswortNeuWdhLeer"/>
      </jsp:include>
<%
    }
    else if (!request.getParameter("PasswortNeu").equals(request.getParameter("PasswortNeuWdh"))) {
%>
      <jsp:include page="inc.erzeugeBeschriftung.jsp">
        <jsp:param name="Formular" value="einstellungen"/>
        <jsp:param name="Textfeld" value="FehlerPasswortNeuUngleich"/>
      </jsp:include>
<%
    }
    else {
       cn = null;
        st = null;
        rs = null;

      try {
        Class.forName( sqlDriver );
        cn = DriverManager.getConnection( sqlURL, sqlUser, sqlPassword );
        st = cn.createStatement();
        rs = st.executeQuery("SELECT Password FROM benutzer WHERE ID="+benutzerID+";");
        if (rs.next()) {
          if(isAdmin || rs.getString("Password").equals(md5(request.getParameter("PasswortAlt")))) {
            fehler = false;
            sql = "UPDATE benutzer SET Password=\""+md5(request.getParameter("PasswortNeu"))+"\" WHERE ID="+benutzerID+";";
          }
          else {
%>
            <jsp:include page="inc.erzeugeBeschriftung.jsp">
              <jsp:param name="Formular" value="einstellungen"/>
              <jsp:param name="Textfeld" value="FehlerPasswortAltFalsch"/>
            </jsp:include>
<%
          }
        }
      }
      catch (Exception e) {
        out.println(e);
      }
      finally {
        try { if( null != rs ) rs.close(); } catch( Exception ex ) {}
        try { if( null != st ) st.close(); } catch( Exception ex ) {}
        try { if( null != cn ) cn.close(); } catch( Exception ex ) {}
      }
    }
  }

  if (!fehler) {
     cn = null;
      st = null;

    try {
      Class.forName( sqlDriver );
      cn = DriverManager.getConnection( sqlURL, sqlUser, sqlPassword );
      st = cn.createStatement();
      st.execute(sql);
%>
        <jsp:include page="inc.erzeugeBeschriftung.jsp">
          <jsp:param name="Formular" value="einstellungen"/>
          <jsp:param name="Textfeld" value="ErfolgDaten"/>
        </jsp:include>
        <a href="javascript:history.back()">
          <jsp:include page="inc.erzeugeBeschriftung.jsp">
            <jsp:param name="Formular" value="einstellungen"/>
            <jsp:param name="Textfeld" value="Zurueck"/>
          </jsp:include>
        </a>
<%
    }
    catch (Exception e) {
      out.println(e);
    }
    finally {
      try { if( null != st ) st.close(); } catch( Exception ex ) {}
      try { if( null != cn ) cn.close(); } catch( Exception ex ) {}
    }
  }
%>

    </div>
  </BODY>
</HTML>

<%
    }
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

