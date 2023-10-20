<%@ page import="de.uni_tuebingen.ub.nppm.db.DatenbankDB" isThreadSafe="false" %>
<%@ page import="java.util.ArrayList" isThreadSafe="false"%>
<%@ page import="java.util.Enumeration" isThreadSafe="false"%>
<%@ page import="java.util.List" isThreadSafe="false"%>
<%@ page import="de.uni_tuebingen.ub.nppm.util.Language" isThreadSafe="false" %>
<%@ include file="../configuration.jsp"%>
<%@ include file="../functions.jsp"%>
<%@ page import="com.lowagie.text.Document" isThreadSafe="false"%>
<%@ page import="com.lowagie.text.*" isThreadSafe="false"%>
<%@ page import="com.lowagie.text.rtf.*" isThreadSafe="false"%>
<%@ page import="java.io.*" isThreadSafe="false"%>

<jsp:include page="../dofilter.jsp" />

<%
    int id = Integer.parseInt(request.getParameter("ID"));

    String formular = "namenkommentar";

    String tableString = "einzelbeleg LEFT OUTER JOIN einzelbeleg_hatperson ON einzelbeleg.ID=einzelbeleg_hatperson.EinzelbelegID LEFT OUTER JOIN person ON einzelbeleg_hatperson.PersonID=person.ID LEFT OUTER JOIN einzelbeleg_hatnamenkommentar ON einzelbeleg_hatnamenkommentar.EinzelbelegID=einzelbeleg.ID LEFT OUTER JOIN namenkommentar ON namenkommentar.ID=einzelbeleg_hatnamenkommentar.NamenkommentarID INNER JOIN quelle ON einzelbeleg.QuelleID=quelle.ID LEFT OUTER JOIN person_hatamtstandweihe ON person.ID=person_hatamtstandweihe.PersonID LEFT OUTER JOIN selektion_amtweihe ON person_hatamtstandweihe.AmtWeiheID=selektion_amtweihe.ID LEFT OUTER JOIN person_hatethnie ON person.ID=person_hatethnie.PersonID LEFT OUTER JOIN selektion_ethnie ON person_hatethnie.EthnieID=selektion_ethnie.ID LEFT OUTER JOIN edition ON einzelbeleg.EditionID=edition.ID LEFT OUTER JOIN selektion_lebendverstorben ON einzelbeleg.LebendVerstorbenID=selektion_lebendverstorben.ID LEFT OUTER JOIN einzelbeleg_textkritik ON einzelbeleg.ID=einzelbeleg_textkritik.EinzelbelegID";
    String order = "";
    String export = "browse";

    List<String> conditions = new ArrayList<>();
    conditions.add("quelle.zuVeroeffentlichen=1");
    conditions.add("namenkommentar.ID=" + id);

    List<String> fields = new ArrayList<>();
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

    List<String> fieldNames = new ArrayList<>();
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

    List<String> tables = new ArrayList<>();
    tables.add("namenkommentar");
    tables.add("person");
    String sprache = "de";

     //till now de is the only one witch gets transfered  --> sprache = (String)session.getAttribute("Sprache");
    if (session != null && session.getAttribute("Sprache") != null)
        sprache = (String)session.getAttribute("Sprache");

    List<String> joins = new ArrayList<>();
    List<String> headlines = new ArrayList<>();
    headlines.add(DatenbankDB.getMapping(sprache, "freie_suche", "Ausgabe_Person_Standardname"));
    headlines.add(DatenbankDB.getMapping(sprache, "freie_suche", "Ausgabe_Person_AmtWeihe"));
    headlines.add(DatenbankDB.getMapping(sprache, "freie_suche", "Ausgabe_Person_AmtWeiheZeitraum"));
    headlines.add(DatenbankDB.getMapping(sprache, "freie_suche", "Ausgabe_Person_Ethnie"));
    headlines.add(DatenbankDB.getMapping(sprache, "freie_suche", "Quelle"));
    headlines.add(DatenbankDB.getMapping(sprache, "quelle", "Edition"));
    headlines.add(DatenbankDB.getMapping(sprache, "einzelbeleg", "EditionKapitel"));
    headlines.add(DatenbankDB.getMapping(sprache, "einzelbeleg", "EditionSeite"));
    headlines.add(DatenbankDB.getMapping(sprache, "freie_suche", "Ausgabe_Einzelbeleg_Belegform"));
    headlines.add(DatenbankDB.getMapping(sprache, "freie_suche", "Ausgabe_Einzelbeleg_Kontext"));

    headlines.add("von T.");
    headlines.add("von M.");
    headlines.add("von J.");
    headlines.add("von Jh.");
    headlines.add("bis T.");
    headlines.add("bis M.");
    headlines.add("bis J.");
    headlines.add("bis Jh.");

    headlines.add(DatenbankDB.getMapping(sprache, "freie_suche", "Ausgabe_Einzelbeleg_Lebend"));
    headlines.add(DatenbankDB.getMapping(sprache, "freie_suche", "Ausgabe_Einzelbeleg_Varianten"));
%>

<jsp:include page="../dojump.jsp">
	<jsp:param name="form" value="gast_namenkommentar" />
</jsp:include>



<jsp:include page="layout/titel.inc.jsp">
	<jsp:param name="title" value="namenkommentar" />
	<jsp:param name="ID" value="<%= id %>" />
	<jsp:param name="size" value="" />
	<jsp:param name="Formular" value="namenkommentar" />
</jsp:include>




<!----------ID---------->
  <div id="id">
    <jsp:include page="../forms/id.jsp">
      <jsp:param name="ID" value="<%=id%>"/>
      <jsp:param name="title" value="gast_namenkommentar"/>
    </jsp:include>
  </div>

<!---------- ---------->
<table class="content-table">
	<tbody>
		<tr>
                    <th><% Language.printDatafield(out, session, "namenkommentar", "Plemma"); %> </th>
			<td>
              <jsp:include page="../inc.modul.jsp">
				<jsp:param name="ID" value="<%= id %>" />
				<jsp:param name="Formular" value="namenkommentar" />
				<jsp:param name="Modul" value="PLemma" />
				<jsp:param name="size" value="25" />
				<jsp:param name="Readonly" value="yes" />
			  </jsp:include>
            </td>
		</tr>
		<tr>
                    <th><% Language.printDatafield(out, session, "namenkommentar", "EinzelbelegRO"); %> </th>
			<td>
              <jsp:include page="../inc.erzeugeFormular.jsp">
				<jsp:param name="ID" value="<%= id %>" />
				<jsp:param name="Formular" value="namenkommentar" />
				<jsp:param name="Datenfeld" value="EinzelbelegRO" />
				<jsp:param name="Readonly" value="yes" />
			  </jsp:include>
            </td>
		</tr>
		<!--  tr>
              <td width="200"><% Language.printTextfield(out, session, "namenkommentar", "BemerkungRO"); %>
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
