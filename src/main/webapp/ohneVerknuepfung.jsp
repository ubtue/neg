<%@ page import="de.uni_tuebingen.ub.nppm.db.*" isThreadSafe="false" %>
<%@ page import="de.uni_tuebingen.ub.nppm.util.*" isThreadSafe="false" %>
<%@ page import="java.util.Date" isThreadSafe="false" %>
<%@ page import="java.util.Map" isThreadSafe="false" %>
<%@ include file="configuration.jsp" %>
<%@ include file="functions.jsp" %>
<%
  Language.setLanguage(request);
%>
  <div>

    <jsp:include page="layout/title.openLink.jsp" />

       <div id="form">
       <ul>
          <li><a href="ohneVerknuepfung?form=einzelbeleg&dbForm=einzelbeleg&zwischentabelle=einzelbeleg_hatnamenkommentar&attribut=Belegform&zwAttribut=einzelbelegID"><% Language.printTextfield(out, session, "ohneVerknuepfung", "EinzelbelegOhneLemma");%></a></li>
          <li><a href="ohneVerknuepfung?form=einzelbeleg&dbForm=einzelbeleg&zwischentabelle=einzelbeleg_textkritik&attribut=Belegform&zwAttribut=einzelbelegID"><% Language.printTextfield(out, session, "ohneVerknuepfung", "EinzelbelegOhneTextkritik");%></a></li>
          <li><a href="ohneVerknuepfung?form=einzelbeleg&dbForm=einzelbeleg&zwischentabelle=einzelbeleg_hatperson&attribut=Belegform&zwAttribut=einzelbelegID"><% Language.printTextfield(out, session, "ohneVerknuepfung", "EinzelbelegOhnePerson");%></a></li>
          <li><a href="ohneVerknuepfung?form=namenkommentar&dbForm=namenkommentar&zwischentabelle=einzelbeleg_hatnamenkommentar&attribut=PLemma&zwAttribut=namenkommentarID"><% Language.printTextfield(out, session, "ohneVerknuepfung", "NamenOhneBelege");%></a></li>
          <li><a href="ohneVerknuepfung?form=person&dbForm=person&zwischentabelle=einzelbeleg_hatperson&attribut=Standardname&zwAttribut=personID"><% Language.printTextfield(out, session, "ohneVerknuepfung", "PersonOhneBelege");%></a></li>
          <li><a href="ohneVerknuepfung?form=quelle&dbForm=quelle&zwischentabelle=quelle_inedition&attribut=Bezeichnung&zwAttribut=QuelleID"><% Language.printTextfield(out, session, "ohneVerknuepfung", "QuelleOhneEdition");%></a></li>
          <li><a href="ohneVerknuepfung?form=quelle&dbForm=quelle&zwischentabelle=handschrift_ueberlieferung&attribut=Bezeichnung&zwAttribut=QuelleID"><% Language.printTextfield(out, session, "ohneVerknuepfung", "QuelleOhneUeberlieferung");%></a></li>
          <li><a href="ohneVerknuepfung?form=handschrift&dbForm=handschrift&zwischentabelle=handschrift_ueberlieferung&attribut=Bibliothekssignatur&zwAttribut=HandschriftID"><% Language.printTextfield(out, session, "ohneVerknuepfung", "TextzeugenOhneUeberlieferung");%></a></li>
          <li><a href="ohneVerknuepfung?view=BelegformMitMehrerenLemmata">Belegformen mit mehreren Lemmata</a></li>
       </ul>


    <%
        String form = request.getParameter("form");
        if (form != null){
            Map<Integer,String> attr = SucheDB.getAttributes(request);
            for (Integer key : attr.keySet()){
                out.println("<a href=\"" + form + "?ID=" + key + "\">-" + attr.get(key) + "</a><br>");
            }
        }
    %>

    <%
        String view = request.getParameter("view");
        if(view != null) {
            if (view.equals("BelegformMitMehrerenLemmata")) {
                List<Object[]> rows = EinzelbelegDB.getBelegformenWithMultipleLemmas();
                out.println("<table>");
                out.println("<tr>");
                out.println("<th>Einzelbeleg ID</th>");
                out.println("<th>Belegform</th>");
                out.println("<th>Lemma ID</th>");
                out.println("<th>Lemma</th>");
                out.println("</tr>");
                for (Object[] row : rows) {
                    out.println("<tr>");
                    out.println("<td><a href=\"einzelbeleg?ID=" + String.valueOf(row[0]) + "\">" + String.valueOf(row[0]) + "</a></td>");
                    out.println("<td>" + Utils.escapeHTML(String.valueOf(row[1])) + "</td>");
                    out.println("<td>" + String.valueOf(row[2]) + "</td>");
                    out.println("<td><a href=\"lemma?ID=" + String.valueOf(row[2]) + "\">" + Utils.escapeHTML(String.valueOf(row[3])) + "</a></td>");
                    out.println("</tr>");
                }
                out.println("</table>");
            }
        }
    %>
    </div>
  </div>
