<%@ page import="de.uni_tuebingen.ub.nppm.db.*"%>
<%@ page import="de.uni_tuebingen.ub.nppm.util.*"%>
<%@ page import="java.util.*"%>

<%

    if (true) {
        conditions = removeDuplicates(conditions);
        fields = removeDuplicates(fields);
        tables = removeDuplicates(tables);
        joins = removeDuplicates(joins);

        // Bedingungen
        String conditionsString = "";
        if (conditions.size() > 0) {
            conditionsString += conditions.get(0);
            for (int i = 1; i < conditions.size(); i++) {
                conditionsString += " AND " + conditions.get(i);
            }
        } else {
            conditionsString += "1";
        }

        // Ausgabefelder
        String fieldsString = "";
        if (fields.size() > 0) {
            fieldsString += QueryHelper.getFieldAliasSelect(fields.get(0));
            for (int i = 1; i < fields.size(); i++) {
                fieldsString += ", " + QueryHelper.getFieldAliasSelect(fields.get(i));
            }
        }

        // Tabellen
        String tablesString = "";
        if (tables.size() > 0) {
            tablesString += tables.get(0);
            for (int i = 1; i < tables.size(); i++) {
                tablesString += ", " + tables.get(i);
            }
        }

        // Joins
        String joinsString = "";
        if (joins.size() > 0) {
            joinsString += joins.get(0);
            for (int i = 1; i < joins.size(); i++) {
                joinsString += " " + joins.get(i);
            }
        }

        tablesString = tableString;
        int pageoffset = 0;
        if (request.getParameter("pageoffset") != null) {
            pageoffset = Integer.parseInt(request.getParameter("pageoffset"));
        }

        if (fields.size() == 0) {
            out.println("Bitte wählen Sie mind. ein Ausgabefeld aus (Schritt 2).");
            return;
        }

        int linecount = SucheDB.getLinecount(tablesString, conditionsString);

        out.println("<h3 class=\"ut-heading ut-heading--h3\">Gesamte Treffer: " + linecount + "</h3>");

        String sql = "SELECT " + fieldsString + " FROM " + tablesString + " WHERE (" + conditionsString + ") " + order; //GROUP BY "+fieldsString+"
        if (export.equals("liste") || export.equals("browse")) {
            sql += " LIMIT " + (pageoffset * pageLimit) + ", " + pageLimit;
        }

        List<Map> rowlist = SucheDB.getMappedList(sql);

        // ########## LISTE/BROWSE ##########
        if (export.equals("liste") || export.equals("browse")) {
            String oldValue[] = new String[5];

            out.println("<table class=\"ut-table ut-table--striped ut-table--striped--color-primary-3\">");
            out.println("<tbody class=\"ut-table__body\">");
            out.println("<tr class=\"ut-table__row\">");
            for (int i = 0; i < headlines.size(); i++) {
                out.println("<th class=\"ut-table__item ut-table__header__item\" scope=\"col\">");
                // Link für Seite erzeugen
                String direction = "";
                if (order.contains(fieldNames.get(i))) {
                    direction = order.substring(order.indexOf(fieldNames.get(i) + " ") + fieldNames.get(i).length() + 1, min(order.length(), order.indexOf(fieldNames.get(i) + " ") + fieldNames.get(i).length() + 5));
                    if (direction.contains("DESC")) {
                        direction = "DESC";
                    } else {
                        direction = "ASC";
                    }
                }

                String parameter = "?neworder=" + fieldNames.get(i);
                if (direction.equals("ASC")) {
                    parameter += "&newdirection=DESC";
                } else {
                    parameter += "&newdirection=ASC";
                }

                for (Enumeration<String> e = request.getParameterNames(); e.hasMoreElements();) {
                    String paramName = e.nextElement();
                    if (!paramName.contains("order") && !paramName.equals("newdirection")) {
                        parameter += "&" + paramName + "=" + urlEncode(request.getParameter(paramName));
                    }
                }

                out.print("<a class=\"ut-link\" href=\"" + parameter + "\">");
                out.print(headlines.get(i));
                if (direction.equals("ASC")) {
                    out.print("<img src='layout/icons/arrowup.gif'>");
                } else if (direction.equals("DESC")) {
                    out.print("<img src='layout/icons/arrowdown.gif'>");
                }
                out.println("</a>");
                out.println("</th>");
            }

            for (Map<String, String> row : rowlist) {

                out.println("<tr class=\"ut-table__row\">");
                if (!formular.equals("favorit") && !formular.equals("freie_suche") && !formular.equals("mgh_lemma") && !formular.equals("namenkommentar") && !formular.equals("literatur")) {
                    out.println("<td class=\"ut-table__item ut-table__body__item\" valign=\"top\" align=\"center\"><a class=\"ut-link\" href=\"" + formular + ".jsp?ID=" + row.get(formular + ".ID").toString() + "\">Gehe zu</a></td>");
                }

                for (int i = 0; i < fieldNames.size(); i++) {
                    out.println("<td class=\"ut-table__item ut-table__body__item\" valign=\"top\">");
                    String fieldName = fieldNames.get(i);
                    String fieldAlias = QueryHelper.getFieldAliasResult(fieldName);
                    if (row.get(fieldAlias) != null && !String.valueOf(row.get(fieldAlias)).equals("")) {
                        String fieldValue = String.valueOf(row.get(fieldAlias));
                        String cell = DBtoHTML(fieldValue);
                        if (export.equals("browse")) {
                            boolean link = false;
                            if (fieldName.contains("einzelbeleg.Belegform") && row.get(QueryHelper.getFieldAliasResult("einzelbeleg.ID")) != null) {
                                out.print("<a class=\"ut-link\" href=\"einzelbeleg?ID=" + String.valueOf(row.get(QueryHelper.getFieldAliasResult("einzelbeleg.ID"))) + "\">");
                                link = true;
                            } else if (fieldName.contains("person.Standardname") && row.get(QueryHelper.getFieldAliasResult("person.ID")) != null) {
                                out.print("<a class=\"ut-link\" href=\"person?ID=" + String.valueOf(row.get(QueryHelper.getFieldAliasResult("person.ID"))) + "\">");
                                link = true;
                            } else if (fieldName.contains("perszu.Standardname") && row.get(QueryHelper.getFieldAliasResult("perszu.ID")) != null) {
                                out.print("<a class=\"ut-link\" href=\"person?ID=" + String.valueOf(row.get(QueryHelper.getFieldAliasResult("perszu.ID"))) + "\">");
                                link = true;
                            } else if (fieldName.contains("namenkommentar.PLemma") && row.get(QueryHelper.getFieldAliasResult("namenkommentar.ID")) != null) {
                                out.print("<a class=\"ut-link\" href=\"namenkommentar?ID=" + String.valueOf(row.get(QueryHelper.getFieldAliasResult("namenkommentar.ID"))) + "\">");
                                link = true;
                            } else if (fieldName.contains("quelle.Bezeichnung") && row.get(QueryHelper.getFieldAliasResult("quelle.ID")) != null) {
                                out.print("<a class=\"ut-link\" href=\"quelle?ID=" + String.valueOf(row.get(QueryHelper.getFieldAliasResult("quelle.ID"))) + "\">");
                                link = true;
                            } else if (fieldName.contains("edition.Titel") && row.get(QueryHelper.getFieldAliasResult("edition.ID")) != null) {
                                try {
                                    out.print("<a class=\"ut-link\" href=\"edition?ID=" + String.valueOf(row.get(QueryHelper.getFieldAliasResult("edition.ID"))) + "\">");
                                    link = true;
                                } catch (Exception e) {
                                    link = false;
                                }
                            } else if (fieldName.contains("ID")) {
                                out.println("<a class=\"ut-link\" href=\"" + formular + ".jsp?ID=" + row.get(formular + ".ID").toString() + "\">Gehe zu: ");
                                link = true;
                            }
                            out.print(cell);
                            if (link) {
                                out.println("</a>");
                            }
                        } else {
                            out.println(cell);
                        }
                    } else {
                        out.println("&nbsp;");
                    }
                    out.println("</td>");
                }
                out.println("</tr>");
            }
            out.println("</tr>");
            out.println("</tbody>");
            out.println("</table>");
        }
        // ########## LISTE/BROWSE #########

        // ########## EXCEL #########
        if (export.equals("excel")) {
            PrintWriter excel = new PrintWriter(new FileWriter(this.getServletContext().getRealPath("/") + "print\\output_" + session.getAttribute("Benutzername") + ".csv"));
            for (int i = 0; i < headlines.size(); i++) {
                excel.print("\"" + headlines.get(i) + "\";");
            }
            excel.println();
            for (Map<String, String> row : rowlist) {
                for (int i = 0; i < fieldNames.size(); i++) {
                    if (row.get(fieldNames.get(i)) == null || row.get(fieldNames.get(i)).toString().equals("null")) {
                        excel.print("\"\";");
                    } else {
                        excel.print("\"" + row.get(fieldNames.get(i)).toString() + "\";");
                    }
                }
                excel.println();
            }
            excel.close();
            out.println("<a  class=\"ut-link\" href='../../print/output_" + session.getAttribute("Benutzername") + ".csv'>herunterladen</a>");
        }
        // ########## EXCEL #########

        // ########## SEITENNAVIGATION #########
        if (export.equals("liste") || export.equals("browse")) {
            out.println("<p class=\"resultlistnavigation\" align=\"center\">");
            int pages = (linecount / pageLimit) + 1;
            for (int i = 0; i < pages; i++) {
                // Link für Seite erzeugen
                String parameter = "?pageoffset=" + i;
                for (Enumeration<String> e = request.getParameterNames(); e.hasMoreElements();) {
                    String paramName = e.nextElement();
                    if (!paramName.equals("pageoffset")) {
                        parameter += "&" + paramName + "=" + urlEncode(request.getParameter(paramName));
                    }
                }

                // Link zur ersten Seite anzeigen falls nötig
                if (i == 0 && i <= pageoffset - 10) {
                    out.println("<a class=\"ut-link\" href=\"" + parameter + "\">" + (i + 1) + "</a>&nbsp;...&nbsp;");
                }

                // gelinkte Seitennummer anzeigen
                if (i < pageoffset + 10 && i > pageoffset - 10) {
                    if (i == pageoffset) {
                        out.println("<b>");
                    }
                    out.println("<a class=\"ut-link\" href=\"" + parameter + "\">" + (i + 1) + "</a>&nbsp;");
                    if (i == pageoffset) {
                        out.println("</b>");
                    }
                }
                // Link zur letzten Seite anzeigen falls nÃ¶tig
                if (i == pages - 1 && i >= pageoffset + 10) {
                    out.println("...&nbsp;<a class=\"ut-link\" href=\"" + parameter + "\">" + (i + 1) + "</a>&nbsp;");
                }
            }
            out.println("</p>");
        }
        // ########## SEITENNAVIGATION #########
    }
%>
