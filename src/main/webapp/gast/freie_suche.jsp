<%@ page import="java.sql.Connection" isThreadSafe="false" %>
<%@ page import="java.sql.DriverManager" isThreadSafe="false" %>
<%@ page import="java.sql.ResultSet" isThreadSafe="false" %>
<%@ page import="java.sql.SQLException" isThreadSafe="false" %>
<%@ page import="java.sql.Statement" isThreadSafe="false" %>
<%@ page import="java.util.Date" isThreadSafe="false" %>
<%@ page import="de.uni_tuebingen.ub.nppm.util.Language" isThreadSafe="false" %>
<%@ include file="../configuration.jsp" %>
<%@ include file="../functions.jsp" %>

<%
  Language.setLanguage(request);
  if (session.getAttribute("BenutzerID")!=null && ((Integer) session.getAttribute("BenutzerID")).intValue() > 0) {
                          session.setAttribute("filter", 0);
        session.setAttribute("filterParameter", "");

    int id = -1;
    int filter = 0;
    String formular = "freie_suche";
%>

<HTML>
  <HEAD>
    <TITLE>Nomen et Gens -
      <jsp:include page="../inc.erzeugeBeschriftung.jsp">
        <jsp:param name="Formular" value="freie_suche"/>
        <jsp:param name="Textfeld" value="Titel"/>
      </jsp:include>
    </TITLE>
    <link rel="icon" href="layout/images/nomen_et_gens_icon.gif" type="image/gif">
    <link rel="stylesheet" href="layout/layout.css" type="text/css">
    <link href='layout/fonts/open-sans.css' rel='stylesheet' type='text/css'>
    <link href='layout/fonts/alegreya-sans-sc.css' rel='stylesheet' type='text/css'>
    <script src="../javascript/funktionen.js" type="text/javascript"></script>
    <script src="../layout/BubbleTooltips.js" type="text/javascript" ></script> <!--Pfad zur js-Datei-->
    <script src="../javascript/jquery-1.11.1.min.js" type="text/javascript"></script>
    <script src="../javascript/javascript.js" type="text/javascript"></script>


<script type="text/javascript">
function CheckAll(index, check, praefix) {
  for(i=0; i< document.forms[index].elements.length; i++){
	if(document.forms[index].elements[i].type=="checkbox" && document.forms[index].elements[i].name.indexOf(praefix)>-1){
       document.forms[index].elements[i].checked = check;
    }
  }
}
</script>
<style>
	.truncate-hint, .truncate-hint a {
		font-size: small !important;
	}
</style>
    <script type="text/javascript">
    $(function() { // when document has loaded

    	// replace [help] with link to help >>
    	var p = $('.truncate-hint');
    	p.html(p.text().trim().replace(/\[(.+)\]/, "<a href='hilfe.jsp'>$1</a>"));
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
    out.print("<br>Zeitraum (nur f&uuml;r Datierung): <input type=\"text\" name=\"order'+i+'zeit\" />  ");

    }
    catch(Exception ex){ex.printStackTrace();}

    out.print("</td></tr>').appendTo('div#tab-3 table tbody');");
//    out.print("</td></tr>').appendTo('div#tab3 div#main table tbody');");
%>
    // if you have the input inside a form, change body to form in the appendTo
            i++; //after the click i will be i = 3 if you click again i will be i = 4
      }
     });
            });
    </script>

    <noscript></noscript>

  </HEAD>

  <BODY>
<!--onLoad="javascript:onoff('tab2','tab1'); onoff('tab1','tab2');"-->

      <FORM method="POST" action="einfaches_ergebnis.jsp">
    <jsp:include page="layout/header.inc.jsp">
        <jsp:param name="current" value="erweiterte_suche" />
    </jsp:include>
</FORM>

<div id="content">
<div id="erweiterte-suche">
        <ul id="tabs">
            <li><a data-id="tab-1" class="tab-1 current-search search-button" href="#">
                  <jsp:include page="../inc.erzeugeBeschriftung.jsp">
                    <jsp:param name="Formular" value="freie_suche"/>
                    <jsp:param name="Textfeld" value="Tab1"/>
                  </jsp:include>
             </a></li>
            <li><a data-id="tab-2" class="tab-2 search-button" href="#">
                  <jsp:include page="../inc.erzeugeBeschriftung.jsp">
                    <jsp:param name="Formular" value="freie_suche"/>
                    <jsp:param name="Textfeld" value="Tab2"/>
                  </jsp:include>
            </a></li>
            <li><a data-id="tab-3" class="tab-3 search-button" href="#">
                  <jsp:include page="../inc.erzeugeBeschriftung.jsp">
                    <jsp:param name="Formular" value="freie_suche"/>
                    <jsp:param name="Textfeld" value="Tab3"/>
                  </jsp:include>
            </a></li>
        </ul>
        <div class="clear"></div>

    <FORM method="POST" action="suchergebnis.jsp">
      <input type="hidden" name="form" value="freie_suche">

<!-- ##### SUCHFELDER ##### -->
        <div id="tab-1">
          <span class="truncate-hint">
          	<jsp:include page="../inc.erzeugeBeschriftung.jsp">
            	<jsp:param name="Formular" value="freie_suche"/>
                <jsp:param name="Textfeld" value="TruncateHint"/>
			</jsp:include>
          </span>
          <span class="move"> Schritt 1 von 3 </span>
          <div class="clear"> </div>
            <table>
              <tbody>
                <tr>
                  <th>
                    <jsp:include page="../inc.erzeugeBeschriftung.jsp">
                      <jsp:param name="Formular" value="freie_suche"/>
                      <jsp:param name="Datenfeld" value="NeGID"/>
                    </jsp:include>
                  </th>
                  <td>
                    <jsp:include page="../inc.erzeugeFormular.jsp">
                      <jsp:param name="Formular" value="freie_suche"/>
                      <jsp:param name="Datenfeld" value="NeGID"/>
                      <jsp:param name="size" value="75"/>
                    </jsp:include>
                  </td>
                </tr>
                <tr><td colspan="2">&nbsp;</td></tr>
                <tr>
                  <th>
                    <jsp:include page="../inc.erzeugeBeschriftung.jsp">
                      <jsp:param name="Formular" value="freie_suche"/>
                      <jsp:param name="Datenfeld" value="Belegform"/>
                    </jsp:include>
                  </th>
                  <td>
                    <jsp:include page="../inc.erzeugeFormular.jsp">
                      <jsp:param name="Formular" value="freie_suche"/>
                      <jsp:param name="Datenfeld" value="Belegform"/>
                    </jsp:include>
                  </td>
                </tr>
                <tr>
                  <th>
                    <jsp:include page="../inc.erzeugeBeschriftung.jsp">
                      <jsp:param name="Formular" value="freie_suche"/>
                      <jsp:param name="Datenfeld" value="Kontext"/>
                    </jsp:include>
                  </th>
                  <td>
                    <jsp:include page="../inc.erzeugeFormular.jsp">
                      <jsp:param name="Formular" value="freie_suche"/>
                      <jsp:param name="Datenfeld" value="Kontext"/>
                    </jsp:include>
                  </td>
                </tr>
                <tr>
                  <th>
                    <jsp:include page="../inc.erzeugeBeschriftung.jsp">
                      <jsp:param name="Formular" value="freie_suche"/>
                      <jsp:param name="Datenfeld" value="Namenlemma"/>
                    </jsp:include>
                  </th>
                  <td>
                    <jsp:include page="../inc.erzeugeFormular.jsp">
                      <jsp:param name="Formular" value="gast_freie_suche"/>
                      <jsp:param name="Datenfeld" value="Namenkommentar"/>
                    </jsp:include>/<jsp:include page="../inc.erzeugeFormular.jsp">
                      <jsp:param name="Formular" value="gast_freie_suche"/>
                      <jsp:param name="Datenfeld" value="Namenkommentar2"/>
                      <jsp:param name="Sorted" value="yes"/>
                    </jsp:include>                  </td>
                </tr>
               <tr>
                  <th>
                    <jsp:include page="../inc.erzeugeBeschriftung.jsp">
                      <jsp:param name="Formular" value="freie_suche"/>
                      <jsp:param name="Datenfeld" value="MGHLemma"/>
                    </jsp:include>
                  </th>
                  <td>
                    <jsp:include page="../inc.erzeugeFormular.jsp">
                      <jsp:param name="Formular" value="freie_suche"/>
                      <jsp:param name="Datenfeld" value="MGHLemma"/>
                    </jsp:include>
                  </td>
                </tr>
                 <tr><td colspan="2">&nbsp;</td></tr>
                <tr>
                  <th>
                    <jsp:include page="../inc.erzeugeBeschriftung.jsp">
                      <jsp:param name="Formular" value="freie_suche"/>
                      <jsp:param name="Datenfeld" value="Personenname"/>
                    </jsp:include>
                  </th>
                  <td>
                    <jsp:include page="../inc.erzeugeFormular.jsp">
                      <jsp:param name="Formular" value="freie_suche"/>
                      <jsp:param name="Datenfeld" value="Personenname"/>
                    </jsp:include>
                  </td>
                </tr>
                <tr>
                  <th>
                    <jsp:include page="../inc.erzeugeBeschriftung.jsp">
                      <jsp:param name="Formular" value="freie_suche"/>
                      <jsp:param name="Datenfeld" value="Geschlecht"/>
                    </jsp:include>
                  </th>
                  <td>
                    <jsp:include page="../inc.erzeugeFormular.jsp">
                      <jsp:param name="Formular" value="freie_suche"/>
                      <jsp:param name="Datenfeld" value="Geschlecht"/>
                    </jsp:include>
                  </td>
                </tr>
                <tr>
                  <th>
                    <jsp:include page="../inc.erzeugeBeschriftung.jsp">
                      <jsp:param name="Formular" value="freie_suche"/>
                      <jsp:param name="Datenfeld" value="PersonZeitraum"/>
                    </jsp:include>
                  </th>
                  <td>
                    <jsp:include page="../inc.erzeugeFormular.jsp">
                      <jsp:param name="Formular" value="freie_suche"/>
                      <jsp:param name="Datenfeld" value="PersonZeitraum"/>
                    </jsp:include>
                  </td>
                </tr>
                <tr><td colspan="2">&nbsp;</td></tr>
                <tr>
                  <th>
                    <jsp:include page="../inc.erzeugeBeschriftung.jsp">
                      <jsp:param name="Formular" value="freie_suche"/>
                      <jsp:param name="Datenfeld" value="AmtWeihePerson"/>
                    </jsp:include>
                  </th>
                  <td>
                    <jsp:include page="../inc.erzeugeFormular.jsp">
                      <jsp:param name="Formular" value="gast_freie_suche"/>
                      <jsp:param name="Datenfeld" value="AmtWeihePerson"/>
                    </jsp:include>
                  </td>
                </tr>
                <tr>
                  <th>
                    <jsp:include page="../inc.erzeugeBeschriftung.jsp">
                      <jsp:param name="Formular" value="freie_suche"/>
                      <jsp:param name="Datenfeld" value="StandPerson"/>
                    </jsp:include>
                  </th>
                  <td>
                    <jsp:include page="../inc.erzeugeFormular.jsp">
                      <jsp:param name="Formular" value="gast_freie_suche"/>
                      <jsp:param name="Datenfeld" value="StandPerson"/>
                    </jsp:include>
                  </td>
                </tr>
                <tr>
                  <th>
                    <jsp:include page="../inc.erzeugeBeschriftung.jsp">
                      <jsp:param name="Formular" value="freie_suche"/>
                      <jsp:param name="Datenfeld" value="EthniePerson"/>
                    </jsp:include>
                  </th>
                  <td>
                    <jsp:include page="../inc.erzeugeFormular.jsp">
                      <jsp:param name="Formular" value="gast_freie_suche"/>
                      <jsp:param name="Datenfeld" value="EthniePerson"/>
                    </jsp:include>
                  </td>
                </tr>
                <tr>
                  <th>
                    <jsp:include page="../inc.erzeugeBeschriftung.jsp">
                      <jsp:param name="Formular" value="freie_suche"/>
                      <jsp:param name="Datenfeld" value="AmtWeiheEinzelbeleg"/>
                    </jsp:include>
                  </th>
                  <td>
                    <jsp:include page="../inc.erzeugeFormular.jsp">
                      <jsp:param name="Formular" value="gast_freie_suche"/>
                      <jsp:param name="Datenfeld" value="AmtWeiheEinzelbeleg"/>
                    </jsp:include>
                  </td>
                </tr>
                <tr>
                  <th>
                    <jsp:include page="../inc.erzeugeBeschriftung.jsp">
                      <jsp:param name="Formular" value="freie_suche"/>
                      <jsp:param name="Datenfeld" value="EthnieEinzelbeleg"/>
                    </jsp:include>
                  </th>
                  <td>
                    <jsp:include page="../inc.erzeugeFormular.jsp">
                      <jsp:param name="Formular" value="gast_freie_suche"/>
                      <jsp:param name="Datenfeld" value="EthnieEinzelbeleg"/>
                    </jsp:include>
                  </td>
                </tr>
                <tr><td colspan="2">&nbsp;</td></tr>
                <tr>
                  <th>
                    <jsp:include page="../inc.erzeugeBeschriftung.jsp">
                      <jsp:param name="Formular" value="freie_suche"/>
                      <jsp:param name="Datenfeld" value="Quelle"/>
                    </jsp:include>
                  </th>
                  <td>
                    <jsp:include page="../inc.erzeugeFormular.jsp">
                      <jsp:param name="Formular" value="gast_freie_suche"/>
                      <jsp:param name="Datenfeld" value="Quellenliste"/>
                    </jsp:include>
                    <jsp:include page="../inc.erzeugeFormular.jsp">
                      <jsp:param name="Formular" value="freie_suche"/>
                      <jsp:param name="Datenfeld" value="Quelle"/>
                    </jsp:include>                  </td>
                </tr>
                <tr>
                  <th>
                    <jsp:include page="../inc.erzeugeBeschriftung.jsp">
                      <jsp:param name="Formular" value="freie_suche"/>
                      <jsp:param name="Datenfeld" value="QuelleZeitraum"/>
                    </jsp:include>
                  </th>
                  <td>
                    <jsp:include page="../inc.erzeugeFormular.jsp">
                      <jsp:param name="Formular" value="freie_suche"/>
                      <jsp:param name="Datenfeld" value="QuelleZeitraum"/>
                    </jsp:include>
                  </td>
                </tr>
              </tbody>
            </table>
            <a href="#erweiterte-suche" class="search-next search-button erweiterte_suche_next" data-id="tab-2"> Weiter zu Schritt 2 </a>
            <div class="clear"> </div>
        </div>


<!-- ##### AUSGABEFELDER ##### -->
        <div id="tab-2" class="hide">
            <span class="move"> Schritt 2 von 3 </span>
            <div class="clear"> </div>
            <table>
              <tbody>
                <tr><td colspan="2"><h3>
                    <jsp:include page="../inc.erzeugeBeschriftung.jsp">
                      <jsp:param name="Formular" value="gast_freie_suche"/>
                      <jsp:param name="Textfeld" value="ZumNamen"/>
                    </jsp:include></h3></td></tr>
                <tr>
                  <td>
                    <jsp:include page="../inc.erzeugeFormular.jsp">
                      <jsp:param name="Formular" value="freie_suche"/>
                      <jsp:param name="Datenfeld" value="Ausgabe_Namenlemma"/>
                    </jsp:include>
                  </td>
                  <td>
                    <jsp:include page="../inc.erzeugeBeschriftung.jsp">
                      <jsp:param name="Formular" value="freie_suche"/>
                      <jsp:param name="Datenfeld" value="Ausgabe_Namenlemma"/>
                    </jsp:include>
                  </td>
                </tr>
                                <tr>
                  <td>
                    <jsp:include page="../inc.erzeugeFormular.jsp">
                      <jsp:param name="Formular" value="freie_suche"/>
                      <jsp:param name="Datenfeld" value="Ausgabe_MGHLemma"/>
                    </jsp:include>
                  </td>
                  <td>
                    <jsp:include page="../inc.erzeugeBeschriftung.jsp">
                      <jsp:param name="Formular" value="freie_suche"/>
                      <jsp:param name="Datenfeld" value="Ausgabe_MGHLemma"/>
                    </jsp:include>
                  </td>
                </tr>                <tr><td colspan="2">&nbsp;</td></tr>
                <tr><td colspan="2"><h3>
				    <jsp:include page="../inc.erzeugeBeschriftung.jsp">
                      <jsp:param name="Formular" value="gast_freie_suche"/>
                      <jsp:param name="Textfeld" value="ZurPerson"/>
                    </jsp:include></h3></td></tr>
                <tr>
                  <td>
                    <jsp:include page="../inc.erzeugeFormular.jsp">
                      <jsp:param name="Formular" value="freie_suche"/>
                      <jsp:param name="Datenfeld" value="Ausgabe_Person_Standardname"/>
                    </jsp:include>
                  </td>
                  <td>
                    <jsp:include page="../inc.erzeugeBeschriftung.jsp">
                      <jsp:param name="Formular" value="freie_suche"/>
                      <jsp:param name="Datenfeld" value="Ausgabe_Person_Standardname"/>
                    </jsp:include>
                  </td>
                </tr>
                <tr>
                  <td>
                    <jsp:include page="../inc.erzeugeFormular.jsp">
                      <jsp:param name="Formular" value="freie_suche"/>
                      <jsp:param name="Datenfeld" value="Ausgabe_Person_AmtWeihe"/>
                    </jsp:include>
                  </td>
                  <td>
                    <jsp:include page="../inc.erzeugeBeschriftung.jsp">
                      <jsp:param name="Formular" value="freie_suche"/>
                      <jsp:param name="Datenfeld" value="Ausgabe_Person_AmtWeihe"/>
                    </jsp:include>
                    <font color="blue"></font>
                  </td>
                </tr>
                <tr>
                  <td>
                  </td>
                  <td>
                    <jsp:include page="../inc.erzeugeFormular.jsp">
                      <jsp:param name="Formular" value="freie_suche"/>
                      <jsp:param name="Datenfeld" value="Ausgabe_Person_AmtWeiheZeitraum"/>
                    </jsp:include>
                    <jsp:include page="../inc.erzeugeBeschriftung.jsp">
                      <jsp:param name="Formular" value="freie_suche"/>
                      <jsp:param name="Datenfeld" value="Ausgabe_Person_AmtWeiheZeitraum"/>
                    </jsp:include>
                  </td>
                </tr>
                <tr>
                  <td>
                    <jsp:include page="../inc.erzeugeFormular.jsp">
                      <jsp:param name="Formular" value="freie_suche"/>
                      <jsp:param name="Datenfeld" value="Ausgabe_Person_Ethnie"/>
                    </jsp:include>
                  </td>
                  <td>
                    <jsp:include page="../inc.erzeugeBeschriftung.jsp">
                      <jsp:param name="Formular" value="freie_suche"/>
                      <jsp:param name="Datenfeld" value="Ausgabe_Person_Ethnie"/>
                    </jsp:include>
                    <font color="blue"></font>
                  </td>
                </tr>
                <tr>
                  <td>
                    <jsp:include page="../inc.erzeugeFormular.jsp">
                      <jsp:param name="Formular" value="freie_suche"/>
                      <jsp:param name="Datenfeld" value="Ausgabe_Geschlecht"/>
                    </jsp:include>
                  </td>
                  <td>
                    <jsp:include page="../inc.erzeugeBeschriftung.jsp">
                      <jsp:param name="Formular" value="freie_suche"/>
                      <jsp:param name="Datenfeld" value="Ausgabe_Geschlecht"/>
                    </jsp:include>
                    <font color="blue"></font>
                  </td>
                </tr>

                <tr><td colspan="2">&nbsp;</td></tr>
                <tr><td colspan="2"><h3>
                    <jsp:include page="../inc.erzeugeBeschriftung.jsp">
                      <jsp:param name="Formular" value="gast_freie_suche"/>
                      <jsp:param name="Textfeld" value="ZumEinzelbeleg"/>
                    </jsp:include></h3></td></tr>
                <tr>
                  <td>
                    <jsp:include page="../inc.erzeugeFormular.jsp">
                      <jsp:param name="Formular" value="freie_suche"/>
                      <jsp:param name="Datenfeld" value="Ausgabe_Einzelbeleg_Belegform"/>
                    </jsp:include>
                  </td>
                  <td>
                    <jsp:include page="../inc.erzeugeBeschriftung.jsp">
                      <jsp:param name="Formular" value="freie_suche"/>
                      <jsp:param name="Datenfeld" value="Ausgabe_Einzelbeleg_Belegform"/>
                    </jsp:include>
                  </td>
                </tr>
                <tr>
                  <td>
                    <jsp:include page="../inc.erzeugeFormular.jsp">
                      <jsp:param name="Formular" value="freie_suche"/>
                      <jsp:param name="Datenfeld" value="Ausgabe_Einzelbeleg_Belegstelle"/>
                    </jsp:include>
                  </td>
                  <td>
                    <jsp:include page="../inc.erzeugeBeschriftung.jsp">
                      <jsp:param name="Formular" value="freie_suche"/>
                      <jsp:param name="Datenfeld" value="Ausgabe_Einzelbeleg_Belegstelle"/>
                    </jsp:include>
                  </td>
                </tr>
                <tr>
                  <td>
                    <jsp:include page="../inc.erzeugeFormular.jsp">
                      <jsp:param name="Formular" value="freie_suche"/>
                      <jsp:param name="Datenfeld" value="Ausgabe_Einzelbeleg_Kontext"/>
                    </jsp:include>
                  </td>
                  <td>
                    <jsp:include page="../inc.erzeugeBeschriftung.jsp">
                      <jsp:param name="Formular" value="freie_suche"/>
                      <jsp:param name="Datenfeld" value="Ausgabe_Einzelbeleg_Kontext"/>
                    </jsp:include>
                  </td>
                </tr>
                <tr>
                  <td>
                    <jsp:include page="../inc.erzeugeFormular.jsp">
                      <jsp:param name="Formular" value="freie_suche"/>
                      <jsp:param name="Datenfeld" value="Ausgabe_Einzelbeleg_Datierung"/>
                    </jsp:include>
                  </td>
                  <td>
                    <jsp:include page="../inc.erzeugeBeschriftung.jsp">
                      <jsp:param name="Formular" value="freie_suche"/>
                      <jsp:param name="Datenfeld" value="Ausgabe_Einzelbeleg_Datierung"/>
                    </jsp:include>
                  </td>
                </tr>
                <tr>
                  <td>
                    <jsp:include page="../inc.erzeugeFormular.jsp">
                      <jsp:param name="Formular" value="freie_suche"/>
                      <jsp:param name="Datenfeld" value="Ausgabe_Einzelbeleg_lebend"/>
                    </jsp:include>
                  </td>
                  <td>
                    <jsp:include page="../inc.erzeugeBeschriftung.jsp">
                      <jsp:param name="Formular" value="freie_suche"/>
                      <jsp:param name="Datenfeld" value="Ausgabe_Einzelbeleg_lebend"/>
                    </jsp:include>
                  </td>
                </tr>
                <tr>
                  <td>
                    <jsp:include page="../inc.erzeugeFormular.jsp">
                      <jsp:param name="Formular" value="freie_suche"/>
                      <jsp:param name="Datenfeld" value="Ausgabe_Einzelbeleg_Varianten"/>
                    </jsp:include>
                  </td>
                  <td>
                    <jsp:include page="../inc.erzeugeBeschriftung.jsp">
                      <jsp:param name="Formular" value="freie_suche"/>
                      <jsp:param name="Datenfeld" value="Ausgabe_Einzelbeleg_Varianten"/>
                    </jsp:include>
                    <font color="blue"></font>
                  </td>
                </tr>
              </tbody>
            </table>
             <p align="right">
              <a href="javascript:CheckAll(1, true, 'Ausgabe_')">

			  </a><br/><a href="javascript:CheckAll(1, false, 'Ausgabe_')">

			  </a><br/>
              <a href="javascript:onoff('tab3','tab2');">

              </a>
            </p>
                <a href="javascript:CheckAll(1, true, 'Ausgabe_')" class="search-next search-functions">
                  <jsp:include page="../inc.erzeugeBeschriftung.jsp">
                    <jsp:param name="Formular" value="gast_freie_suche"/>
                    <jsp:param name="Textfeld" value="AlleAuswahlen"/>
                  </jsp:include>
                </a>
                <div class="clear"></div>
                <a href="javascript:CheckAll(1, false, 'Ausgabe_')" class="search-next search-functions">
                  <jsp:include page="../inc.erzeugeBeschriftung.jsp">
                    <jsp:param name="Formular" value="gast_freie_suche"/>
                    <jsp:param name="Textfeld" value="AuswahlAufheben"/>
                  </jsp:include>
                </a>
                <div class="clear"></div>
                <a href="#erweiterte-suche" class="search-next search-button left erweiterte_suche_prev" data-id="tab-1"> Zur&uuml;ck zu Schritt 1 </a>
                <a href="#erweiterte-suche" class="search-next search-button erweiterte_suche_next" data-id="tab-3"> Weiter zu Schritt 3 </a>
                <div class="clear"> </div>
        </div>

<!-- ##### SORTIERUNG ##### -->
        <div id="tab-3" class="hide gruppierung">
            <span class="move"> Schritt 3 von 3 </span>
            <div class="clear"> </div>
            <h3>
              <jsp:include page="../inc.erzeugeBeschriftung.jsp">
                <jsp:param name="Formular" value="freie_suche"/>
                <jsp:param name="Textfeld" value="Ueberschrift3"/>
              </jsp:include>
            </h3>
            <table>
              <tbody>
                <tr>
                  <th>
                    <jsp:include page="../inc.erzeugeBeschriftung.jsp">
                      <jsp:param name="Formular" value="freie_suche"/>
                      <jsp:param name="Textfeld" value="Sortierung1"/>
                    </jsp:include>
                  </th>
                  <td>
                    <jsp:include page="../forms/search.order.jsp">
                      <jsp:param name="name" value="order1"/>
                    </jsp:include>
                  </td>
                </tr>
                <tr>
                  <th>
                    <jsp:include page="../inc.erzeugeBeschriftung.jsp">
                      <jsp:param name="Formular" value="freie_suche"/>
                      <jsp:param name="Textfeld" value="Sortierung2"/>
                    </jsp:include>
                  </th>
                  <td>
                    <jsp:include page="../forms/search.order.jsp">
                      <jsp:param name="name" value="order2"/>
                    </jsp:include>
                  </td>
                </tr>
                <tr>
                  <th>
                    <jsp:include page="../inc.erzeugeBeschriftung.jsp">
                      <jsp:param name="Formular" value="freie_suche"/>
                      <jsp:param name="Textfeld" value="Sortierung3"/>
                    </jsp:include>
                  </th>
                  <td>
                    <jsp:include page="../forms/search.order.jsp">
                      <jsp:param name="name" value="order3"/>
                    </jsp:include>
                  </td>
                </tr>
              </tbody>
            </table>
            <a href="#" id="add" class="search-next search-functions"> Weitere Gruppierung hinzuf&uuml;gen </a>
            <div class="clear"></div>
            <p> &nbsp; </p>
                <a href="#erweiterte-suche" class="search-next search-button left erweiterte_suche_prev" data-id="tab-2"> Zur&uuml;ck zu Schritt 2 </a>
            <input class="search-next" type="submit" value="Suchen">
            <input class="search-next marginRight" type="reset" value="Zur&uuml;cksetzen">
            <div class="clear"> </div>
<!--
           <p align="right">
               <a href="#" id="add">Weitere Gruppierung hinzufÃ¼gen</a>
              <input type="reset">
              <input type="submit">

            </p>
-->
        </div>

<!-- ##### AUSGABEFORMAT ##### -->
        <!--div id="tab4">
          <div id="header">
            <ul id="primary">
              <li>
                <a href="javascript:onoff('tab1','tab4');">
                  <jsp:include page="../inc.erzeugeBeschriftung.jsp">
                    <jsp:param name="Formular" value="freie_suche"/>
                    <jsp:param name="Textfeld" value="Tab1"/>
                  </jsp:include>
                </a>
              </li>
              <li>
                <a href="javascript:onoff('tab2','tab4');">
                  <jsp:include page="../inc.erzeugeBeschriftung.jsp">
                    <jsp:param name="Formular" value="freie_suche"/>
                    <jsp:param name="Textfeld" value="Tab2"/>
                  </jsp:include>
                </a>
              </li>
              <li>
                <a href="javascript:onoff('tab3','tab4');">
                  <jsp:include page="../inc.erzeugeBeschriftung.jsp">
                    <jsp:param name="Formular" value="freie_suche"/>
                    <jsp:param name="Textfeld" value="Tab3"/>
                  </jsp:include>
                </a>
              </li>
              <li>
                <span>
                  <jsp:include page="../inc.erzeugeBeschriftung.jsp">
                    <jsp:param name="Formular" value="freie_suche"/>
                    <jsp:param name="Textfeld" value="Tab4"/>
                  </jsp:include>
                </span>
              </li>
            </ul>
          </div>
          <div id="main">
            <table>
              <tbody>
                <tr>
                  <td>
                    <input type="radio" name="export" value="liste" />
                  </td>
                  <td>
                    <jsp:include page="../inc.erzeugeBeschriftung.jsp">
                      <jsp:param name="Formular" value="freie_suche"/>
                      <jsp:param name="Textfeld" value="ExportListe"/>
                    </jsp:include>
                  </td>
                </tr>
                <tr>
                  <td>
                    <input type="radio" name="export" value="browse" />
                  </td>
                  <td>
                    <jsp:include page="../inc.erzeugeBeschriftung.jsp">
                      <jsp:param name="Formular" value="freie_suche"/>
                      <jsp:param name="Textfeld" value="ExportBrowse"/>
                    </jsp:include>
                  </td>
                </tr>
              </tbody>
            </table>
            <p align="right">
              <input type="reset">
              <input type="submit">
            </p>
          </div>
        </div-->
      </div>
</div>
<jsp:include page="layout/footer.inc.jsp" />
    </FORM>
  </div>
          <script type="text/javascript">
      enableTooltips();
    </script>

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
