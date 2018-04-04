<%@ page import="java.sql.Connection" isThreadSafe="false" %>
<%@ page import="java.sql.DriverManager" isThreadSafe="false" %>
<%@ page import="java.sql.ResultSet" isThreadSafe="false" %>
<%@ page import="java.sql.SQLException" isThreadSafe="false" %>
<%@ page import="java.sql.Statement" isThreadSafe="false" %>
<%@ page import="java.util.Date" isThreadSafe="false" %>

<%@ include file="../configuration.jsp" %>
<%@ include file="../functions.jsp" %>
<jsp:include page="../dolanguage.jsp" />

<%
  if (session.getAttribute("BenutzerID")!=null && ((Integer) session.getAttribute("BenutzerID")).intValue() > 0) {

                              session.setAttribute("filter", 0);
        session.setAttribute("filterParameter", "");
    int id = -1;
    int filter = 0;
    String formular = "einfache_suche";
%>

<HTML>
  <HEAD>
    <TITLE>Nomen et Gens -
      <jsp:include page="../inc.erzeugeBeschriftung.jsp">
        <jsp:param name="Formular" value="freie_suche"/>
        <jsp:param name="Textfeld" value="Titel"/>
      </jsp:include>
    </TITLE>
    <link rel="stylesheet" href="layout/layout.css" type="text/css">
    <script src="../javascript/funktionen.js" type="text/javascript"></script>
      <script src="../javascript/funktionen.js" type="text/javascript"></script>
    <script type="text/javascript"
            src="http://ajax.googleapis.com/ajax/libs/jquery/1.3.2/jquery.min.js"></script>

 </HEAD>

  <BODY>
      <FORM method="POST">


    <jsp:include page="layout/image.inc.html" />
    <jsp:include page="layout/titel.suche.html" />
</FORM>
    <FORM method="POST" action="einfaches_ergebnis.jsp">
      <input type="hidden" name="form" value="einfache_suche">

<!-- ##### SUCHFELDER ##### -->
      <div id="form">
        <div id="tab1">
          <div id="main" style="padding-left:10px">


<p>
<h3>  <jsp:include page="../inc.erzeugeBeschriftung.jsp">
      <jsp:param name="Formular" value="gast_freie_suche"/>
      <jsp:param name="Textfeld" value="EinfacheSuche"/>
    </jsp:include></h3>
<input type="text" name="query" style="width:75%">
              <input type="submit" name="Suchen" value="&gt;">
</p>
 <%
    if(session.getAttribute("Sprache").equals("de")){

 %><p>
Sie k&ouml;nnen nach Namenlemmata, Personen, Quellen und Einzelbelegen (konkreten
Namensnennungen in einer Quelle) suchen. F&uuml;r <b>komplexere Suchanfragen</b> wechseln Sie bitte zur
<b><a href="freie_suche.jsp">erweiterten Suche</a></b>.
 </p>
<p>
Gro&szlig;- und Kleinschreibung werden bei der Suche nicht ber&uuml;cksichtigt.
 </p>
<p>
Mit dem <b>%</b> k&ouml;nnen Sie Ihre Suchanfrage <b>TRUNKIEREN</b>. Das hei&szlig;t, das % steht f&uuml;r eine beliebige
Menge an Zeichen an jeder Stelle (auch am Anfang) des Suchbegriffes. <b>Die Trunkierung des
Suchbegriffes am Ende Ihrer Eingabe ist f&uuml;r die meisten Suchanfragen sinnvoll,</b> da die Suche nur
solche Eintr&auml;ge anzeigt, die dem Suchbegriff  tats&auml;chlich genau entsprechen.  Mehrere Suchbegriffe
werden <b>nicht</b> durch &bdquo;und/oder&ldquo; verbunden, setzen Sie deshalb bitte auch zwischen mehreren
Suchbegriffen ein %.
 </p>
<p>
<b>Namen</b>: Die Eintr&auml;ge zu Personennamen bestehen in der Datenbank aus einem Namen  + weiteren
Kennzeichen zur Individualisierung einer einzelnen Person (z. B.  Karl Martell &lt;Hausmeier, +741&gt;).
Das hei&szlig;t jedoch, Sie finden Eintr&auml;ge zum fr&auml;nkischen Hausmeier Karl Martell in der Datenbank nur,
wenn sie den Suchbegriff als &bdquo;Karl%Martell%&ldquo; eingeben; den heiligen Columban nur, wenn Sie nach
&bdquo;Columban%&ldquo; suchen.
 </p>
<p>
Folgende <b>&Auml;mter</b> werden bei Personenbezeichnungen abgek&uuml;rzt angegeben:  Ebf. (Erzbischof), Bf.
(Bischof), &Auml;bt. (&Auml;btissin), Kg. (K&ouml;nig), Ks. (Kaiser), Hz. (Herzog), Gf. (Graf), Pfalzgf. (Pfalzgraf). Bitte trunkieren Sie &Auml;mter
als Suchbegriff vor und hinter dem Amtstitel / der Abk&uuml;rzung mit dem % (z.B. &bdquo;Columban%Abt%&ldquo;;
oder nur &bdquo;%Abt%&ldquo;).
 </p>
<p>
Jede Suchkategorie (Lemmata, Personen, Quellen, Einzelbelege) wird unabh&auml;ngig von den &uuml;brigen
Kategorien durchsucht; Eintr&auml;ge in verschiedenen Kategorien werden von der Suche nicht
miteinander verkn&uuml;pft! Ihr Suchbegriff muss also einem Eintrag in einer Kategorie vollst&auml;ndig
entsprechen, damit Ihnen Ergebnisse angezeigt werden.
 </p>
<p>
F&uuml;r <b>komplexere Suchanfragen</b> wechseln Sie bitte zur
<b><a href="freie_suche.jsp">erweiterten Suche</a></b>.
</p>
<%
}else{
%>
<h4>How to search the database</h4>

<p>The database allows you to search for name lemmata, persons, and primary sources, as well as single references (specific names within a source). For a more detailed search, please press the <a href="freie_suche.jsp">advanced search button</a>. Upper and lower case are disregarded as search criteria.
 </p>
<p>By entering % you can truncate your query. Put differently, the % represents a random amount of signs at each position (also in the beginning) of the search keyword. The truncation of the keyword at the end of the keyword is practical, because the database only shows entries which match the keyword exactly. Multiple search keywords are not conjoined by using 'and/or', thus you have to put a % between multiple search keywords.
 </p>
<p>Names: The entries concerning personal names in the database consist of a name + additional information that help to distinguish a particular person (e.g. Karl Martell &lt;Hausmeier, +741&gt;). This means that you will only be able to find information on a specific person in the database if you enter the keyword this way: "Karl%Martell%"; the holy Columban can only be found by searching for "Columban%".
 </p>
<p>Please pay attention to the following abbreviations: Ebf. (Archbishop), Bf. (Bishop), &Auml;bt. (Abbess), Kg. (King), Ks. (Emperor), Hz. (Duke), Gf. (Earl), Pfalzgf. (Palsgrave). Thus, if you want to search the database for a specific person with an official title, you need to truncate the query as follows: "Columban%Abt%".
 </p>
<p>Each category, be it name lemmata, persons, primary sources, or single references, must be browsed independently and entries in these different categories are not linked up with each other. In other words, an internal cross-reference search between categories is impossible. Hence, your keyword has to match an entry in one of the aforementioned categories to obtain results.
 </p>
<p>For a more detailed search please press the <a href="freie_suche.jsp">advanced search button</a>.
 </p>

<%

}
%>
          </div>
        </div>
      </div>
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
