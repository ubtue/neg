<%@ page import="de.uni_tuebingen.ub.nppm.db.AbstractBase" isThreadSafe="false"%>
<%@ page import="java.sql.*" isThreadSafe="false"%>
<%@ page import="java.sql.Date" isThreadSafe="false"%>
<%@ page import="java.sql.Time" isThreadSafe="false"%>
<%@ page import="java.util.List" isThreadSafe="false"%>
<%@ page import="java.util.Map" isThreadSafe="false"%>

<%@ include file="configuration.jsp"%>
<%@ include file="functions.jsp"%>

<%
	String id = request.getParameter("ID");
	String formular = request.getParameter("Formular");
	String modul = request.getParameter("Modul");

	if (formular.equals("einzelbeleg")) {
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

                        List<Map> rowlist = JoinedDB.getMappedList(
                            "SELECT ed.Zitierweise, ue.Sigle, et.Variante, h.VonTag,h.VonMonat,h.VonJahr,h.VonJahrhundert, h.BisTag,h.BisMonat,h.BisJahr,h.BisJahrhundert, et.Bemerkung from einzelbeleg_textkritik et, "
                            + "edition ed, handschrift_ueberlieferung h, ueberlieferung_edition ue, einzelbeleg e where "
                            + " h.ID=ue.UeberlieferungID AND et.HandschriftID=h.ID AND ue.EditionID=ed.ID AND "
                            + " h.QuelleID=e.QuelleID AND ed.ID=et.EditionID "
                            + " AND et.EinzelbelegID="
                            + id
                            + " AND e.ID=" + id);

                        int count = 0;
                        for (Map row : rowlist) {
                                count++;

                                if (count % 2 == 0)
                                    out.println("<tr>");
                                else
                                    out.println("<tr bgcolor='#AACCDD'>");

                                out.println("<td>" + row.get("ed.Zitierweise").toString()
                                                + "</td>");
                                String sigle = row.get("ue.Sigle").toString();

                                if (sigle == null)
                                        sigle = "";

                                out.println("<td>" + sigle + "</td>");
                                out.println("<td>" + row.get("et.Variante").toString()
                                                + "</td>");

                                String vonTag = row.get("h.VonTag").toString();
                                String vonMonat = row.get("h.VonMonat").toString();
                                String vonJahr = row.get("h.VonJahr").toString();
                                String vonJhdt = row.get("h.VonJahrhundert").toString();
                                String bisTag = row.get("h.BisTag").toString();
                                String bisMonat = row.get("h.BisMonat").toString();
                                String bisJahr = row.get("h.BisJahr").toString();
                                String bisJhdt = row.get("h.BisJahrhundert").toString();

                                String von = "";

                                if (vonTag != null && !vonTag.equals("")
                                                && !vonTag.equals("0"))
                                        von = vonTag + ".";
                                if (vonMonat != null && !vonMonat.equals("")
                                                && !vonMonat.equals("0"))
                                        von = von + vonMonat + ".";
                                if (vonJahr != null && !vonJahr.equals("")
                                                && !vonJahr.equals("0"))
                                        von = von + vonJahr;
                                if (von.equals("") && vonJhdt != null)
                                        von = vonJhdt;

                                String bis = "";

                                if (bisTag != null && !bisTag.equals("")
                                                && !bisTag.equals("0"))
                                        bis = bisTag + ".";
                                if (bisMonat != null && !bisMonat.equals("")
                                                && !bisMonat.equals("0"))
                                        bis = bis + bisMonat + ".";
                                if (bisJahr != null && !bisJahr.equals("")
                                                && !bisJahr.equals("0"))
                                        bis = bis + bisJahr;
                                if (bis.equals("") && bisJhdt != null)
                                        bis = bisJhdt;

                                if (!bis.equals(von) && !bis.equals(""))
                                        out.println("<td>" + von + " - " + bis
                                                        + "</td>");
                                else
                                        out.println("<td>" + von + "</td>");

                                String bem = row.get("et.Bemerkung").toString();

                                if (bem == null)
                                        bem = "";

                                out.println("<td>" + bem + "</td>");
                                out.println("</tr>");
                        }
                out.println("</table>\n");
            }
	}

	else if (formular.equals("person")) {
            if (modul.equals("namen")) {
                out.println("<tr><td>\n");

                    Integer count = JoinedDB.getIntNative("SELECT count(DISTINCT namenkommentar.ID) FROM einzelbeleg LEFT OUTER JOIN "+
                                    "einzelbeleg_hatperson ON "+
                                    "einzelbeleg.ID=einzelbeleg_hatperson.EinzelbelegID LEFT OUTER JOIN "+
                                    "person ON einzelbeleg_hatperson.PersonID=person.ID LEFT OUTER JOIN "+
                                    "einzelbeleg_hatnamenkommentar ON "+
                                    "einzelbeleg_hatnamenkommentar.EinzelbelegID=einzelbeleg.ID "+
                                    "LEFT OUTER JOIN namenkommentar ON "+
                                    "namenkommentar.ID=einzelbeleg_hatnamenkommentar.NamenkommentarID WHERE person.ID=\""
                                                    + id + "\"");
                    out.print("<label>Name");
                    if(count != null && count > 1) out.println("n");
                    out.println("</label></td><td>");

                    List<Map> rowlist = JoinedDB.getMappedList(
                        "SELECT DISTINCT namenkommentar.PLemma, "+
                        "namenkommentar.ID FROM einzelbeleg LEFT OUTER JOIN "+
                        "einzelbeleg_hatperson ON "+
                        "einzelbeleg.ID=einzelbeleg_hatperson.EinzelbelegID LEFT OUTER JOIN "+
                        "person ON einzelbeleg_hatperson.PersonID=person.ID LEFT OUTER JOIN "+
                        "einzelbeleg_hatnamenkommentar ON "+
                        "einzelbeleg_hatnamenkommentar.EinzelbelegID=einzelbeleg.ID "+
                        "LEFT OUTER JOIN namenkommentar ON "+
                        "namenkommentar.ID=einzelbeleg_hatnamenkommentar.NamenkommentarID WHERE person.ID=\""
                                        + id + "\"");
                    for (Map row : rowlist) {
                        if (row.get("namenkommentar.PLemma") != null) {
                            out.println("<a href=\"namenkommentar?ID="+row.get("namenkommentar.ID")+"\">"+format(row.get("namenkommentar.PLemma").toString(),"PLemma")+"<br>");
                        }
                    }
                    out.println("</td></tr>");

                out.println("</ul>\n");
            }

            if (modul.equals("nachweise")) {
                out.println("<table>\n");
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
				List<Map> rowlist = JoinedDB.getMappedList(
                                    "SELECT e.ID, e.Belegnummer, e.Belegform,"
                                    + "e.VonTag, e.VonMonat, e.VonJahr, e.BisTag, e.BisMonat, e.BisJahr, sew.Bezeichnung, st.Bezeichnung, e.kontext "
                                    + " FROM (((einzelbeleg e LEFT JOIN einzelbeleg_hatamtweihe ew ON ew.einzelbelegID=e.ID)"
                                    + " LEFT JOIN selektion_amtweihe sew ON ew.AmtWeiheID=sew.ID) LEFT JOIN "
                                    + " einzelbeleg_hatstand es ON es.einzelbelegID=e.ID) "
                                    + " LEFT JOIN selektion_stand st ON es.StandID=st.ID, einzelbeleg_hatperson p "
                                    + "where e.id in (SELECT einzelbeleg.ID FROM einzelbeleg, quelle WHERE einzelbeleg.QuelleID=quelle.ID) and e.id=p.einzelbelegID and  p.personID= \""
                                    + id
                                    + "\""
                                    + " ORDER BY e.vonJahr ASC, e.vonMonat ASC, e.vonTag ASC");
				int count = 0;
				for (Map row : rowlist) {
					count++;
					if (count % 2 == 0)
						out.println("<tr>");
					else
						out.println("<tr bgcolor='#AACCDD'>");
					out.println("<td><a href=\"einzelbeleg?ID="
							+ row.get("e.ID").toString() + "\">");
%>
<jsp:include page="inc.erzeugeBeschriftung.jsp">
	<jsp:param name="Formular" value="person" />
	<jsp:param name="Textfeld" value="BelegLink" />
</jsp:include>
<%
                            out.println("</a></td>");
                            out.println("<td>" + row.get("e.Belegform").toString()
                                            + "</td>");
                            out.println("<td> "
                                            + makeDate(Integer.parseInt(row.get("e.VonTag").toString()), Integer.parseInt(row.get("e.VonMonat").toString()), Integer.parseInt(row.get("e.VonJahr").toString()))
                                            + " - "
                                            + makeDate(Integer.parseInt(row.get("e.BisTag").toString()), Integer.parseInt(row.get("e.BisMonat").toString()), Integer.parseInt(row.get("e.BisJahr").toString())) + "</td>");
                            out
                                            .println("<td>"
                                                            + (row.get("sew.Bezeichnung").toString() != null ? row
                                                                            .get("sew.Bezeichnung").toString()
                                                                            : "-") + "</td>");
                            out
                                            .println("<td>"
                                                            + (row.get("st.Bezeichnung").toString() != null ? row
                                                                            .get("st.Bezeichnung").toString()
                                                                            : "-") + "</td>");
                            out.println("<td>"
                                            + (row.get("e.Kontext").toString() != null ? row
                                                            .get("e.Kontext").toString() : "-")
                                            + "</td>");
                            out.println("</tr>");
                        }
                    out.println("</table>\n");
		}
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
				List<Map> rowlist = JoinedDB.getMappedList(
                                    "SELECT e.ID, e.Belegnummer, e.Belegform,"
                                    + "e.VonTag, e.VonMonat, e.VonJahr, e.VonJahrhundert, e.BisTag, e.BisMonat, e.BisJahr, e.BisJahrhundert, sew.Bezeichnung, ss.Bezeichnung, e.kontext "
                                    + " FROM (((einzelbeleg e LEFT JOIN einzelbeleg_hatamtweihe ew ON ew.einzelbelegID=e.ID)"
                                    + " LEFT JOIN selektion_amtweihe sew ON ew.AmtWeiheID=sew.ID) LEFT JOIN "
                                    + " einzelbeleg_hatstand es ON es.einzelbelegID=e.ID)"
                                    + " LEFT JOIN selektion_stand ss ON es.StandID=ss.ID, einzelbeleg_hatperson p "
                                    + "where e.id in (SELECT einzelbeleg.ID FROM einzelbeleg, quelle WHERE einzelbeleg.QuelleID=quelle.ID AND quelle.ZuVeroeffentlichen=1) and e.id=p.einzelbelegID and  p.personID= \""
                                    + id
                                    + "\""
                                    + " ORDER BY e.vonJahr ASC, e.vonMonat ASC, e.vonTag ASC");
				int count = 0;
				for (Map row : rowlist) {
                                    count++;
                                    if (count % 2 == 0)
                                            out.println("<tr>");
                                    else
                                            out.println("<tr bgcolor='#AACCDD'>");
                                    out.println("<td><a href=\"einzelbeleg?ID="
                                                    + row.get("e.ID").toString() + "\">");
%>
<jsp:include page="inc.erzeugeBeschriftung.jsp">
	<jsp:param name="Formular" value="person" />
	<jsp:param name="Textfeld" value="BelegLink" />
</jsp:include>
<%
                            out.println("</a></td>");
                            out.println("<td>" + getBelegformLinked(row.get("e.ID").toString(), row.get("e.Belegform").toString())
                                            + "</td>");

                            String vonTag = row.get("e.VonTag").toString();
                            String vonMonat = row.get("e.VonMonat").toString();
                            String vonJahr = row.get("e.VonJahr").toString();
                            String vonJhdt = row.get("e.VonJahrhundert").toString();
                            String bisTag = row.get("e.BisTag").toString();
                            String bisMonat = row.get("e.BisMonat").toString();
                            String bisJahr = row.get("e.BisJahr").toString();
                            String bisJhdt = row.get("e.BisJahrhundert").toString();

                            String von = "";

                            if (vonTag != null && !vonTag.equals("")
                                            && !vonTag.equals("0"))
                                    von = vonTag + ".";
                            if (vonMonat != null && !vonMonat.equals("")
                                            && !vonMonat.equals("0"))
                                    von = von + vonMonat + ".";
                            if (vonJahr != null && !vonJahr.equals("")
                                            && !vonJahr.equals("0"))
                                    von = von + vonJahr;
                            if (von.equals("") && vonJhdt != null)
                                    von = vonJhdt;

                            String bis = "";

                            if (bisTag != null && !bisTag.equals("")
                                            && !bisTag.equals("0"))
                                    bis = bisTag + ".";
                            if (bisMonat != null && !bisMonat.equals("")
                                            && !bisMonat.equals("0"))
                                    bis = bis + bisMonat + ".";
                            if (bisJahr != null && !bisJahr.equals("")
                                            && !bisJahr.equals("0"))
                                    bis = bis + bisJahr;
                            if (bis.equals("") && bisJhdt != null)
                                    bis = bisJhdt;

                            if (!bis.equals(von) && !bis.equals(""))
                                    out.println("<td>" + von + " - " + bis
                                                    + "</td>");
                            else
                                    out.println("<td>" + von + "</td>");
                            out
                                            .println("<td>"
                                                            + (row.get("sew.Bezeichnung").toString() != null ? row
                                                                            .get("sew.Bezeichnung").toString()
                                                                            : "-") + "</td>");
                            out
                                            .println("<td>"
                                                            + (row.get("ss.Bezeichnung").toString() != null ? row
                                                                            .get("ss.Bezeichnung").toString()
                                                                            : "-") + "</td>");
                            out.println("<td>"
                                            + (row.get("e.Kontext").toString() != null ? row
                                                            .get("e.Kontext").toString() : "-")
                                            + "</td>");
                            out.println("</tr>");
                        }
                    out.println("</table>\n");
		}
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
                        List<Map> rowlist = JoinedDB.getMappedList(
                            "select p.ID, p.Standardname, sv.Bezeichnung from person p, "
                            + "person_verwandtmit pv, selektion_verwandtschaftsgrad sv where "
                            + "pv.personIDvon="
                            + id
                            + " and pv.personIDzu=p.ID and "
                            + "pv.verwandtschaftsgradID=sv.ID and p.ID in "
                            + "(SELECT PersonID FROM einzelbeleg_hatperson WHERE EinzelbelegID IN "
                            + "(SELECT einzelbeleg.ID FROM einzelbeleg, quelle WHERE "
                            + "einzelbeleg.QuelleID=quelle.ID AND quelle.ZuVeroeffentlichen=1))");
                        int count = 0;
                        boolean atLeastOne = false;
                        for (Map row : rowlist) {
                                count++;
                                out.println("<tr>");
                                out.println("<td><a href=\"person?ID="
                                                + row.get("p.ID").toString() + "\">"
                                                + row.get("p.Standardname").toString()
                                                + "</a></td>");
                                out.println("<td>" + row.get("sv.Bezeichnung").toString()
                                                + "</td>");
                                out.println("</tr>");
                                atLeastOne = true;
                        }
                        if (!atLeastOne) {
                                out.println("<tr>");
                                out.println("<td>-</td>");
                                out.println("<td>-</td>");
                                out.println("</tr>");
                        }
                out.println("</table>\n");
            }
	}

	else if (formular.equals("edition")) {
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


				List<Map> rowlist = JoinedDB.getMappedList(
                                    "SELECT quelle.ID, quelle.Bezeichnung Bezeichnung FROM quelle_inedition, quelle WHERE quelle_inedition.EditionID=  "
                                    + id
                                    + " AND quelle_inedition.quelleID=quelle.ID ORDER BY Bezeichnung ASC");

				for (Map row : rowlist) {
					String bez = row.get("Bezeichnung").toString();
					String qID = row.get("quelle.ID").toString();
					List<Map> rowlist2 = JoinedDB.getMappedList(
                                            "SELECT handschrift.ID, handschrift.Bibliothekssignatur,  handschrift_ueberlieferung.ID, ueberlieferung_edition.Sigle, handschrift_ueberlieferung.VonTag, VonMonat, VonJahr, VonJahrhundert, BisTag, BisMonat, BisJahr, BisJahrhundert, selektion_ort.Bezeichnung"
                                            + " FROM handschrift, (handschrift_ueberlieferung JOIN selektion_ort ON selektion_ort.ID = handschrift_ueberlieferung.Schriftheimat), ueberlieferung_edition"
                                            + " WHERE handschrift_ueberlieferung.HandschriftID = handschrift.ID AND ueberlieferung_edition.EditionID = "
                                            + id
                                            + " AND ueberlieferung_edition.UeberlieferungID =handschrift_ueberlieferung.ID AND handschrift_ueberlieferung.QuelleID = \""
                                            + qID
                                            + "\" "
                                            + " ORDER BY ueberlieferung_edition.Sigle ASC");

					out.println("<tr><td colspan=6>");

	out.println("Quelle: " + bez + "</td></tr>");
					for (Map row2 : rowlist2) {
						out.println("<tr>");
						out
								.println("<td>&nbsp;</td><td><a href=\"handschrift?ID="
										+ row2.get("handschrift.ID").toString()
										+ "\">");
%>
<jsp:include page="inc.erzeugeBeschriftung.jsp">
	<jsp:param name="Formular" value="quelle" />
	<jsp:param name="Textfeld" value="ZurHandschrift" />
</jsp:include>

<%
	out.println("</a></td>");
						out
								.println("<td>"
										+ (row2.get("handschrift.Bibliothekssignatur") == null ? ""
												: row2.get("handschrift.Bibliothekssignatur").toString())
										+ "</td>");
						out
								.println("<td>"
										+ (row2
												.get("ueberlieferung_edition.Sigle") == null ? ""
												: row2.get("ueberlieferung_edition.Sigle").toString())
										+ "</td>");
						out
								.println("<td> "
										+ makeDate(
												Integer.parseInt(row2.get("handschrift_ueberlieferung.VonTag").toString()),
												Integer.parseInt(row2.get("handschrift_ueberlieferung.VonMonat").toString()),
												Integer.parseInt(row2.get("handschrift_ueberlieferung.VonJahr").toString()))
										+ (row2.get("handschrift_ueberlieferung.VonJahrhundert") == null || row2.get("handschrift_ueberlieferung.VonJahrhundert").toString().equals("")?"":"("+row2.get("handschrift_ueberlieferung.VonJahrhundert").toString()+")")

										+ " - "
										+ makeDate(
												Integer.parseInt(row2.get("handschrift_ueberlieferung.BisTag").toString()),
												Integer.parseInt(row2.get("handschrift_ueberlieferung.BisMonat").toString()),
												Integer.parseInt(row2.get("handschrift_ueberlieferung.BisJahr").toString()))
										+ (row2.get("handschrift_ueberlieferung.BisJahrhundert") == null || row2.get("handschrift_ueberlieferung.BisJahrhundert").toString().equals("")?"":"("+row2.get("handschrift_ueberlieferung.VonJahrhundert").toString()+")")
										+ "</td>");
						out
								.println("<td>"
										+ (row2.get("selektion_ort.Bezeichnung") == null ? ""
												: row2.get("selektion_ort.Bezeichnung").toString())
										+ "</td>");
						out.println("</tr>");
					}
				}
			out.println("</table>\n");
		}
		else if (modul.equals("quellen")) {
			out.println("<table>\n");
			out.println("<tr><th>Quelle</th><th>Sigle</th><th>Standard</th></tr>\n");

                        List<Map> rowlist = JoinedDB.getMappedList(
                            "SELECT quelle.ID, quelle.Bezeichnung, quelle_inedition.Sigle, quelle_inedition.Standard"
                            + " FROM quelle_inedition, quelle"
                            + " WHERE quelle.ID = quelle_inedition.QuelleID"
                            + " AND quelle_inedition.EditionID = \""
                            + id
                            + "\""
                            + " ORDER BY quelle_inedition.Sigle ASC");
                        for (Map row : rowlist) {
                            out.println("<tr>");
                            out.println("<td><a href=\"quelle?ID="
                                            + row.get("quelle.ID").toString() + "\">"
                                            + row.get("quelle.Bezeichnung").toString()
                                            + "</a></td>");
                            out.println("<td>" + (row.get("quelle_inedition.Sigle") == null ? "" : row.get("quelle_inedition.Sigle").toString()) + "</td>");
                            out.println("<td>"+ (Integer.parseInt(row.get("quelle_inedition.Standard").toString()) == 1 ? "JA": "") + "</td>");
                            out.println("</tr>");
                        }
			out.println("</table>\n");
		}
	}

	else if (formular.equals("quelle")) {
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
				List<Map> rowlist = JoinedDB.getMappedList(
                                    "SELECT edition.ID, edition.Zitierweise Bezeichnung FROM quelle_inedition, edition WHERE quelle_inedition.QuelleID=  "
                                    + id
                                    + " AND quelle_inedition.editionID=edition.ID ORDER BY Bezeichnung ASC");
				for (Map row : rowlist) {
					String bez = row.get("Bezeichnung").toString();
					String edID = row.get("edition.ID").toString();

					List<Map> rowlist2 = JoinedDB.getMappedList(
                                            "SELECT handschrift.ID, handschrift.Bibliothekssignatur,  handschrift_ueberlieferung.ID, ueberlieferung_edition.Sigle, handschrift_ueberlieferung.VonTag, VonMonat, VonJahr, VonJahrhundert, BisTag, BisMonat, BisJahr, BisJahrhundert, selektion_ort.Bezeichnung"
                                            + " FROM handschrift, (handschrift_ueberlieferung JOIN selektion_ort ON selektion_ort.ID = handschrift_ueberlieferung.Schriftheimat), ueberlieferung_edition"
                                            + " WHERE handschrift_ueberlieferung.HandschriftID = handschrift.ID AND ueberlieferung_edition.EditionID = "
                                            + edID
                                            + " AND ueberlieferung_edition.UeberlieferungID =handschrift_ueberlieferung.ID AND handschrift_ueberlieferung.QuelleID = \""
                                            + id
                                            + "\" "
                                            + " ORDER BY ueberlieferung_edition.Sigle ASC");

					out.println("<tr><td colspan=6>");
%><jsp:include page="inc.erzeugeBeschriftung.jsp">
	<jsp:param name="Formular" value="quelle" />
	<jsp:param name="Textfeld" value="Edition" />
</jsp:include>
<%
	out.println(": " + bez + "</td></tr>");
					for (Map row2 : rowlist2) {
						out.println("<tr>");
						out.println("<td>&nbsp;</td><td><a href=\"handschrift?ID="
										+ row2.get("handschrift.ID").toString()
										+ "\">");
%>
<jsp:include page="inc.erzeugeBeschriftung.jsp">
	<jsp:param name="Formular" value="quelle" />
	<jsp:param name="Textfeld" value="ZurHandschrift" />
</jsp:include>

<%
	out.println("</a></td>");
						out
								.println("<td>"
										+ (row2.get("handschrift.Bibliothekssignatur") == null ? ""
												: row2.get("handschrift.Bibliothekssignatur").toString())
										+ "</td>");
						out
								.println("<td>"
										+ (row2
												.get("ueberlieferung_edition.Sigle") == null ? ""
												: row2.get("ueberlieferung_edition.Sigle").toString())
										+ "</td>");
						out
								.println("<td> "
										+ makeDate(
												Integer.parseInt(row2.get("handschrift_ueberlieferung.VonTag").toString()),
												Integer.parseInt(row2.get("handschrift_ueberlieferung.VonMonat").toString()),
												Integer.parseInt(row2.get("handschrift_ueberlieferung.VonJahr").toString()))
										+ (row2.get("handschrift_ueberlieferung.VonJahrhundert") == null || row2.get("handschrift_ueberlieferung.VonJahrhundert").toString().equals("")?"":"("+row2.get("handschrift_ueberlieferung.VonJahrhundert").toString()+(row2.get("handschrift_ueberlieferung.VonJahrhundert").toString().contains("J")?"":" Jh.")+")")

										+ " - "
										+ makeDate(
												Integer.parseInt(row2.get("handschrift_ueberlieferung.BisTag").toString()),
												Integer.parseInt(row2.get("handschrift_ueberlieferung.BisMonat").toString()),
												Integer.parseInt(row2.get("handschrift_ueberlieferung.BisJahr").toString()))
										+ (row2.get("handschrift_ueberlieferung.BisJahrhundert") == null || row2.get("handschrift_ueberlieferung.BisJahrhundert").toString().equals("")?"":"("+row2.get("handschrift_ueberlieferung.BisJahrhundert").toString()+(row2.get("handschrift_ueberlieferung.BisJahrhundert").toString().contains("J")?"":" Jh.")+")")
										+ "</td>");
						out
								.println("<td>"
										+ (row2.get("selektion_ort.Bezeichnung") == null ? ""
												: row2.get("selektion_ort.Bezeichnung").toString())
										+ "</td>");
						out.println("</tr>");
					}
				}
			out.println("</table>\n");
		} else if (modul.equals("ueberlieferungRO")) {
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

				List<Map> rowlist = JoinedDB.getMappedList("SELECT edition.ID, edition.Zitierweise Bezeichnung FROM quelle_inedition, edition WHERE quelle_inedition.QuelleID=  "
								+ id
								+ " AND quelle_inedition.editionID=edition.ID ORDER BY Bezeichnung ASC");
				for (Map row : rowlist) {
					String bez = row.get("Bezeichnung").toString();
					String edID = row.get("edition.ID").toString();

					List<Map> rowlist2 = JoinedDB.getMappedList("SELECT handschrift.ID, handschrift.Bibliothekssignatur,  handschrift_ueberlieferung.ID, ueberlieferung_edition.Sigle, handschrift_ueberlieferung.VonJahrhundert, handschrift_ueberlieferung.BisJahrhundert, handschrift_ueberlieferung.VonJahr, handschrift_ueberlieferung.BisJahr, handschrift_ueberlieferung.VonMonat, handschrift_ueberlieferung.BisMonat, handschrift_ueberlieferung.VonTag, handschrift_ueberlieferung.BisTag, selektion_ort.Bezeichnung"
									+ " FROM handschrift, (handschrift_ueberlieferung JOIN selektion_ort ON selektion_ort.ID = handschrift_ueberlieferung.Schriftheimat), ueberlieferung_edition"
									+ " WHERE handschrift_ueberlieferung.HandschriftID = handschrift.ID AND ueberlieferung_edition.EditionID = "
									+ edID
									+ " AND ueberlieferung_edition.UeberlieferungID =handschrift_ueberlieferung.ID AND handschrift_ueberlieferung.QuelleID = \""
									+ id
									+ "\" "
									+ " ORDER BY ueberlieferung_edition.Sigle ASC");


					out.println("<tr><th colspan=4><b>");
%>
<jsp:include page="inc.erzeugeBeschriftung.jsp">
	<jsp:param name="Formular" value="quelle" />
	<jsp:param name="Textfeld" value="Edition" />
</jsp:include>

<%
                            out.println(": " + bez + "</b></td></tr>");
                            for (Map row2 : rowlist2) {
                                    out.println("<tr>");
                                    out
                                                    .println("<td>"
                                                                    + (row2.get("handschrift.Bibliothekssignatur") == null ? ""
                                                                                    : row2.get("handschrift.Bibliothekssignatur").toString())
                                                                    + "</td>");
                                    out
                                                    .println("<td>"
                                                                    + (row2.get("ueberlieferung_edition.Sigle") == null ? ""
                                                                                    : row2.get("ueberlieferung_edition.Sigle").toString())
                                                                    + "</td>");

                                    String vonTag = row2.get("handschrift_ueberlieferung.VonTag").toString();
                                    String vonMonat = row2.get("handschrift_ueberlieferung.VonMonat").toString();
                                    String vonJahr = row2.get("handschrift_ueberlieferung.VonJahr").toString();
                                    String vonJhdt = row2.get("handschrift_ueberlieferung.VonJahrhundert").toString();
                                    String bisTag = row2.get("handschrift_ueberlieferung.BisTag").toString();
                                    String bisMonat = row2.get("handschrift_ueberlieferung.BisMonat").toString();
                                    String bisJahr = row2.get("handschrift_ueberlieferung.BisJahr").toString();
                                    String bisJhdt = row2.get("handschrift_ueberlieferung.BisJahrhundert").toString();

                                    String von = "";

                                    if (vonTag != null && !vonTag.equals("")
                                                    && !vonTag.equals("0"))
                                            von = vonTag + ".";
                                    if (vonMonat != null && !vonMonat.equals("")
                                                    && !vonMonat.equals("0"))
                                            von = von + vonMonat + ".";
                                    if (vonJahr != null && !vonJahr.equals("")
                                                    && !vonJahr.equals("0"))
                                            von = von + vonJahr;
                                    if (von.equals("") && vonJhdt != null)
                                            von = vonJhdt;

                                    if(!von.equals("") && !von.contains("J") && (vonTag==null || vonTag.equals("") || vonTag.equals("0")) && (vonMonat==null || vonMonat.equals("") || vonMonat.equals("0")) && (vonJahr==null || vonJahr.equals("") || vonJahr.equals("0"))) von = von + " Jh.";

                                    String bis = "";

                                    if (bisTag != null && !bisTag.equals("")
                                                    && !bisTag.equals("0"))
                                            bis = bisTag + ".";
                                    if (bisMonat != null && !bisMonat.equals("")
                                                    && !bisMonat.equals("0"))
                                            bis = bis + bisMonat + ".";
                                    if (bisJahr != null && !bisJahr.equals("")
                                                    && !bisJahr.equals("0"))
                                            bis = bis + bisJahr;
                                    if (bis.equals("") && bisJhdt != null)
                                            bis = bisJhdt;

                                    if(!bis.equals("")  && !bis.contains("J") && (bisTag==null || bisTag.equals("") || bisTag.equals("0")) && (bisMonat==null || bisMonat.equals("") || bisMonat.equals("0")) && (bisJahr==null || bisJahr.equals("") || bisJahr.equals("0"))) bis = bis + " Jh.";


                                    if (!bis.equals(von) && !bis.equals(""))
                                            out.println("<td>" + von + " - " + bis
                                                            + "</td>");
                                    else
                                            out.println("<td>" + von + "</td>");

                                    out
                                                    .println("<td>"
                                                                    + (row2.get("selektion_ort.Bezeichnung") == null ? ""
                                                                                    : row2.get("selektion_ort.Bezeichnung").toString())
                                                                    + "</td>");
                                    out.println("</tr>");
                            }
                    }
                    out.println("</table>\n");
		} else if (modul.equals("edition")) {
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
					if (count % 2 == 0)
						out.println("<tr>");
					else
						out.println("<tr bgcolor='#AACCDD'>");

%>	<td><strong><jsp:include page="inc.erzeugeBeschriftung.jsp">
		<jsp:param name="Formular" value="quelle" />
		<jsp:param name="Textfeld" value="StandardEdition" />
	</jsp:include></strong></td>


<%
    boolean firstEdition = true;
    boolean showNummer = false;
				List<Map> rowlist = JoinedDB.getMappedList("Select e.ID, e.Titel, r.Bezeichnung as Reihe, e.BandNummer as Band, o. Bezeichnung as Ort, e.Jahr, qi.Seiten, e.Seiten, qi.Nummer from ((edition e join quelle_inedition qi on e.ID=qi.EditionID) left join selektion_reihe r on e.ReiheID=r.ID) left join selektion_ort o on e.OrtID=o.ID where qi.QuelleID="
								+ id + " and qi.Standard=1");
				for (Map row : rowlist) {
					if(!firstEdition){
					count++;
					if (count % 2 == 0)
						out.println("<tr>");
					else
						out.println("<tr bgcolor='#AACCDD'>");
					   out.println("<td></td>");
					}
					firstEdition = false;
					out.println("<td>" + row.get("e.Titel").toString()
							+ "</td>");
					out.println("<td>"
							+ (row.get("Reihe") == null ? "--"
									: DBtoHTML(row.get("Reihe").toString()))
							+ "</td>");
					out.println("<td>"
							+ (row.get("Band") == null ? "--"
									: DBtoHTML(row.get("Band").toString()))
							+ "</td>");
					out.println("<td>"
							+ (row.get("Ort") == null ? "--"
									: DBtoHTML(row.get("Ort").toString()))
							+ "</td>");
					out.println("<td>"
							+ (row.get("e.Jahr") == null ? "--"
									: DBtoHTML(row.get("e.Jahr").toString()))
							+ "</td>");
					out
							.println("<td> "
									+ (row.get("qi.Seiten") == null ? (row.get("e.Seiten") == null ? "--"
											: DBtoHTML(row.get("e.Seiten").toString()))
											: DBtoHTML(row.get("qi.Seiten").toString()))
									+ "</td>");
					out.println("<td>"
							+ ((row.get("qi.Nummer") == null ||  row.get("qi.Nummer").toString().trim().equals(""))? "--"
									: DBtoHTML(row.get("qi.Nummer").toString()))
							+ "</td>");
					if(row.get("qi.Nummer").toString() != null && !row.get("qi.Nummer").toString().trim().equals("")) showNummer =true;
					out.println("<td>");

					List<Map> rowlist2 = JoinedDB.getMappedList("select s.Bezeichnung from selektion_editor s, edition_hateditor ehe where ehe.EditionID="
									+ row.get("e.ID").toString()
									+ " AND ehe.EditorID=s.ID");
					boolean first = true;
					for (Map row2 : rowlist2) {
						if (!first)
							out.print(" / ");
						out.print(row2.get("s.Bezeichnung").toString());
						first = false;
					}
					out.println("</td>");
					out.println("</tr>");
				}
				if(firstEdition)out.println("<td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td></tr>");
					count++;
					if (count % 2 == 0)
						out.println("<tr>");
					else
						out.println("<tr bgcolor='#AACCDD'>");
%>
	<td><jsp:include page="inc.erzeugeBeschriftung.jsp">
		<jsp:param name="Formular" value="quelle" />
		<jsp:param name="Textfeld" value="WeitereEditionen" />
	</jsp:include></td>

<%
firstEdition = true;
				rowlist = JoinedDB.getMappedList(
                                        "Select e.ID, e.Titel, r.Bezeichnung as Reihe, e.BandNummer as Band, o. Bezeichnung as Ort, e.Jahr, qi.Seiten, e.Seiten, qi.Nummer from ((edition e join quelle_inedition qi on e.ID=qi.EditionID) left join selektion_reihe r on e.ReiheID=r.ID) left join selektion_ort o on e.OrtID=o.ID where qi.QuelleID="
					+ id + " and qi.Standard=0");
				for (Map row : rowlist) {

					if(!firstEdition){
					count++;
					if (count % 2 == 0)
						out.println("<tr>");
					else
						out.println("<tr bgcolor='#AACCDD'>");
					   out.println("<td></td>");
					}
 				    firstEdition = false;
					out.println("<td>" + row.get("e.Titel").toString()
							+ "</td>");
					out.println("<td>"
							+ (row.get("Reihe") == null ? "--"
									: DBtoHTML(row.get("Reihe").toString()))
							+ "</td>");
					out.println("<td>"
							+ (row.get("Band") == null ? "--"
									: DBtoHTML(row.get("Band").toString()))
							+ "</td>");
					out.println("<td>"
							+ (row.get("Ort") == null ? "--"
									: DBtoHTML(row.get("Ort").toString()))
							+ "</td>");
					out.println("<td>"
							+ (row.get("e.Jahr") == null ? "--"
									: DBtoHTML(row.get("e.Jahr").toString()))
							+ "</td>");
				out
							.println("<td> "
									+ (row.get("qi.Seiten") == null ? (row.get("e.Seiten") == null ? "--"
											: DBtoHTML(row.get("e.Seiten").toString()))
											: DBtoHTML(row.get("qi.Seiten").toString()))
									+ "</td>");
					out.println("<td>"
							+ ((row.get("qi.Nummer") == null ||  row.get("qi.Nummer").toString().trim().equals(""))? "--"
									: DBtoHTML(row.get("qi.Nummer").toString()))
							+ "</td>");
					if(row.get("qi.Nummer").toString() != null && !row.get("qi.Nummer").toString().trim().equals("")) showNummer =true;
					out.println("<td>");

					List<Map> rowlist2 = JoinedDB.getMappedList("select s.Bezeichnung from selektion_editor s, edition_hateditor ehe where ehe.EditionID="
									+ row.get("e.ID").toString()
									+ " AND ehe.EditorID=s.ID");
					boolean first = true;
					for (Map row2 : rowlist2) {
                                            if (!first)
                                                out.print(" / ");
                                            out.print(row2.get("s.Bezeichnung").toString());
                                            first = false;
					}
					out.println("</td>");
					out.println("</tr>");
				}
			out.println("</tbody valign=\"bottom\">\n");
			out.println("</table>\n");
			if(!showNummer){
			%>
<script type="text/javascript">
   var rows = document.getElementById('edition').getElementsByTagName('tr');
   for (var i = 0; i < rows.length; i++) {
   if(rows[i].getElementsByTagName('th')[7])
    rows[i].getElementsByTagName('th')[7].style.display='none';
   if(rows[i].getElementsByTagName('td')[7])
    rows[i].getElementsByTagName('td')[7].style.display='none';
  }
</script>
	<%	}
		}
	}
	else if (formular.equals("mgh_lemma")) {
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
                        List<Map> rowlist = JoinedDB.getMappedList("SELECT benutzer.Nachname, benutzer.Vorname, mgh_lemma_"
                                                        + modul
                                                        + ".Zeitstempel"
                                                        + " FROM mgh_lemma, mgh_lemma_"
                                                        + modul
                                                        + ", benutzer"
                                                        + " WHERE mgh_lemma.ID = \""
                                                        + id
                                                        + "\""
                                                        + " AND mgh_lemma.ID = mgh_lemma_"
                                                        + modul
                                                        + ".MGHLemmaID"
                                                        + " AND mgh_lemma_"
                                                        + modul
                                                        + ".BenutzerID = benutzer.ID"
                                                        + " ORDER BY mgh_lemma_"
                                                        + modul
                                                        + ".Zeitstempel ASC;");
                        for (Map row : rowlist) {
                                Object date = row.get("mgh_lemma_" + modul
                                                + ".Zeitstempel");
                                Object time = row.get("mgh_lemma_" + modul
                                                + ".Zeitstempel");
                                out.println("<tr>");
                                out
                                                .println("<td>"
                                                                + DBtoHTML(row.get("benutzer.Nachname").toString())
                                                                + ", "
                                                                + DBtoHTML(row.get("Benutzer.Vorname").toString())
                                                                + "</td>");
                                out.println("<td>" + (date == null ? "--" : date.toString())
                                                + "</td>");
                                out.println("<td>" + (time == null ? "--" : time.toString())
                                                + "</td>");
                                out.println("</tr>");
                        }
			out.println("</table>\n");
		}		else if (modul.equals("belege")) {
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
				List<Map> rowlist = JoinedDB.getMappedList("SELECT einzelbeleg.ID, einzelbeleg.Belegnummer, einzelbeleg.Belegform"
								+ ", person.ID, person.PKZ, person.Standardname"
								+ ", einzelbeleg.VonTag, einzelbeleg.VonMonat, einzelbeleg.VonJahr, einzelbeleg.BisTag, einzelbeleg.BisMonat, einzelbeleg.BisJahr"
								+ " FROM einzelbeleg_hatmghlemma, (einzelbeleg LEFT JOIN einzelbeleg_hatperson ON einzelbeleg.ID = einzelbeleg_hatperson.EinzelbelegID) LEFT JOIN person ON einzelbeleg_hatperson.PersonID = person.ID"
								+ " WHERE einzelbeleg_hatmghlemma.MGHLemmaID = \""
								+ id
								+ "\""
								+ " AND einzelbeleg_hatmghlemma.EinzelbelegID = einzelbeleg.ID"
								+ " ORDER BY einzelbeleg.VonJahr, einzelbeleg.VonMonat, einzelbeleg.VonTag ASC");
				for (Map row : rowlist) {
					out.println("<tr>");
					out.println("<td><a href=\"einzelbeleg?ID="
							+ row.get("einzelbeleg.ID").toString() + "\">");
%>
<jsp:include page="inc.erzeugeBeschriftung.jsp">
	<jsp:param name="Formular" value="mgh_lemma" />
	<jsp:param name="Textfeld" value="ZumBeleg" />
</jsp:include>

<%
	out.println("</a></td>");
					out
							.println("<td>"
									+ (row.get("einzelbeleg.Belegform") == null ? "&nbsp;"
											: row.get("einzelbeleg.Belegform").toString())
									+ "</td>");
					out.println("<td>");
					if (row.get("person.PKZ") == null)
						out.println("--");
					else {
						out.println("<a href=\"person?ID="
								+ row.get("person.ID").toString() + "\">");
%>
<jsp:include page="inc.erzeugeBeschriftung.jsp">
	<jsp:param name="Formular" value="mgh_lemma" />
	<jsp:param name="Textfeld" value="ZurPerson" />
</jsp:include>
<%
	}
					out.println("</a></td>");
					out
							.println("<td>"
									+ (row.get("person.Standardname") == null ? "--"
											: DBtoHTML(row.get("person.Standardname").toString()))
									+ "</td>");
					out.println("<td> "
							+ makeDate(Integer.parseInt(row.get("einzelbeleg.VonTag").toString()),
									Integer.parseInt(row.get("einzelbeleg.VonMonat").toString()),
									Integer.parseInt(row.get("einzelbeleg.VonJahr").toString()))
							+ " - "
							+ makeDate(Integer.parseInt(row.get("einzelbeleg.BisTag").toString()),
									Integer.parseInt(row.get("einzelbeleg.BisMonat").toString()),
									Integer.parseInt(row.get("einzelbeleg.BisJahr").toString()))
							+ "</td>");
					out.println("</tr>");
				}
			out.println("</table>\n");
		}
}

	else if (formular.equals("namenkommentar")) {
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
                        List<Map> rowlist = JoinedDB.getMappedList("SELECT benutzer.Nachname, benutzer.Vorname, namenkommentar_"
                                                        + modul
                                                        + ".Zeitstempel"
                                                        + " FROM namenkommentar, namenkommentar_"
                                                        + modul
                                                        + ", benutzer"
                                                        + " WHERE namenkommentar.ID = \""
                                                        + id
                                                        + "\""
                                                        + " AND namenkommentar.ID = namenkommentar_"
                                                        + modul
                                                        + ".NamenkommentarID"
                                                        + " AND namenkommentar_"
                                                        + modul
                                                        + ".BenutzerID = benutzer.ID"
                                                        + " ORDER BY namenkommentar_"
                                                        + modul
                                                        + ".Zeitstempel ASC;");
                        for (Map row : rowlist) {
                                Object date = row.get("namenkommentar_" + modul + ".Zeitstempel");
                                Object time = row.get("namenkommentar_" + modul + ".Zeitstempel");
                                out.println("<tr>");
                                out.println("<td>" + DBtoHTML(row.get("benutzer.Nachname").toString()) + ", " + DBtoHTML(row.get("Benutzer.Vorname").toString())+ "</td>");
                                out.println("<td>" + (date == null ? "--" : date.toString())
                                                + "</td>");
                                out.println("<td>" + (time == null ? "--" : time.toString())
                                                + "</td>");
                                out.println("</tr>");
                        }
			out.println("</table>\n");
		}

		else if (modul.equals("belege")) {
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
				List<Map> rowlist = JoinedDB.getMappedList("SELECT einzelbeleg.ID, einzelbeleg.Belegnummer, einzelbeleg.Belegform"
								+ ", person.ID, person.PKZ, person.Standardname"
								+ ", einzelbeleg.VonTag, einzelbeleg.VonMonat, einzelbeleg.VonJahr, einzelbeleg.BisTag, einzelbeleg.BisMonat, einzelbeleg.BisJahr"
								+ " FROM einzelbeleg_hatnamenkommentar, (einzelbeleg LEFT JOIN einzelbeleg_hatperson ON einzelbeleg.ID = einzelbeleg_hatperson.EinzelbelegID) LEFT JOIN person ON einzelbeleg_hatperson.PersonID = person.ID"
								+ " WHERE einzelbeleg_hatnamenkommentar.NamenkommentarID = \""
								+ id
								+ "\""
								+ " AND einzelbeleg_hatnamenkommentar.EinzelbelegID = einzelbeleg.ID"
								+ " ORDER BY einzelbeleg.VonJahr, einzelbeleg.VonMonat, einzelbeleg.VonTag ASC");
				for (Map row : rowlist) {
					out.println("<tr>");
					out.println("<td><a href=\"einzelbeleg?ID="
							+ row.get("einzelbeleg.ID").toString() + "\">");
%>
<jsp:include page="inc.erzeugeBeschriftung.jsp">
	<jsp:param name="Formular" value="namenkommentar" />
	<jsp:param name="Textfeld" value="ZumBeleg" />
</jsp:include>

<%
	out.println("</a></td>");
					out
							.println("<td>"
									+ (row.get("einzelbeleg.Belegform") == null ? "&nbsp;"
											: row.get("einzelbeleg.Belegform").toString())
									+ "</td>");
					out.println("<td>");
					if (row.get("person.PKZ") == null)
						out.println("--");
					else {
						out.println("<a href=\"person?ID="
								+ row.get("person.ID").toString() + "\">");
%>
<jsp:include page="inc.erzeugeBeschriftung.jsp">
	<jsp:param name="Formular" value="namenkommentar" />
	<jsp:param name="Textfeld" value="ZurPerson" />
</jsp:include>
<%
	}
					out.println("</a></td>");
					out
							.println("<td>"
									+ (row.get("person.Standardname") == null ? "--"
											: DBtoHTML(row.get("person.Standardname").toString()))
									+ "</td>");
					out.println("<td> "
							+ makeDate(Integer.parseInt(row.get("einzelbeleg.VonTag").toString()),
									Integer.parseInt(row.get("einzelbeleg.VonMonat").toString()),
									Integer.parseInt(row.get("einzelbeleg.VonJahr").toString()))
							+ " - "
							+ makeDate(Integer.parseInt(row.get("einzelbeleg.BisTag").toString()),
									Integer.parseInt(row.get("einzelbeleg.BisMonat").toString()),
									Integer.parseInt(row.get("einzelbeleg.BisJahr").toString()))
							+ "</td>");
					out.println("</tr>");
				}
			out.println("</table>\n");
		}

		else if (modul.equals("PLemma")) {
                    List<Map> rowlist = JoinedDB.getMappedList("SELECT PLemma"
                                    + " FROM namenkommentar " + " WHERE ID = \""
                                    + id + "\"");
                    for (Map row : rowlist) {
                            String lemma = row.get("PLemma").toString();

                            out.println(format(lemma,"PLemma"));

                    }
		}

	}
%>
