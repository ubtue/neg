<%@ page import="de.uni_tuebingen.ub.nppm.db.*" isThreadSafe="false" %>
<%@ page import="de.uni_tuebingen.ub.nppm.model.*" isThreadSafe="false" %>
<%@ page import="de.uni_tuebingen.ub.nppm.util.*" isThreadSafe="false" %>
<%@ page import="java.util.Date" isThreadSafe="false" %>
<%@ page import="java.util.HashSet" isThreadSafe="false" %>
<%@ page import="java.util.Map" isThreadSafe="false" %>
<%@ page import="java.util.Set" isThreadSafe="false" %>
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
          <li><a href="ohneVerknuepfung?view=LemmaNachGlied">Lemmata nach Erst/Zweitglied</a></li>
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
        if (view != null) {
            if (view.equals("BelegformMitMehrerenLemmata")) {
                Set<String> groupKeys = new HashSet<>();
                List<Map> rows = EinzelbelegDB.getBelegformenWithMultipleLemmas();

                out.println("<table>");
                out.println("<tr>");
                out.println("<th>Gruppierung</th>");
                out.println("<th>Einzelbeleg ID</th>");
                out.println("<th>Belegform</th>");
                out.println("<th>Lemma ID</th>");
                out.println("<th>Lemma</th>");
                out.println("<th>Provenienz</th>");
                out.println("</tr>");
                for (Map row : rows) {
                    // TODO: Diacritical Marks must not be removed for grouping since they can lead to different Lemmas due to Mr. Geuenich
                    String groupKey = Utils.removeDiacriticalMarks(String.valueOf(row.get("Belegform"))).toLowerCase();
                    //String groupKey = String.valueOf(row.get("Belegform")).toLowerCase();
                    groupKeys.add(groupKey);
                    out.println("<tr>");
                    out.println("<td><b>" + Utils.escapeHTML(groupKey) + "</b></td>");
                    out.println("<td><a href=\"einzelbeleg?ID=" + String.valueOf(row.get("EinzelbelegID")) + "\">" + String.valueOf(row.get("EinzelbelegID")) + "</a></td>");
                    out.println("<td>" + Utils.escapeHTML(String.valueOf(row.get("Belegform"))) + "</td>");
                    out.println("<td><a href=\"lemma?ID=" + String.valueOf(row.get("MGHLemmaID")) + "\">" + String.valueOf(row.get("MGHLemmaID")) + "</a></td>");
                    out.println("<td>" + Utils.escapeHTML(String.valueOf(row.get("MGHLemma"))) + "</td>");
                    if (String.valueOf(row.get("provenance_source")).equals("DMP")) {
                        out.println("<td><a href=\"https://dmp.ub.uni-tuebingen.de?table=namen&mode=view&g_index=" + String.valueOf(row.get("provenance_id")) + "\" target=\"_blank\">" + Utils.escapeHTML(String.valueOf(row.get("provenance_source"))) + "</a></td>");
                    } else {
                        out.println("<td>" + Utils.escapeHTML(String.valueOf(row.get("provenance_source"))) + "</td>");
                    }
                    out.println("</tr>");
                }
                out.println("</table>");

                out.println("<p>Insgesamt " + rows.size() + " Einzelbelege in " + groupKeys.size() + " Gruppen</p>");
            }

            if (view.equals("LemmaNachGlied")) {
                String mode = request.getParameter("mode");

                // nav
                out.println("<a href=\"?view=LemmaNachGlied&mode=erstglied\">Nach Erstglied</a>");
                out.println("<a href=\"?view=LemmaNachGlied&mode=zweitglied\">Nach Zweitglied</a>");

                // select
                if (mode != null) {
                    String selectedGlied = request.getParameter("glied");
                    if (selectedGlied == null) {
                        List<String> glieder = new ArrayList<>();
                        if (mode.equals("erstglied")) {
                            glieder = LemmaDB.getListErstglied();
                        } else if (mode.equals("zweitglied")) {
                            glieder = LemmaDB.getListZweitglied();
                        }

                        out.println("<table>\n");
                        for (String glied : glieder) {
                            out.println("<tr><td><a href=\"?view=LemmaNachGlied&mode=" + Utils.urlEncode(mode) + "&glied=" + Utils.urlEncode(glied) + "\">" + Utils.escapeHTML(glied) + "</a></td></tr>\n");
                        }
                        out.println("</table>\n");
                    } else {
                        List<MghLemma> lemmas = new ArrayList<>();
                        if (mode.equals("erstglied")) {
                            lemmas = LemmaDB.getListByErstglied(selectedGlied);
                        } else if (mode.equals("zweitglied")) {
                            lemmas = LemmaDB.getListByZweitglied(selectedGlied);
                        }
                        out.println("<table>\n");
                        for (MghLemma lemma : lemmas) {
                            out.println("<tr><td><a href=\"lemma?ID=" + lemma.getId() + "\">" + Utils.escapeHTML(lemma.getMghLemma()) + "</a></td></tr>\n");
                        }
                        out.println("</table>\n");
                    }
                }
            }
        }
    %>
    </div>
  </div>
