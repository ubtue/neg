<%@ page import="java.sql.*" isThreadSafe="false"%>
<%@ page import="java.sql.Date" isThreadSafe="false"%>
<%@ page import="java.sql.Time" isThreadSafe="false"%>

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
	Connection cn = null;
			Statement st = null;
			ResultSet rs = null;
			try {
				Class.forName(sqlDriver);
				cn = DriverManager.getConnection(sqlURL, sqlUser,
						sqlPassword);
				st = cn.createStatement();
				rs = st
						.executeQuery("SELECT ed.Zitierweise, ue.Sigle, et.Variante, h.VonTag,h.VonMonat,h.VonJahr,h.VonJahrhundert, h.BisTag,h.BisMonat,h.BisJahr,h.BisJahrhundert, et.Bemerkung from einzelbeleg_textkritik et, "
								+ "edition ed, handschrift_ueberlieferung h, ueberlieferung_edition ue, einzelbeleg e where "
								+ " h.ID=ue.UeberlieferungID AND et.HandschriftID=h.ID AND ue.EditionID=ed.ID AND "
								+ " h.QuelleID=e.QuelleID AND ed.ID=et.EditionID "
								+ " AND et.EinzelbelegID="
								+ id
								+ " AND e.ID=" + id);

				int count = 0;
				while (rs.next()) {
					count++;

					if (count % 2 == 0)
						out.println("<tr>");
					else
						out.println("<tr bgcolor='#AACCDD'>");

					out.println("<td>" + rs.getString("ed.Zitierweise")
							+ "</td>");
					String sigle = rs.getString("ue.Sigle");

					if (sigle == null)
						sigle = "";

					out.println("<td>" + sigle + "</td>");
					out.println("<td>" + rs.getString("et.Variante")
							+ "</td>");

					String vonTag = rs.getString("h.VonTag");
					String vonMonat = rs.getString("h.VonMonat");
					String vonJahr = rs.getString("h.VonJahr");
					String vonJhdt = rs.getString("h.VonJahrhundert");
					String bisTag = rs.getString("h.BisTag");
					String bisMonat = rs.getString("h.BisMonat");
					String bisJahr = rs.getString("h.BisJahr");
					String bisJhdt = rs.getString("h.BisJahrhundert");

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

					String bem = rs.getString("et.Bemerkung");

					if (bem == null)
						bem = "";

					out.println("<td>" + bem + "</td>");
					out.println("</tr>");
				}
			} catch (Exception e) {
				out.println(e);
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
			out.println("</table>\n");
		}
	}

	else if (formular.equals("person")) {
		if (modul.equals("namen")) {
			out.println("<tr><td>\n");

	Connection cn = null;
			Statement st = null;
			ResultSet rs = null;
			try {
				Class.forName(sqlDriver);
				cn = DriverManager.getConnection(sqlURL, sqlUser,
						sqlPassword);
				st = cn.createStatement();
								
				rs = st
						.executeQuery("SELECT count(DISTINCT namenkommentar.ID) FROM einzelbeleg LEFT OUTER JOIN "+
						"einzelbeleg_hatperson ON "+
						"einzelbeleg.ID=einzelbeleg_hatperson.EinzelbelegID LEFT OUTER JOIN "+
						"person ON einzelbeleg_hatperson.PersonID=person.ID LEFT OUTER JOIN "+
						"einzelbeleg_hatnamenkommentar ON "+
						"einzelbeleg_hatnamenkommentar.EinzelbelegID=einzelbeleg.ID "+
						"LEFT OUTER JOIN namenkommentar ON "+
						"namenkommentar.ID=einzelbeleg_hatnamenkommentar.NamenkommentarID WHERE person.ID=\""
								+ id + "\"");
				out.print("<label>Name");
				if(rs.next() && rs.getInt(1)>1) out.println("n");
				out.println("</label></td><td>");
				rs = st
						.executeQuery("SELECT DISTINCT namenkommentar.PLemma, "+
						"namenkommentar.ID FROM einzelbeleg LEFT OUTER JOIN "+
						"einzelbeleg_hatperson ON "+
						"einzelbeleg.ID=einzelbeleg_hatperson.EinzelbelegID LEFT OUTER JOIN "+
						"person ON einzelbeleg_hatperson.PersonID=person.ID LEFT OUTER JOIN "+
						"einzelbeleg_hatnamenkommentar ON "+
						"einzelbeleg_hatnamenkommentar.EinzelbelegID=einzelbeleg.ID "+
						"LEFT OUTER JOIN namenkommentar ON "+
						"namenkommentar.ID=einzelbeleg_hatnamenkommentar.NamenkommentarID WHERE person.ID=\""
								+ id + "\"");
				while (rs.next()  && rs.getString("namenkommentar.PLemma") !=null) {
					out.println("<a href=\"namenkommentar?ID="+rs.getString("namenkommentar.ID")+"\">"+format(rs.getString("namenkommentar.PLemma"),"PLemma")+"<br>");
				}
				out.println("</td></tr>");
			} catch (Exception e) {
				out.println(e);
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
			out.println("</ul>\n");
		}if (modul.equals("nachweise")) {
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
	Connection cn = null;
			Statement st = null;
			ResultSet rs = null;
			try {
				Class.forName(sqlDriver);
				cn = DriverManager.getConnection(sqlURL, sqlUser,
						sqlPassword);
				st = cn.createStatement();
				rs = st
						.executeQuery("SELECT e.ID, e.Belegnummer, e.Belegform,"
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
				while (rs.next()) {
					count++;
					if (count % 2 == 0)
						out.println("<tr>");
					else
						out.println("<tr bgcolor='#AACCDD'>");
					out.println("<td><a href=\"einzelbeleg?ID="
							+ rs.getInt("e.ID") + "\">");
%>
<jsp:include page="inc.erzeugeBeschriftung.jsp">
	<jsp:param name="Formular" value="person" />
	<jsp:param name="Textfeld" value="BelegLink" />
</jsp:include>
<%
	out.println("</a></td>");
					out.println("<td>" + rs.getString("e.Belegform")
							+ "</td>");
					out.println("<td> "
							+ makeDate(rs.getInt("e.VonTag"), rs
									.getInt("e.VonMonat"), rs
									.getInt("e.VonJahr"))
							+ " - "
							+ makeDate(rs.getInt("e.BisTag"), rs
									.getInt("e.BisMonat"), rs
									.getInt("e.BisJahr")) + "</td>");
					out
							.println("<td>"
									+ (rs.getString("sew.Bezeichnung") != null ? rs
											.getString("sew.Bezeichnung")
											: "-") + "</td>");
					out
							.println("<td>"
									+ (rs.getString("st.Bezeichnung") != null ? rs
											.getString("st.Bezeichnung")
											: "-") + "</td>");
					out.println("<td>"
							+ (rs.getString("e.Kontext") != null ? rs
									.getString("e.Kontext") : "-")
							+ "</td>");
					out.println("</tr>");
				}
			} catch (Exception e) {
				out.println(e);
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
	Connection cn = null;
			Statement st = null;
			ResultSet rs = null;
			try {
				Class.forName(sqlDriver);
				cn = DriverManager.getConnection(sqlURL, sqlUser,
						sqlPassword);
				st = cn.createStatement();
				rs = st
						.executeQuery("SELECT e.ID, e.Belegnummer, e.Belegform,"
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
				while (rs.next()) {
					count++;
					if (count % 2 == 0)
						out.println("<tr>");
					else
						out.println("<tr bgcolor='#AACCDD'>");
					out.println("<td><a href=\"einzelbeleg?ID="
							+ rs.getInt("e.ID") + "\">");
%>
<jsp:include page="inc.erzeugeBeschriftung.jsp">
	<jsp:param name="Formular" value="person" />
	<jsp:param name="Textfeld" value="BelegLink" />
</jsp:include>
<%
	out.println("</a></td>");
					out.println("<td>" + getBelegformLinked(cn, rs.getString("e.ID"), rs.getString("e.Belegform"))
							+ "</td>");

					String vonTag = rs.getString("e.VonTag");
					String vonMonat = rs.getString("e.VonMonat");
					String vonJahr = rs.getString("e.VonJahr");
					String vonJhdt = rs.getString("e.VonJahrhundert");
					String bisTag = rs.getString("e.BisTag");
					String bisMonat = rs.getString("e.BisMonat");
					String bisJahr = rs.getString("e.BisJahr");
					String bisJhdt = rs.getString("e.BisJahrhundert");

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
									+ (rs.getString("sew.Bezeichnung") != null ? rs
											.getString("sew.Bezeichnung")
											: "-") + "</td>");
					out
							.println("<td>"
									+ (rs.getString("ss.Bezeichnung") != null ? rs
											.getString("ss.Bezeichnung")
											: "-") + "</td>");
					out.println("<td>"
							+ (rs.getString("e.Kontext") != null ? rs
									.getString("e.Kontext") : "-")
							+ "</td>");
					out.println("</tr>");
				}
			} catch (Exception e) {
				out.println(e);
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
	Connection cn = null;
			Statement st = null;
			ResultSet rs = null;
			try {
				Class.forName(sqlDriver);
				cn = DriverManager.getConnection(sqlURL, sqlUser,
						sqlPassword);
				st = cn.createStatement();
				rs = st
						.executeQuery("select p.ID, p.Standardname, sv.Bezeichnung from person p, "
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
				while (rs.next()) {
					count++;
					out.println("<tr>");
					out.println("<td><a href=\"person?ID="
							+ rs.getInt("p.ID") + "\">"
							+ rs.getString("p.Standardname")
							+ "</a></td>");
					out.println("<td>" + rs.getString("sv.Bezeichnung")
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
			} catch (Exception e) {
				out.println(e);
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
	Connection cn = null;
			Statement st = null;
			ResultSet rs = null;
			try {
				Class.forName(sqlDriver);
				cn = DriverManager.getConnection(sqlURL, sqlUser,
						sqlPassword);
				st = cn.createStatement();
				rs = st
						.executeQuery("SELECT quelle.ID, quelle.Bezeichnung Bezeichnung FROM quelle_inedition, quelle WHERE quelle_inedition.EditionID=  "
								+ id
								+ " AND quelle_inedition.quelleID=quelle.ID ORDER BY Bezeichnung ASC");
				while (rs.next()) {
					String bez = rs.getString("Bezeichnung");
					String qID = rs.getString("quelle.ID");
					Statement st2 = cn.createStatement();

					ResultSet rs2 = st2
							.executeQuery("SELECT handschrift.ID, handschrift.Bibliothekssignatur,  handschrift_ueberlieferung.ID, ueberlieferung_edition.Sigle, handschrift_ueberlieferung.VonTag, VonMonat, VonJahr, VonJahrhundert, BisTag, BisMonat, BisJahr, BisJahrhundert, selektion_ort.Bezeichnung"
									+ " FROM handschrift, (handschrift_ueberlieferung JOIN selektion_ort ON selektion_ort.ID = handschrift_ueberlieferung.Schriftheimat), ueberlieferung_edition"
									+ " WHERE handschrift_ueberlieferung.HandschriftID = handschrift.ID AND ueberlieferung_edition.EditionID = "
									+ id
									+ " AND ueberlieferung_edition.UeberlieferungID =handschrift_ueberlieferung.ID AND handschrift_ueberlieferung.QuelleID = \""
									+ qID
									+ "\" "
									+ " ORDER BY ueberlieferung_edition.Sigle ASC");

					out.println("<tr><td colspan=6>");

	out.println("Quelle: " + bez + "</td></tr>");
					while (rs2.next()) {
						out.println("<tr>");
						out
								.println("<td>&nbsp;</td><td><a href=\"handschrift.jsp?ID="
										+ rs2.getInt("handschrift.ID")
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
										+ (rs2
												.getString("handschrift.Bibliothekssignatur") == null ? ""
												: rs2
														.getString("handschrift.Bibliothekssignatur"))
										+ "</td>");
						out
								.println("<td>"
										+ (rs2
												.getString("ueberlieferung_edition.Sigle") == null ? ""
												: rs2
														.getString("ueberlieferung_edition.Sigle"))
										+ "</td>");
						out
								.println("<td> "
										+ makeDate(
												rs2
														.getInt("handschrift_ueberlieferung.VonTag"),
												rs2
														.getInt("handschrift_ueberlieferung.VonMonat"),
												rs2
														.getInt("handschrift_ueberlieferung.VonJahr"))
										+ (rs2.getString("handschrift_ueberlieferung.VonJahrhundert") == null || rs2.getString("handschrift_ueberlieferung.VonJahrhundert").equals("")?"":"("+rs2.getString("handschrift_ueberlieferung.VonJahrhundert")+")")
										
										+ " - "
										+ makeDate(
												rs2
														.getInt("handschrift_ueberlieferung.BisTag"),
												rs2
														.getInt("handschrift_ueberlieferung.BisMonat"),
												rs2
														.getInt("handschrift_ueberlieferung.BisJahr"))
										+ (rs2.getString("handschrift_ueberlieferung.BisJahrhundert") == null || rs2.getString("handschrift_ueberlieferung.BisJahrhundert").equals("")?"":"("+rs2.getString("handschrift_ueberlieferung.VonJahrhundert")+")")
										+ "</td>");
						out
								.println("<td>"
										+ (rs2
												.getString("selektion_ort.Bezeichnung") == null ? ""
												: rs2
														.getString("selektion_ort.Bezeichnung"))
										+ "</td>");
						out.println("</tr>");
					}
				}
			} catch (Exception e) {
				out.println(e);
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
			out.println("</table>\n");
		}
		else if (modul.equals("quellen")) {
			out.println("<table>\n");
			out
					.println("<tr><th>Quelle</th><th>Sigle</th><th>Standard</th></tr>\n");
			Connection cn = null;
			Statement st = null;
			ResultSet rs = null;
			try {
				Class.forName(sqlDriver);
				cn = DriverManager.getConnection(sqlURL, sqlUser,
						sqlPassword);
				st = cn.createStatement();
				rs = st
						.executeQuery("SELECT quelle.ID, quelle.Bezeichnung, quelle_inedition.Sigle, quelle_inedition.Standard"
								+ " FROM quelle_inedition, quelle"
								+ " WHERE quelle.ID = quelle_inedition.QuelleID"
								+ " AND quelle_inedition.EditionID = \""
								+ id
								+ "\""
								+ " ORDER BY quelle_inedition.Sigle ASC");
				while (rs.next()) {
					out.println("<tr>");
					out.println("<td><a href=\"quelle.jsp?ID="
							+ rs.getInt("quelle.ID") + "\">"
							+ rs.getString("quelle.Bezeichnung")
							+ "</a></td>");
					out
							.println("<td>"
									+ (rs
											.getString("quelle_inedition.Sigle") == null ? ""
											: rs
													.getString("quelle_inedition.Sigle"))
									+ "</td>");
					out
							.println("<td>"
									+ (rs
											.getInt("quelle_inedition.Standard") == 1 ? "JA"
											: "") + "</td>");
					out.println("</tr>");
				}
			} catch (Exception e) {
				out.println(e);
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
	Connection cn = null;
			Statement st = null;
			ResultSet rs = null;
			try {
				Class.forName(sqlDriver);
				cn = DriverManager.getConnection(sqlURL, sqlUser,
						sqlPassword);
				st = cn.createStatement();
				rs = st
						.executeQuery("SELECT edition.ID, edition.Zitierweise Bezeichnung FROM quelle_inedition, edition WHERE quelle_inedition.QuelleID=  "
								+ id
								+ " AND quelle_inedition.editionID=edition.ID ORDER BY Bezeichnung ASC");
				while (rs.next()) {
					String bez = rs.getString("Bezeichnung");
					String edID = rs.getString("edition.ID");
					Statement st2 = cn.createStatement();

					ResultSet rs2 = st2
							.executeQuery("SELECT handschrift.ID, handschrift.Bibliothekssignatur,  handschrift_ueberlieferung.ID, ueberlieferung_edition.Sigle, handschrift_ueberlieferung.VonTag, VonMonat, VonJahr, VonJahrhundert, BisTag, BisMonat, BisJahr, BisJahrhundert, selektion_ort.Bezeichnung"
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
					while (rs2.next()) {
						out.println("<tr>");
						out
								.println("<td>&nbsp;</td><td><a href=\"handschrift.jsp?ID="
										+ rs2.getInt("handschrift.ID")
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
										+ (rs2
												.getString("handschrift.Bibliothekssignatur") == null ? ""
												: rs2
														.getString("handschrift.Bibliothekssignatur"))
										+ "</td>");
						out
								.println("<td>"
										+ (rs2
												.getString("ueberlieferung_edition.Sigle") == null ? ""
												: rs2
														.getString("ueberlieferung_edition.Sigle"))
										+ "</td>");
						out
								.println("<td> "
										+ makeDate(
												rs2
														.getInt("handschrift_ueberlieferung.VonTag"),
												rs2
														.getInt("handschrift_ueberlieferung.VonMonat"),
												rs2
														.getInt("handschrift_ueberlieferung.VonJahr"))
										+ (rs2.getString("handschrift_ueberlieferung.VonJahrhundert") == null || rs2.getString("handschrift_ueberlieferung.VonJahrhundert").equals("")?"":"("+rs2.getString("handschrift_ueberlieferung.VonJahrhundert")+(rs2.getString("handschrift_ueberlieferung.VonJahrhundert").contains("J")?"":" Jh.")+")")
										
										+ " - "
										+ makeDate(
												rs2
														.getInt("handschrift_ueberlieferung.BisTag"),
												rs2
														.getInt("handschrift_ueberlieferung.BisMonat"),
												rs2
														.getInt("handschrift_ueberlieferung.BisJahr"))
										+ (rs2.getString("handschrift_ueberlieferung.BisJahrhundert") == null || rs2.getString("handschrift_ueberlieferung.BisJahrhundert").equals("")?"":"("+rs2.getString("handschrift_ueberlieferung.BisJahrhundert")+(rs2.getString("handschrift_ueberlieferung.BisJahrhundert").contains("J")?"":" Jh.")+")")
										+ "</td>");
						out
								.println("<td>"
										+ (rs2
												.getString("selektion_ort.Bezeichnung") == null ? ""
												: rs2
														.getString("selektion_ort.Bezeichnung"))
										+ "</td>");
						out.println("</tr>");
					}
				}
			} catch (Exception e) {
				out.println(e);
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
Connection cn = null;
Statement st = null;
ResultSet rs = null;
try {
	Class.forName(sqlDriver);
	cn = DriverManager.getConnection(sqlURL, sqlUser,
			sqlPassword);
				st = cn.createStatement();
				rs = st
						.executeQuery("SELECT edition.ID, edition.Zitierweise Bezeichnung FROM quelle_inedition, edition WHERE quelle_inedition.QuelleID=  "
								+ id
								+ " AND quelle_inedition.editionID=edition.ID ORDER BY Bezeichnung ASC");
				while (rs.next()) {
					String bez = rs.getString("Bezeichnung");
					String edID = rs.getString("edition.ID");
					Statement st2 = cn.createStatement();

					ResultSet rs2 = st2
							.executeQuery("SELECT handschrift.ID, handschrift.Bibliothekssignatur,  handschrift_ueberlieferung.ID, ueberlieferung_edition.Sigle, handschrift_ueberlieferung.VonJahrhundert, handschrift_ueberlieferung.BisJahrhundert, handschrift_ueberlieferung.VonJahr, handschrift_ueberlieferung.BisJahr, handschrift_ueberlieferung.VonMonat, handschrift_ueberlieferung.BisMonat, handschrift_ueberlieferung.VonTag, handschrift_ueberlieferung.BisTag, selektion_ort.Bezeichnung"
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
					while (rs2.next()) {
						out.println("<tr>");
						out
								.println("<td>"
										+ (rs2
												.getString("handschrift.Bibliothekssignatur") == null ? ""
												: rs2
														.getString("handschrift.Bibliothekssignatur"))
										+ "</td>");
						out
								.println("<td>"
										+ (rs2
												.getString("ueberlieferung_edition.Sigle") == null ? ""
												: rs2
														.getString("ueberlieferung_edition.Sigle"))
										+ "</td>");

						String vonTag = rs2
								.getString("handschrift_ueberlieferung.VonTag");
						String vonMonat = rs2
								.getString("handschrift_ueberlieferung.VonMonat");
						String vonJahr = rs2
								.getString("handschrift_ueberlieferung.VonJahr");
						String vonJhdt = rs2
								.getString("handschrift_ueberlieferung.VonJahrhundert");
						String bisTag = rs2
								.getString("handschrift_ueberlieferung.BisTag");
						String bisMonat = rs2
								.getString("handschrift_ueberlieferung.BisMonat");
						String bisJahr = rs2
								.getString("handschrift_ueberlieferung.BisJahr");
						String bisJhdt = rs2
								.getString("handschrift_ueberlieferung.BisJahrhundert");
								
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
										+ (rs2
												.getString("selektion_ort.Bezeichnung") == null ? ""
												: rs2
														.getString("selektion_ort.Bezeichnung"))
										+ "</td>");
						out.println("</tr>");
					}
				}
			} catch (Exception e) {
				out.println(e);
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
	Connection cn = null;
			Statement st = null;
			ResultSet rs = null;
			try {
				Class.forName(sqlDriver);
				cn = DriverManager.getConnection(sqlURL, sqlUser,
						sqlPassword);
				st = cn.createStatement();
				rs = st
						.executeQuery("Select e.ID, e.Titel, r.Bezeichnung as Reihe, e.BandNummer as Band, o. Bezeichnung as Ort, e.Jahr, qi.Seiten, e.Seiten, qi.Nummer from ((edition e join quelle_inedition qi on e.ID=qi.EditionID) left join selektion_reihe r on e.ReiheID=r.ID) left join selektion_ort o on e.OrtID=o.ID where qi.QuelleID="
								+ id + " and qi.Standard=1");
				while (rs.next()) {
					if(!firstEdition){
					count++;
					if (count % 2 == 0)
						out.println("<tr>");
					else
						out.println("<tr bgcolor='#AACCDD'>");
					   out.println("<td></td>");
					}
					firstEdition = false;
					out.println("<td>" + rs.getString("e.Titel")
							+ "</td>");
					out.println("<td>"
							+ (rs.getString("Reihe") == null ? "--"
									: DBtoHTML(rs.getString("Reihe")))
							+ "</td>");
					out.println("<td>"
							+ (rs.getString("Band") == null ? "--"
									: DBtoHTML(rs.getString("Band")))
							+ "</td>");
					out.println("<td>"
							+ (rs.getString("Ort") == null ? "--"
									: DBtoHTML(rs.getString("Ort")))
							+ "</td>");
					out.println("<td>"
							+ (rs.getString("e.Jahr") == null ? "--"
									: DBtoHTML(rs.getString("e.Jahr")))
							+ "</td>");
					out
							.println("<td> "
									+ (rs.getString("qi.Seiten") == null ? (rs.getString("e.Seiten") == null ? "--"
											: DBtoHTML(rs
													.getString("e.Seiten")))
											: DBtoHTML(rs
													.getString("qi.Seiten")))
									+ "</td>");
					out.println("<td>"
							+ ((rs.getString("qi.Nummer") == null ||  rs.getString("qi.Nummer").trim().equals(""))? "--"
									: DBtoHTML(rs.getString("qi.Nummer")))
							+ "</td>");
					if(rs.getString("qi.Nummer") != null && !rs.getString("qi.Nummer").trim().equals("")) showNummer =true;
					out.println("<td>");
					Statement st2 = cn.createStatement();
					ResultSet rs2 = st2
							.executeQuery("select s.Bezeichnung from selektion_editor s, edition_hateditor ehe where ehe.EditionID="
									+ rs.getString("e.ID")
									+ " AND ehe.EditorID=s.ID");
					boolean first = true;
					while (rs2.next()) {
						if (!first)
							out.print(" / ");
						out.print(rs2.getString("s.Bezeichnung"));
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
	rs = st
						.executeQuery("Select e.ID, e.Titel, r.Bezeichnung as Reihe, e.BandNummer as Band, o. Bezeichnung as Ort, e.Jahr, qi.Seiten, e.Seiten, qi.Nummer from ((edition e join quelle_inedition qi on e.ID=qi.EditionID) left join selektion_reihe r on e.ReiheID=r.ID) left join selektion_ort o on e.OrtID=o.ID where qi.QuelleID="
								+ id + " and qi.Standard=0");
				while (rs.next()) {
					
					if(!firstEdition){
					count++;
					if (count % 2 == 0)
						out.println("<tr>");
					else
						out.println("<tr bgcolor='#AACCDD'>");
					   out.println("<td></td>");
					}
 				    firstEdition = false;
					out.println("<td>" + rs.getString("e.Titel")
							+ "</td>");
					out.println("<td>"
							+ (rs.getString("Reihe") == null ? "--"
									: DBtoHTML(rs.getString("Reihe")))
							+ "</td>");
					out.println("<td>"
							+ (rs.getString("Band") == null ? "--"
									: DBtoHTML(rs.getString("Band")))
							+ "</td>");
					out.println("<td>"
							+ (rs.getString("Ort") == null ? "--"
									: DBtoHTML(rs.getString("Ort")))
							+ "</td>");
					out.println("<td>"
							+ (rs.getString("e.Jahr") == null ? "--"
									: DBtoHTML(rs.getString("e.Jahr")))
							+ "</td>");
				out
							.println("<td> "
									+ (rs.getString("qi.Seiten") == null ? (rs.getString("e.Seiten") == null ? "--"
											: DBtoHTML(rs
													.getString("e.Seiten")))
											: DBtoHTML(rs
													.getString("qi.Seiten")))
									+ "</td>");
					out.println("<td>"
							+ ((rs.getString("qi.Nummer") == null ||  rs.getString("qi.Nummer").trim().equals(""))? "--"
									: DBtoHTML(rs.getString("qi.Nummer")))
							+ "</td>");	
					if(rs.getString("qi.Nummer") != null && !rs.getString("qi.Nummer").trim().equals("")) showNummer =true;
					out.println("<td>");

					Statement st2 = cn.createStatement();
					ResultSet rs2 = st2
							.executeQuery("select s.Bezeichnung from selektion_editor s, edition_hateditor ehe where ehe.EditionID="
									+ rs.getString("e.ID")
									+ " AND ehe.EditorID=s.ID");
					boolean first = true;
					while (rs2.next()) {
						if (!first)
							out.print(" / ");
						out.print(rs2.getString("s.Bezeichnung"));
						first = false;
					}
					out.println("</td>");
					out.println("</tr>");
				}

			} catch (Exception e) {
				out.println(e);
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
	Connection cn = null;
			Statement st = null;
			ResultSet rs = null;
			try {
				Class.forName(sqlDriver);
				cn = DriverManager.getConnection(sqlURL, sqlUser,
						sqlPassword);
				st = cn.createStatement();
				rs = st
						.executeQuery("SELECT benutzer.Nachname, benutzer.Vorname, mgh_lemma_"
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
				while (rs.next()) {
					Date date = null;
					Time time = null;
					try {
						date = rs.getDate("mgh_lemma_" + modul
								+ ".Zeitstempel");
						time = rs.getTime("mgh_lemma_" + modul
								+ ".Zeitstempel");
					} catch (SQLException e) {
					}
					out.println("<tr>");
					out
							.println("<td>"
									+ DBtoHTML(rs
											.getString("benutzer.Nachname"))
									+ ", "
									+ DBtoHTML(rs
											.getString("Benutzer.Vorname"))
									+ "</td>");
					out.println("<td>" + (date == null ? "--" : date)
							+ "</td>");
					out.println("<td>" + (time == null ? "--" : time)
							+ "</td>");
					out.println("</tr>");
				}
			} catch (Exception e) {
				out.println(e);
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
	Connection cn = null;
			Statement st = null;
			ResultSet rs = null;
			try {
				Class.forName(sqlDriver);
				cn = DriverManager.getConnection(sqlURL, sqlUser,
						sqlPassword);
				st = cn.createStatement();
				rs = st
						.executeQuery("SELECT einzelbeleg.ID, einzelbeleg.Belegnummer, einzelbeleg.Belegform"
								+ ", person.ID, person.PKZ, person.Standardname"
								+ ", einzelbeleg.VonTag, einzelbeleg.VonMonat, einzelbeleg.VonJahr, einzelbeleg.BisTag, einzelbeleg.BisMonat, einzelbeleg.BisJahr"
								+ " FROM einzelbeleg_hatmghlemma, (einzelbeleg LEFT JOIN einzelbeleg_hatperson ON einzelbeleg.ID = einzelbeleg_hatperson.EinzelbelegID) LEFT JOIN person ON einzelbeleg_hatperson.PersonID = person.ID"
								+ " WHERE einzelbeleg_hatmghlemma.MGHLemmaID = \""
								+ id
								+ "\""
								+ " AND einzelbeleg_hatmghlemma.EinzelbelegID = einzelbeleg.ID"
								+ " ORDER BY einzelbeleg.VonJahr, einzelbeleg.VonMonat, einzelbeleg.VonTag ASC");
				while (rs.next()) {
					out.println("<tr>");
					out.println("<td><a href=\"einzelbeleg?ID="
							+ rs.getInt("einzelbeleg.ID") + "\">");
%>
<jsp:include page="inc.erzeugeBeschriftung.jsp">
	<jsp:param name="Formular" value="mgh_lemma" />
	<jsp:param name="Textfeld" value="ZumBeleg" />
</jsp:include>

<%
	out.println("</a></td>");
					out
							.println("<td>"
									+ (rs
											.getString("einzelbeleg.Belegform") == null ? "&nbsp;"
											: rs
													.getString("einzelbeleg.Belegform"))
									+ "</td>");
					out.println("<td>");
					if (rs.getString("person.PKZ") == null)
						out.println("--");
					else {
						out.println("<a href=\"person?ID="
								+ rs.getInt("person.ID") + "\">");
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
									+ (rs
											.getString("person.Standardname") == null ? "--"
											: DBtoHTML(rs
													.getString("person.Standardname")))
									+ "</td>");
					out.println("<td> "
							+ makeDate(rs.getInt("einzelbeleg.VonTag"),
									rs.getInt("einzelbeleg.VonMonat"),
									rs.getInt("einzelbeleg.VonJahr"))
							+ " - "
							+ makeDate(rs.getInt("einzelbeleg.BisTag"),
									rs.getInt("einzelbeleg.BisMonat"),
									rs.getInt("einzelbeleg.BisJahr"))
							+ "</td>");
					out.println("</tr>");
				}
			} catch (Exception e) {
				out.println(e);
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
	Connection cn = null;
			Statement st = null;
			ResultSet rs = null;
			try {
				Class.forName(sqlDriver);
				cn = DriverManager.getConnection(sqlURL, sqlUser,
						sqlPassword);
				st = cn.createStatement();
				rs = st
						.executeQuery("SELECT benutzer.Nachname, benutzer.Vorname, namenkommentar_"
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
				while (rs.next()) {
					Date date = null;
					Time time = null;
					try {
						date = rs.getDate("namenkommentar_" + modul
								+ ".Zeitstempel");
						time = rs.getTime("namenkommentar_" + modul
								+ ".Zeitstempel");
					} catch (SQLException e) {
					}
					out.println("<tr>");
					out
							.println("<td>"
									+ DBtoHTML(rs
											.getString("benutzer.Nachname"))
									+ ", "
									+ DBtoHTML(rs
											.getString("Benutzer.Vorname"))
									+ "</td>");
					out.println("<td>" + (date == null ? "--" : date)
							+ "</td>");
					out.println("<td>" + (time == null ? "--" : time)
							+ "</td>");
					out.println("</tr>");
				}
			} catch (Exception e) {
				out.println(e);
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
	Connection cn = null;
			Statement st = null;
			ResultSet rs = null;
			try {
				Class.forName(sqlDriver);
				cn = DriverManager.getConnection(sqlURL, sqlUser,
						sqlPassword);
				st = cn.createStatement();
				rs = st
						.executeQuery("SELECT einzelbeleg.ID, einzelbeleg.Belegnummer, einzelbeleg.Belegform"
								+ ", person.ID, person.PKZ, person.Standardname"
								+ ", einzelbeleg.VonTag, einzelbeleg.VonMonat, einzelbeleg.VonJahr, einzelbeleg.BisTag, einzelbeleg.BisMonat, einzelbeleg.BisJahr"
								+ " FROM einzelbeleg_hatnamenkommentar, (einzelbeleg LEFT JOIN einzelbeleg_hatperson ON einzelbeleg.ID = einzelbeleg_hatperson.EinzelbelegID) LEFT JOIN person ON einzelbeleg_hatperson.PersonID = person.ID"
								+ " WHERE einzelbeleg_hatnamenkommentar.NamenkommentarID = \""
								+ id
								+ "\""
								+ " AND einzelbeleg_hatnamenkommentar.EinzelbelegID = einzelbeleg.ID"
								+ " ORDER BY einzelbeleg.VonJahr, einzelbeleg.VonMonat, einzelbeleg.VonTag ASC");
				while (rs.next()) {
					out.println("<tr>");
					out.println("<td><a href=\"einzelbeleg?ID="
							+ rs.getInt("einzelbeleg.ID") + "\">");
%>
<jsp:include page="inc.erzeugeBeschriftung.jsp">
	<jsp:param name="Formular" value="namenkommentar" />
	<jsp:param name="Textfeld" value="ZumBeleg" />
</jsp:include>

<%
	out.println("</a></td>");
					out
							.println("<td>"
									+ (rs
											.getString("einzelbeleg.Belegform") == null ? "&nbsp;"
											: rs
													.getString("einzelbeleg.Belegform"))
									+ "</td>");
					out.println("<td>");
					if (rs.getString("person.PKZ") == null)
						out.println("--");
					else {
						out.println("<a href=\"person?ID="
								+ rs.getInt("person.ID") + "\">");
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
									+ (rs
											.getString("person.Standardname") == null ? "--"
											: DBtoHTML(rs
													.getString("person.Standardname")))
									+ "</td>");
					out.println("<td> "
							+ makeDate(rs.getInt("einzelbeleg.VonTag"),
									rs.getInt("einzelbeleg.VonMonat"),
									rs.getInt("einzelbeleg.VonJahr"))
							+ " - "
							+ makeDate(rs.getInt("einzelbeleg.BisTag"),
									rs.getInt("einzelbeleg.BisMonat"),
									rs.getInt("einzelbeleg.BisJahr"))
							+ "</td>");
					out.println("</tr>");
				}
			} catch (Exception e) {
				out.println(e);
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
			out.println("</table>\n");
		}

		else if (modul.equals("PLemma")) {

			Connection cn = null;
			Statement st = null;
			ResultSet rs = null;
			try {
				Class.forName(sqlDriver);
				cn = DriverManager.getConnection(sqlURL, sqlUser,
						sqlPassword);
				st = cn.createStatement();
				rs = st.executeQuery("SELECT PLemma"
						+ " FROM namenkommentar " + " WHERE ID = \""
						+ id + "\"");
				while (rs.next()) {
					String lemma = rs.getString("PLemma");

					out.println(format(lemma,"PLemma"));

				}
			} catch (Exception e) {
				out.println(e);
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

	}
%>
