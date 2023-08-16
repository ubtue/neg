<%@ page import="de.uni_tuebingen.ub.nppm.db.*" isThreadSafe="false" %>
<%@ page import="java.util.ArrayList" isThreadSafe="false" %>
<%@ page import="java.util.List" isThreadSafe="false" %>
<%@ page import="java.util.Map" isThreadSafe="false" %>

<%
    if (feldtyp.equals("combined") && array) {
        int count = 0;
        out.println("<table " + (isReadOnly ? "width=\"100%\"" : "") + ">\n");
        out.println("<tr>\n");
        for (int i = 0; i < combinedAnzeigenamen.length; i++) {
            out.println("<th>");
            if (!isReadOnly || combinedFeldtypen[i].equals("sqlselect")
                    || combinedFeldtypen[i].equals("select")
                    || combinedFeldtypen[i].equals("textfield")
                    || combinedFeldtypen[i].equals("textarea")
                    || combinedFeldtypen[i].contains("link")
                    || combinedFeldtypen[i].contains("info")
                    || combinedFeldtypen[i].contains("list")) {
                out.println(combinedAnzeigenamen[i] + "\n");
            }
            out.println("</th>");
        }
        out.println("</tr>\n");

        String[] zielattributArray = zielAttribut.split(";");
        for (int i = 0; i < zielattributArray.length; i++) {
            zielattributArray[i] = zielattributArray[i].trim();
        }

        if (auswahlherkunft == null) {
            auswahlherkunft = "";
        }
        String[] auswahlherkunftArray = auswahlherkunft.split(";");
        for (int i = 0; i < auswahlherkunftArray.length; i++) {
            auswahlherkunftArray[i] = auswahlherkunftArray[i].trim();
        }

        List<Map> rowlist = AbstractBase.getMappedList("SELECT * FROM " + zielTabelle
                + " WHERE " + formularAttribut + "=\"" + id + "\"");

        boolean alreadyOne = false;
        int i = 0;
        for (Map row : rowlist) {
            out.println("<input type=\"hidden\" name=\""
                    + datenfeld.toLowerCase() + "[" + i
                    + "]_entryid\" value=\"" + row.get("ID").toString()
                    + "\">");
            alreadyOne = true;

            count++;
            if (count % 2 == 0) {
                out.println("<tr>");
            } else {
                out.println("<tr bgcolor='#AACCDD'>");
            }

            for (int j = 0; j < combinedFeldtypen.length; j++) {
                if (combinedFeldtypen[j].equals("dateinfo")
                        || combinedFeldtypen[j].equals("addselect")) {
                    out.println("<td nowrap>");
                } else {
                    out.println("<td>");
                }

                if (combinedFeldtypen[j].equals("textfield")) {
                    if (!isReadOnly) {
                        out.println("<input name=\""
                                + combinedFeldnamen[j]
                                + "["
                                + i
                                + "]\""
                                + " value=\""
                                + (row.get(zielattributArray[j]) != null ? DBtoHTML(row
                                .get(zielattributArray[j]).toString())
                                : "")
                                + "\""
                                + " maxlength=\""
                                + AbstractBase.getMaxCharacterLength(zielTabelle, zielattributArray[j])
                                + "\" "
                                + (combinedFeldnamen[j]
                                        .endsWith("ID") ? " size=\"5\""
                                : " size=\"10\"")
                                + " />");
                    } else {
                        out.println(row
                                .get(zielattributArray[j]) != null ? DBtoHTML(row
                                .get(zielattributArray[j]).toString())
                                : (alreadyOne ? "" : "-"));
                    }
                } else if (combinedFeldtypen[j].equals("textarea")) {
                    if (!isReadOnly) {
                        out.println("<textarea name=\"" + combinedFeldnamen[j]
                                + "["
                                + i
                                + "]\"" + disabled + ">"
                                + (row.get(zielattributArray[j]) != null ? DBtoHTML(row
                                .get(zielattributArray[j]).toString())
                                : "")
                                + "</textarea>");
                    } else {
                        out.println((row
                                .get(zielattributArray[j]) != null ? DBtoHTML(row
                                .get(zielattributArray[j]).toString())
                                : (alreadyOne ? "" : "-")));
                    }
                } else if (combinedFeldtypen[j].equals("addselect")) {
                    int selected = (row.get(zielattributArray[j]) != null ? Integer.parseInt(row
                            .get(zielattributArray[j]).toString())
                            : -1);
                    out.println("<select name=\""
                            + combinedFeldnamen[j] + "[" + i
                            + "]\" id=\"" + combinedFeldnamen[j]
                            + "[" + i + "]\" style=\"width:6em\">");

                    List<Map> rowlist2 = AbstractBase.getMappedList("SELECT * FROM "
                            + auswahlherkunftArray[j]
                            + " ORDER BY Bezeichnung ASC");
                    for (Map row2 : rowlist2) {
                        out.println("<option value=\""
                                + row2.get("ID").toString()
                                + "\" "
                                + (Integer.parseInt(row2.get("ID").toString()) == selected ? "selected"
                                : "")
                                + ">"
                                + DBtoHTML(row2
                                        .get("Bezeichnung").toString())
                                + "</option>");
                    }
                    out.print("</select>");
                    out.println("<a href=\"javascript:popup('addselect', this, '"
                            + auswahlherkunftArray[j]
                                    .substring(10)
                            + "', '"
                            + combinedFeldnamen[j]
                            + "["
                            + i
                            + "]', '');\">"
                            + txt_newentry + "</a>");

                } else if (combinedFeldtypen[j].equals("addselectandtext")) {

                    out.println("<select name=\""
                            + combinedFeldnamen[j] + "[" + i
                            + "]\" id=\""
                            + combinedFeldnamen[j] + "[" + i
                            + "]\" style=\"width:6em\">");

                    List<Map> rowlist2 = AbstractBase.getMappedList(
                            "SELECT * FROM "
                            + auswahlherkunftArray[j]
                            + " ORDER BY Bezeichnung ASC");
                    for (Map row2 : rowlist2) {
                        out.println("<option value=\""
                                + row2.get("ID").toString()
                                + "\""
                                + (Integer.parseInt(row2.get("ID").toString()) == -1 ? "selected"
                                : "")
                                + ">"
                                + DBtoHTML(row2.get("Bezeichnung").toString())
                                + "</option>");
                    }
                    out.print("</select>");
                    out.println("<a href=\"javascript:popup('addselect', this, '"
                            + auswahlherkunftArray[j]
                                    .substring(10)
                            + "', '"
                            + combinedFeldnamen[j]
                            + "["
                            + i
                            + "]', '');\">"
                            + txt_newentry + "</a>");

                } else if (combinedFeldtypen[j].equals("select")) {
                    if (!isReadOnly) {
                        out.println("<select name=\""
                                + combinedFeldnamen[j] + "[" + i
                                + "]\" style=\"width:8em\">");
                    }

                    List<Map> rowlist2 = AbstractBase.getMappedList(
                            "SELECT * FROM "
                            + auswahlherkunftArray[j]
                            + " ORDER BY Bezeichnung ASC");
                    int selected = (row.get(zielattributArray[j]) != null ? Integer.parseInt(row
                            .get(zielattributArray[j]).toString())
                            : -1);
                    for (Map row2 : rowlist2) {
                        if (!isReadOnly) {
                            out
                                    .println("<option value='"
                                            + row2.get("ID").toString()
                                            + "' "
                                            + (Integer.parseInt(row2.get("ID").toString()) == selected ? "selected"
                                            : "")
                                            + ">"
                                            + row2.get("Bezeichnung").toString()
                                            + "</option>");
                        } else if (Integer.parseInt(row2.get("ID").toString()) == selected) {
                            if (!alreadyOne) {
                                out.println("-");
                            }
                        }
                    }

                    if (!isReadOnly) {
                        out.println("</select>");
                    }
                } else if (combinedFeldtypen[j].equals("subtable")) {
                    out.println("<table>");
                    String sql = "SELECT edition.ID, edition.Zitierweise Bezeichnung FROM quelle_inedition, edition WHERE quelle_inedition.QuelleID=  "
                            + row.get("QuelleID").toString()
                            + " AND quelle_inedition.editionID=edition.ID ORDER BY Bezeichnung ASC";

                    List<Map> rowlist2 = AbstractBase.getMappedList(sql);

                    int i2 = 0;

                    for (Map row2 : rowlist2) {
                        Map row3 = AbstractBase.getMappedRow("SELECT Sigle FROM ueberlieferung_edition WHERE ueberlieferung_edition.editionID="
                                + row2.get("ID").toString()
                                + " AND ueberlieferung_edition.ueberlieferungID="
                                + row.get("ID").toString());

                        out.println("<tr><td><a href=\"edition?ID="
                                + row2.get("ID").toString()
                                + "\">"
                                + row2.get("Bezeichnung").toString()
                                + "</a><input type=\"hidden\" name=\""
                                + combinedFeldnamen[j]
                                + "_ed["
                                + i
                                + "]["
                                + i2
                                + "]\""
                                + " value=\""
                                + row2.get("ID").toString()
                                + "\"/></td><td><input name=\""
                                + combinedFeldnamen[j]
                                + "["
                                + i
                                + "]["
                                + i2
                                + "]\""
                                + " value=\""
                                + DBtoHTML(row3 != null ? row3.get("Sigle").toString() : "")
                                        + "\""
                                        + " maxlength=\""
                                        + "\" "
                                        + (combinedFeldnamen[j]
                                                .endsWith("ID") ? " size=\"5\""
                                        : " size=\"10\"")
                                        + " /></td></tr>");
                        i2++;
                    }

                    out.println("</table>");
                } else if (combinedFeldtypen[j].equals("checkbox")) {
                    if (!isReadOnly) {
                        out.println("<input name=\""
                                + combinedFeldnamen[j]
                                + "["
                                + i
                                + "]\""
                                + " type=\"checkbox\""
                                + (Integer.parseInt(row.get(zielattributArray[j]).toString()) == 1 ? " checked"
                                : "") + " />");
                    }

                } else if (combinedFeldtypen[j].equals("sqlselect")) {
                    String sql = "";

                    if (!isReadOnly) {
                        out.println("<select name=\""
                                + combinedFeldnamen[j] + "[" + i
                                + "]\" style=\"width:8em\">");
                    }

                    if (combinedFeldnamen[j].equals("TKHandschrift") && row.get("EditionID") != null) {
                        sql = "SELECT handschrift_ueberlieferung.ID, ueberlieferung_edition.Sigle Bezeichnung FROM handschrift_ueberlieferung, einzelbeleg, ueberlieferung_edition WHERE handschrift_ueberlieferung.ID=ueberlieferung_edition.UeberlieferungID and ueberlieferung_edition.EditionID= "
                                + row.get("EditionID").toString()
                                + " AND handschrift_ueberlieferung.QuelleID=einzelbeleg.QuelleID AND einzelbeleg.ID="
                                + id
                                + " ORDER BY Bezeichnung ASC";
                    }
                    if (combinedFeldnamen[j]
                            .equals("TKEditionID")) {
                        sql = "SELECT edition.ID, edition.Zitierweise Bezeichnung FROM quelle_inedition, edition, einzelbeleg WHERE quelle_inedition.QuelleID = einzelbeleg.QuelleID AND quelle_inedition.editionID=edition.ID AND einzelbeleg.ID = "
                                + id
                                + " ORDER BY Bezeichnung ASC";
                    }
                    if (combinedFeldnamen[j].equals("HSEditionID") && row.get("QuelleID") != null) {
                        sql = "SELECT edition.ID, edition.Titel Bezeichnung FROM quelle_inedition, edition WHERE quelle_inedition.QuelleID=  "
                                + row.get("QuelleID").toString()
                                + " AND quelle_inedition.editionID=edition.ID ORDER BY Bezeichnung ASC";
                    }

                    List<Map> rowlist2 = new ArrayList<Map>();
                    if (!sql.equals("")) {
                        rowlist2 = AbstractBase.getMappedList(sql);
                    }
                    int selected = (row.get(zielattributArray[j]) != null ? Integer.parseInt(row
                            .get(zielattributArray[j]).toString())
                            : -1);
                    //Map stores the options fields of a select form
                    //key: the value of the option
                    //value: selected attribute of the option
                    Map<Integer, String> selectForm = new HashMap<Integer, String>();
                    //init
                    selectForm.put(0, "");
                    selectForm.put(-1, "");
                    //assign
                    if (selected == 0) {
                        selectForm.put(0, "selected");
                    } else if (selected == -1) {
                        selectForm.put(-1, "selected");
                    }

                    if (!isReadOnly) {
                        out.println("<option value=\"NULL\" " + selectForm.get(-1) + ">nicht bearbeitet</option>");
                    }
                    //if (!sql.equals("")) {
                    for (Map row2 : rowlist2) {
                        if (!isReadOnly) {
                            out.println("<option value='"
                                    + row2.get("ID").toString()
                                    + "' "
                                    + (Integer.parseInt(row2.get("ID").toString()) == selected ? "selected"
                                    : "")
                                    + ">"
                                    + row2.get("Bezeichnung").toString()
                                    + "</option>");
                        } else if (Integer.parseInt(row2.get("ID").toString()) == selected
                                && combinedFeldnamen[j].equals("TKHandschrift")) {
                            out.println(row2.get("Bezeichnung").toString());
                        }
                    }
                    //}

                    out.println("</select>");
                } else if (combinedFeldtypen[j].equals("checkbox")) {
                    if (!isReadOnly) {
                        out.println("<input name=\""
                                + combinedFeldnamen[j]
                                + "["
                                + i
                                + "]\""
                                + " type=\"checkbox\""
                                + ((Integer.parseInt(row.get(zielattributArray[j]).toString()) == 1) ? " checked"
                                : "") + " />");
                    }
                } else if (combinedFeldtypen[j].startsWith("link")) {
                    String[] fields = combinedFeldtypen[j]
                            .substring(
                                    combinedFeldtypen[j]
                                            .lastIndexOf('(') + 1,
                                    combinedFeldtypen[j]
                                            .lastIndexOf(')'))
                            .split(",");

                    Map row2 = null;
                    if (row.get(fields[1]) != null)
                        row2 = AbstractBase.getMappedRow("SELECT "
                            + fields[2] + " FROM "
                            + fields[0] + " WHERE ID="
                            + row.get(fields[1]).toString());

                    if (row2 != null) {

                        String add = fields[0];
                        if (add.equals("mgh_lemma")) {
                            add = "mghlemma";
                        }

                        out.println("<a href=\""
                                + add
                                + "?ID="
                                + row.get(fields[1]).toString()
                                + "\">");
                        out.println(row2
                                .get(fields[2]) != null ? DBtoHTML(row2
                                .get(fields[2]).toString())
                                : "Zum Datensatz");
                        out.println("</a>");
                    }
                } else if (combinedFeldtypen[j].startsWith("info")) {
                    String[] fields = combinedFeldtypen[j]
                            .substring(
                                    combinedFeldtypen[j]
                                            .lastIndexOf('(') + 1,
                                    combinedFeldtypen[j]
                                            .lastIndexOf(')'))
                            .split(",");

                    Map row2 = AbstractBase.getMappedRow("SELECT "
                            + fields[2] + " FROM "
                            + fields[0] + " WHERE ID="
                            + row.get(fields[1]).toString());

                    if (row2 != null) {
                        out.println(row2
                                .get(fields[2]) != null ? DBtoHTML(row2
                                .get(fields[2]).toString())
                                : "");
                    }
                } else if (combinedFeldtypen[j].startsWith("list")) {
                    String[] fields = combinedFeldtypen[j]
                            .substring(
                                    combinedFeldtypen[j]
                                            .lastIndexOf('(') + 1,
                                    combinedFeldtypen[j]
                                            .lastIndexOf(')'))
                            .split(",");

                    List<Map> rowlist2 = AbstractBase.getMappedList("SELECT Bezeichnung FROM selektion_"
                            + fields[0] + " sel, einzelbeleg_hat" + fields[0] + " zt WHERE zt."
                            + fields[0] + "ID=sel.ID AND zt." + fields[1] + "="
                            + row.get(fields[1]).toString());
                    for (Map row2 : rowlist2) {
                        out.println((row2.get("Bezeichnung") != null ? DBtoHTML(row2.get("Bezeichnung").toString())
                                : ""));
                        out.println("<br>");
                    }

                } else if (combinedFeldtypen[j].startsWith("date(")) {
                    String[] fields = combinedFeldtypen[j]
                            .substring(
                                    combinedFeldtypen[j]
                                            .lastIndexOf('(') + 1,
                                    combinedFeldtypen[j]
                                            .lastIndexOf(')'))
                            .split(",");
                } else if (combinedFeldtypen[j].startsWith("search")) {
                    String[] fields = combinedFeldtypen[j]
                            .substring(
                                    combinedFeldtypen[j]
                                            .lastIndexOf('(') + 1,
                                    combinedFeldtypen[j]
                                            .lastIndexOf(')'))
                            .split(",");
                    if (!isReadOnly) {
                        out
                                .println("<a href=\"javascript:popup('search', this, '"
                                        + fields[0]
                                        + "', '"
                                        + fields[2]
                                        + "["
                                        + i
                                        + "]', '"
                                        + fields[1]
                                        + "');\">"
                                        + txt_search
                                        + "</a>");
                    }
                } else if (combinedFeldtypen[j].equals("dateinfo")) {

                    out.println("<label id=\"quelleDate["
                            + i
                            + "]\">"
                            + row.get(combinedFeldnamen[j]
                                    + "VonJahr").toString()
                            + "("
                            + row.get(combinedFeldnamen[j]
                                    + "VonJahrhundert").toString()
                            + ". Jhd)-"
                            + row.get(combinedFeldnamen[j]
                                    + "BisJahr").toString()
                            + "("
                            + row.get(combinedFeldnamen[j]
                                    + "BisJahrhundert").toString()
                            + ". Jhd)</label>");
                    out
                            .println("<a href=\"javascript:popup('changedate', this, '', 'quelleDate["
                                    + i
                                    + "]', '"
                                    + row.get("ID").toString()
                                    + "');\"><img src=\"layout/icons/calendar.gif\" border=0></a>");
                } else {
                    out.println("folgt!");
                }
                out.println("</td>");
            }
            if (!isReadOnly) {
                String href = "javascript:deleteEntry('"
                        + zielTabelle + "', '" + row.get("ID").toString()
                        + "', '" + returnpage + "', '" + id + "');";
                out.println("<td>");
                out.println("<a href=\"" + href + "\">");
                out.println(txt_delete);
                out.println("</a>");
                out.println("</td>");
            }
            /*      else{
                                        out.println("<td>");
                                        out.println("<input type=\"checkbox\" name=\"" + beschriftung + "Speichern\" value=\"1\">Hinzuf&uuml;gen<br>");
                                        out.println("</td>");
                                      }*/
            out.println("</tr>");
            i++;
        }
        out.println("</table>\n");
    }
%>
