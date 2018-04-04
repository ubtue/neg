<%@ page import="java.sql.Connection" isThreadSafe="false" %>
<%@ page import="java.sql.DriverManager" isThreadSafe="false" %>
<%@ page import="java.sql.ResultSet" isThreadSafe="false" %>
<%@ page import="java.sql.SQLException" isThreadSafe="false" %>
<%@ page import="java.sql.Statement" isThreadSafe="false" %>

<%@ include file="../../configuration.jsp" %>
<%@ include file="../../functions.jsp" %>

<%
  Connection cn = null;
  Statement  st = null;
  ResultSet  rs = null;

%>
<div id="page-wrap">
<div id="page">
	<div id="header">
		<div id="header-left">
			<a href="startseite.jsp"> Nomen et Gens </a>
		</div>
		<div id="header-right">
<!--
			<p> pageContext.request.requestURI eq 'person.jsp' ? ' active' : ''
				<form action="#">
				<input type="submit" name="language" alt="Deutsch" title="Deutsch" value="de" style="border:#fff 1px solid;
				 		background-image: url(img/de.gif); height: 14px; width: 22px;">
				<input type="submit" name="language" alt="English" title="English" value="gb" style="border:#000 1px solid;
						background-image: url(img/gb.gif); height: 14px; width: 22px;">
				<input type="submit" name="language" alt="Francáis" title="Francáis" value="fr" style="border:#fff 1px solid;
						background-image: url(img/fr.gif); height: 14px; width: 22px;">
				<input type="submit" name="language" alt="Latein" title="Latein" value="la" style="border:#fff 1px solid;
						background-image: url(img/la.gif); height: 14px; width: 22px;">
				</form>
			</p>
-->

			<p><a href="hilfe.jsp"> <strong> Hilfe </strong></a>|<a href="../logout.jsp"> <strong> Interner Bereich </strong> </a></p>
		</div>
		<div class="clear"></div>
	</div>

    <div class="menu-placeholder">
        <div class="menu-wrap">
            <div class="menu">
                <ul>
                    <li> <a class="${param.current eq 'startseite' ? 'current' : ''}" href="startseite.jsp"> Startseite </a></li>
                    <li> <a class="${param.current eq 'einzelbeleg' ? 'current' : ''}" href="einzelbeleg.jsp">
                        <jsp:include page="../../inc.erzeugeBeschriftung.jsp">
                          <jsp:param name="Formular" value="einzelbeleg"/>
                          <jsp:param name="Textfeld" value="Titel"/>
                        </jsp:include>
                      </a>
                    </li>
                    <li><a class="${param.current eq 'person' ? 'current' : ''}" href="person.jsp">
                        <jsp:include page="../../inc.erzeugeBeschriftung.jsp">
                          <jsp:param name="Formular" value="person"/>
                          <jsp:param name="Textfeld" value="Titel"/>
                        </jsp:include>
                      </a>
                    </li>
                    <li><a class="${param.current eq 'namenkommentar' ? 'current' : ''}" href="mghlemma.jsp">
                        <jsp:include page="../../inc.erzeugeBeschriftung.jsp">
                          <jsp:param name="Formular" value="namenkommentar"/>
                          <jsp:param name="Textfeld" value="Titel"/>
                        </jsp:include>
                      </a>
                    </li>
                    <li><a class="${param.current eq 'quelle' ? 'current' : ''}" href="quelle.jsp">
                        <jsp:include page="../../inc.erzeugeBeschriftung.jsp">
                          <jsp:param name="Formular" value="quelle"/>
                          <jsp:param name="Textfeld" value="Titel"/>
                        </jsp:include>
                      </a>
                    </li>
                </ul>
                <div id="search-wrap">
                    <div id="search">
                    <FORM method="POST" action="einfaches_ergebnis.jsp">
                            <input type="hidden" name="form" value="einfache_suche">
                            <input id="button" name="Suchen" value="" type="submit">
                            <input type="text" name="query" placeholder="Suchen">
                    </FORM>
                    </div>
                      <a id="erweiterte_suche_button" class="${param.current eq 'erweiterte_suche' ? 'erweiterte_suche_active' : ''}" href="freie_suche.jsp">
                        <jsp:include page="../../inc.erzeugeBeschriftung.jsp">
                          <jsp:param name="Formular" value="gast_freie_suche"/>
                          <jsp:param name="Textfeld" value="Titel"/>
                        </jsp:include>
                      </a>
                </div>
                <div class="anim1"></div>
            </div>
            <div class="clear"> </div>
            <div id="line-after-menu"> </div>
        </div>
    </div>

<!--
<div id="navigation">

  <br>
  <hr>

  <br>
  <hr>

  <br>
  <hr>
  <br>
-->
  <!--hr>
  <a href="edition.jsp">
    <jsp:include page="../../inc.erzeugeBeschriftung.jsp">
      <jsp:param name="Formular" value="edition"/>
      <jsp:param name="Textfeld" value="Titel"/>
    </jsp:include>
  </a>
  <br>
  <hr>
  <a href="handschrift.jsp">
    <jsp:include page="../../inc.erzeugeBeschriftung.jsp">
      <jsp:param name="Formular" value="handschrift"/>
      <jsp:param name="Textfeld" value="Titel"/>
    </jsp:include>
  </a>
  <br>
  <hr>
  <a href="literatur.jsp">
    <jsp:include page="../../inc.erzeugeBeschriftung.jsp">
      <jsp:param name="Formular" value="literatur"/>
      <jsp:param name="Textfeld" value="Titel"/>
    </jsp:include>
  </a>
  <br-->
<!--
  <a href="einfache_suche.jsp">
  <jsp:include page="../../inc.erzeugeBeschriftung.jsp">
      <jsp:param name="Formular" value="gast_freie_suche"/>
      <jsp:param name="Textfeld" value="EinfacheSuche"/>
    </jsp:include>
  </a>
-->


<!--
  <a href="hilfe.jsp">
    Hilfe
  </a>
-->

  <!--hr>
  <hr>
  <a href="einstellungen.jsp">
    <jsp:include page="../../inc.erzeugeBeschriftung.jsp">
      <jsp:param name="Formular" value="einstellungen"/>
      <jsp:param name="Textfeld" value="Titel"/>
    </jsp:include>
  </a>
  <br>
  <hr>
  <a href="administration.jsp">
    <jsp:include page="../../inc.erzeugeBeschriftung.jsp">
      <jsp:param name="Formular" value="administration"/>
      <jsp:param name="Textfeld" value="Titel"/>
    </jsp:include>
  </a>
  <br-->

<!--
  <a href="../logout.jsp">
    <jsp:include page="../../inc.erzeugeBeschriftung.jsp">
      <jsp:param name="Formular" value="logout"/>
      <jsp:param name="Textfeld" value="Titel"/>
    </jsp:include>
  </a>
-->

<!--
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
-->
<!--
        <center>
          <font size="1">
            <jsp:include page="../../inc.erzeugeBeschriftung.jsp">
              <jsp:param name="Formular" value="navigation"/>
              <jsp:param name="Textfeld" value="AngemeldetAls"/>
            </jsp:include>
            <%= DBtoHTML(rs.getString("Vorname")) %>
            <%= DBtoHTML(rs.getString("Nachname")) %>
            (<%= DBtoHTML(rs.getString("Gruppe")) %>)
          </font>
        </center>
-->
<!--
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
-->

<!--
    <jsp:include page="../../forms/language.jsp">
      <jsp:param name="ID" value="<%= request.getParameter("ID") %>"/>
      <jsp:param name="title" value="<%= request.getParameter("title") %>"/>
    </jsp:include>
-->
<!--</div>-->
