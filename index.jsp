<%@ page import="java.sql.Connection" isThreadSafe="false" %>
<%@ page import="java.sql.DriverManager" isThreadSafe="false" %>
<%@ page import="java.sql.ResultSet" isThreadSafe="false" %>
<%@ page import="java.sql.SQLException" isThreadSafe="false" %>
<%@ page import="java.sql.Statement" isThreadSafe="false" %>
<%@ page import="java.math.BigInteger" isThreadSafe="false" %>
<%@ page import="java.security.MessageDigest" isThreadSafe="false" %>

<%@ include file="configuration.jsp" %>
<%@ include file="functions.jsp" %>


<%
  if (session!=null && session.getAttribute("BenutzerID")!=null && ((Integer) session.getAttribute("BenutzerID")).intValue() > 0 && !((Boolean) session.getAttribute("Gast"))) {
    %><jsp:forward page="einzelbeleg.jsp" /><%
  }
  else if (session!=null && session.getAttribute("BenutzerID")!=null && ((Integer) session.getAttribute("BenutzerID")).intValue() > 0 && ((Boolean) session.getAttribute("Gast"))) {
    response.sendRedirect("gast/startseite.jsp");
  }
  else {
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

          // Weiterleitung
          if((Boolean)session.getAttribute("Gast")){
            response.sendRedirect("gast/startseite.jsp");
          }
          else{
            response.sendRedirect("einzelbeleg.jsp");
          }
        }
        else {
        %>
          <p>
            <jsp:include page="inc.erzeugeBeschriftung.jsp">
              <jsp:param name="Formular" value="error"/>
              <jsp:param name="Textfeld" value="BenutzerKennwortFalsch"/>
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
      }
      finally {
        try { if( null != rs ) rs.close(); } catch( Exception ex ) {}
        try { if( null != st ) st.close(); } catch( Exception ex ) {}
        try { if( null != cn ) cn.close(); } catch( Exception ex ) {}
      }
 
  }
%>
