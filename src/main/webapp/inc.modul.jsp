<%@page import="java.time.LocalDateTime"%>
<%@ page import="java.sql.*" isThreadSafe="false"%>
<%@ page import="java.sql.Date" isThreadSafe="false"%>
<%@ page import="java.sql.Time" isThreadSafe="false"%>

<%@ include file="configuration.jsp"%>
<%@ include file="functions.jsp"%>

<%    String id = request.getParameter("ID");
    String formular = request.getParameter("Formular");
    String modul = request.getParameter("Modul");

    if (formular.equals("einzelbeleg")) {
        //Gast: Einzelbeleg Katagorie/Bereich Textkritik (Edition, Sigle, Varianten, Datierung d. Textzeugen, Bemerkung)
        if (modul.equals("lesartenRO")) {

            out.println("<table class=\"content-table\" width=\"100%\">\n");
%>
<tr>
    <th><jsp:include page="inc.erzeugeBeschriftung.jsp">
            <jsp:param name="Formular" value="einzelbeleg" />
            <jsp:param name="Textfeld" value="Edition" />
        </jsp:include></th>
    <th><jsp:include page="inc.erzeugeBeschriftung.jsp">
            <jsp:param name="Formular" value="einzelbeleg" />
            <jsp:param name="Textfeld" value="Sigle" />
        </jsp:include></th>
    <th><jsp:include page="inc.erzeugeBeschriftung.jsp">
            <jsp:param name="Formular" value="einzelbeleg" />
            <jsp:param name="Textfeld" value="Varianten" />
        </jsp:include></th>
    <th><jsp:include page="inc.erzeugeBeschriftung.jsp">
            <jsp:param name="Formular" value="einzelbeleg" />
            <jsp:param name="Textfeld" value="DatierungTextzeuge" />
        </jsp:include></th>
    <th><jsp:include page="inc.erzeugeBeschriftung.jsp">
            <jsp:param name="Formular" value="einzelbeleg" />
            <jsp:param name="Textfeld" value="Bemerkung" />
        </jsp:include></th>
</tr>

<%
            try {

                List<Object[]> resultList = ModulIncDB.getListEinzelbelegTextkritik(id);

                int count = 0;
                for (Object[] row : resultList) {
                    count++;
                    if (count % 2 == 0) {
                        out.println("<tr>");
                    } else {
                        out.println("<tr bgcolor='#AACCDD'>");
                    }

                    String zitierweise = row[0] != null ? String.valueOf(row[0]) : "";
                    String sigle = row[1] != null ? String.valueOf(row[1]) : "";
                    String variante = row[2] != null ? String.valueOf(row[2]) : "";

                    String vonTag = row[3] != null ? String.valueOf(row[3]) : "";
                    String vonMonat = row[4] != null ? String.valueOf(row[4]) : "";
                    String vonJahr = row[5] != null ? String.valueOf(row[5]) : "";
                    String vonJhdt = row[6] != null ? String.valueOf(row[6]) : "";

                    String bisTag = row[7] != null ? String.valueOf(row[7]) : "";
                    String bisMonat = row[8] != null ? String.valueOf(row[8]) : "";
                    String bisJahr = row[9] != null ? String.valueOf(row[9]) : "";
                    String bisJhdt = row[10] != null ? String.valueOf(row[10]) : "";

                    String bemerkung = row[11] != null ? String.valueOf(row[11]) : "";

                    out.println("<td>" + zitierweise + "</td>");
                    out.println("<td>" + sigle + "</td>");
                    out.println("<td>" + variante + "</td>");

                    String von = "";

                    if (vonTag != null && !vonTag.equals("")
                            && !vonTag.equals("0")) {
                        von = vonTag + ".";
                    }
                    if (vonMonat != null && !vonMonat.equals("")
                            && !vonMonat.equals("0")) {
                        von = von + vonMonat + ".";
                    }
                    if (vonJahr != null && !vonJahr.equals("")
                            && !vonJahr.equals("0")) {
                        von = von + vonJahr;
                    }
                    if (von.equals("") && vonJhdt != null) {
                        von = vonJhdt;
                    }

                    if (!von.equals("") && !von.contains("J") && !von.equals("0")
                            && (vonTag == null || vonTag.equals("") || vonTag.equals("0"))
                            && (vonMonat == null || vonMonat.equals("") || vonMonat.equals("0"))
                            && (vonJahr == null || vonJahr.equals("") || vonJahr.equals("0"))) {
                        von = von + " Jh.";
                    }

                    String bis = "";

                    if (bisTag != null && !bisTag.equals("")
                            && !bisTag.equals("0")) {
                        bis = bisTag + ".";
                    }
                    if (bisMonat != null && !bisMonat.equals("")
                            && !bisMonat.equals("0")) {
                        bis = bis + bisMonat + ".";
                    }
                    if (bisJahr != null && !bisJahr.equals("")
                            && !bisJahr.equals("0")) {
                        bis = bis + bisJahr;
                    }
                    if (bis.equals("") && bisJhdt != null) {
                        bis = bisJhdt;
                    }

                    if (!bis.equals("") && !bis.contains("J") && !bis.equals("0")
                            && (bisTag == null || bisTag.equals("") || bisTag.equals("0"))
                            && (bisMonat == null || bisMonat.equals("") || bisMonat.equals("0"))
                            && (bisJahr == null || bisJahr.equals("") || bisJahr.equals("0"))) {
                        bis = bis + " Jh.";
                    }

                    if (!bis.equals(von) && !bis.equals("")) {
                        out.println("<td>" + von + " - " + bis + "</td>");
                    } else {
                        out.println("<td>" + von + "</td>");
                    }

                    out.println("<td>" + bemerkung + "</td>");
                    out.println("</tr>");

                }

            } catch (Exception e) {
                out.println(e);
            } finally {

            }
            out.println("</table>\n");
        }
    }

    if (formular.equals("person")) {
        //Backend: Personen, Feld Namen z.b Gudalandaz (zweite Zeile) Gōdalandaz
        if (modul.equals("namen")) {
            out.println("<tr><td>\n");

            try {
                // Abfrage der Anzahl der Kommentare
                int count = ModulIncDB.countNamenkommentar(id);

                out.print("<label>Name");
                if (count > 1) {
                    out.println("n");
                }
                out.println("</label></td><td>");

                // Abfrage der Namenkommentare
                List<Object[]> resultList = ModulIncDB.getListPersonNamenkommentarPlemma(id);

                // Schleife durch die Ergebnisse
                if (resultList != null && !resultList.isEmpty()) {
                    for (Object[] row : resultList) {
                        String plemma = String.valueOf(row[0]);
                        String plemmaID = String.valueOf(row[1]);

                        if (plemma != null && !plemma.isEmpty() && !plemma.equalsIgnoreCase("null")) {
                            out.println("<a href=\"namenkommentar?ID=" + plemmaID + "\">" + format(plemma, "PLemma") + "<br>");
                        }
                    }
                }

                out.println("</td></tr>");
            } catch (Exception e) {
                out.println(e);
            }

            out.println("</ul>\n");
        }

        //Gast: Personen, Katagorie/Bereich: Einzelbeleg (Beleg, Belegform, Datierung, Amt/Weihe, Stand, Kontext)
        if (modul.equals("nachweiseRO")) {
            out.println("<table \"width=100%\" id=\"einzelbelege\" class=\"content-table\">\n");
%>
<tr>
    <th><jsp:include page="inc.erzeugeBeschriftung.jsp">
            <jsp:param name="Formular" value="person" />
            <jsp:param name="Textfeld" value="Beleg" />
        </jsp:include></th>
    <th><jsp:include page="inc.erzeugeBeschriftung.jsp">
            <jsp:param name="Formular" value="person" />
            <jsp:param name="Textfeld" value="Belegform" />
        </jsp:include></th>
    <th><jsp:include page="inc.erzeugeBeschriftung.jsp">
            <jsp:param name="Formular" value="person" />
            <jsp:param name="Textfeld" value="Datierung" />
        </jsp:include></th>
    <th><jsp:include page="inc.erzeugeBeschriftung.jsp">
            <jsp:param name="Formular" value="person" />
            <jsp:param name="Textfeld" value="AmtWeihe" />
        </jsp:include></th>
    <th><jsp:include page="inc.erzeugeBeschriftung.jsp">
            <jsp:param name="Formular" value="person" />
            <jsp:param name="Textfeld" value="Stand" />
        </jsp:include></th>
    <th><jsp:include page="inc.erzeugeBeschriftung.jsp">
            <jsp:param name="Formular" value="person" />
            <jsp:param name="Textfeld" value="Kontext" />
        </jsp:include></th>
</tr>
<%
    try {

        List<Object[]> resultList = ModulIncDB.getListPersonenEinzelbelege(id);

        int count = 0;

        for (Object[] row : resultList) {
            count++;
            if (count % 2 == 0) {
                out.println("<tr>");
            } else {
                out.println("<tr bgcolor='#AACCDD'>");
            }

            String eId = String.valueOf(row[0]);
            String belegform = row[2] != null ? String.valueOf(row[2]) : "";

            out.println("<td><a href=\"einzelbeleg?ID="
                    + eId + "\">");
%>
<jsp:include page="inc.erzeugeBeschriftung.jsp">
    <jsp:param name="Formular" value="person" />
    <jsp:param name="Textfeld" value="BelegLink" />
</jsp:include>
<%
                out.println("</a></td>");
                out.println("<td>" + getBelegformExternalLinked(eId, belegform) + "</td>");

                String vonTag = row[3] != null ? String.valueOf(row[3]) : "";
                String vonMonat = row[4] != null ? String.valueOf(row[4]) : "";
                String vonJahr = row[5] != null ? String.valueOf(row[5]) : "";
                String vonJhdt = row[6] != null ? String.valueOf(row[6]) : "";
                String bisTag = row[7] != null ? String.valueOf(row[7]) : "";
                String bisMonat = row[8] != null ? String.valueOf(row[8]) : "";
                String bisJahr = row[9] != null ? String.valueOf(row[9]) : "";
                String bisJhdt = row[10] != null ? String.valueOf(row[10]) : "";

                String sewBezeichnung = row[11] != null ? String.valueOf(row[11]) : "";
                String ssBezeichnung = row[12] != null ? String.valueOf(row[12]) : "";
                String kontext = row[13] != null ? String.valueOf(row[13]) : "";

                String von = "";

                if (vonTag != null && !vonTag.equals("")
                        && !vonTag.equals("0")) {
                    von = vonTag + ".";
                }
                if (vonMonat != null && !vonMonat.equals("")
                        && !vonMonat.equals("0")) {
                    von = von + vonMonat + ".";
                }
                if (vonJahr != null && !vonJahr.equals("")
                        && !vonJahr.equals("0")) {
                    von = von + vonJahr;
                }
                if (von.equals("") && vonJhdt != null) {
                    von = vonJhdt;
                }

                if (!von.equals("") && !von.contains("J") && !von.equals("0")
                        && (vonTag == null || vonTag.equals("") || vonTag.equals("0"))
                        && (vonMonat == null || vonMonat.equals("") || vonMonat.equals("0"))
                        && (vonJahr == null || vonJahr.equals("") || vonJahr.equals("0"))) {
                    von = von + " Jh.";
                }

                String bis = "";

                if (bisTag != null && !bisTag.equals("")
                        && !bisTag.equals("0")) {
                    bis = bisTag + ".";
                }
                if (bisMonat != null && !bisMonat.equals("")
                        && !bisMonat.equals("0")) {
                    bis = bis + bisMonat + ".";
                }
                if (bisJahr != null && !bisJahr.equals("")
                        && !bisJahr.equals("0")) {
                    bis = bis + bisJahr;
                }
                if (bis.equals("") && bisJhdt != null) {
                    bis = bisJhdt;
                }

                if (!bis.equals("") && !bis.contains("J") && !bis.equals("0")
                        && (bisTag == null || bisTag.equals("") || bisTag.equals("0"))
                        && (bisMonat == null || bisMonat.equals("") || bisMonat.equals("0"))
                        && (bisJahr == null || bisJahr.equals("") || bisJahr.equals("0"))) {
                    bis = bis + " Jh.";
                }

                if (!bis.equals(von) && !bis.equals("")) {
                    out.println("<td>" + von + " - " + bis + "</td>");

                } else {
                    out.println("<td>" + von + "</td>");
                }

                if (sewBezeichnung == null || sewBezeichnung.equals("") || sewBezeichnung.equalsIgnoreCase("null")) {
                    out.println("<td>-</td>");
                } else {
                    out.println("<td>" + sewBezeichnung + "</td>");
                }

                if (ssBezeichnung == null || ssBezeichnung.equals("") || ssBezeichnung.equalsIgnoreCase("null")) {
                    out.println("<td>-</td>");
                } else {
                    out.println("<td>" + ssBezeichnung + "</td>");
                }

                if (kontext == null || kontext.equals("") || kontext.equalsIgnoreCase("null")) {
                    out.println("<td>-</td>");
                } else {
                    out.println("<td>" + kontext + "</td>");
                }

                out.println("</tr>");

            }//end for

        } catch (Exception e) {
            out.println(e);
        }
        out.println("</table>\n");
    }

    //Gast: Personen Katagorie/Feld Verwandte (Name d. person), Verwandschaftsgrade (z.b Gottfried, Vater)
    if (modul.equals("Verwandte")) {
        out.println("<table>\n");
%>
<tr>
    <th><jsp:include page="inc.erzeugeBeschriftung.jsp">
            <jsp:param name="Formular" value="gast_person" />
            <jsp:param name="Textfeld" value="PersonName" />
        </jsp:include></th>
    <th><jsp:include page="inc.erzeugeBeschriftung.jsp">
            <jsp:param name="Formular" value="gast_person" />
            <jsp:param name="Textfeld" value="Verwandtschaftsgrade" />
        </jsp:include></th>
</tr>
<%
            try {

                List<Object[]> resultList = ModulIncDB.getListPersonenVerwandte(id);

                boolean atLeastOne = false;

                for (Object[] row : resultList) {

                    String pId = row[0] != null ? String.valueOf(row[0]) : "";
                    String standardname = row[1] != null ? String.valueOf(row[1]) : "";
                    String bezeichnung = row[2] != null ? String.valueOf(row[2]) : "";

                    out.println("<tr>");
                    out.println("<td><a href=\"person?ID=" + pId + "\">" + standardname + "</a></td>");
                    out.println("<td>" + bezeichnung + "</td>");
                    out.println("</tr>");
                    atLeastOne = true;
                }//end for

                if (!atLeastOne) {
                    out.println("<tr>");
                    out.println("<td>-</td>");
                    out.println("<td>-</td>");
                    out.println("</tr>");
                }

            } catch (Exception e) {
                out.println(e);
            }

            out.println("</table>\n");
        }

    }

    if (formular.equals("edition")) {
        //Backend: Edition, Tab Überlieferung (Überlieferung, Signatur/Bezeichnung, Sigle, Datierung, Schriftheimat) [z.b E125]
        if (modul.equals("ueberlieferung")) {
            out.println("<table>\n");
%>
<tr>
    <th></th>
    <th><jsp:include page="inc.erzeugeBeschriftung.jsp">
            <jsp:param name="Formular" value="quelle" />
            <jsp:param name="Textfeld" value="Ueberlieferung" />
        </jsp:include></th>
    <th><jsp:include page="inc.erzeugeBeschriftung.jsp">
            <jsp:param name="Formular" value="quelle" />
            <jsp:param name="Textfeld" value="Signatur" />
        </jsp:include></th>
    <th><jsp:include page="inc.erzeugeBeschriftung.jsp">
            <jsp:param name="Formular" value="quelle" />
            <jsp:param name="Textfeld" value="Sigle" />
        </jsp:include></th>
    <th><jsp:include page="inc.erzeugeBeschriftung.jsp">
            <jsp:param name="Formular" value="quelle" />
            <jsp:param name="Textfeld" value="Datierung" />
        </jsp:include></th>
    <th><jsp:include page="inc.erzeugeBeschriftung.jsp">
            <jsp:param name="Formular" value="quelle" />
            <jsp:param name="Textfeld" value="Schriftheimat" />
        </jsp:include></th>
</tr>
<%
    try {

        List<Object[]> resultList = ModulIncDB.getListQuellenbezeichnungen(id);

        for (Object[] row : resultList) {

            String qId = String.valueOf(row[0]);
            String bezeichnung = String.valueOf(row[1]);

            List<Object[]> resultList_2 = ModulIncDB.getListQuellenInformationen(qId, id);

            out.println("<tr><td colspan=6>");
            out.println("Quelle: " + bezeichnung + "</td></tr>");

            for (Object[] row_2 : resultList_2) {

                String handschriftId = String.valueOf(row_2[0]);
                String bibliothekssignatur = row_2[1] != null ? String.valueOf(row_2[1]) : "";
                String sigel = row_2[3] != null ? String.valueOf(row_2[3]) : "";

                String vonTag = row_2[4] != null ? String.valueOf(row_2[4]) : "";
                String vonMonat = row_2[5] != null ? String.valueOf(row_2[5]) : "";
                String vonJahr = row_2[6] != null ? String.valueOf(row_2[6]) : "";
                String vonJhdt = row_2[7] != null ? String.valueOf(row_2[7]) : "";
                String bisTag = row_2[8] != null ? String.valueOf(row_2[8]) : "";
                String bisMonat = row_2[9] != null ? String.valueOf(row_2[9]) : "";
                String bisJahr = row_2[10] != null ? String.valueOf(row_2[10]) : "";
                String bisJhdt = row_2[11] != null ? String.valueOf(row_2[11]) : "";

                String bezeichnungOrt = row_2[12] != null ? String.valueOf(row_2[12]) : "";

                out.println("<tr>");
                out.println("<td>&nbsp;</td><td><a href=\"handschrift?ID=" + handschriftId + "\">");
%>
<jsp:include page="inc.erzeugeBeschriftung.jsp">
    <jsp:param name="Formular" value="quelle" />
    <jsp:param name="Textfeld" value="ZurHandschrift" />
</jsp:include>

<%
                        out.println("</a></td>");

                        out.println("<td>" + bibliothekssignatur + "</td>");

                        out.println("<td>" + sigel + "</td>");

                        String von = "";

                        if (vonTag != null && !vonTag.equals("")
                                && !vonTag.equals("0")) {
                            von = vonTag + ".";
                        }
                        if (vonMonat != null && !vonMonat.equals("")
                                && !vonMonat.equals("0")) {
                            von = von + vonMonat + ".";
                        }
                        if (vonJahr != null && !vonJahr.equals("")
                                && !vonJahr.equals("0")) {
                            von = von + vonJahr;
                        }
                        if (von.equals("") && vonJhdt != null) {
                            von = vonJhdt;
                        }

                        if (!von.equals("") && !von.contains("J") && !von.equals("0")
                                && (vonTag == null || vonTag.equals("") || vonTag.equals("0"))
                                && (vonMonat == null || vonMonat.equals("") || vonMonat.equals("0"))
                                && (vonJahr == null || vonJahr.equals("") || vonJahr.equals("0"))) {
                            von = von + " Jh.";
                        }

                        String bis = "";

                        if (bisTag != null && !bisTag.equals("")
                                && !bisTag.equals("0")) {
                            bis = bisTag + ".";
                        }
                        if (bisMonat != null && !bisMonat.equals("")
                                && !bisMonat.equals("0")) {
                            bis = bis + bisMonat + ".";
                        }
                        if (bisJahr != null && !bisJahr.equals("")
                                && !bisJahr.equals("0")) {
                            bis = bis + bisJahr;
                        }
                        if (bis.equals("") && bisJhdt != null) {
                            bis = bisJhdt;
                        }

                        if (!bis.equals("") && !bis.contains("J") && !bis.equals("0")
                                && (bisTag == null || bisTag.equals("") || bisTag.equals("0"))
                                && (bisMonat == null || bisMonat.equals("") || bisMonat.equals("0"))
                                && (bisJahr == null || bisJahr.equals("") || bisJahr.equals("0"))) {
                            bis = bis + " Jh.";
                        }

                        if (!bis.equals(von) && !bis.equals("")) {
                            out.println("<td>" + von + " - " + bis
                                    + "</td>");
                        } else {
                            out.println("<td>" + von + "</td>");
                        }

                        out.println("<td>" + bezeichnungOrt + "</td>");

                        out.println("</tr>");

                    } //end row_2
                } //end row

            } catch (Exception e) {
                out.println(e);
            }
            out.println("</table>\n");
        }
    }

    //Backend: Quellen --> Tab: Überlieferung (Uberlieferung, Signatur/Bezeichnung, Sigle, Datierung, Schriftheimat)
    if (formular.equals("quelle")) {
        if (modul.equals("ueberlieferung")) {
            out.println("<table>\n");
%>
<tr>
    <th></th>
    <th><jsp:include page="inc.erzeugeBeschriftung.jsp">
            <jsp:param name="Formular" value="quelle" />
            <jsp:param name="Textfeld" value="Ueberlieferung" />
        </jsp:include></th>
    <th><jsp:include page="inc.erzeugeBeschriftung.jsp">
            <jsp:param name="Formular" value="quelle" />
            <jsp:param name="Textfeld" value="Signatur" />
        </jsp:include></th>
    <th><jsp:include page="inc.erzeugeBeschriftung.jsp">
            <jsp:param name="Formular" value="quelle" />
            <jsp:param name="Textfeld" value="Sigle" />
        </jsp:include></th>
    <th><jsp:include page="inc.erzeugeBeschriftung.jsp">
            <jsp:param name="Formular" value="quelle" />
            <jsp:param name="Textfeld" value="Datierung" />
        </jsp:include></th>
    <th><jsp:include page="inc.erzeugeBeschriftung.jsp">
            <jsp:param name="Formular" value="quelle" />
            <jsp:param name="Textfeld" value="Schriftheimat" />
        </jsp:include></th>
</tr>
<%
    try {

        List<Object[]> resultList = ModulIncDB.getListQuelleEditionen(id);

        for (Object[] row : resultList) {

            String edId = String.valueOf(row[0]);
            String bez = String.valueOf(row[1]);

            List<Object[]> resultList_2 = ModulIncDB.getListQuelleSignaturen(edId, id);
            out.println("<tr><td colspan=6>");
%><jsp:include page="inc.erzeugeBeschriftung.jsp">
    <jsp:param name="Formular" value="quelle" />
    <jsp:param name="Textfeld" value="Edition" />
</jsp:include>
<%
    out.println(": " + bez + "</td></tr>");

    for (Object[] row_2 : resultList_2) {

        String handschriftId = String.valueOf(row_2[0]);
        String bibliothekssignatur = row_2[1] != null ? String.valueOf(row_2[1]) : "";
        String sigel = row_2[3] != null ? String.valueOf(row_2[3]) : "";

        String vonTag = row_2[4] != null ? String.valueOf(row_2[4]) : "";
        String vonMonat = row_2[5] != null ? String.valueOf(row_2[5]) : "";
        String vonJahr = row_2[6] != null ? String.valueOf(row_2[6]) : "";
        String vonJhdt = row_2[7] != null ? String.valueOf(row_2[7]) : "";

        String bisTag = row_2[8] != null ? String.valueOf(row_2[8]) : "";
        String bisMonat = row_2[9] != null ? String.valueOf(row_2[9]) : "";
        String bisJahr = row_2[10] != null ? String.valueOf(row_2[10]) : "";
        String bisJhdt = row_2[11] != null ? String.valueOf(row_2[11]) : "";

        String bezeichnung = row_2[12] != null ? String.valueOf(row_2[12]) : "";

        out.println("<tr>");
        out.println("<td>&nbsp;</td><td><a href=\"handschrift?ID=" + handschriftId + "\">");
%>

<jsp:include page="inc.erzeugeBeschriftung.jsp">
    <jsp:param name="Formular" value="quelle" />
    <jsp:param name="Textfeld" value="ZurHandschrift" />
</jsp:include>

<%
                    out.println("</a></td>");
                    out.println("<td>" + bibliothekssignatur + "</td>");
                    out.println("<td>" + sigel + "</td>");

                    String von = "";

                    if (vonTag != null && !vonTag.equals("")
                            && !vonTag.equals("0")) {
                        von = vonTag + ".";
                    }
                    if (vonMonat != null && !vonMonat.equals("")
                            && !vonMonat.equals("0")) {
                        von = von + vonMonat + ".";
                    }
                    if (vonJahr != null && !vonJahr.equals("")
                            && !vonJahr.equals("0")) {
                        von = von + vonJahr;
                    }
                    if (von.equals("") && vonJhdt != null) {
                        von = vonJhdt;
                    }

                    if (!von.equals("") && !von.contains("J") && !von.equals("0")
                            && (vonTag == null || vonTag.equals("") || vonTag.equals("0"))
                            && (vonMonat == null || vonMonat.equals("") || vonMonat.equals("0"))
                            && (vonJahr == null || vonJahr.equals("") || vonJahr.equals("0"))) {
                        von = von + " Jh.";
                    }

                    String bis = "";

                    if (bisTag != null && !bisTag.equals("")
                            && !bisTag.equals("0")) {
                        bis = bisTag + ".";
                    }
                    if (bisMonat != null && !bisMonat.equals("")
                            && !bisMonat.equals("0")) {
                        bis = bis + bisMonat + ".";
                    }
                    if (bisJahr != null && !bisJahr.equals("")
                            && !bisJahr.equals("0")) {
                        bis = bis + bisJahr;
                    }
                    if (bis.equals("") && bisJhdt != null) {
                        bis = bisJhdt;
                    }

                    if (!bis.equals("") && !bis.contains("J") && !bis.equals("0")
                            && (bisTag == null || bisTag.equals("") || bisTag.equals("0"))
                            && (bisMonat == null || bisMonat.equals("") || bisMonat.equals("0"))
                            && (bisJahr == null || bisJahr.equals("") || bisJahr.equals("0"))) {
                        bis = bis + " Jh.";
                    }

                    if (!bis.equals(von) && !bis.equals("")) {
                        out.println("<td>" + von + " - " + bis
                                + "</td>");
                    } else {
                        out.println("<td>" + von + "</td>");
                    }

                    out.println("<td>" + bezeichnung + "</td>");
                    out.println("</tr>");
                }
            }
        } catch (Exception e) {
            out.println(e);
        }
        out.println("</table>\n");
    }

//Gast:  Quellen --> Bereich/Katagorie Überlieferung
    if (modul.equals("ueberlieferungRO")) {
        out.println("<table id=\"ueberlieferung\" class=\"content-table\">\n");
%>
<tr>
    <th><jsp:include page="inc.erzeugeBeschriftung.jsp">
            <jsp:param name="Formular" value="quelle" />
            <jsp:param name="Textfeld" value="Signatur" />
        </jsp:include></th>
    <th><jsp:include page="inc.erzeugeBeschriftung.jsp">
            <jsp:param name="Formular" value="quelle" />
            <jsp:param name="Textfeld" value="Sigle" />
        </jsp:include></th>
    <th><jsp:include page="inc.erzeugeBeschriftung.jsp">
            <jsp:param name="Formular" value="quelle" />
            <jsp:param name="Textfeld" value="Datierung" />
        </jsp:include></th>
    <th><jsp:include page="inc.erzeugeBeschriftung.jsp">
            <jsp:param name="Formular" value="quelle" />
            <jsp:param name="Textfeld" value="Schriftheimat" />
        </jsp:include></th>
</tr>
<%
    try {

        List<Object[]> resultList = ModulIncDB.getListQuelleEditionen(id);

        for (Object[] row : resultList) {
            String edId = String.valueOf(row[0]);
            String bez = row[1] != null ? String.valueOf(row[1]) : "";

            List<Object[]> resultList_2 = ModulIncDB.getListGastQuelleSignaturen(edId, id);

            out.println("<tr><th colspan=4><b>");
%>
<jsp:include page="inc.erzeugeBeschriftung.jsp">
    <jsp:param name="Formular" value="quelle" />
    <jsp:param name="Textfeld" value="Edition" />
</jsp:include>

<%
                out.println(": " + bez + "</b></td></tr>");

                for (Object[] row_2 : resultList_2) {

                    String bibliothekssignatur = row_2[1] != null ? String.valueOf(row_2[1]) : "";
                    String sigel = row_2[3] != null ? String.valueOf(row_2[3]) : "";

                    String vonTag = row_2[10] != null ? String.valueOf(row_2[10]) : "";
                    String vonMonat = row_2[8] != null ? String.valueOf(row_2[8]) : "";
                    String vonJahr = row_2[6] != null ? String.valueOf(row_2[6]) : "";
                    String vonJhdt = row_2[4] != null ? String.valueOf(row_2[4]) : "";

                    String bisTag = row_2[11] != null ? String.valueOf(row_2[11]) : "";
                    String bisMonat = row_2[9] != null ? String.valueOf(row_2[9]) : "";
                    String bisJahr = row_2[7] != null ? String.valueOf(row_2[7]) : "";
                    String bisJhdt = row_2[5] != null ? String.valueOf(row_2[5]) : "";

                    String bezeichnung = row_2[12] != null ? String.valueOf(row_2[12]) : "";

                    out.println("<tr>");
                    out.println("<td>" + bibliothekssignatur + "</td>");
                    out.println("<td>" + sigel + "</td>");

                    String von = "";

                    if (vonTag != null && !vonTag.equals("")
                            && !vonTag.equals("0")) {
                        von = vonTag + ".";
                    }
                    if (vonMonat != null && !vonMonat.equals("")
                            && !vonMonat.equals("0")) {
                        von = von + vonMonat + ".";
                    }
                    if (vonJahr != null && !vonJahr.equals("")
                            && !vonJahr.equals("0")) {
                        von = von + vonJahr;
                    }
                    if (von.equals("") && vonJhdt != null) {
                        von = vonJhdt;
                    }

                    if (!von.equals("") && !von.contains("J") && !von.equals("0")
                            && (vonTag == null || vonTag.equals("") || vonTag.equals("0"))
                            && (vonMonat == null || vonMonat.equals("") || vonMonat.equals("0"))
                            && (vonJahr == null || vonJahr.equals("") || vonJahr.equals("0"))) {
                        von = von + " Jh.";
                    }

                    String bis = "";

                    if (bisTag != null && !bisTag.equals("")
                            && !bisTag.equals("0")) {
                        bis = bisTag + ".";
                    }
                    if (bisMonat != null && !bisMonat.equals("")
                            && !bisMonat.equals("0")) {
                        bis = bis + bisMonat + ".";
                    }
                    if (bisJahr != null && !bisJahr.equals("")
                            && !bisJahr.equals("0")) {
                        bis = bis + bisJahr;
                    }
                    if (bis.equals("") && bisJhdt != null) {
                        bis = bisJhdt;
                    }

                    if (!bis.equals("") && !bis.contains("J") && !bis.equals("0")
                            && (bisTag == null || bisTag.equals("") || bisTag.equals("0"))
                            && (bisMonat == null || bisMonat.equals("") || bisMonat.equals("0"))
                            && (bisJahr == null || bisJahr.equals("") || bisJahr.equals("0"))) {
                        bis = bis + " Jh.";
                    }

                    if (!bis.equals(von) && !bis.equals("")) {
                        out.println("<td>" + von + " - " + bis
                                + "</td>");
                    } else {
                        out.println("<td>" + von + "</td>");
                    }

                    out.println("<td>" + bezeichnung + "</td>");

                    out.println("</tr>");
                }
            }
        } catch (Exception e) {
            out.println(e);
        }
        out.println("</table>\n");
    }

    //Gast:  Quellen --> Bereich/Katagorie Standard Edition &n Weitere Editionen (Qeullen, Reihe, Bd., Ort, Jahr, Seiten, Herausgeber)
    if (modul.equals("edition")) {
        out.println("<table id=\"edition\">\n");
%>
<tbody  valign="bottom">

    <tr>
        <th class="date">&nbsp;</th>
        <th class="date"><jsp:include page="inc.erzeugeBeschriftung.jsp">
                <jsp:param name="Formular" value="quelle" />
                <jsp:param name="Textfeld" value="Titel" />
            </jsp:include></th>
        <th class="date"><jsp:include page="inc.erzeugeBeschriftung.jsp">
                <jsp:param name="Formular" value="quelle" />
                <jsp:param name="Textfeld" value="Reihe" />
            </jsp:include></th>
        <th class="date">Bd.</th>
        <th class="date"><jsp:include page="inc.erzeugeBeschriftung.jsp">
                <jsp:param name="Formular" value="quelle" />
                <jsp:param name="Textfeld" value="Ort" />
            </jsp:include></th>
        <th class="date"><jsp:include page="inc.erzeugeBeschriftung.jsp">
                <jsp:param name="Formular" value="quelle" />
                <jsp:param name="Textfeld" value="Jahr" />
            </jsp:include></th>
        <th class="date"><jsp:include page="inc.erzeugeBeschriftung.jsp">
                <jsp:param name="Formular" value="quelle" />
                <jsp:param name="Textfeld" value="Seiten" />
            </jsp:include></th>
        <th class="date">Nummer</th>
        <th class="date"><jsp:include page="inc.erzeugeBeschriftung.jsp">
                <jsp:param name="Formular" value="quelle" />
                <jsp:param name="Textfeld" value="Herausgeber" />
            </jsp:include></th>
    </tr>
    <%
        int count = 0;
        count++;
        if (count % 2 == 0) {
            out.println("<tr>");
        } else {
            out.println("<tr bgcolor='#AACCDD'>");
        }

    %>	<td><strong><jsp:include page="inc.erzeugeBeschriftung.jsp">
            <jsp:param name="Formular" value="quelle" />
            <jsp:param name="Textfeld" value="StandardEdition" />
        </jsp:include></strong></td>


<%    boolean firstEdition = true;
    boolean showNummer = false;

    try {

        List<Object[]> resultList = ModulIncDB.getListGastQuelleEditionen("1", id);

        for (Object[] row : resultList) {

            if (!firstEdition) {
                count++;
                if (count % 2 == 0) {
                    out.println("<tr>");
                } else {
                    out.println("<tr bgcolor='#AACCDD'>");
                }
                out.println("<td></td>");
            }
            firstEdition = false;

            String eId = row[0] != null ? String.valueOf(row[0]) : "-1";
            String titel = row[1] != null ? String.valueOf(row[1]) : "";
            String reihe = row[2] != null ? String.valueOf(row[2]) : "--";
            String band = row[3] != null ? String.valueOf(row[3]) : "--";
            String ort = row[4] != null ? String.valueOf(row[4]) : "--";
            String jahr = row[5] != null ? String.valueOf(row[5]) : "--";
            String qiSeiten = row[6] != null ? String.valueOf(row[6]) : row[7] != null ? String.valueOf(row[7]) : "--";
            String nummer = (row[8] != null && !String.valueOf(row[8]).trim().equals("")) ? String.valueOf(row[8]) : "--";

            out.println("<td>" + titel + "</td>");
            out.println("<td>" + DBtoHTML(reihe) + "</td>");
            out.println("<td>" + DBtoHTML(band) + "</td>");
            out.println("<td>" + DBtoHTML(ort) + "</td>");
            out.println("<td>" + DBtoHTML(jahr) + "</td>");
            out.println("<td>" + DBtoHTML(qiSeiten) + "</td>");
            out.println("<td>" + DBtoHTML(nummer) + "</td>");

            if (nummer != null && !nummer.trim().equals("")) {
                showNummer = true;
            }

            out.println("<td>");

            List<String> resultList_2 = ModulIncDB.getListGastQuelleEditionHerausgeber(eId);
            boolean first = true;

            for (String row_2 : resultList_2) {

                String bezeichnung = row_2 != null ? row_2 : "";

                if (!first) {
                    out.print(" / ");
                }
                out.print(bezeichnung);
                first = false;
            } //end for 2
            out.println("</td>");
            out.println("</tr>");
        } //end for 1

        if (firstEdition) {
            out.println("<td colspan=\"8\"></tr>");
        }
        count++;
        if (count % 2 == 0)
            out.println("<tr>");
        else
            out.println("<tr bgcolor='#AACCDD'>");
%>
<td><jsp:include page="inc.erzeugeBeschriftung.jsp">
        <jsp:param name="Formular" value="quelle" />
        <jsp:param name="Textfeld" value="WeitereEditionen" />
    </jsp:include>
</td>

<%
        firstEdition = true;

        List<Object[]> resultList_3 = ModulIncDB.getListGastQuelleEditionen("0", id);

        for (Object[] row_3 : resultList_3) {

            if (!firstEdition) {
                count++;
                if (count % 2 == 0) {
                    out.println("<tr>");
                } else {
                    out.println("<tr bgcolor='#AACCDD'>");
                }
                out.println("<td></td>");
            }
            firstEdition = false;

            String eId = row_3[0] != null ? String.valueOf(row_3[0]) : "-1";
            String titel = row_3[1] != null ? String.valueOf(row_3[1]) : "";
            String reihe = row_3[2] != null ? String.valueOf(row_3[2]) : "--";
            String band = row_3[3] != null ? String.valueOf(row_3[3]) : "--";
            String ort = row_3[4] != null ? String.valueOf(row_3[4]) : "--";
            String jahr = row_3[5] != null ? String.valueOf(row_3[5]) : "--";
            String qiSeiten = row_3[6] != null ? String.valueOf(row_3[6]) : row_3[7] != null ? String.valueOf(row_3[7]) : "--";
            String nummer = (row_3[8] != null && !String.valueOf(row_3[8]).trim().equals("")) ? String.valueOf(row_3[8]) : "--";

            out.println("<td>" + titel + "</td>");
            out.println("<td>" + DBtoHTML(reihe) + "</td>");
            out.println("<td>" + DBtoHTML(band) + "</td>");
            out.println("<td>" + DBtoHTML(ort) + "</td>");
            out.println("<td>" + DBtoHTML(jahr) + "</td>");
            out.println("<td>" + DBtoHTML(qiSeiten) + "</td>");
            out.println("<td>" + DBtoHTML(nummer) + "</td>");

            if (nummer != null && !nummer.trim().equals("")) {
                showNummer = true;
            }

            out.println("<td>");

            List<String> resultList_4 = ModulIncDB.getListGastQuelleEditionHerausgeber(eId);

            boolean first = true;

            for (String row_4 : resultList_4) {

                String bezeichnung = row_4 != null ? row_4 : "";

                if (!first) {
                    out.print(" / ");
                }
                out.print(bezeichnung);
                first = false;
            } //end for 4
            out.println("</td>");
            out.println("</tr>");
        } //end for 3

    } catch (Exception e) {
        out.println(e);
    }
    out.println("</tbody valign=\"bottom\">\n");
    out.println("</table>\n");
    if (!showNummer) {
%>
<script type="text/javascript">
    var rows = document.getElementById('edition').getElementsByTagName('tr');
    for (var i = 0; i < rows.length; i++) {
        if (rows[i].getElementsByTagName('th')[7])
            rows[i].getElementsByTagName('th')[7].style.display = 'none';
        if (rows[i].getElementsByTagName('td')[7])
            rows[i].getElementsByTagName('td')[7].style.display = 'none';
    }
</script>
<%	}
        }
    }

    //Backend: (mgh)lemma --> Tab Bearbeiter (Bearbeiter, Datum, Uhrzeit
    if (formular.equals("mgh_lemma")) {
        if (modul.equals("bearbeiter") || modul.equals("korrektor")) {
            out.println("<table>\n");
            out.print("<tr><th width=\"200\">");
            if (modul.equals("bearbeiter")) {
%>
<jsp:include page="inc.erzeugeBeschriftung.jsp">
    <jsp:param name="Formular" value="mgh_lemma" />
    <jsp:param name="Textfeld" value="Bearbeiter" />
</jsp:include>

<%
} else {
%>
<jsp:include page="inc.erzeugeBeschriftung.jsp">
    <jsp:param name="Formular" value="mgh_lemma" />
    <jsp:param name="Textfeld" value="Korrektor" />
</jsp:include>
<%
    }
%>
</th>
<th width="100"><jsp:include page="inc.erzeugeBeschriftung.jsp">
        <jsp:param name="Formular" value="mgh_lemma" />
        <jsp:param name="Textfeld" value="Datum" />
    </jsp:include></th>

<th width="100"><jsp:include page="inc.erzeugeBeschriftung.jsp">
        <jsp:param name="Formular" value="mgh_lemma" />
        <jsp:param name="Textfeld" value="Uhrzeit" />
    </jsp:include></th>
</tr>
<%
        try {

            List<Object[]> resultList = ModulIncDB.getListLemmaBearbeiterKorrektor(modul, id);

            for (Object[] row : resultList) {

                Date date = null;
                Time time = null;

                String nachname = String.valueOf(row[0]);
                String vorname = String.valueOf(row[1]);
                String zeitstempelString = String.valueOf(row[2]);                           //besser !!!

                Timestamp zeitstempel = Timestamp.valueOf(zeitstempelString);

                // LocalDateTime aus Timestamp holen
                LocalDateTime localDateTime = zeitstempel.toLocalDateTime();

                // Date und Time extrahieren
                date = Date.valueOf(localDateTime.toLocalDate());   // Nur Datum
                time = Time.valueOf(localDateTime.toLocalTime());   // Nur Uhrzeit

                out.println("<tr>");
                out.println("<td>" + DBtoHTML(nachname) + ", " + DBtoHTML(vorname) + "</td>");
                out.println("<td>" + (date == null ? "--" : date) + "</td>");
                out.println("<td>" + (time == null ? "--" : time) + "</td>");
                out.println("</tr>");
            }//end for
        } catch (Exception e) {
            out.println(e);
        }
        out.println("</table>\n");
    } //korrektor

    if (modul.equals("belege")) {
        out.println("<table>\n");
%>
<tr>
    <th><jsp:include page="inc.erzeugeBeschriftung.jsp">
            <jsp:param name="Formular" value="mgh_lemma" />
            <jsp:param name="Textfeld" value="Beleg" />
        </jsp:include></th>
    <th><jsp:include page="inc.erzeugeBeschriftung.jsp">
            <jsp:param name="Formular" value="mgh_lemma" />
            <jsp:param name="Textfeld" value="Belegform" />
        </jsp:include></th>
    <th><jsp:include page="inc.erzeugeBeschriftung.jsp">
            <jsp:param name="Formular" value="mgh_lemma" />
            <jsp:param name="Textfeld" value="Person" />
        </jsp:include></th>
    <th><jsp:include page="inc.erzeugeBeschriftung.jsp">
            <jsp:param name="Formular" value="mgh_lemma" />
            <jsp:param name="Textfeld" value="Standardname" />
        </jsp:include></th>
    <th><jsp:include page="inc.erzeugeBeschriftung.jsp">
            <jsp:param name="Formular" value="mgh_lemma" />
            <jsp:param name="Textfeld" value="Datierung" />
        </jsp:include></th>
</tr>
<%
    try {
        List<Object[]> resultList = ModulIncDB.getListNamenLemmaBelege("mghlemma", id);

        for (Object[] row : resultList) {

            String einzelbelegId = String.valueOf(row[0]);
            String einzelbelegBelegform = row[2] != null ? String.valueOf(row[2]) : "";
            String personId = String.valueOf(row[3]);
            String personPkz = row[4] != null ? String.valueOf(row[4]) : "";
            String standardname = row[5] != null ? String.valueOf(row[5]) : "";

            String vonTag = row[6] != null ? String.valueOf(row[6]) : "";
            String vonMonat = row[7] != null ? String.valueOf(row[7]) : "";
            String vonJahr = row[8] != null ? String.valueOf(row[8]) : "";
            String vonJhdt = row[9] != null ? String.valueOf(row[9]) : "";

            String bisTag = row[10] != null ? String.valueOf(row[10]) : "";
            String bisMonat = row[11] != null ? String.valueOf(row[11]) : "";
            String bisJahr = row[12] != null ? String.valueOf(row[12]) : "";
            String bisJhdt = row[13] != null ? String.valueOf(row[13]) : "";

            out.println("<tr>");
            out.println("<td><a href=\"einzelbeleg?ID=" + einzelbelegId + "\">");
%>
<jsp:include page="inc.erzeugeBeschriftung.jsp">
    <jsp:param name="Formular" value="mgh_lemma" />
    <jsp:param name="Textfeld" value="ZumBeleg" />
</jsp:include>

<%
    out.println("</a></td>");
    if (einzelbelegBelegform.equals("")) {
        out.println("<td> &nbsp; </td>");
    } else {
        out.println("<td>" + einzelbelegBelegform + "</td>");
    }

    out.println("<td>");

    if (personPkz.equals("")) {
        out.println("--");
    } else {
        out.println("<a href=\"person?ID=" + personId + "\">");
%>
<jsp:include page="inc.erzeugeBeschriftung.jsp">
    <jsp:param name="Formular" value="mgh_lemma" />
    <jsp:param name="Textfeld" value="ZurPerson" />
</jsp:include>
<%
                    }

                    out.println("</a></td>");

                    if (standardname.equals("")) {
                        out.println("<td>--</td>");
                    } else {
                        out.println("<td>" + DBtoHTML(standardname) + "</td>");
                    }

                    String von = "";

                    if (vonTag != null && !vonTag.equals("")
                            && !vonTag.equals("0")) {
                        von = vonTag + ".";
                    }
                    if (vonMonat != null && !vonMonat.equals("")
                            && !vonMonat.equals("0")) {
                        von = von + vonMonat + ".";
                    }
                    if (vonJahr != null && !vonJahr.equals("")
                            && !vonJahr.equals("0")) {
                        von = von + vonJahr;
                    }
                    if (von.equals("") && vonJhdt != null) {
                        von = vonJhdt;
                    }

                    if (!von.equals("") && !von.contains("J") && !von.equals("0")
                            && (vonTag == null || vonTag.equals("") || vonTag.equals("0"))
                            && (vonMonat == null || vonMonat.equals("") || vonMonat.equals("0"))
                            && (vonJahr == null || vonJahr.equals("") || vonJahr.equals("0"))) {
                        von = von + " Jh.";
                    }

                    String bis = "";

                    if (bisTag != null && !bisTag.equals("")
                            && !bisTag.equals("0")) {
                        bis = bisTag + ".";
                    }
                    if (bisMonat != null && !bisMonat.equals("")
                            && !bisMonat.equals("0")) {
                        bis = bis + bisMonat + ".";
                    }
                    if (bisJahr != null && !bisJahr.equals("")
                            && !bisJahr.equals("0")) {
                        bis = bis + bisJahr;
                    }
                    if (bis.equals("") && bisJhdt != null) {
                        bis = bisJhdt;
                    }

                    if (!bis.equals("") && !bis.contains("J") && !bis.equals("0")
                            && (bisTag == null || bisTag.equals("") || bisTag.equals("0"))
                            && (bisMonat == null || bisMonat.equals("") || bisMonat.equals("0"))
                            && (bisJahr == null || bisJahr.equals("") || bisJahr.equals("0"))) {
                        bis = bis + " Jh.";
                    }

                    if (!bis.equals(von) && !bis.equals("")) {
                        out.println("<td>" + von + " - " + bis
                                + "</td>");
                    } else {
                        out.println("<td>" + von + "</td>");
                    }

                    out.println("</tr>");
                }
            } catch (Exception e) {
                out.println(e);
            }

            out.println("</table>\n");
        }

    }//mgh-lemma

    if (formular.equals("namenkommentar")) {
        //Backend: Namen bzw. namenkommentar  Tab Bearbeiter (Bearbeiter, Datum Uhrzeit) z.b ( Team, NPPM , 2024-09-16, 9:57:21)
        if (modul.equals("bearbeiter") || modul.equals("korrektor")) {
            out.println("<table>\n");
            out.print("<tr><th width=\"200\">");
            if (modul.equals("bearbeiter")) {
%>
<jsp:include page="inc.erzeugeBeschriftung.jsp">
    <jsp:param name="Formular" value="namenkommentar" />
    <jsp:param name="Textfeld" value="Bearbeiter" />
</jsp:include>

<%
} else {
%>
<jsp:include page="inc.erzeugeBeschriftung.jsp">
    <jsp:param name="Formular" value="namenkommentar" />
    <jsp:param name="Textfeld" value="Korrektor" />
</jsp:include>
<%
    }
%>
</th>
<th width="100"><jsp:include page="inc.erzeugeBeschriftung.jsp">
        <jsp:param name="Formular" value="namenkommentar" />
        <jsp:param name="Textfeld" value="Datum" />
    </jsp:include></th>

<th width="100"><jsp:include page="inc.erzeugeBeschriftung.jsp">
        <jsp:param name="Formular" value="namenkommentar" />
        <jsp:param name="Textfeld" value="Uhrzeit" />
    </jsp:include></th>
</tr>
<%
        try {
            List<Object[]> resultList = ModulIncDB.getListNamenBearbeiterKorrektor(modul, id);

            for (Object[] row : resultList) {

                Date date = null;
                Time time = null;

                String nachname = String.valueOf(row[0]);
                String vorname = String.valueOf(row[1]);
                String zeitstempelString = String.valueOf(row[2]);                           //besser !!!

                Timestamp zeitstempel = Timestamp.valueOf(zeitstempelString);

                // LocalDateTime aus Timestamp holen
                LocalDateTime localDateTime = zeitstempel.toLocalDateTime();

                // Date und Time extrahieren
                date = Date.valueOf(localDateTime.toLocalDate());   // Nur Datum
                time = Time.valueOf(localDateTime.toLocalTime());   // Nur Uhrzeit

                out.println("<tr>");
                out.println("<td>" + DBtoHTML(nachname) + ", " + DBtoHTML(vorname) + "</td>");
                out.println("<td>" + (date == null ? "--" : date) + "</td>");
                out.println("<td>" + (time == null ? "--" : time) + "</td>");
                out.println("</tr>");
            }//end for
        } catch (Exception e) {
            out.println(e);
        }
        out.println("</table>\n");
    }

    //Backend: Namen (bzw. namenkommentar) Tab Belege (Beleg, Belegform, Person, Standardname, Datierung)
    if (modul.equals("belege")) {
        out.println("<table>\n");
%>
<tr>
    <th><jsp:include page="inc.erzeugeBeschriftung.jsp">
            <jsp:param name="Formular" value="namenkommentar" />
            <jsp:param name="Textfeld" value="Beleg" />
        </jsp:include></th>
    <th><jsp:include page="inc.erzeugeBeschriftung.jsp">
            <jsp:param name="Formular" value="namenkommentar" />
            <jsp:param name="Textfeld" value="Belegform" />
        </jsp:include></th>
    <th><jsp:include page="inc.erzeugeBeschriftung.jsp">
            <jsp:param name="Formular" value="namenkommentar" />
            <jsp:param name="Textfeld" value="Person" />
        </jsp:include></th>
    <th><jsp:include page="inc.erzeugeBeschriftung.jsp">
            <jsp:param name="Formular" value="namenkommentar" />
            <jsp:param name="Textfeld" value="Standardname" />
        </jsp:include></th>
    <th><jsp:include page="inc.erzeugeBeschriftung.jsp">
            <jsp:param name="Formular" value="namenkommentar" />
            <jsp:param name="Textfeld" value="Datierung" />
        </jsp:include></th>
</tr>
<%
    List<Object[]> resultList = ModulIncDB.getListNamenLemmaBelege("namenkommentar", id);

    for (Object[] row : resultList) {

        String einzelbelegId = String.valueOf(row[0]);
        String einzelbelegBelegform = row[2] != null ? String.valueOf(row[2]) : "";
        String personId = String.valueOf(row[3]);
        String personPkz = row[4] != null ? String.valueOf(row[4]) : "";
        String standardname = row[5] != null ? String.valueOf(row[5]) : "";

        String vonTag = row[6] != null ? String.valueOf(row[6]) : "";
        String vonMonat = row[7] != null ? String.valueOf(row[7]) : "";
        String vonJahr = row[8] != null ? String.valueOf(row[8]) : "";
        String vonJhdt = row[9] != null ? String.valueOf(row[9]) : "";

        String bisTag = row[10] != null ? String.valueOf(row[10]) : "";
        String bisMonat = row[11] != null ? String.valueOf(row[11]) : "";
        String bisJahr = row[12] != null ? String.valueOf(row[12]) : "";
        String bisJhdt = row[13] != null ? String.valueOf(row[13]) : "";

        out.println("<tr>");
        out.println("<td><a href=\"einzelbeleg?ID=" + einzelbelegId + "\">");

%>
<jsp:include page="inc.erzeugeBeschriftung.jsp">
    <jsp:param name="Formular" value="namenkommentar" />
    <jsp:param name="Textfeld" value="ZumBeleg" />
</jsp:include>

<%    out.println("</a></td>");
    if (einzelbelegBelegform.equals("")) {
        out.println("<td> &nbsp; </td>");
    } else {
        out.println("<td>" + einzelbelegBelegform + "</td>");
    }

    out.println("<td>");

    if (personPkz.equals("")) {
        out.println("--");
    } else {
        out.println("<a href=\"person?ID=" + personId + "\">");
%>
<jsp:include page="inc.erzeugeBeschriftung.jsp">
    <jsp:param name="Formular" value="namenkommentar" />
    <jsp:param name="Textfeld" value="ZurPerson" />
</jsp:include>
<%
                }

                out.println("</a></td>");

                if (standardname.equals("")) {
                    out.println("<td>--</td>");
                } else {
                    out.println("<td>" + DBtoHTML(standardname) + "</td>");
                }

                String von = "";

                if (vonTag != null && !vonTag.equals("")
                        && !vonTag.equals("0")) {
                    von = vonTag + ".";
                }
                if (vonMonat != null && !vonMonat.equals("")
                        && !vonMonat.equals("0")) {
                    von = von + vonMonat + ".";
                }
                if (vonJahr != null && !vonJahr.equals("")
                        && !vonJahr.equals("0")) {
                    von = von + vonJahr;
                }
                if (von.equals("") && vonJhdt != null) {
                    von = vonJhdt;
                }

                if (!von.equals("") && !von.contains("J") && !von.equals("0")
                        && (vonTag == null || vonTag.equals("") || vonTag.equals("0"))
                        && (vonMonat == null || vonMonat.equals("") || vonMonat.equals("0"))
                        && (vonJahr == null || vonJahr.equals("") || vonJahr.equals("0"))) {
                    von = von + " Jh.";
                }

                String bis = "";

                if (bisTag != null && !bisTag.equals("")
                        && !bisTag.equals("0")) {
                    bis = bisTag + ".";
                }
                if (bisMonat != null && !bisMonat.equals("")
                        && !bisMonat.equals("0")) {
                    bis = bis + bisMonat + ".";
                }
                if (bisJahr != null && !bisJahr.equals("")
                        && !bisJahr.equals("0")) {
                    bis = bis + bisJahr;
                }
                if (bis.equals("") && bisJhdt != null) {
                    bis = bisJhdt;
                }

                if (!bis.equals("") && !bis.contains("J") && !bis.equals("0")
                        && (bisTag == null || bisTag.equals("") || bisTag.equals("0"))
                        && (bisMonat == null || bisMonat.equals("") || bisMonat.equals("0"))
                        && (bisJahr == null || bisJahr.equals("") || bisJahr.equals("0"))) {
                    bis = bis + " Jh.";
                }

                if (!bis.equals(von) && !bis.equals("")) {
                    out.println("<td>" + von + " - " + bis
                            + "</td>");
                } else {
                    out.println("<td>" + von + "</td>");
                }
                out.println("</tr>");
            }
            out.println("</table>\n");
        }

        //backend: namenkommtar, Philologisches Lemma (...) z.b (Idwiniz)
        if (modul.equals("PLemma")) {
            try {
                List<String> plemmaList = ModulIncDB.getListPlemma(id);

                for (String plemma : plemmaList) {

                    String lemma = plemma;

                    out.println(format(lemma, "PLemma"));
                }

            } catch (Exception e) {
                out.println(e);
            }
        }
    }
%>
