<%@page import="de.uni_tuebingen.ub.nppm.util.SaltHash"%>
﻿<%@ page import="java.sql.Connection" isThreadSafe="false" %>
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
  String sql_1 = "";
  String sql_2 = "";
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
        String oldPassword = request.getParameter("PasswortAlt");
        String newPassword = request.getParameter("PasswortNeu");
        String dBPassword = "";
        String dbSalt = "";

        Class.forName( sqlDriver );
        cn = DriverManager.getConnection( sqlURL, sqlUser, sqlPassword );
        st = cn.createStatement();
          rs = st.executeQuery("SELECT Salt FROM benutzer WHERE ID="+benutzerID+";");

          if(rs.next())
          {
            dbSalt = rs.getString("Salt");
          }


        rs = st.executeQuery("SELECT Password FROM benutzer WHERE ID="+benutzerID+";");

       
        if(rs.next())
        {
            dBPassword = rs.getString("Password"); //get password from database; 
        }

      

        //Hash and Salt oldPassword
        //i want to Salt and Hash oldPassword
        SaltHash saltHash = new SaltHash();
        String algorithm = "MD5";
       
        oldPassword = saltHash.decodeSaltHash(oldPassword, algorithm, dbSalt); 

        if(isAdmin || dBPassword.equals(oldPassword))
        {
            
            SaltHash saltHashNew = new SaltHash();
            String algorithmNew = "MD5";
            byte[] saltNew = saltHash.createSalt();
            newPassword = saltHash.generateHash(request.getParameter("PasswortNeu"), algorithm, saltNew);
            fehler = false;
            sql_1 = "UPDATE benutzer SET Password=\""+ newPassword +"\" WHERE ID="+ benutzerID +";";
            sql_2 = "UPDATE benutzer SET Salt =\""+ saltHash.getSaltString() +"\" WHERE ID="+ benutzerID +";";
        }           
         else {
%>
            <jsp:include page="inc.erzeugeBeschriftung.jsp">
              <jsp:param name="Formular" value="einstellungen"/>
              <jsp:param name="Textfeld" value="FehlerPasswortAltFalsch"/>
            </jsp:include>
<%
          }
        
      }//end try
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
      if(sql.length() > 0)
        st.executeUpdate(sql);
      if(sql_1.length() > 0 && sql_2.length()>0)
      {
         st.executeUpdate(sql_1);
         st.executeUpdate(sql_2);
      }
      
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
      try { if( null != rs ) rs.close(); } catch( Exception ex ) {}
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

