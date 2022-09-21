<%@ page import="java.sql.Connection" isThreadSafe="false"%>
<%@ page import="java.sql.DriverManager" isThreadSafe="false"%>
<%@ page import="java.sql.ResultSet" isThreadSafe="false"%>
<%@ page import="java.sql.SQLException" isThreadSafe="false"%>
<%@ page import="java.sql.Statement" isThreadSafe="false"%>
<%@ page import="java.util.Vector" isThreadSafe="false"%>
<%@ page import="java.util.Enumeration" isThreadSafe="false"%>
<%@ page import="de.uni_tuebingen.ub.nppm.util.Language" isThreadSafe="false" %>
<%@ include file="../configuration.jsp"%>
<%@ include file="../functions.jsp"%>

<%@ page import="com.lowagie.text.Document" isThreadSafe="false"%>
<%@ page import="com.lowagie.text.*" isThreadSafe="false"%>
<%@ page import="com.lowagie.text.rtf.*" isThreadSafe="false"%>
<%@ page import="java.io.*" isThreadSafe="false"%>

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

  }	if (session.getAttribute("BenutzerID") != null
			&& ((Integer) session.getAttribute("BenutzerID"))
					.intValue() > 0) {

		                          session.setAttribute("filter", 0);
        session.setAttribute("filterParameter", "");
		int id = -2;
		int filter = 0;
		String formular = "mgh_lemma";

		try {
			id = Integer.parseInt(request.getParameter("ID"));
		} catch (Exception e) {
		}
		try {
			filter = ((Integer) session.getAttribute("filter"))
					.intValue();
		} catch (Exception e) {
		}
        {
			Connection cn = null;
			Statement st = null;
			ResultSet rs = null;
			String sql = "";
			try {
				Class.forName(sqlDriver);
				cn = DriverManager.getConnection(sqlURL, sqlUser,
						sqlPassword);
				st = cn.createStatement();

				rs = st
						.executeQuery("SELECT * FROM datenbank_filter WHERE Formular='gast_"
								+ formular
								+ "' AND Nummer='"
								+ filter
								+ "';");
				if (rs.next()) {
					sql = rs.getString("SQLString");
				}
				sql = sql.replace("*", "min(" + formular + ".ID) m");

				String filterParameter = (String) session
						.getAttribute("filterParameter");
				if (filterParameter != null)
					sql = sql.replace("###", filterParameter);
				sql = sql.replace("#userid#",
						""
								+ ((Integer) session
										.getAttribute("BenutzerID"))
										.intValue());
				sql = sql.replace("#groupid#", ""
						+ ((Integer) session.getAttribute("GruppeID"))
								.intValue());
        if(id>-1)rs = st.executeQuery(sql+(sql.contains("WHERE")?" AND ":" WHERE ")+formular+".ID = "+id);
        else rs = st.executeQuery(sql);
        if (rs.next() && id>-1 && rs.getString("m")==null){
           out.println("ID nicht vorhanden. <a href=\"javascript:history.back();\">Zur&uuml;ck zur vorherigen Seite</a>");
           return;
        }
        else id = rs.getInt("m");
			} catch (Exception e) {
           out.println("ID nicht vorhanden. <a href=\"javascript:history.back();\">Zur&uuml;ck zur vorherigen Seite</a>");
           return;
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
		}
		String tableString = "einzelbeleg LEFT OUTER JOIN einzelbeleg_hatperson ON einzelbeleg.ID=einzelbeleg_hatperson.EinzelbelegID LEFT OUTER JOIN person ON einzelbeleg_hatperson.PersonID=person.ID LEFT OUTER JOIN einzelbeleg_hatmghlemma ON einzelbeleg_hatmghlemma.EinzelbelegID=einzelbeleg.ID LEFT OUTER JOIN mgh_lemma ON mgh_lemma.ID=einzelbeleg_hatmghlemma.MGHLemmaID INNER JOIN quelle ON einzelbeleg.QuelleID=quelle.ID LEFT OUTER JOIN person_hatamtstandweihe ON person.ID=person_hatamtstandweihe.PersonID LEFT OUTER JOIN selektion_amtweihe ON person_hatamtstandweihe.AmtWeiheID=selektion_amtweihe.ID LEFT OUTER JOIN person_hatethnie ON person.ID=person_hatethnie.PersonID LEFT OUTER JOIN selektion_ethnie ON person_hatethnie.EthnieID=selektion_ethnie.ID LEFT OUTER JOIN edition ON einzelbeleg.EditionID=edition.ID LEFT OUTER JOIN selektion_lebendverstorben ON einzelbeleg.LebendVerstorbenID=selektion_lebendverstorben.ID LEFT OUTER JOIN einzelbeleg_textkritik ON einzelbeleg.ID=einzelbeleg_textkritik.EinzelbelegID";
		String order = "";
		String export = "browse";

		Vector<String> conditions = new Vector<String>();
		conditions.add("quelle.zuVeroeffentlichen=1");
		conditions.add("mgh_lemma.ID=" + id);

		Vector<String> fields = new Vector<String>();
		fields.add("person.Standardname");
		fields.add("person.ID");
		fields.add("selektion_amtweihe.Bezeichnung");
		fields.add("person_hatamtstandweihe.Zeitraum");
		fields.add("selektion_ethnie.Bezeichnung");
		fields.add("quelle.Bezeichnung");
		fields.add("quelle.ID");
		fields.add("edition.Titel");
		fields.add("einzelbeleg.EditionKapitel");
		fields.add("einzelbeleg.EditionSeite");
		fields.add("einzelbeleg.Belegform");
		fields.add("einzelbeleg.ID");
		fields.add("einzelbeleg.Kontext");
		fields.add("einzelbeleg.VonTag");
		fields.add("einzelbeleg.VonMonat");
		fields.add("einzelbeleg.VonJahr");
		fields.add("einzelbeleg.VonJahrhundert");
		fields.add("einzelbeleg.BisTag");
		fields.add("einzelbeleg.BisMonat");
		fields.add("einzelbeleg.BisJahr");
		fields.add("einzelbeleg.BisJahrhundert");
		fields.add("selektion_lebendverstorben.Bezeichnung");
		fields.add("einzelbeleg_textkritik.Variante");
		Vector<String> fieldNames = new Vector<String>();
		fieldNames.add("person.Standardname");
		fieldNames.add("selektion_amtweihe.Bezeichnung");
		fieldNames.add("person_hatamtstandweihe.Zeitraum");
		fieldNames.add("selektion_ethnie.Bezeichnung");
		fieldNames.add("quelle.Bezeichnung");
		fieldNames.add("edition.Titel");
		fieldNames.add("einzelbeleg.EditionKapitel");
		fieldNames.add("einzelbeleg.EditionSeite");
		fieldNames.add("einzelbeleg.Belegform");
		fieldNames.add("einzelbeleg.Kontext");
		fieldNames.add("einzelbeleg.VonTag");
		fieldNames.add("einzelbeleg.VonMonat");
		fieldNames.add("einzelbeleg.VonJahr");
		fieldNames.add("einzelbeleg.VonJahrhundert");
		fieldNames.add("einzelbeleg.BisTag");
		fieldNames.add("einzelbeleg.BisMonat");
		fieldNames.add("einzelbeleg.BisJahr");
		fieldNames.add("einzelbeleg.BisJahrhundert");
		fieldNames.add("selektion_lebendverstorben.Bezeichnung");
		fieldNames.add("einzelbeleg_textkritik.Variante");

		Vector<String> tables = new Vector<String>();
		tables.add("mghlemma");
		tables.add("person");

		    String sprache = "de";
  if (session != null && session.getAttribute("Sprache") != null)
    sprache = (String)session.getAttribute("Sprache");
   Connection con = null;
  Statement  stmt = null;
   try {
    Class.forName( sqlDriver );
    con = DriverManager.getConnection( sqlURL, sqlUser, sqlPassword );
    stmt = con.createStatement();
    }
  catch (Exception e) {
    out.println(e);
  }

		Vector<String> joins = new Vector<String>();
		Vector<String> headlines = new Vector<String>();
    	headlines.add(getLabel("freie_suche", "Ausgabe_Person_Standardname", null, stmt, sprache));
	    headlines.add(getLabel("freie_suche", "Ausgabe_Person_AmtWeihe", null, stmt, sprache));
        headlines.add(getLabel("freie_suche", "Ausgabe_Person_AmtWeiheZeitraum", null, stmt, sprache));
        headlines.add(getLabel("freie_suche", "Ausgabe_Person_Ethnie", null, stmt, sprache));
        headlines.add(getLabel("freie_suche", "Quelle", null, stmt, sprache));
        headlines.add(getLabel("quelle", "Edition", null, stmt, sprache));
        headlines.add(getLabel("einzelbeleg", "EditionKapitel", null, stmt, sprache));
        headlines.add(getLabel("einzelbeleg", "EditionSeite", null, stmt, sprache));
        headlines.add(getLabel("freie_suche", "Ausgabe_Einzelbeleg_Belegform", null, stmt, sprache));
        headlines.add(getLabel("freie_suche", "Ausgabe_Einzelbeleg_Kontext", null, stmt, sprache));

	/*	headlines.add("Standardname");
		headlines.add("Amt / Weihe");
		headlines.add("Zeitraum Amt/Weihe");
		headlines.add("Ethnie(n)");
		headlines.add("Quelle");
		headlines.add("Edition");
		headlines.add("Kapitel");
		headlines.add("Seite");
		headlines.add("Belegform");
		headlines.add("Kontext");
*/		headlines.add("von T.");
		headlines.add("von M.");
		headlines.add("von J.");
		headlines.add("von Jh.");
		headlines.add("bis T.");
		headlines.add("bis M.");
		headlines.add("bis J.");
		headlines.add("bis Jh.");
	/*	headlines.add("lebend / verstorben");
		headlines.add("Variante");*/
        headlines.add(getLabel("freie_suche", "Ausgabe_Einzelbeleg_Lebend", null, stmt, sprache));
        headlines.add(getLabel("freie_suche", "Ausgabe_Einzelbeleg_Varianten", null, stmt, sprache));



%>

<jsp:include page="../dojump.jsp">
	<jsp:param name="form" value="gast_mgh_lemma" />
</jsp:include>


<HTML>
<HEAD>
<TITLE>Nomen et Gens | <jsp:include
	page="../inc.erzeugeBeschriftung.jsp">
	<jsp:param name="Formular" value="namenkommentar" />
	<jsp:param name="Textfeld" value="Titel" />
</jsp:include></TITLE>
<link rel="icon" href="layout/images/nomen_et_gens_icon.gif" type="image/gif">
<link rel="stylesheet" href="layout/layout.css" type="text/css">
<link href='layout/fonts/open-sans.css' rel='stylesheet' type='text/css'>
<link href='layout/fonts/alegreya-sans-sc.css' rel='stylesheet' type='text/css'>
<script src="../javascript/funktionen.js" type="text/javascript"></script>
<script src="../javascript/jquery-1.11.1.min.js" type="text/javascript"></script>
<script src="../javascript/javascript.js" type="text/javascript"></script>
<noscript></noscript>
</HEAD>

<BODY onLoad="urlRewrite(<%=id%>);">
<jsp:include page="layout/header.inc.jsp">
    <jsp:param name="current" value="mgh_lemma" />
</jsp:include>
<!--<jsp:include page="layout/image.inc.html" />-->
<jsp:include page="layout/titel.inc.jsp">
	<jsp:param name="title" value="mgh_lemma" />
	<jsp:param name="ID" value="<%= id %>" />
	<jsp:param name="size" value="" />
	<jsp:param name="Formular" value="mgh_lemma" />
</jsp:include>


<div id="content">

<!----------ID---------->
  <div id="id">
    <jsp:include page="../forms/id.jsp">
      <jsp:param name="ID" value="<%=id%>"/>
      <jsp:param name="title" value="gast_mghlemma"/>
    </jsp:include>
  </div>

<!---------- ---------->
<table class="content-table">
	<tbody>
		<tr>
			<th>
              <jsp:include page="../inc.erzeugeBeschriftung.jsp">
				<jsp:param name="Formular" value="mgh_lemma" />
				<jsp:param name="Datenfeld" value="MGHLemma" />
			  </jsp:include>
            </th>
			<td>
			<jsp:include page="../inc.erzeugeFormular.jsp">
				<jsp:param name="ID" value="<%= id %>" />
				<jsp:param name="Formular" value="mgh_lemma" />
				<jsp:param name="Datenfeld" value="MGHLemma" />
				<jsp:param name="Klarlemma" value="yes"/>
				<jsp:param name="size" value="25" />
			    <jsp:param name="Readonly" value="yes" />
			  </jsp:include>
            </td>
		</tr>
		<tr>
			<th>
              <jsp:include page="../inc.erzeugeBeschriftung.jsp">
				<jsp:param name="Formular" value="mgh_lemma" />
				<jsp:param name="Datenfeld" value="EinzelbelegRO" />
			  </jsp:include>
            </th>
			<td>
              <jsp:include page="../inc.erzeugeFormular.jsp">
				<jsp:param name="ID" value="<%= id %>" />
				<jsp:param name="Formular" value="mgh_lemma" />
				<jsp:param name="Datenfeld" value="EinzelbelegRO" />
				<jsp:param name="Readonly" value="yes" />
			  </jsp:include>
            </td>
		</tr>
		<!--  tr>
              <td width="200">
                <jsp:include page="../inc.erzeugeBeschriftung.jsp">
                  <jsp:param name="Formular" value="namenkommentar"/>
                  <jsp:param name="Textfeld" value="BemerkungRO"/>
                </jsp:include>
              </td>
              <td width="450">
                <jsp:include page="../inc.erzeugeFormular.jsp">
                  <jsp:param name="ID" value="<%=id%>"/>
                  <jsp:param name="Formular" value="namenkommentar"/>
                  <jsp:param name="Datenfeld" value="BemerkungAlle"/>
                  <jsp:param name="Readonly" value="yes"/>
                </jsp:include>
              </td>
            </tr-->
	</tbody>
</table>
<!----------Treffer insgesamt---------->
<div style="overflow:auto;">

<%@ include file="suche/ergebnisliste.jsp"%>

</div>

</div>
</div>
<jsp:include page="layout/footer.inc.jsp" />
</BODY>
</HTML>
<%
	} else {
%>
<p><jsp:include page="../inc.erzeugeBeschriftung.jsp">
	<jsp:param name="Formular" value="error" />
	<jsp:param name="Textfeld" value="Zugriff" />
</jsp:include></p>
<a href="index.jsp"> <jsp:include page="../inc.erzeugeBeschriftung.jsp">
	<jsp:param name="Formular" value="all" />
	<jsp:param name="Textfeld" value="Startseite" />
</jsp:include> </a>
<%
	}
%>
