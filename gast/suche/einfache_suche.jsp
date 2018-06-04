<%@ page import="java.sql.Connection" isThreadSafe="false" %>
<%@ page import="java.sql.DriverManager" isThreadSafe="false" %>
<%@ page import="java.sql.ResultSet" isThreadSafe="false" %>
<%@ page import="java.sql.SQLException" isThreadSafe="false" %>
<%@ page import="java.sql.Statement" isThreadSafe="false" %>
<%@ page import="java.util.Enumeration" isThreadSafe="false" %>
<%@ page import="java.util.Vector" isThreadSafe="false" %>

<%@ page import="com.lowagie.text.Document" isThreadSafe="false" %>
<%@ page import="com.lowagie.text.*" isThreadSafe="false" %>
<%@ page import="com.lowagie.text.rtf.*" isThreadSafe="false" %>
<%@ page import="java.io.*" isThreadSafe="false" %>
<%@ page import="java.awt.Color" isThreadSafe="false" %>


<%
  String query = request.getParameter("query");
  
     Connection cn = null;
    Statement  st = null;
    ResultSet  rs = null;

    try {

      Class.forName( sqlDriver );
      cn = DriverManager.getConnection( sqlURL, sqlUser, sqlPassword );
      st = cn.createStatement();

      Vector<String> headlines = new Vector<String> ();
      Vector<String> fieldNames = new Vector<String> ();
      int orderSize = 0;

       String belegform = "";
      boolean firstBeleg = true;

       if(query.toUpperCase().matches("[BPNQ][0-9]+")){
              String newID = query;
        String newForm = "";
        if(newID.startsWith("B") || newID.startsWith("b")) newForm="einzelbeleg";
        else if(newID.startsWith("P") || newID.startsWith("p")) newForm="person";
        else if(newID.startsWith("N") || newID.startsWith("n")) newForm="namenkommentar";
        else if(newID.startsWith("Q") || newID.startsWith("q")) newForm="quelle";
        out.println("<script type=\"text/javascript\">");
        String url = request.getRequestURL().toString();
    //    session.setAttribute("filter", 0);
    //    session.setAttribute("filterParameter", "");
        url = url.substring(0, url.lastIndexOf('/')+1);
        out.println("location.replace('"+url + newForm +".jsp?ID='+"+newID.substring(1)+");");
        out.println("</script>");


       }
       
       //>> Fix #3
	   	query = query.trim();

		if(query.length() < 3)
			throw new Exception("<b>Bitte geben Sie mindestens 3 Zeichen als Suchtext an.</b>");

		String query_like = query;
		// if query in double quotes, use verbatim, otherwise replace spaces with % wildcards
    	if(query_like.startsWith("\"") && query_like.endsWith("\"")) {
    		// remove quotes beginning and end
    		query_like = query_like.substring(1, query_like.length() - 1);
    	}
    	else {
    		query_like = query.replaceAll("\\s+", "%");
    		if(!query_like.startsWith("%"))
    			query_like = "%" + query_like;
    		if(!query_like.endsWith("%"))
    			query_like = query_like + "%";
    	}
    	out.println("<script>console.log('Using query term: " + query_like.replaceAll("'", "\\'") + "')</script>");
       //<<

            out.println("<div id=\"level_function\"> <div class=\"open_next_level\" onClick=\"expandNextLevel('complete')\">Weitere Ebene aufklappen</div>");
      out.print("<div class=\"close_prev_level\" onClick=\"collapseNextLevel('complete')\">Weitere Ebene zuklappen</div></div>");



      headlines = new Vector<String> ();
      headlines.add("Namenlemma");
      headlines.add("Standardname");
      headlines.add("Quelle");
      headlines.add("Edition");
      headlines.add("c.");
      headlines.add("S.");
      headlines.add("Q von J.");
      headlines.add("Q von Jh.");
      headlines.add("Q bis J.");
      headlines.add("Q bis Jh.");
      headlines.add("Belegform");
      headlines.add("EB von J.");
      headlines.add("EB von Jh.");
      headlines.add("EB bis J.");
      headlines.add("EB bis Jh.");
       headlines.add("Q Jahr");
      fieldNames = new Vector<String> ();
      fieldNames.add("namenkommentar.PLemma");
      fieldNames.add("person.Standardname");
      fieldNames.add("quelle.Bezeichnung");
      fieldNames.add("editionTitel");
      fieldNames.add("e2.EditionKapitel");
      fieldNames.add("e2.EditionSeite");
      fieldNames.add("quelle.VonJahr");
      fieldNames.add("quelle.VonJahrhundert");
      fieldNames.add("quelle.BisJahr");
      fieldNames.add("quelle.BisJahrhundert");
      fieldNames.add("e2.Belegform");
      fieldNames.add("e2.VonJahr");
      fieldNames.add("e2.VonJahrhundert");
      fieldNames.add("e2.BisJahr");
      fieldNames.add("e2.BisJahrhundert");
      fieldNames.add("quelleBerJahr");
      orderSize = 0;
      String order = "ORDER BY namenkommentar.PLemma ASC, person.Standardname ASC, (VON_JAHR_JHDT(quelle.VonJahr, quelle.VonJahrhundert, quelle.BisJahrhundert) DIV 25), VON_JAHR_JHDT(quelle.VonJahr, quelle.VonJahrhundert, quelle.BisJahrhundert) ASC ";

      String orderV0 [] = {"namenkommentar.PLemma","person.Standardname","e2.Belegform","quelleBerJahr"};

	 String sql = "SELECT DISTINCT namenkommentar.PLemma, namenkommentar.ID, person.Standardname, person.ID, "+
				   "quelle.Bezeichnung, "+
				   "quelle.ID, edition.Titel as editionTitel, edition.ID, e2.EditionKapitel, e2.EditionSeite, quelle.VonTag, "+
				   "quelle.VonMonat, quelle.VonJahr, quelle.VonJahrhundert, quelle.BisTag, quelle.BisMonat, quelle.BisJahr, "+
				   "quelle.BisJahrhundert, e2.Belegform, e2.ID, e2.VonTag, e2.VonMonat, "+
				   "e2.VonJahr, e2.VonJahrhundert, e2.BisTag, e2.BisMonat, e2.BisJahr, "+
				   "e2.BisJahrhundert, VON_JAHR_JHDT(quelle.VonJahr, quelle.VonJahrhundert, quelle.BisJahrhundert) AS "+
				   "quelleBerJahr FROM (select * from einzelbeleg where Belegform LIKE '"+query_like+"') as e1 LEFT OUTER JOIN einzelbeleg_hatnamenkommentar ehk1 ON "+
				   "ehk1.EinzelbelegID=e1.ID LEFT OUTER JOIN namenkommentar ON "+
				   "namenkommentar.ID=ehk1.NamenkommentarID LEFT OUTER JOIN einzelbeleg_hatnamenkommentar ehk2 "+
				   "ON namenkommentar.ID=ehk2.NamenkommentarID "+
				   "LEFT OUTER JOIN einzelbeleg e2 ON ehk2.EinzelbelegID=e2.ID LEFT OUTER JOIN einzelbeleg_hatperson ON e2.ID=einzelbeleg_hatperson.EinzelbelegID "+
				   "LEFT OUTER JOIN person ON einzelbeleg_hatperson.PersonID=person.ID LEFT OUTER JOIN quelle ON "+
				   "e2.QuelleID=quelle.ID LEFT OUTER JOIN edition ON e2.EditionID=edition.ID WHERE "+
				   "(quelle.zuVeroeffentlichen='1') ORDER BY namenkommentar.PLemma ASC, "+
				   "person.Standardname ASC, e2.Belegform ASC, (VON_JAHR_JHDT(quelle.VonJahr, quelle.VonJahrhundert, "+
				   "quelle.BisJahrhundert) DIV 25), VON_JAHR_JHDT(quelle.VonJahr, quelle.VonJahrhundert, quelle.BisJahrhundert) ASC";

//	out.println(sql);

      belegform = "";
      firstBeleg = true;
    //  out.println(sql);

      rs = st.executeQuery(sql);

      boolean found = false;
     out.println("<ul class=\"mktree\" id=\"complete\">");

     if(rs.isBeforeFirst()){
      found = true;
      out.print("<li  style=\"width:49%;float:left;\" class=\"liOpen\" style=\"font-size:large\">\""+query+"\" entspricht dem Lemma folgender Namen <ul>");
      test(out, headlines, fieldNames, rs, orderV0, order,"", false);

        out.println("</ul></li>");

      }
     headlines = new Vector<String> ();
     headlines.add("MGHLemma");
     headlines.add("Standardname");
     headlines.add("Quelle");
     headlines.add("Edition");
     headlines.add("c.");
     headlines.add("S.");
     headlines.add("Q von J.");
     headlines.add("Q von Jh.");
     headlines.add("Q bis J.");
     headlines.add("Q bis Jh.");
     headlines.add("Belegform");
     headlines.add("EB von J.");
     headlines.add("EB von Jh.");
     headlines.add("EB bis J.");
     headlines.add("EB bis Jh.");
      headlines.add("Q Jahr");
     fieldNames = new Vector<String> ();
     fieldNames.add("mgh_lemma.MGHLemma");
     fieldNames.add("person.Standardname");
     fieldNames.add("quelle.Bezeichnung");
     fieldNames.add("editionTitel");
     fieldNames.add("e2.EditionKapitel");
     fieldNames.add("e2.EditionSeite");
     fieldNames.add("quelle.VonJahr");
     fieldNames.add("quelle.VonJahrhundert");
     fieldNames.add("quelle.BisJahr");
     fieldNames.add("quelle.BisJahrhundert");
     fieldNames.add("e2.Belegform");
     fieldNames.add("e2.VonJahr");
     fieldNames.add("e2.VonJahrhundert");
     fieldNames.add("e2.BisJahr");
     fieldNames.add("e2.BisJahrhundert");
     fieldNames.add("quelleBerJahr");
     orderSize = 0;
      order = "ORDER BY mgh_lemma.MGHLemma ASC, person.Standardname ASC, (VON_JAHR_JHDT(quelle.VonJahr, quelle.VonJahrhundert, quelle.BisJahrhundert) DIV 25), VON_JAHR_JHDT(quelle.VonJahr, quelle.VonJahrhundert, quelle.BisJahrhundert) ASC ";

      String orderV1 [] = {"mgh_lemma.MGHLemma","person.Standardname","e2.Belegform","quelleBerJahr"};

	  sql = "SELECT DISTINCT mgh_lemma.MGHLemma, mgh_lemma.ID, person.Standardname, person.ID, "+
				   "quelle.Bezeichnung, "+
				   "quelle.ID, edition.Titel as editionTitel, edition.ID, e2.EditionKapitel, e2.EditionSeite, quelle.VonTag, "+
				   "quelle.VonMonat, quelle.VonJahr, quelle.VonJahrhundert, quelle.BisTag, quelle.BisMonat, quelle.BisJahr, "+
				   "quelle.BisJahrhundert, e2.Belegform, e2.ID, e2.VonTag, e2.VonMonat, "+
				   "e2.VonJahr, e2.VonJahrhundert, e2.BisTag, e2.BisMonat, e2.BisJahr, "+
				   "e2.BisJahrhundert, VON_JAHR_JHDT(quelle.VonJahr, quelle.VonJahrhundert, quelle.BisJahrhundert) AS "+
				   "quelleBerJahr FROM (select * from einzelbeleg where Belegform LIKE '"+query_like+"') as e1 LEFT OUTER JOIN einzelbeleg_hatmghlemma ehk1 ON "+
				   "ehk1.EinzelbelegID=e1.ID LEFT OUTER JOIN mgh_lemma ON "+
				   "mgh_lemma.ID=ehk1.MGHLemmaID LEFT OUTER JOIN einzelbeleg_hatmghlemma ehk2 "+
				   "ON mgh_lemma.ID=ehk2.MGHLemmaID "+
				   "LEFT OUTER JOIN einzelbeleg e2 ON ehk2.EinzelbelegID=e2.ID LEFT OUTER JOIN einzelbeleg_hatperson ON e2.ID=einzelbeleg_hatperson.EinzelbelegID "+
				   "LEFT OUTER JOIN person ON einzelbeleg_hatperson.PersonID=person.ID LEFT OUTER JOIN quelle ON "+
				   "e2.QuelleID=quelle.ID LEFT OUTER JOIN edition ON e2.EditionID=edition.ID WHERE "+
				   "(quelle.zuVeroeffentlichen='1') ORDER BY mgh_lemma.MGHLemma ASC, "+
				   "person.Standardname ASC, e2.Belegform ASC, (VON_JAHR_JHDT(quelle.VonJahr, quelle.VonJahrhundert, "+
				   "quelle.BisJahrhundert) DIV 25), VON_JAHR_JHDT(quelle.VonJahr, quelle.VonJahrhundert, quelle.BisJahrhundert) ASC";

// 	out.println(sql);

     belegform = "";
     firstBeleg = true;
   //  out.println(sql);

     rs = st.executeQuery(sql);

      found = false;
//     out.println("<ul class=\"mktree\" id=\"complete\">");

    if(rs.isBeforeFirst()){
     found = true;
     out.print("<li  style=\"width:45%;float:left;margin-left:1em\"  class=\"liOpen\" style=\"font-size:large\">MGH-Lemma <ul>");
     test(out, headlines, fieldNames, rs, orderV1, order,"", false);

       out.println("</ul></li>");

     }

     headlines = new Vector<String> ();
      headlines.add("Standardname");
      headlines.add("Quelle");
      headlines.add("Edition");
      headlines.add("c.");
      headlines.add("S.");
      headlines.add("Q von J.");
      headlines.add("Q von Jh.");
      headlines.add("Q bis J.");
      headlines.add("Q bis Jh.");
      headlines.add("Belegform");
      headlines.add("EB von J.");
      headlines.add("EB von Jh.");
      headlines.add("EB bis J.");
      headlines.add("EB bis Jh.");
       headlines.add("EB Jahr");
      fieldNames = new Vector<String> ();
      fieldNames.add("person.Standardname");
      fieldNames.add("quelle.Bezeichnung");
      fieldNames.add("Titel");
      fieldNames.add("EditionKapitel");
      fieldNames.add("EditionSeite");
      fieldNames.add("VonJahr");
      fieldNames.add("VonJahrhundert");
      fieldNames.add("BisJahr");
      fieldNames.add("BisJahrhundert");
      fieldNames.add("e2.Belegform");
      fieldNames.add("VonJahr");
      fieldNames.add("VonJahrhundert");
      fieldNames.add("BisJahr");
      fieldNames.add("BisJahrhundert");
      fieldNames.add("einzelbelegBerJahr");
       order = "ORDER BY person.Standardname ASC, quelle.Bezeichnung ASC, (VON_JAHR_JHDT(einzelbeleg.VonJahr, einzelbeleg.VonJahrhundert, einzelbeleg.BisJahrhundert) DIV 25), VON_JAHR_JHDT(einzelbeleg.VonJahr, einzelbeleg.VonJahrhundert, einzelbeleg.BisJahrhundert) ASC ";

      String [] orderV2 = {"person.Standardname", "quelle.Bezeichnung", "e2.Belegform", "einzelbelegBerJahr"};

  /*     sql = "SELECT DISTINCT person.Standardname, person.ID, quelle.Bezeichnung, quelle.ID, edition.Titel, edition.ID, einzelbeleg.EditionKapitel, einzelbeleg.EditionSeite, quelle.VonTag, quelle.VonMonat, quelle.VonJahr, quelle.VonJahrhundert, quelle.BisTag, quelle.BisMonat, quelle.BisJahr, quelle.BisJahrhundert, einzelbeleg.Belegform, einzelbeleg.ID, einzelbeleg.VonTag, einzelbeleg.VonMonat, einzelbeleg.VonJahr, einzelbeleg.VonJahrhundert, einzelbeleg.BisTag, einzelbeleg.BisMonat, einzelbeleg.BisJahr, einzelbeleg.BisJahrhundert, VON_JAHR_JHDT(einzelbeleg.VonJahr, einzelbeleg.VonJahrhundert, einzelbeleg.BisJahrhundert) AS einzelbelegBerJahr "+
       "FROM einzelbeleg LEFT OUTER JOIN einzelbeleg_hatperson ON einzelbeleg.ID=einzelbeleg_hatperson.EinzelbelegID LEFT OUTER JOIN "+
       "person ON einzelbeleg_hatperson.PersonID=person.ID LEFT OUTER JOIN quelle ON einzelbeleg.QuelleID=quelle.ID "+
       "LEFT OUTER JOIN edition ON einzelbeleg.EditionID=edition.ID "+
       "WHERE ((einzelbeleg.Belegform LIKE '"+query+"' OR person.Standardname LIKE '"+query+"') and Quelle.zuVeroeffentlichen='1') "+
       "ORDER BY person.Standardname ASC, quelle.Bezeichnung ASC, einzelbeleg.Belegform ASC, "+
       "(VON_JAHR_JHDT(einzelbeleg.VonJahr, einzelbeleg.VonJahrhundert, einzelbeleg.BisJahrhundert) DIV 25), "+
       "VON_JAHR_JHDT(einzelbeleg.VonJahr, einzelbeleg.VonJahrhundert, einzelbeleg.BisJahrhundert) ASC ";*/

       sql = "SELECT DISTINCT person.Standardname, person.ID, quelle.Bezeichnung, quelle.ID, edition.Titel, edition.ID, "+
       "e2.EditionKapitel, e2.EditionSeite, quelle.VonTag, quelle.VonMonat, quelle.VonJahr, "+
       "quelle.VonJahrhundert, quelle.BisTag, quelle.BisMonat, quelle.BisJahr, quelle.BisJahrhundert, e2.Belegform, "+
       "e2.ID, e2.VonTag, e2.VonMonat, e2.VonJahr, e2.VonJahrhundert, "+
       "e2.BisTag, e2.BisMonat, e2.BisJahr, e2.BisJahrhundert, "+
       "VON_JAHR_JHDT(e2.VonJahr, e2.VonJahrhundert, e2.BisJahrhundert) AS einzelbelegBerJahr "+
       "FROM (select * from person where person.Standardname LIKE '"+query_like+"') as person "+
       "LEFT OUTER JOIN einzelbeleg_hatperson eh2 ON eh2.PersonID=person.ID "+
       "LEFT OUTER JOIN einzelbeleg e2 ON e2.ID=eh2.EinzelbelegID "+
       "LEFT OUTER JOIN quelle ON e2.QuelleID=quelle.ID "+
       "LEFT OUTER JOIN edition ON e2.EditionID=edition.ID "+
       "WHERE (quelle.zuVeroeffentlichen='1') "+
       "ORDER BY person.Standardname ASC, quelle.Bezeichnung ASC, e2.Belegform ASC, (VON_JAHR_JHDT(e2.VonJahr, e2.VonJahrhundert, e2.BisJahrhundert) DIV 25), VON_JAHR_JHDT(e2.VonJahr, e2.VonJahrhundert, e2.BisJahrhundert) ASC";

     //  out.println(sql);

      rs = st.executeQuery(sql);

      if(rs.isBeforeFirst()){
     found = true;
      out.print("<li  style=\"width:100%;float:left\" class=\"liOpen\" style=\"margin-top:20pt;font-size:large\">\""+query+"\" entspricht dem Namen folgender Personen<ul>");
      test(out, headlines, fieldNames, rs, orderV2, order, "EB Jahr", false);

       out.println("</ul></li>");

    }

  headlines = new Vector<String> ();
      headlines.add("Quelle");
       headlines.add("Q Jahr");
      fieldNames = new Vector<String> ();
      fieldNames.add("quelle.Bezeichnung");
      fieldNames.add("quelleBerJahr");
       order = "";

      String [] orderV3 = {"quelle.Bezeichnung"};

       sql = "SELECT DISTINCT quelle.Bezeichnung, quelle.ID, VON_JAHR_JHDT(quelle.VonJahr, quelle.VonJahrhundert, quelle.BisJahrhundert) AS quelleBerJahr FROM quelle WHERE (quelle.Bezeichnung LIKE '"+query_like+"' and quelle.zuVeroeffentlichen='1') ORDER BY quelle.Bezeichnung ASC ,VON_JAHR_JHDT(quelle.VonJahr, quelle.VonJahrhundert, quelle.BisJahrhundert) ASC ";
//	out.println(sql);

      rs = st.executeQuery(sql);



      if(rs.isBeforeFirst()){
      found = true;
      out.print("<li style=\"width:100%;float:left\" class=\"liOpen\" style=\"margin-top:20pt;font-size:large\">\""+query+"\" entspricht dem Namen folgender Quellen <ul>");
      test(out, headlines, fieldNames, rs, orderV3, order,"", false);

       out.println("</ul></li>");



       }

            headlines = new Vector<String> ();
      headlines = new Vector<String> ();
      headlines.add("Quelle");
      headlines.add("Edition");
      headlines.add("c.");
      headlines.add("S.");
      headlines.add("Q von J.");
      headlines.add("Q von Jh.");
      headlines.add("Q bis J.");
      headlines.add("Q bis Jh.");
      headlines.add("Belegform");
      headlines.add("EB von J.");
      headlines.add("EB von Jh.");
      headlines.add("EB bis J.");
      headlines.add("EB bis Jh.");
       headlines.add("Q Jahr");
      fieldNames = new Vector<String> ();
      fieldNames.add("quelle.Bezeichnung");
      fieldNames.add("editionTitel");
      fieldNames.add("e2.EditionKapitel");
      fieldNames.add("e2.EditionSeite");
      fieldNames.add("quelle.VonJahr");
      fieldNames.add("quelle.VonJahrhundert");
      fieldNames.add("quelle.BisJahr");
      fieldNames.add("quelle.BisJahrhundert");
      fieldNames.add("e2.Belegform");
      fieldNames.add("e2.VonJahr");
      fieldNames.add("e2.VonJahrhundert");
      fieldNames.add("e2.BisJahr");
      fieldNames.add("e2.BisJahrhundert");
      fieldNames.add("quelleBerJahr");
      orderSize = 0;
       order = "ORDER BY einzelbeleg.Belegform, (VON_JAHR_JHDT(quelle.VonJahr, quelle.VonJahrhundert, quelle.BisJahrhundert) DIV 25), VON_JAHR_JHDT(quelle.VonJahr, quelle.VonJahrhundert, quelle.BisJahrhundert) ASC, quelle.Bezeichnung ASC ";

      String orderV4 [] = {"e2.Belegform","quelleBerJahr","quelle.Bezeichnung"};

	  sql = "SELECT DISTINCT quelle.Bezeichnung, "+
				   "quelle.ID, edition.Titel as editionTitel, edition.ID, e2.EditionKapitel, e2.EditionSeite, quelle.VonTag, "+
				   "quelle.VonMonat, quelle.VonJahr, quelle.VonJahrhundert, quelle.BisTag, quelle.BisMonat, quelle.BisJahr, "+
				   "quelle.BisJahrhundert, e2.Belegform, e2.ID, e2.VonTag, e2.VonMonat, "+
				   "e2.VonJahr, e2.VonJahrhundert, e2.BisTag, e2.BisMonat, e2.BisJahr, "+
				   "e2.BisJahrhundert, VON_JAHR_JHDT(quelle.VonJahr, quelle.VonJahrhundert, quelle.BisJahrhundert) AS "+
				   "quelleBerJahr FROM (select * from einzelbeleg where Belegform LIKE '"+query_like+"') as e2 "+
				   "LEFT OUTER JOIN quelle ON "+
				   "e2.QuelleID=quelle.ID LEFT OUTER JOIN edition ON e2.EditionID=edition.ID WHERE "+
				   "(quelle.zuVeroeffentlichen='1') ORDER BY e2.Belegform ASC, (VON_JAHR_JHDT(quelle.VonJahr, quelle.VonJahrhundert, "+
				   "quelle.BisJahrhundert) DIV 25), VON_JAHR_JHDT(quelle.VonJahr, quelle.VonJahrhundert, quelle.BisJahrhundert) ASC, quelle.Bezeichnung ASC";

//	out.println(sql);

      belegform = "";
      firstBeleg = true;
    //  out.println(sql);

      rs = st.executeQuery(sql);

     if(rs.isBeforeFirst()){
      found = true;
      out.print("<li style=\"width:100%;float:left\" class=\"liOpen\" style=\"margin-top:20pt;font-size:large\">\""+query+"\" entspricht folgenden Belegformen <ul>");
      test(out, headlines, fieldNames, rs, orderV4, order,"", true);

        out.println("</ul></li>");





    }

        out.println("</ul>");
         %>
    <script type="text/javascript">
   var array = document.getElementsByTagName("li");
   for(var j=0; j< array.length; j++){
     if(array[j].getElementsByTagName("ul").length==0)continue;  var ul =   array[j].getElementsByTagName("ul")[0].previousSibling;
       var li =     array[j].getElementsByTagName("li");
       var count = 0;
       if(li.length<1)
          count = (array[j].getElementsByTagName("table")[0].rows.length-2);
       else
          count = ul.nextSibling.childNodes.length;
     //     alert(ul.data);
       if(count==1)ul.data=ul.data + "("+ count + " Eintrag)";
       else ul.data=ul.data + "("+ count + " Eintr\u00E4ge)";
   }
   </script>


<%              if (!found) out.println("<b>F&uuml;r Ihre Suchanfrage wurden keine Ergebnisse gefunden</b>");

       }
          catch (Exception e) {
      out.println(e.getMessage());
    }
    finally {
      try { if( null != rs ) rs.close(); } catch( Exception ex ) {}
      try { if( null != st ) st.close(); } catch( Exception ex ) {}
      try { if( null != cn ) cn.close(); } catch( Exception ex ) {}
    }


%>
