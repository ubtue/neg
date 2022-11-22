<%@ page import="java.sql.Connection" isThreadSafe="false" %>
<%@ page import="java.sql.DriverManager" isThreadSafe="false" %>
<%@ page import="java.sql.ResultSet" isThreadSafe="false" %>
<%@ page import="java.sql.SQLException" isThreadSafe="false" %>
<%@ page import="java.sql.Statement" isThreadSafe="false" %>
<%@ page import="java.util.Date" isThreadSafe="false" %>
<%@ page import="de.uni_tuebingen.ub.nppm.util.Language" isThreadSafe="false" %>
<%@ page import="de.uni_tuebingen.ub.nppm.util.AuthHelper" isThreadSafe="false" %>
<%@ include file="configuration.jsp" %>
<%@ include file="functions.jsp" %>

<jsp:include page="doduplicate.jsp" />


<jsp:include page="dofilter.jsp" />


<%
  Language.setLanguage(request);
  if (AuthHelper.isBenutzerLogin(request)) {

    int id = -1;
    int filter = 0;
    String formular = "freie_suche";
%>

<HTML>
  <HEAD>
    <TITLE>Nomen et Gens -
      <jsp:include page="inc.erzeugeBeschriftung.jsp">
        <jsp:param name="Formular" value="freie_suche"/>
        <jsp:param name="Textfeld" value="Titel"/>
      </jsp:include>
    </TITLE>
    <link rel="stylesheet" href="layout/jquery-ui-1.10.3.css" />
    <script src="javascript/jquery-1.11.1.min.js" type="text/javascript"></script>
    <script src="javascript/jquery-ui-1.10.3.js" type="text/javascript"></script>
<!-->link rel="stylesheet" href="/resources/demos/style.css" /-->
<style>
	#truncate-hint {
		font-size: small;
		right: 0;
	    position: absolute;
	    width: 240px;
	}
</style>
<script>
$(function() {
	$( document ).tooltip();
});
</script>

    <link rel="stylesheet" href="layout/layout.css" type="text/css">
    <script src="javascript/funktionen.js" type="text/javascript"></script>
            <link rel="stylesheet" type="text/css" href="layout/jquery.autocomplete.css" />
    <script src="javascript/jquery.autocomplete.js"></script>
    <script type="text/javascript">
    $(function() { // when document has loaded

    	// replace [help] with link to help >>
    	var p = $('#truncate-hint');
    	p.html(p.text().trim().replace(/\[(.+)\]/, "<a href='gast/hilfe'>$1</a>"));
    	// <<

        var i = 4; // check how many input exists on the document and add 1 for the add command to work
        $('a#add').click(function() { // when you click the add link
        if(i<15){
<%
   out.print("$('<tr><th>Dann nach</th><td>");
   out.print("<select name=\"order'+i+'\">");
   out.print("  <option value=\"-1\">--</option>");
   Connection cn = null;
   Statement st = null;
   ResultSet rs = null;

     String sprache = "de";
  if (session != null && session.getAttribute("Sprache") != null)
    sprache = (String)session.getAttribute("Sprache");


   try {
    Class.forName( sqlDriver );
    cn = DriverManager.getConnection( sqlURL, sqlUser, sqlPassword );
    st = cn.createStatement();
    rs = st.executeQuery("SELECT * FROM datenbank_texte WHERE Formular='freie_suche' AND Textfeld LIKE \"Order%\"");

    while (rs.next()) {

       out.print("<option value=\"" + rs.getString("Textfeld") +"\">");
       out.print(rs.getString(sprache));
       out.print("</option>");

    }
    out.print("</select>");

    out.print("<input type=\"radio\" name=\"order'+i+'ASCDESC\" value=\"ASC\" checked/>");
    out.print("aufsteigend");
    out.print(" &nbsp;");
    out.print(" <input type=\"radio\" name=\"order'+i+'ASCDESC\" value=\"DESC\" />");
 	out.print("absteigend");
    out.print("<br>Zeitraum (nur für Datierung): <input type=\"text\" name=\"order'+i+'zeit\" />  ");

    }
    catch(Exception ex){ex.printStackTrace();}

    out.print("</td></tr>').appendTo('div#tab3 div#main table tbody');");
%>
    // if you have the input inside a form, change body to form in the appendTo
            i++; //after the click i will be i = 3 if you click again i will be i = 4
      }
     });
            });
    </script>

    <noscript></noscript>
  </HEAD>



    <jsp:include page="layout/navigation.inc.jsp" />
    <jsp:include page="layout/image.inc.html" />
    <jsp:include page="layout/titel.suche.html" />

    <FORM method="POST" action="suchergebnis.jsp">
      <input type="hidden" name="form" value="freie_suche">

<!-- ##### SUCHFELDER ##### -->
      <div id="form">
        <div id="tab1">
          <div id="header">
            <ul id="primary">
              <li>
                <span>
                  <jsp:include page="inc.erzeugeBeschriftung.jsp">
                    <jsp:param name="Formular" value="freie_suche"/>
                    <jsp:param name="Textfeld" value="Tab1"/>
                  </jsp:include>
                </span>
              </li>
              <li>
                <a href="javascript:onoff('tab2','tab1');">
                  <jsp:include page="inc.erzeugeBeschriftung.jsp">
                    <jsp:param name="Formular" value="freie_suche"/>
                    <jsp:param name="Textfeld" value="Tab2"/>
                  </jsp:include>
                </a>
              </li>
              <li>
                <a href="javascript:onoff('tab3','tab1');">
                  <jsp:include page="inc.erzeugeBeschriftung.jsp">
                    <jsp:param name="Formular" value="freie_suche"/>
                    <jsp:param name="Textfeld" value="Tab3"/>
                  </jsp:include>
                </a>
              </li>
              <li>
                <a href="javascript:onoff('tab4','tab1');">
                  <jsp:include page="inc.erzeugeBeschriftung.jsp">
                    <jsp:param name="Formular" value="freie_suche"/>
                    <jsp:param name="Textfeld" value="Tab4"/>
                  </jsp:include>
                </a>
              </li>
            </ul>
          </div>
          <div id="main">
            <p id="truncate-hint">
            	<jsp:include page="inc.erzeugeBeschriftung.jsp">
                	<jsp:param name="Formular" value="freie_suche"/>
                	<jsp:param name="Textfeld" value="TruncateHint"/>
              	</jsp:include>
            </p>
            <h3>
              <jsp:include page="inc.erzeugeBeschriftung.jsp">
                <jsp:param name="Formular" value="freie_suche"/>
                <jsp:param name="Textfeld" value="Ueberschrift1"/>
              </jsp:include>
            </h3>
            <table>
              <tbody>
                <tr>
                  <th width="200">
                                      <jsp:include page="inc.erzeugeBeschriftung.jsp">
                      <jsp:param name="Formular" value="freie_suche"/>
                      <jsp:param name="Datenfeld" value="NeGIDjump"/>
                    </jsp:include>

                  </th>
                  <td width="450">
                    <span></span><input type="text"  title="NeG-ID" placeholder="NeG-ID" name="jumpValueID" size="5">
     <input type="submit" name="jumpID" value="&gt;">
                  </td>
                </tr>
                <tr><td colspan="2">&nbsp;</td></tr>
                <tr>
                  <th width="200">
                    <jsp:include page="inc.erzeugeBeschriftung.jsp">
                      <jsp:param name="Formular" value="freie_suche"/>
                      <jsp:param name="Datenfeld" value="Belegform"/>
                    </jsp:include>
                  </th>
                  <td width="450">
                    <jsp:include page="inc.erzeugeFormular.jsp">
                      <jsp:param name="Formular" value="freie_suche"/>
                      <jsp:param name="Datenfeld" value="Belegform"/>
                      <jsp:param name="size" value="75"/>
                    </jsp:include>
                  </td>
                </tr>
                <tr>
                  <th width="200">
                    <jsp:include page="inc.erzeugeBeschriftung.jsp">
                      <jsp:param name="Formular" value="freie_suche"/>
                      <jsp:param name="Datenfeld" value="Kontext"/>
                    </jsp:include>
                  </th>
                  <td width="450">
                    <jsp:include page="inc.erzeugeFormular.jsp">
                      <jsp:param name="Formular" value="freie_suche"/>
                      <jsp:param name="Datenfeld" value="Kontext"/>
                    </jsp:include>
                  </td>
                </tr>
                <tr>
                  <th width="200">
                    <jsp:include page="inc.erzeugeBeschriftung.jsp">
                      <jsp:param name="Formular" value="freie_suche"/>
                      <jsp:param name="Datenfeld" value="Namenlemma"/>
                    </jsp:include>
                  </th>
                  <td width="450">
                    <jsp:include page="inc.erzeugeFormular.jsp">
                      <jsp:param name="Formular" value="freie_suche"/>
                      <jsp:param name="Datenfeld" value="Namenlemma"/>
                      <jsp:param name="size" value="75"/>
                    </jsp:include>
                  </td>
                </tr>
                <tr>
                  <th width="200">
                    <jsp:include page="inc.erzeugeBeschriftung.jsp">
                      <jsp:param name="Formular" value="freie_suche"/>
                      <jsp:param name="Datenfeld" value="Erstglied"/>
                    </jsp:include>
                  </th>
                  <td width="450">
                    <jsp:include page="inc.erzeugeFormular.jsp">
                      <jsp:param name="Formular" value="freie_suche"/>
                      <jsp:param name="Datenfeld" value="Erstglied"/>
                    </jsp:include>
                  </td>
                </tr>
                <tr>
                  <th width="200" valign="top">
                    <jsp:include page="inc.erzeugeBeschriftung.jsp">
                      <jsp:param name="Formular" value="freie_suche"/>
                      <jsp:param name="Datenfeld" value="Zweitglied"/>
                    </jsp:include>
                  </th>
                  <td width="450">
                    <jsp:include page="inc.erzeugeFormular.jsp">
                      <jsp:param name="Formular" value="freie_suche"/>
                      <jsp:param name="Datenfeld" value="Zweitglied"/>
                    </jsp:include>
                  </td>
                </tr>
                <tr>
                  <th width="200" valign="top">
                    <jsp:include page="inc.erzeugeBeschriftung.jsp">
                      <jsp:param name="Formular" value="freie_suche"/>
                      <jsp:param name="Datenfeld" value="MGHLemma"/>
                    </jsp:include>
                  </th>
                  <td width="450">
                    <jsp:include page="inc.erzeugeFormular.jsp">
                      <jsp:param name="Formular" value="freie_suche"/>
                      <jsp:param name="Datenfeld" value="MGHLemma"/>
                    </jsp:include>
                  </td>
                </tr>
                <tr><td colspan="2">&nbsp;</td></tr>
                <tr>
                  <th width="200" valign="top">
                    <jsp:include page="inc.erzeugeBeschriftung.jsp">
                      <jsp:param name="Formular" value="freie_suche"/>
                      <jsp:param name="Datenfeld" value="Personenname"/>
                    </jsp:include>
                  </th>
                  <td width="450">
                    <jsp:include page="inc.erzeugeFormular.jsp">
                      <jsp:param name="Formular" value="freie_suche"/>
                      <jsp:param name="Datenfeld" value="Personenname"/>
                      <jsp:param name="size" value="75"/>
                    </jsp:include>
                  </td>
                </tr>
                <tr>
                  <th width="200" valign="top">
                    <jsp:include page="inc.erzeugeBeschriftung.jsp">
                      <jsp:param name="Formular" value="freie_suche"/>
                      <jsp:param name="Datenfeld" value="Geschlecht"/>
                    </jsp:include>
                  </th>
                  <td width="450">
                    <jsp:include page="inc.erzeugeFormular.jsp">
                      <jsp:param name="Formular" value="freie_suche"/>
                      <jsp:param name="Datenfeld" value="Geschlecht"/>
                      <jsp:param name="Empty" value="yes"/>
                    </jsp:include>
                  </td>
                </tr>
                <tr>
                  <th width="200" valign="top">
                    <jsp:include page="inc.erzeugeBeschriftung.jsp">
                      <jsp:param name="Formular" value="freie_suche"/>
                      <jsp:param name="Datenfeld" value="PersonZeitraum"/>
                    </jsp:include>
                  </th>
                  <td width="450">
                    <jsp:include page="inc.erzeugeFormular.jsp">
                      <jsp:param name="Formular" value="freie_suche"/>
                      <jsp:param name="Datenfeld" value="PersonZeitraum"/>
                    </jsp:include>
                    <br>
                    <jsp:include page="inc.erzeugeBeschriftung.jsp">
                      <jsp:param name="Formular" value="freie_suche"/>
                      <jsp:param name="Textfeld" value="Datumsformat"/>
                    </jsp:include>: 6Jh2, 750, 750-810, 5Jh1-7Jh2
                  </td>
                </tr>
                <tr><td colspan="2">&nbsp;</td></tr>
                <tr>
                  <th width="200" valign="top">
                    <jsp:include page="inc.erzeugeBeschriftung.jsp">
                      <jsp:param name="Formular" value="freie_suche"/>
                      <jsp:param name="Datenfeld" value="AmtWeihePerson"/>
                    </jsp:include>
                  </th>
                  <td width="450">
                    <jsp:include page="inc.erzeugeFormular.jsp">
                      <jsp:param name="Formular" value="freie_suche"/>
                      <jsp:param name="Datenfeld" value="AmtWeihePerson"/>
                      <jsp:param name="Empty" value="yes"/>
                    </jsp:include>
                  </td>
                </tr>
                <tr>
                  <th width="200" valign="top">
                    <jsp:include page="inc.erzeugeBeschriftung.jsp">
                      <jsp:param name="Formular" value="freie_suche"/>
                      <jsp:param name="Datenfeld" value="StandPerson"/>
                     </jsp:include>
                  </th>
                  <td width="450">
                    <jsp:include page="inc.erzeugeFormular.jsp">
                      <jsp:param name="Formular" value="freie_suche"/>
                      <jsp:param name="Datenfeld" value="StandPerson"/>
                      <jsp:param name="Empty" value="yes"/>
                    </jsp:include>
                  </td>
                </tr>
                <tr>
                  <th width="200" valign="top">
                    <jsp:include page="inc.erzeugeBeschriftung.jsp">
                      <jsp:param name="Formular" value="freie_suche"/>
                      <jsp:param name="Datenfeld" value="AmtWeiheEinzelbeleg"/>
                    </jsp:include>
                  </th>
                  <td width="450">
                    <jsp:include page="inc.erzeugeFormular.jsp">
                      <jsp:param name="Formular" value="freie_suche"/>
                      <jsp:param name="Datenfeld" value="AmtWeiheEinzelbeleg"/>
                       <jsp:param name="Empty" value="yes"/>
                    </jsp:include>
                  </td>
                </tr>
                <tr>
                  <th width="200" valign="top">
                    <jsp:include page="inc.erzeugeBeschriftung.jsp">
                      <jsp:param name="Formular" value="freie_suche"/>
                      <jsp:param name="Datenfeld" value="StandEinzelbeleg"/>
                    </jsp:include>
                  </th>
                  <td width="450">
                    <jsp:include page="inc.erzeugeFormular.jsp">
                      <jsp:param name="Formular" value="freie_suche"/>
                      <jsp:param name="Datenfeld" value="StandEinzelbeleg"/>
                    </jsp:include>
                  </td>
                </tr>
                <tr>
                  <th width="200" valign="top">
                    <jsp:include page="inc.erzeugeBeschriftung.jsp">
                      <jsp:param name="Formular" value="freie_suche"/>
                      <jsp:param name="Datenfeld" value="Funktion"/>
                    </jsp:include>
                  </th>
                  <td width="450">
                    <jsp:include page="inc.erzeugeFormular.jsp">
                      <jsp:param name="Formular" value="freie_suche"/>
                      <jsp:param name="Datenfeld" value="Funktion"/>
                      <jsp:param name="Empty" value="yes"/>
                    </jsp:include>
                  </td>
                </tr>
                <tr><td colspan="2">&nbsp;</td></tr>
                <tr>
                  <th width="200" valign="top">
                    <jsp:include page="inc.erzeugeBeschriftung.jsp">
                      <jsp:param name="Formular" value="freie_suche"/>
                      <jsp:param name="Datenfeld" value="Verwandtschaftsgrad"/>
                    </jsp:include>
                  </th>
                  <td width="450">
                    <jsp:include page="inc.erzeugeFormular.jsp">
                      <jsp:param name="Formular" value="freie_suche"/>
                      <jsp:param name="Datenfeld" value="Verwandtschaftsgrad"/>
                      <jsp:param name="Empty" value="yes"/>
                    </jsp:include>
                  </td>
                </tr>
                <tr><td colspan="2">&nbsp;</td></tr>
                <tr>
                  <th width="200" valign="top">
                    <jsp:include page="inc.erzeugeBeschriftung.jsp">
                      <jsp:param name="Formular" value="freie_suche"/>
                      <jsp:param name="Datenfeld" value="Quelle"/>
                    </jsp:include>
                  </th>
                  <td width="450">
                    <jsp:include page="inc.erzeugeFormular.jsp">
                      <jsp:param name="Formular" value="freie_suche"/>
                      <jsp:param name="Datenfeld" value="Quelle"/>
                      <jsp:param name="size" value="75"/>
                    </jsp:include>
                  </td>
                </tr>
                <tr>
                  <th width="200" valign="top">
                    <jsp:include page="inc.erzeugeBeschriftung.jsp">
                      <jsp:param name="Formular" value="freie_suche"/>
                      <jsp:param name="Datenfeld" value="Quellengattung"/>
                    </jsp:include>
                  </th>
                  <td width="450">
                    <jsp:include page="inc.erzeugeFormular.jsp">
                      <jsp:param name="Formular" value="freie_suche"/>
                      <jsp:param name="Datenfeld" value="Quellengattung"/>
                      <jsp:param name="Empty" value="yes"/>
                    </jsp:include>
                  </td>
                </tr>
                 <tr>
                  <th width="200" valign="top">
                    <jsp:include page="inc.erzeugeBeschriftung.jsp">
                      <jsp:param name="Formular" value="freie_suche"/>
                      <jsp:param name="Datenfeld" value="QuelleZeitraum"/>
                    </jsp:include>
                  </th>
                  <td width="450">
                    <jsp:include page="inc.erzeugeFormular.jsp">
                      <jsp:param name="Formular" value="freie_suche"/>
                      <jsp:param name="Datenfeld" value="QuelleZeitraum"/>
                    </jsp:include>
                    <br>
                    <jsp:include page="inc.erzeugeBeschriftung.jsp">
                      <jsp:param name="Formular" value="freie_suche"/>
                      <jsp:param name="Textfeld" value="Datumsformat"/>
                    </jsp:include>: 6Jh2, 750, 750-810, 5Jh1-7Jh2
                  </td>
                </tr>
              </tbody>
            </table>
            <!--p>&nbsp;<font color="red">*</font> <br>
                    <jsp:include page="inc.erzeugeBeschriftung.jsp">
                      <jsp:param name="Formular" value="freie_suche"/>
                      <jsp:param name="Textfeld" value="KeineFunktion"/>
                    </jsp:include></p-->
            <p align="right">
              <a href="javascript:onoff('tab2','tab1');">
                <jsp:include page="inc.erzeugeBeschriftung.jsp">
                  <jsp:param name="Formular" value="freie_suche"/>
                  <jsp:param name="Textfeld" value="LinkWeiter"/>
                </jsp:include>
              </a>
            </p>
          </div>
        </div>

<!-- ##### AUSGABEFELDER ##### -->
        <div id="tab2">
          <div id="header">
            <ul id="primary">
              <li>
                <a href="javascript:onoff('tab1','tab2');">
                  <jsp:include page="inc.erzeugeBeschriftung.jsp">
                    <jsp:param name="Formular" value="freie_suche"/>
                    <jsp:param name="Textfeld" value="Tab1"/>
                  </jsp:include>
                </a>
              </li>
              <li>
                <span>
                  <jsp:include page="inc.erzeugeBeschriftung.jsp">
                    <jsp:param name="Formular" value="freie_suche"/>
                    <jsp:param name="Textfeld" value="Tab2"/>
                  </jsp:include>
                </span>
              </li>
              <li>
                <a href="javascript:onoff('tab3','tab2');">
                  <jsp:include page="inc.erzeugeBeschriftung.jsp">
                    <jsp:param name="Formular" value="freie_suche"/>
                    <jsp:param name="Textfeld" value="Tab3"/>
                  </jsp:include>
                </a>
              </li>
              <li>
                <a href="javascript:onoff('tab4','tab2');">
                  <jsp:include page="inc.erzeugeBeschriftung.jsp">
                    <jsp:param name="Formular" value="freie_suche"/>
                    <jsp:param name="Textfeld" value="Tab4"/>
                  </jsp:include>
                </a>
              </li>
            </ul>
          </div>
          <div id="main">
            <h3>
              <jsp:include page="inc.erzeugeBeschriftung.jsp">
                <jsp:param name="Formular" value="freie_suche"/>
                <jsp:param name="Textfeld" value="Ueberschrift2"/>
              </jsp:include>
            </h3>
            <table>
              <tbody>
                <tr><td colspan="2"><h3>
                    <jsp:include page="inc.erzeugeBeschriftung.jsp">
                      <jsp:param name="Formular" value="freie_suche"/>
                      <jsp:param name="Textfeld" value="ZumNamen"/>
                    </jsp:include></h3></td></tr>
                <tr>
                  <td width="25">
                    <jsp:include page="inc.erzeugeFormular.jsp">
                      <jsp:param name="Formular" value="freie_suche"/>
                      <jsp:param name="Datenfeld" value="Ausgabe_Namenlemma"/>
                    </jsp:include>
                  </td>
                  <th width="350" valign="top">
                    <jsp:include page="inc.erzeugeBeschriftung.jsp">
                      <jsp:param name="Formular" value="freie_suche"/>
                      <jsp:param name="Datenfeld" value="Ausgabe_Namenlemma"/>
                    </jsp:include>
                  </th>
                </tr>
                <tr>
                  <td width="25">
                    <jsp:include page="inc.erzeugeFormular.jsp">
                      <jsp:param name="Formular" value="freie_suche"/>
                      <jsp:param name="Datenfeld" value="Ausgabe_Erstglied"/>
                    </jsp:include>
                  </td>
                  <td width="350" valign="top">
                    <jsp:include page="inc.erzeugeBeschriftung.jsp">
                      <jsp:param name="Formular" value="freie_suche"/>
                      <jsp:param name="Datenfeld" value="Ausgabe_Erstglied"/>
                    </jsp:include>
                  </td>
                </tr>
                <tr>
                  <td width="25">
                    <jsp:include page="inc.erzeugeFormular.jsp">
                      <jsp:param name="Formular" value="freie_suche"/>
                      <jsp:param name="Datenfeld" value="Ausgabe_Zweitglied"/>
                    </jsp:include>
                  </td>
                  <td width="350" valign="top">
                    <jsp:include page="inc.erzeugeBeschriftung.jsp">
                      <jsp:param name="Formular" value="freie_suche"/>
                      <jsp:param name="Datenfeld" value="Ausgabe_Zweitglied"/>
                    </jsp:include>
                  </td>
                </tr>
                                <tr>
                  <td width="25">
                    <jsp:include page="inc.erzeugeFormular.jsp">
                      <jsp:param name="Formular" value="freie_suche"/>
                      <jsp:param name="Datenfeld" value="Ausgabe_MGHLemma"/>
                    </jsp:include>
                  </td>
                  <td width="350" valign="top">
                    <jsp:include page="inc.erzeugeBeschriftung.jsp">
                      <jsp:param name="Formular" value="freie_suche"/>
                      <jsp:param name="Datenfeld" value="Ausgabe_MGHLemma"/>
                    </jsp:include>
                  </td>
                </tr>                 <tr><td colspan="2">&nbsp;</td></tr>
                <tr><td colspan="2"><h3><jsp:include page="inc.erzeugeBeschriftung.jsp">
                      <jsp:param name="Formular" value="freie_suche"/>
                      <jsp:param name="Textfeld" value="Zur Person"/>
                    </jsp:include></h3></td></tr>
                <tr>
                  <td width="25">
                    <jsp:include page="inc.erzeugeFormular.jsp">
                      <jsp:param name="Formular" value="freie_suche"/>
                      <jsp:param name="Datenfeld" value="Ausgabe_Person_Standardname"/>
                    </jsp:include>
                  </td>
                  <th width="350" valign="top">
                    <jsp:include page="inc.erzeugeBeschriftung.jsp">
                      <jsp:param name="Formular" value="freie_suche"/>
                      <jsp:param name="Datenfeld" value="Ausgabe_Person_Standardname"/>
                    </jsp:include>
                  </th>
                </tr>
                <tr>
                  <td width="25">
                    <jsp:include page="inc.erzeugeFormular.jsp">
                      <jsp:param name="Formular" value="freie_suche"/>
                      <jsp:param name="Datenfeld" value="Ausgabe_Person_AmtWeihe"/>
                    </jsp:include>
                  </td>
                  <td width="350" valign="top">
                    <jsp:include page="inc.erzeugeBeschriftung.jsp">
                      <jsp:param name="Formular" value="freie_suche"/>
                      <jsp:param name="Datenfeld" value="Ausgabe_Person_AmtWeihe"/>
                    </jsp:include>
                    <font color="blue">**</font>
                  </td>
                </tr>
                <tr>
                  <td width="25">
                  </td>
                  <td width="350" valign="top">
                    <jsp:include page="inc.erzeugeFormular.jsp">
                      <jsp:param name="Formular" value="freie_suche"/>
                      <jsp:param name="Datenfeld" value="Ausgabe_Person_AmtWeiheZeitraum"/>
                    </jsp:include>
                    <jsp:include page="inc.erzeugeBeschriftung.jsp">
                      <jsp:param name="Formular" value="freie_suche"/>
                      <jsp:param name="Datenfeld" value="Ausgabe_Person_AmtWeiheZeitraum"/>
                    </jsp:include>
                  </td>
                </tr>
                <tr>
                  <td width="25">
                    <jsp:include page="inc.erzeugeFormular.jsp">
                      <jsp:param name="Formular" value="freie_suche"/>
                      <jsp:param name="Datenfeld" value="Ausgabe_Person_Ethnie"/>
                    </jsp:include>
                  </td>
                  <td width="350" valign="top">
                    <jsp:include page="inc.erzeugeBeschriftung.jsp">
                      <jsp:param name="Formular" value="freie_suche"/>
                      <jsp:param name="Datenfeld" value="Ausgabe_Person_Ethnie"/>
                    </jsp:include>
                    <font color="blue">**</font>
                  </td>
                </tr>
                <tr>
                  <td width="25">
                    <jsp:include page="inc.erzeugeFormular.jsp">
                      <jsp:param name="Formular" value="freie_suche"/>
                      <jsp:param name="Datenfeld" value="Ausgabe_Stand"/>
                    </jsp:include>
                  </td>
                  <td width="350" valign="top">
                    <jsp:include page="inc.erzeugeBeschriftung.jsp">
                      <jsp:param name="Formular" value="freie_suche"/>
                      <jsp:param name="Datenfeld" value="Ausgabe_Stand"/>
                    </jsp:include>
                    <font color="blue">**</font>
                  </td>
                </tr>
                <tr>
                  <td width="25">
                    <jsp:include page="inc.erzeugeFormular.jsp">
                      <jsp:param name="Formular" value="freie_suche"/>
                      <jsp:param name="Datenfeld" value="Ausgabe_Geschlecht"/>
                    </jsp:include>
                  </td>
                  <td width="350" valign="top">
                    <jsp:include page="inc.erzeugeBeschriftung.jsp">
                      <jsp:param name="Formular" value="freie_suche"/>
                      <jsp:param name="Datenfeld" value="Ausgabe_Geschlecht"/>
                    </jsp:include>
                    <font color="blue">**</font>
                  </td>
                </tr>
                <tr>
                  <td width="25">
                    <jsp:include page="inc.erzeugeFormular.jsp">
                      <jsp:param name="Formular" value="freie_suche"/>
                      <jsp:param name="Datenfeld" value="Ausgabe_Person_Verwandte"/>
                    </jsp:include>
                  </td>
                  <td width="350" valign="top">
                    <jsp:include page="inc.erzeugeBeschriftung.jsp">
                      <jsp:param name="Formular" value="freie_suche"/>
                      <jsp:param name="Datenfeld" value="Ausgabe_Person_Verwandte"/>
                    </jsp:include>
                    <font color="blue">**</font>
                  </td>
                </tr>
                <tr>
                  <td width="25">
                    <jsp:include page="inc.erzeugeFormular.jsp">
                      <jsp:param name="Formular" value="freie_suche"/>
                      <jsp:param name="Datenfeld" value="Ausgabe_Person_Areal"/>
                    </jsp:include>
                  </td>
                  <td width="350" valign="top">
                    <jsp:include page="inc.erzeugeBeschriftung.jsp">
                      <jsp:param name="Formular" value="freie_suche"/>
                      <jsp:param name="Datenfeld" value="Ausgabe_Person_Areal"/>
                    </jsp:include>
                    <font color="blue">**</font>
                  </td>
                </tr>

                <tr><td colspan="2">&nbsp;</td></tr>
                <tr><td colspan="2"><h3><jsp:include page="inc.erzeugeBeschriftung.jsp">
                      <jsp:param name="Formular" value="freie_suche"/>
                      <jsp:param name="Textfeld" value="ZumEinzelbeleg"/>
                    </jsp:include></h3></td></tr>
                <tr>
                  <td width="25">
                    <jsp:include page="inc.erzeugeFormular.jsp">
                      <jsp:param name="Formular" value="freie_suche"/>
                      <jsp:param name="Datenfeld" value="Ausgabe_Einzelbeleg_Belegstelle"/>
                    </jsp:include>
                  </td>
                  <td width="350" valign="top">
                    <jsp:include page="inc.erzeugeBeschriftung.jsp">
                      <jsp:param name="Formular" value="freie_suche"/>
                      <jsp:param name="Datenfeld" value="Ausgabe_Einzelbeleg_Belegstelle"/>
                    </jsp:include>
                  </td>
                </tr>
                <tr>
                  <td width="25">
                    <jsp:include page="inc.erzeugeFormular.jsp">
                      <jsp:param name="Formular" value="freie_suche"/>
                      <jsp:param name="Datenfeld" value="Ausgabe_Quelle_Datierung"/>
                    </jsp:include>
                  </td>
                  <td width="350" valign="top">
                    <jsp:include page="inc.erzeugeBeschriftung.jsp">
                      <jsp:param name="Formular" value="freie_suche"/>
                      <jsp:param name="Datenfeld" value="Ausgabe_Quelle_Datierung"/>
                    </jsp:include>
                  </td>
                </tr>
                <tr>
                  <td width="25">
                    <jsp:include page="inc.erzeugeFormular.jsp">
                      <jsp:param name="Formular" value="freie_suche"/>
                      <jsp:param name="Datenfeld" value="Ausgabe_Einzelbeleg_Quellengattung"/>
                    </jsp:include>
                  </td>
                  <td width="350" valign="top">
                    <jsp:include page="inc.erzeugeBeschriftung.jsp">
                      <jsp:param name="Formular" value="freie_suche"/>
                      <jsp:param name="Datenfeld" value="Ausgabe_Einzelbeleg_Quellengattung"/>
                    </jsp:include>
                  </td>
                </tr>
                <tr>
                  <td width="25">
                    <jsp:include page="inc.erzeugeFormular.jsp">
                      <jsp:param name="Formular" value="freie_suche"/>
                      <jsp:param name="Datenfeld" value="Ausgabe_Einzelbeleg_Belegform"/>
                    </jsp:include>
                  </td>
                  <th width="350" valign="top">
                    <jsp:include page="inc.erzeugeBeschriftung.jsp">
                      <jsp:param name="Formular" value="freie_suche"/>
                      <jsp:param name="Datenfeld" value="Ausgabe_Einzelbeleg_Belegform"/>
                    </jsp:include>
                  </th>
                </tr>
                <tr>
                  <td width="25">
                    <jsp:include page="inc.erzeugeFormular.jsp">
                      <jsp:param name="Formular" value="freie_suche"/>
                      <jsp:param name="Datenfeld" value="Ausgabe_Einzelbeleg_Kontext"/>
                    </jsp:include>
                  </td>
                  <td width="350" valign="top">
                    <jsp:include page="inc.erzeugeBeschriftung.jsp">
                      <jsp:param name="Formular" value="freie_suche"/>
                      <jsp:param name="Datenfeld" value="Ausgabe_Einzelbeleg_Kontext"/>
                    </jsp:include>
                  </td>
                </tr>
                <tr>
                  <td width="25">
                    <jsp:include page="inc.erzeugeFormular.jsp">
                      <jsp:param name="Formular" value="freie_suche"/>
                      <jsp:param name="Datenfeld" value="Ausgabe_Einzelbeleg_Datierung"/>
                    </jsp:include>
                  </td>
                  <td width="350" valign="top">
                    <jsp:include page="inc.erzeugeBeschriftung.jsp">
                      <jsp:param name="Formular" value="freie_suche"/>
                      <jsp:param name="Datenfeld" value="Ausgabe_Einzelbeleg_Datierung"/>
                    </jsp:include>
                  </td>
                </tr>
                <tr>
                  <td width="25">
                    <jsp:include page="inc.erzeugeFormular.jsp">
                      <jsp:param name="Formular" value="freie_suche"/>
                      <jsp:param name="Datenfeld" value="Ausgabe_Einzelbeleg_lebend"/>
                    </jsp:include>
                  </td>
                  <td width="350" valign="top">
                    <jsp:include page="inc.erzeugeBeschriftung.jsp">
                      <jsp:param name="Formular" value="freie_suche"/>
                      <jsp:param name="Datenfeld" value="Ausgabe_Einzelbeleg_lebend"/>
                    </jsp:include>
                  </td>
                </tr>
                <tr>
                  <td width="25">
                    <jsp:include page="inc.erzeugeFormular.jsp">
                      <jsp:param name="Formular" value="freie_suche"/>
                      <jsp:param name="Datenfeld" value="Ausgabe_Einzelbeleg_Funktion"/>
                    </jsp:include>
                  </td>
                  <td width="350" valign="top">
                    <jsp:include page="inc.erzeugeBeschriftung.jsp">
                      <jsp:param name="Formular" value="freie_suche"/>
                      <jsp:param name="Datenfeld" value="Ausgabe_Einzelbeleg_Funktion"/>
                    </jsp:include>
                    <font color="blue">**</font>
                  </td>
                </tr>
                <tr>
                  <td width="25">
                    <jsp:include page="inc.erzeugeFormular.jsp">
                      <jsp:param name="Formular" value="freie_suche"/>
                      <jsp:param name="Datenfeld" value="Ausgabe_Einzelbeleg_Areal"/>
                    </jsp:include>
                  </td>
                  <td width="350" valign="top">
                    <jsp:include page="inc.erzeugeBeschriftung.jsp">
                      <jsp:param name="Formular" value="freie_suche"/>
                      <jsp:param name="Datenfeld" value="Ausgabe_Einzelbeleg_Areal"/>
                    </jsp:include>
                    <font color="blue">**</font>
                  </td>
                </tr>
                <tr>
                  <td width="25">
                    <jsp:include page="inc.erzeugeFormular.jsp">
                      <jsp:param name="Formular" value="freie_suche"/>
                      <jsp:param name="Datenfeld" value="Ausgabe_Einzelbeleg_Varianten"/>
                    </jsp:include>
                  </td>
                  <td width="350" valign="top">
                    <jsp:include page="inc.erzeugeBeschriftung.jsp">
                      <jsp:param name="Formular" value="freie_suche"/>
                      <jsp:param name="Datenfeld" value="Ausgabe_Einzelbeleg_Varianten"/>
                    </jsp:include>
                    <font color="blue">**</font>
                  </td>
                </tr>
                <tr>
                  <td width="25">
                    <jsp:include page="inc.erzeugeFormular.jsp">
                      <jsp:param name="Formular" value="freie_suche"/>
                      <jsp:param name="Datenfeld" value="Ausgabe_Einzelbeleg_Textzeuge"/>
                    </jsp:include>
                  </td>
                  <td width="350" valign="top">
                    <jsp:include page="inc.erzeugeBeschriftung.jsp">
                      <jsp:param name="Formular" value="freie_suche"/>
                      <jsp:param name="Datenfeld" value="Ausgabe_Einzelbeleg_Textzeuge"/>
                    </jsp:include>
                    <font color="red">*</font>
                  </td>
                </tr>
                <tr>
                  <td width="25">
                  </td>
                  <td width="350" valign="top">
                    <jsp:include page="inc.erzeugeFormular.jsp">
                      <jsp:param name="Formular" value="freie_suche"/>
                      <jsp:param name="Datenfeld" value="Ausgabe_Einzelbeleg_Textzeuge_Datierung"/>
                    </jsp:include>
                    <jsp:include page="inc.erzeugeBeschriftung.jsp">
                      <jsp:param name="Formular" value="freie_suche"/>
                      <jsp:param name="Datenfeld" value="Ausgabe_Einzelbeleg_Textzeuge_Datierung"/>
                    </jsp:include>
                    <font color="red">*</font>
                  </td>
                </tr>
                <tr>
                  <td width="25">
                  </td>
                  <td width="350" valign="top">
                    <jsp:include page="inc.erzeugeFormular.jsp">
                      <jsp:param name="Formular" value="freie_suche"/>
                      <jsp:param name="Datenfeld" value="Ausgabe_Einzelbeleg_Textzeuge_Schriftheimat"/>
                    </jsp:include>
                    <jsp:include page="inc.erzeugeBeschriftung.jsp">
                      <jsp:param name="Formular" value="freie_suche"/>
                      <jsp:param name="Datenfeld" value="Ausgabe_Einzelbeleg_Textzeuge_Schriftheimat"/>
                    </jsp:include>
                    <font color="red">*</font>
                  </td>
                </tr>
                <tr>
                  <td width="25">
                  </td>
                  <td width="350" valign="top">
                    <jsp:include page="inc.erzeugeFormular.jsp">
                      <jsp:param name="Formular" value="freie_suche"/>
                      <jsp:param name="Datenfeld" value="Ausgabe_Einzelbeleg_Textzeuge_Bibliotheksheimat"/>
                    </jsp:include>
                    <jsp:include page="inc.erzeugeBeschriftung.jsp">
                      <jsp:param name="Formular" value="freie_suche"/>
                      <jsp:param name="Datenfeld" value="Ausgabe_Einzelbeleg_Textzeuge_Bibliotheksheimat"/>
                    </jsp:include>
                    <font color="red">*</font>
                  </td>
                </tr>
              </tbody>
            </table>
            <p>
              &nbsp;<font color="red">*</font> <jsp:include page="inc.erzeugeBeschriftung.jsp">
                      <jsp:param name="Formular" value="freie_suche"/>
                      <jsp:param name="Textfeld" value="KeineFunktion"/>
                    </jsp:include><br>
              &nbsp;<font color="blue">**</font> <jsp:include page="inc.erzeugeBeschriftung.jsp">
                      <jsp:param name="Formular" value="freie_suche"/>
                      <jsp:param name="Textfeld" value="GroessereAusgabe"/>
                    </jsp:include>
            </p>
            <p align="right">
              <a href="javascript:onoff('tab3','tab2');">
                <jsp:include page="inc.erzeugeBeschriftung.jsp">
                  <jsp:param name="Formular" value="freie_suche"/>
                  <jsp:param name="Textfeld" value="LinkWeiter"/>
                </jsp:include>
              </a>
            </p>
          </div>
        </div>

<!-- ##### SORTIERUNG ##### -->
        <div id="tab3">
          <div id="header">
            <ul id="primary">
              <li>
                <a href="javascript:onoff('tab1','tab3');">
                  <jsp:include page="inc.erzeugeBeschriftung.jsp">
                    <jsp:param name="Formular" value="freie_suche"/>
                    <jsp:param name="Textfeld" value="Tab1"/>
                  </jsp:include>
                </a>
              </li>
              <li>
                <a href="javascript:onoff('tab2','tab3');">
                  <jsp:include page="inc.erzeugeBeschriftung.jsp">
                    <jsp:param name="Formular" value="freie_suche"/>
                    <jsp:param name="Textfeld" value="Tab2"/>
                  </jsp:include>
                </a>
              </li>
              <li>
                <span>
                  <jsp:include page="inc.erzeugeBeschriftung.jsp">
                    <jsp:param name="Formular" value="freie_suche"/>
                    <jsp:param name="Textfeld" value="Tab3"/>
                  </jsp:include>
                </span>
              </li>
              <li>
                <a href="javascript:onoff('tab4','tab3');">
                  <jsp:include page="inc.erzeugeBeschriftung.jsp">
                    <jsp:param name="Formular" value="freie_suche"/>
                    <jsp:param name="Textfeld" value="Tab4"/>
                  </jsp:include>
                </a>
              </li>
            </ul>
          </div>
          <div id="main">
            <h3>
              <jsp:include page="inc.erzeugeBeschriftung.jsp">
                <jsp:param name="Formular" value="freie_suche"/>
                <jsp:param name="Textfeld" value="Ueberschrift3"/>
              </jsp:include>
            </h3>
            <table>
              <tbody>
                <tr>
                  <th width="200" valign="top">
                    <jsp:include page="inc.erzeugeBeschriftung.jsp">
                      <jsp:param name="Formular" value="freie_suche"/>
                      <jsp:param name="Textfeld" value="Sortierung1"/>
                    </jsp:include>
                  </th>
                  <td width="450">
                    <jsp:include page="forms/search.order.jsp">
                      <jsp:param name="name" value="order1"/>
                    </jsp:include>
                  </td>
                </tr>
                <tr>
                  <th width="200" valign="top">
                    <jsp:include page="inc.erzeugeBeschriftung.jsp">
                      <jsp:param name="Formular" value="freie_suche"/>
                      <jsp:param name="Textfeld" value="Sortierung2"/>
                    </jsp:include>
                  </th>
                  <td width="450">
                    <jsp:include page="forms/search.order.jsp">
                      <jsp:param name="name" value="order2"/>
                    </jsp:include>
                  </td>
                </tr>
                <tr>
                  <th width="200" valign="top">
                    <jsp:include page="inc.erzeugeBeschriftung.jsp">
                      <jsp:param name="Formular" value="freie_suche"/>
                      <jsp:param name="Textfeld" value="Sortierung3"/>
                    </jsp:include>
                  </th>
                  <td width="450">
                    <jsp:include page="forms/search.order.jsp">
                      <jsp:param name="name" value="order3"/>
                    </jsp:include>
                  </td>
                </tr>
              </tbody>
            </table>
           <p align="right">
               <a href="#" id="add">Weitere Gruppierung hinzufügen</a>
            </p>
            <p align="right">
              <a href="javascript:onoff('tab4','tab3');">
                <jsp:include page="inc.erzeugeBeschriftung.jsp">
                  <jsp:param name="Formular" value="freie_suche"/>
                  <jsp:param name="Textfeld" value="LinkWeiter"/>
                </jsp:include>
              </a>
            </p>
          </div>
        </div>

<!-- ##### AUSGABEFORMAT ##### -->
        <div id="tab4">
          <div id="header">
            <ul id="primary">
              <li>
                <a href="javascript:onoff('tab1','tab4');">
                  <jsp:include page="inc.erzeugeBeschriftung.jsp">
                    <jsp:param name="Formular" value="freie_suche"/>
                    <jsp:param name="Textfeld" value="Tab1"/>
                  </jsp:include>
                </a>
              </li>
              <li>
                <a href="javascript:onoff('tab2','tab4');">
                  <jsp:include page="inc.erzeugeBeschriftung.jsp">
                    <jsp:param name="Formular" value="freie_suche"/>
                    <jsp:param name="Textfeld" value="Tab2"/>
                  </jsp:include>
                </a>
              </li>
              <li>
                <a href="javascript:onoff('tab3','tab4');">
                  <jsp:include page="inc.erzeugeBeschriftung.jsp">
                    <jsp:param name="Formular" value="freie_suche"/>
                    <jsp:param name="Textfeld" value="Tab3"/>
                  </jsp:include>
                </a>
              </li>
              <li>
                <span>
                  <jsp:include page="inc.erzeugeBeschriftung.jsp">
                    <jsp:param name="Formular" value="freie_suche"/>
                    <jsp:param name="Textfeld" value="Tab4"/>
                  </jsp:include>
                </span>
              </li>
            </ul>
          </div>
          <div id="main">
            <h3>
              <jsp:include page="inc.erzeugeBeschriftung.jsp">
                <jsp:param name="Formular" value="freie_suche"/>
                <jsp:param name="Textfeld" value="Ueberschrift4"/>
              </jsp:include>
            </h3>
            <table>
              <tbody>
                <tr>
                  <td>
                    <input type="radio" name="export" value="liste" />
                  </td>
                  <td>
                    <jsp:include page="inc.erzeugeBeschriftung.jsp">
                      <jsp:param name="Formular" value="freie_suche"/>
                      <jsp:param name="Textfeld" value="ExportListe"/>
                    </jsp:include>
                  </td>
                </tr>
                <tr>
                  <td>
                    <input type="radio" name="export" value="excel" />
                  </td>
                  <td>
                    <jsp:include page="inc.erzeugeBeschriftung.jsp">
                      <jsp:param name="Formular" value="freie_suche"/>
                      <jsp:param name="Textfeld" value="ExportExcel"/>
                    </jsp:include>
                  </td>
                </tr>
                <tr>
                  <td>
                    <input type="radio" name="export" value="rtf" />
                  </td>
                  <td>
                    <jsp:include page="inc.erzeugeBeschriftung.jsp">
                      <jsp:param name="Formular" value="freie_suche"/>
                      <jsp:param name="Textfeld" value="ExportRtf"/>
                    </jsp:include>
                    <font color="red">*</font>
                  </td>
                </tr>
                <tr>
                  <td>
                    <input type="radio" name="export" value="browse" />
                  </td>
                  <td>
                    <jsp:include page="inc.erzeugeBeschriftung.jsp">
                      <jsp:param name="Formular" value="freie_suche"/>
                      <jsp:param name="Textfeld" value="ExportBrowse"/>
                    </jsp:include>
                  </td>
                </tr>
              </tbody>
            </table>
            <p>
              &nbsp;<font color="red">*</font> <jsp:include page="inc.erzeugeBeschriftung.jsp">
                      <jsp:param name="Formular" value="freie_suche"/>
                      <jsp:param name="Textfeld" value="KeineFunktion"/>
                    </jsp:include>
            </p>
            <p align="right">
              <input type="reset">
              <input type="submit">
            </p>
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
