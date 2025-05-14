<%@page import="de.uni_tuebingen.ub.nppm.util.Language"%>
<%@ page import="de.uni_tuebingen.ub.nppm.db.SucheDB"%>
<%@ page import="de.uni_tuebingen.ub.nppm.util.Utils"%>
<%@ page import="java.util.Map"%>
<%@ page import="java.util.ArrayList" isThreadSafe="false" %>
<%@ page import="java.util.Enumeration" isThreadSafe="false" %>
<%@ page import="java.util.List" isThreadSafe="false" %>
<%@ page import="com.lowagie.text.Document" isThreadSafe="false" %>
<%@ page import="com.lowagie.text.*" isThreadSafe="false" %>
<%@ page import="com.lowagie.text.rtf.*" isThreadSafe="false" %>
<%@ page import="java.io.*" isThreadSafe="false" %>
<%@ page import="java.awt.Color" isThreadSafe="false" %>


<%
    String query = request.getParameter("query");

    try {
        List<String> headlines = new ArrayList<>();
        List<String> fieldNames = new ArrayList<>();

        int orderSize = 0;

        String belegform = "";

        query = query.trim();

        if (query.length() < 3) {
            throw new Exception("<b>Bitte geben Sie mindestens 3 Zeichen als Suchtext an.</b>");  //Übersetzen
        }

        String query_like = query;
        boolean is_exact_query = false;
        // if query in double quotes, use verbatim, otherwise replace spaces with % wildcards
        if (query_like.startsWith("\"") && query_like.endsWith("\"")) {
            // remove quotes beginning and end
            query_like = query_like.substring(1, query_like.length() - 1);
            is_exact_query = true;
        }

        String subquery;
        //query_like = query_like.replace("*", "%");  //Wenn du * als Wildcard zulassen willst
        if (query_like.contains("%") || query_like.contains("_")) {
            //Hier reicht es die ID abzufragen (s. Hauptquery)
            subquery = "SELECT ID FROM einzelbeleg WHERE Belegform LIKE '" + query_like + "'";
        } else {
            subquery = "SELECT ID FROM einzelbeleg WHERE Belegform = '" + query_like + "'";
        }

        out.println("<script>console.log('Using query term: " + query_like.replaceAll("'", "\\'") + "')</script>");

        String aufklappen = Language.getTextfield(session, "gast_freie_suche", "EbeneAufklappen");

        String zuklappen = Language.getTextfield(session, "gast_freie_suche", "EbeneZuklappen");

        out.println("<div id=\"level-function\">");
        out.println("<button class=\"ut-btn \" type=\"button\"  aria-label=\"" + aufklappen + "\" onClick=\"expandNextLevel('complete')\"><img src=\"layout/images/open_next_level.png\" alt=\"Aufklappen\" style=\"vertical-align: middle height: 23px; width: 30px; margin-right: 5px;\">" + aufklappen + "</button>");
        out.println("<button class=\"ut-btn \" type=\"button\"  aria-label=\"" + zuklappen + "\" onClick=\"collapseNextLevel('complete')\"><img src=\"layout/images/close_next_level.png\"  style=\"vertical-align: middle height: 23px; width: 30px; margin-right: 5px;\">" + zuklappen + "</button>");
        out.println("</div>");

        out.println("<ul class=\"mktree\" id=\"complete\">");

        headlines = new ArrayList<>();
        headlines.add("");
        headlines.add("");
        headlines.add("Belegform");
        headlines.add("Quelle");
        headlines.add("Nr./S.");
        headlines.add("Rast.");
        headlines.add("Edition");
        headlines.add("c.");
        headlines.add("S.");
        headlines.add("Q von J.");
        headlines.add("Q von Jh.");
        headlines.add("Q bis J.");
        headlines.add("Q bis Jh.");

        headlines.add("EB von J.");
        headlines.add("EB von Jh.");
        headlines.add("EB bis J.");
        headlines.add("EB bis Jh.");
        headlines.add("Q Jahr");

        fieldNames = new ArrayList<>();
        fieldNames.add("MGHLemma");
        fieldNames.add("Standardname");
        fieldNames.add("Belegform");
        fieldNames.add("Bezeichnung");
        fieldNames.add("seite");
        fieldNames.add("raster");
        fieldNames.add("editionTitel");
        fieldNames.add("EditionKapitel");
        fieldNames.add("EditionSeite");
        fieldNames.add("quelleVonJahr");
        fieldNames.add("quelleVonJahrhundert");
        fieldNames.add("quelleBisJahr");
        fieldNames.add("quelleBisJahrhundert");

        fieldNames.add("VonJahr");
        fieldNames.add("VonJahrhundert");
        fieldNames.add("BisJahr");
        fieldNames.add("BisJahrhundert");
        fieldNames.add("quelleBerJahr");

        orderSize = 0;
        String order = "ORDER BY mgh_lemma.MGHLemma ASC, person.Standardname ASC, (VON_JAHR_JHDT(quelle.VonJahr, quelle.VonJahrhundert, quelle.BisJahrhundert) DIV 25), VON_JAHR_JHDT(quelle.VonJahr, quelle.VonJahrhundert, quelle.BisJahrhundert) ASC ";

        String orderV1[] = {"MGHLemma", "Standardname", "Belegform"};

        String sql = "SELECT DISTINCT mgh_lemma.MGHLemma, mgh_lemma.ID as mgh_lemmaID, person.Standardname, person.ID as personID, "
                + "quelle.Bezeichnung, "
                + "quelle.ID as quelleID, edition.Titel as editionTitel, edition.ID as editionID, e2.EditionKapitel, e2.EditionSeite, e2.seite AS seite, e2.raster AS raster, quelle.VonTag as quelleVonTag, "
                + "quelle.VonMonat as quelleVonMonat, quelle.VonJahr as quelleVonJahr, quelle.VonJahrhundert as quelleVonJahrhundert, quelle.BisTag as quelleBisTag, quelle.BisMonat as quelleBisMonat, quelle.BisJahr as quelleBisJahr, "
                + "quelle.BisJahrhundert as quelleBisJahrhundert, e2.Belegform, e2.ID as e2ID, e2.VonTag, e2.VonMonat, "
                + "e2.VonJahr, e2.VonJahrhundert, e2.BisTag, e2.BisMonat, e2.BisJahr, "
                + "e2.BisJahrhundert, VON_JAHR_JHDT(quelle.VonJahr, quelle.VonJahrhundert, quelle.BisJahrhundert) AS "
                + "quelleBerJahr FROM (" + subquery + ") as e1 LEFT OUTER JOIN einzelbeleg_hatmghlemma ehk1 ON "
                + "ehk1.EinzelbelegID=e1.ID LEFT OUTER JOIN mgh_lemma ON "
                + "mgh_lemma.ID=ehk1.MGHLemmaID LEFT OUTER JOIN einzelbeleg_hatmghlemma ehk2 "
                + "ON mgh_lemma.ID=ehk2.MGHLemmaID "
                + "LEFT OUTER JOIN einzelbeleg e2 ON ehk2.EinzelbelegID=e2.ID LEFT OUTER JOIN einzelbeleg_hatperson ON e2.ID=einzelbeleg_hatperson.EinzelbelegID "
                + "LEFT OUTER JOIN person ON einzelbeleg_hatperson.PersonID=person.ID LEFT OUTER JOIN quelle ON "
                + "e2.QuelleID=quelle.ID LEFT OUTER JOIN edition ON e2.EditionID=edition.ID WHERE "
                + "(quelle.zuVeroeffentlichen='1') ORDER BY mgh_lemma.MGHLemma ASC, "
                + "person.Standardname ASC, e2.Belegform ASC, (VON_JAHR_JHDT(quelle.VonJahr, quelle.VonJahrhundert, "
                + "quelle.BisJahrhundert) DIV 25), VON_JAHR_JHDT(quelle.VonJahr, quelle.VonJahrhundert, quelle.BisJahrhundert) ASC";

        belegform = "";

        java.util.List<Map> resultAsMap = SucheDB.getEinfacheSucheResult(sql);

        boolean found = false;

        if (!resultAsMap.isEmpty()) {
            found = true;
            out.print("<li  style=\"width:45%;float:left;margin-left:1em\"  class=\"liOpen\" style=\"font-size:large\">Lemma <ul>");

            Utils.simpleSearch(out, headlines, fieldNames, resultAsMap, orderV1, order, "", false);
            out.println("</ul></li>");
        }

        out.println("</ul>");
%>
<script type="text/javascript">
    var array = document.getElementsByTagName("li");
    for (var j = 0; j < array.length; j++) {
        if (array[j].getElementsByTagName("ul").length == 0)
            continue;
        var ul = array[j].getElementsByTagName("ul")[0].previousSibling;
        var li = array[j].getElementsByTagName("li");
        var count = 0;
        if (li.length < 1)
            count = (array[j].getElementsByTagName("table")[0].rows.length - 2);
        else
            count = ul.nextSibling.childNodes.length;
        //     alert(ul.data);
        if (count == 1)
            ul.data = ul.data + "(" + count + " Eintrag)";
        else
            ul.data = ul.data + "(" + count + " Eintr\u00E4ge)";
    }
</script>

<%
        if (!found) {
            out.println("<b>F&uuml;r Ihre Suchanfrage wurden keine Ergebnisse gefunden</b>");
        }

    } catch (Exception e) {
        out.println(e.getMessage());
    }

%>
