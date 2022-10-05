<%@ page import="java.sql.Connection" isThreadSafe="false" %>
<%@ page import="java.sql.DriverManager" isThreadSafe="false" %>
<%@ page import="java.sql.ResultSet" isThreadSafe="false" %>
<%@ page import="java.sql.SQLException" isThreadSafe="false" %>
<%@ page import="java.sql.Statement" isThreadSafe="false" %>

<%@ include file="../configuration.jsp" %>
<%@ include file="../functions.jsp" %>

<%
  Connection cn = null;
  Statement  st = null;
  ResultSet  rs = null;
%>

<div id="navigation">
  <a href="einzelbeleg.jsp">
    <jsp:include page="../inc.erzeugeBeschriftung.jsp">
      <jsp:param name="Formular" value="einzelbeleg"/>
      <jsp:param name="Textfeld" value="Titel"/>
    </jsp:include>
  </a>
  <br>
  <hr>
  <a href="person.jsp">
    <jsp:include page="../inc.erzeugeBeschriftung.jsp">
      <jsp:param name="Formular" value="person"/>
      <jsp:param name="Textfeld" value="Titel"/>
    </jsp:include>
  </a>
  <br>
  <hr>
  <a href="namenkommentar.jsp">
    <jsp:include page="../inc.erzeugeBeschriftung.jsp">
      <jsp:param name="Formular" value="namenkommentar"/>
      <jsp:param name="Textfeld" value="Titel"/>
    </jsp:include>
  </a>
  <br>
  <hr>
  <a href="mghlemma">
    <jsp:include page="../inc.erzeugeBeschriftung.jsp">
      <jsp:param name="Formular" value="mgh_lemma"/>
      <jsp:param name="Textfeld" value="Titel"/>
    </jsp:include>
  </a>
  <br>
  <hr>
  <a href="quelle.jsp">
    <jsp:include page="../inc.erzeugeBeschriftung.jsp">
      <jsp:param name="Formular" value="quelle"/>
      <jsp:param name="Textfeld" value="Titel"/>
    </jsp:include>
  </a>
  <br>
  <hr>
  <a href="edition.jsp">
    <jsp:include page="../inc.erzeugeBeschriftung.jsp">
      <jsp:param name="Formular" value="edition"/>
      <jsp:param name="Textfeld" value="Titel"/>
    </jsp:include>
  </a>
  <br>
  <hr>
  <a href="handschrift.jsp">
    <jsp:include page="../inc.erzeugeBeschriftung.jsp">
      <jsp:param name="Formular" value="handschrift"/>
      <jsp:param name="Textfeld" value="Titel"/>
    </jsp:include>
  </a>
  <br>
  <hr>
  <a href="suche.jsp">
    <jsp:include page="../inc.erzeugeBeschriftung.jsp">
      <jsp:param name="Formular" value="suche"/>
      <jsp:param name="Textfeld" value="Titel"/>
    </jsp:include>
  </a>
  <br>
  <hr>
  <a href="ohneVerknuepfung.jsp">offene Verkn&uuml;pfung</a>
  <br>
  <hr>
  <a href="freie_suche.jsp">
    <jsp:include page="../inc.erzeugeBeschriftung.jsp">
      <jsp:param name="Formular" value="freie_suche"/>
      <jsp:param name="Textfeld" value="Titel"/>
    </jsp:include>
  </a>
  <hr>
  <hr>
  <a href="einstellungen">
    <jsp:include page="../inc.erzeugeBeschriftung.jsp">
      <jsp:param name="Formular" value="einstellungen"/>
      <jsp:param name="Textfeld" value="Titel"/>
    </jsp:include>
  </a><%
  if (session.getAttribute("BenutzerID")!=null
      && ((Integer) session.getAttribute("BenutzerID")).intValue() > 0
      && ((Boolean) session.getAttribute("Administrator")).booleanValue()
     ) {
%>

  <br>
  <hr>
  <a href="administration.jsp">
    <jsp:include page="../inc.erzeugeBeschriftung.jsp">
      <jsp:param name="Formular" value="administration"/>
      <jsp:param name="Textfeld" value="Titel"/>
    </jsp:include>
  </a>
  <br>
  <hr>
   <a href="gast/edit.jsp" target="_blank">
    Hilfe bearbeiten
  </a>
  <%
  }
  %>
  <br>
  <hr>
  <hr>
  <!-- <a href="logout.jsp">
    <jsp:include page="../inc.erzeugeBeschriftung.jsp">
      <jsp:param name="Formular" value="logout"/>
      <jsp:param name="Textfeld" value="Titel"/>
    </jsp:include>
  </a>-->
  <a href="logout.jsp?go=gast">Abmelden</a>
  <br>
  <br>
<%
  if (session.getAttribute("BenutzerID")!=null
    && ((Integer) session.getAttribute("BenutzerID")).intValue() > 0) {

    try {
      Class.forName( sqlDriver );
      cn = DriverManager.getConnection( sqlURL, sqlUser, sqlPassword );
      st = cn.createStatement();
      rs = st.executeQuery("SELECT benutzer.Nachname Nachname, benutzer.Vorname Vorname, benutzer_gruppe.Bezeichnung Gruppe FROM benutzer, benutzer_gruppe WHERE benutzer.ID=\""+((Integer) session.getAttribute("BenutzerID")).intValue()+"\" AND benutzer_gruppe.ID = benutzer.GruppeID");

      if( rs.next() ) {
%>
        <center>
          <font size="1">
            <jsp:include page="../inc.erzeugeBeschriftung.jsp">
              <jsp:param name="Formular" value="navigation"/>
              <jsp:param name="Textfeld" value="AngemeldetAls"/>
            </jsp:include>
            <%= DBtoHTML(rs.getString("Vorname")) %>
            <%= DBtoHTML(rs.getString("Nachname")) %>
            (<%= DBtoHTML(rs.getString("Gruppe")) %>)
          </font>
        </center>
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
  <br>
    <jsp:include page="../forms/language.jsp">
      <jsp:param name="ID" value="<%= request.getParameter("ID") %>"/>
      <jsp:param name="title" value="<%= request.getParameter("title") %>"/>
    </jsp:include>
</div>


<jsp:include page="../inc.matomo.jsp">
  <jsp:param name="frontendType" value="Backend" />
</jsp:include>
