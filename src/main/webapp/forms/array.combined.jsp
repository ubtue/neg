
<%
	if (feldtyp.equals("combined") && array) {
	    int count=0;
		out.println("<table "+(isReadOnly?"width=\"100%\"":"")+">\n");
		out.println("<tr>\n");
		for (int i = 0; i < combinedAnzeigenamen.length; i++) {
			out.println("<th>");
			if (!isReadOnly || combinedFeldtypen[i].equals("sqlselect")
					|| combinedFeldtypen[i].equals("select")
					|| combinedFeldtypen[i].equals("textfield")
					|| combinedFeldtypen[i].equals("textarea")
					|| combinedFeldtypen[i].contains("link")
					|| combinedFeldtypen[i].contains("info")
					|| combinedFeldtypen[i].contains("list"))
				out.println(combinedAnzeigenamen[i] + "\n");
			out.println("</th>");
		}
		out.println("</tr>\n");

		String[] zielattributArray = zielAttribut.split(";");
		for (int i = 0; i < zielattributArray.length; i++) {
			zielattributArray[i] = zielattributArray[i].trim();
		}

		if (auswahlherkunft == null)
			auswahlherkunft = "";
		String[] auswahlherkunftArray = auswahlherkunft.split(";");
		for (int i = 0; i < auswahlherkunftArray.length; i++) {
			auswahlherkunftArray[i] = auswahlherkunftArray[i].trim();
		}

		try {
			Class.forName(sqlDriver);
			cn = DriverManager.getConnection(sqlURL, sqlUser,
					sqlPassword);
			st = cn.createStatement();
			rs = st.executeQuery("SELECT * FROM " + zielTabelle
					+ " WHERE " + formularAttribut + "=\"" + id + "\"");
			boolean repeat = true;
			boolean alreadyOne = false;
			int i = 0;
			while (repeat) {
				if (rs.next()) {
					out.println("<input type=\"hidden\" name=\""
							+ datenfeld.toLowerCase() + "[" + i
							+ "]_entryid\" value=\"" + rs.getInt("ID")
							+ "\">");
					alreadyOne = true;
				} else {
					repeat = false;
				}
					count++;
					if (count % 2 == 0)
						out.println("<tr>");
					else
						out.println("<tr bgcolor='#AACCDD'>");

				for (int j = 0; j < combinedFeldtypen.length; j++) {
					if (combinedFeldtypen[j].equals("dateinfo")
							|| combinedFeldtypen[j].equals("addselect"))
						out.println("<td nowrap>");
					else
						out.println("<td>");

					if (combinedFeldtypen[j].equals("textfield")) {
						if (!isReadOnly)
							out
									.println("<input name=\""
											+ combinedFeldnamen[j]
											+ "["
											+ i
											+ "]\""
											+ " value=\""
											+ (repeat
													&& rs.getString(zielattributArray[j]) != null ? DBtoHTML(rs
													.getString(zielattributArray[j]))
													: "")
											+ "\""
											+ " maxlength=\""
											+ rs
													.getMetaData()
													.getColumnDisplaySize(
															rs.findColumn(zielattributArray[j]))
											+ "\" "
											+ (combinedFeldnamen[j]
													.endsWith("ID") ? " size=\"5\""
													: " size=\"10\"")
											+ " />");
						else
							out
									.println((repeat
											&& rs
													.getString(zielattributArray[j]) != null ? DBtoHTML(rs
											.getString(zielattributArray[j]))
											: (alreadyOne?"":"-")));
					}
					else if (combinedFeldtypen[j].equals("textarea")) {
						if (!isReadOnly)
							out
									.println("<textarea name=\""+combinedFeldnamen[j]
											+ "["
											+ i
											+ "]\""+disabled+">"
											+ (repeat
													&& rs.getString(zielattributArray[j]) != null ? DBtoHTML(rs
													.getString(zielattributArray[j]))
													: "")
											+ "</textarea>");
						else
							out
									.println((repeat
											&& rs
													.getString(zielattributArray[j]) != null ? DBtoHTML(rs
											.getString(zielattributArray[j]))
											: (alreadyOne?"":"-")));
					}
					else if (combinedFeldtypen[j].equals("addselect")) {
						int selected = (repeat
								&& rs.getString(zielattributArray[j]) != null ? rs
								.getInt(zielattributArray[j])
								: -1);
						out.println("<select name=\""
								+ combinedFeldnamen[j] + "[" + i
								+ "]\" id=\"" + combinedFeldnamen[j]
								+ "[" + i + "]\" style=\"width:6em\">");
						Statement st2 = null;
						ResultSet rs2 = null;
						st2 = cn.createStatement();
						rs2 = st2.executeQuery("SELECT * FROM "
								+ auswahlherkunftArray[j]
								+ " ORDER BY Bezeichnung ASC");
						while (rs2.next()) {
							out
									.println("<option value=\""
											+ rs2.getInt("ID")
											+ "\" "
											+ (rs2.getInt("ID") == selected ? "selected"
													: "")
											+ ">"
											+ DBtoHTML(rs2
													.getString("Bezeichnung"))
											+ "</option>");
						}
						out.print("</select>");
						out
								.println("<a href=\"javascript:popup('addselect', this, '"
										+ auswahlherkunftArray[j]
												.substring(10)
										+ "', '"
										+ combinedFeldnamen[j]
										+ "["
										+ i
										+ "]', '');\">"
										+ txt_newentry + "</a>");

					}

					else if (combinedFeldtypen[j]
							.equals("addselectandtext")) {
						if (repeat) {
							Statement st2 = null;
							ResultSet rs2 = null;
							st2 = cn.createStatement();
							rs2 = st2.executeQuery("SELECT * FROM "
									+ auswahlherkunftArray[j]
									+ " WHERE ID="
									+ rs.getInt(zielattributArray[j]));

							if (rs2.next())
								out.println(rs2
										.getString("Bezeichnung"));
						} else {
							out.println("<select name=\""
									+ combinedFeldnamen[j] + "[" + i
									+ "]\" id=\""
									+ combinedFeldnamen[j] + "[" + i
									+ "]\" style=\"width:6em\">");
							Statement st2 = null;
							ResultSet rs2 = null;
							st2 = cn.createStatement();
							rs2 = st2.executeQuery("SELECT * FROM "
									+ auswahlherkunftArray[j]
									+ " ORDER BY Bezeichnung ASC");
							while (rs2.next()) {
								out
										.println("<option value=\""
												+ rs2.getInt("ID")
												+ "\""
												+ (rs2.getInt("ID") == -1 ? "selected"
														: "")
												+ ">"
												+ DBtoHTML(rs2
														.getString("Bezeichnung"))
												+ "</option>");
							}
							out.print("</select>");
							out
									.println("<a href=\"javascript:popup('addselect', this, '"
											+ auswahlherkunftArray[j]
													.substring(10)
											+ "', '"
											+ combinedFeldnamen[j]
											+ "["
											+ i
											+ "]', '');\">"
											+ txt_newentry + "</a>");

						}

					}

					else if (combinedFeldtypen[j].equals("select")) {
						Statement st2 = null;
						ResultSet rs2 = null;
						if (!isReadOnly)
							out.println("<select name=\""
									+ combinedFeldnamen[j] + "[" + i
									+ "]\" style=\"width:8em\">");
						try {
							st2 = cn.createStatement();
							rs2 = st2.executeQuery("SELECT * FROM "
									+ auswahlherkunftArray[j]
									+ " ORDER BY Bezeichnung ASC");
							int selected = (repeat
									&& rs
											.getString(zielattributArray[j]) != null ? rs
									.getInt(zielattributArray[j])
									: -1);
							while (rs2.next()) {
								if (!isReadOnly)
									out
											.println("<option value='"
													+ rs2.getInt("ID")
													+ "' "
													+ (rs2.getInt("ID") == selected ? "selected"
															: "")
													+ ">"
													+ rs2
															.getString("Bezeichnung")
													+ "</option>");
								else if (rs2.getInt("ID") == selected)
									   if (repeat)
									   out.println(rs2
											.getString("Bezeichnung"));
									else if(!alreadyOne)out.println("-");
							}
						} finally {
							try {
								if (null != rs2)
									rs2.close();
							} catch (Exception ex) {
							}
							try {
								if (null != st2)
									st2.close();
							} catch (Exception ex) {
							}
						}
						if (!isReadOnly)
							out.println("</select>");
					}

					else if (combinedFeldtypen[j].equals("subtable")) {
						String sql = "";
						Statement st2 = null;
						ResultSet rs2 = null;
						out.println("<table>");
						try {
							if (repeat) {
								sql = "SELECT edition.ID, edition.Zitierweise Bezeichnung FROM quelle_inedition, edition WHERE quelle_inedition.QuelleID=  "
										+ rs.getString("QuelleID")
										+ " AND quelle_inedition.editionID=edition.ID ORDER BY Bezeichnung ASC";
							}
							st2 = cn.createStatement();
							if (!sql.equals(""))
								rs2 = st2.executeQuery(sql);
							int i2 = 0;
							if (!sql.equals(""))
								while (rs2.next()) {
									Statement st3 = cn
											.createStatement();
									ResultSet rs3 = st3
											.executeQuery("Select Sigle from ueberlieferung_edition where ueberlieferung_edition.editionID="
													+ rs2
															.getString("ID")
													+ " AND ueberlieferung_edition.ueberlieferungID="
													+ rs.getInt("ID"));
									out
											.println("<tr><td><a href=\"edition?ID="
													+ rs2
															.getString("ID")
													+ "\">"
													+ rs2
															.getString("Bezeichnung")
													+ "</a><input type=hidden name=\""
													+ combinedFeldnamen[j]
													+ "_ed["
													+ i
													+ "]["
													+ i2
													+ "]\""
													+ " value=\""
													+ rs2
															.getString("ID")
													+ "\"/></td><td><input name=\""
													+ combinedFeldnamen[j]
													+ "["
													+ i
													+ "]["
													+ i2
													+ "]\""
													+ " value=\""
													+ (rs3.next() ? DBtoHTML(rs3
															.getString("Sigle"))
															: "")
													+ "\""
													+ " maxlength=\""
													+ "\" "
													+ (combinedFeldnamen[j]
															.endsWith("ID") ? " size=\"5\""
															: " size=\"10\"")
													+ " /></td></tr>");
									i2++;
								}
						} catch (Exception e) {
							out.println(e);
						} finally {
							try {
								if (null != rs2)
									rs2.close();
							} catch (Exception ex) {
							}
							try {
								if (null != st2)
									st2.close();
							} catch (Exception ex) {
							}
						}
						out.println("</table>");
					}

					else if (combinedFeldtypen[j].equals("checkbox")) {
						if (!isReadOnly)
							out
									.println("<input name=\""
											+ combinedFeldnamen[j]
											+ "["
											+ i
											+ "]\""
											+ " type=\"checkbox\""
											+ (repeat
													&& (rs
															.getInt(zielattributArray[j]) == 1) ? " checked"
													: "") + " />");

					}

					else if (combinedFeldtypen[j].equals("sqlselect")) {
						String sql = "";
						Statement st2 = null;
						ResultSet rs2 = null;
						if (!isReadOnly)
							out.println("<select name=\""
									+ combinedFeldnamen[j] + "[" + i
									+ "]\" style=\"width:8em\">");
						try {
							if (combinedFeldnamen[j]
									.equals("TKHandschrift")) {
								if (repeat)
									sql = "SELECT handschrift_ueberlieferung.ID, ueberlieferung_edition.Sigle Bezeichnung FROM handschrift_ueberlieferung, einzelbeleg, ueberlieferung_edition WHERE handschrift_ueberlieferung.ID=ueberlieferung_edition.UeberlieferungID and ueberlieferung_edition.EditionID= "
											+ rs.getString("EditionID")
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
							if (combinedFeldnamen[j]
									.equals("HSEditionID")) {
								// out.println(rs.getString("QuelleID"));
								if (repeat)
									sql = "SELECT edition.ID, edition.Titel Bezeichnung FROM quelle_inedition, edition WHERE quelle_inedition.QuelleID=  "
											+ rs.getString("QuelleID")
											+ " AND quelle_inedition.editionID=edition.ID ORDER BY Bezeichnung ASC";
							}
							st2 = cn.createStatement();
							if (!sql.equals(""))
								rs2 = st2.executeQuery(sql);
							int selected = (repeat
									&& rs
											.getString(zielattributArray[j]) != null ? rs
									.getInt(zielattributArray[j])
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
                                                        
							if (!isReadOnly)
								out
										.println("<option value=\"NULL\" "+selectForm.get(-1)+">nicht bearbeitet</option>");
							if (!isReadOnly)
								out
										.println("<option value=\"0\" "+selectForm.get(0)+">unklar</option>");
							if (!sql.equals(""))
								while (rs2.next()) {
									if (!isReadOnly)
										out
												.println("<option value='"
														+ rs2
																.getInt("ID")
														+ "' "
														+ (rs2
																.getInt("ID") == selected ? "selected"
																: "")
														+ ">"
														+ rs2
																.getString("Bezeichnung")
														+ "</option>");
									else if (repeat
											&& rs2.getInt("ID") == selected
											&& combinedFeldnamen[j]
													.equals("TKHandschrift"))
										out
												.println(rs2
														.getString("Bezeichnung"));
								}
						} catch (Exception e) {
							out.println(e);
						} finally {
							try {
								if (null != rs2)
									rs2.close();
							} catch (Exception ex) {
							}
							try {
								if (null != st2)
									st2.close();
							} catch (Exception ex) {
							}
						}
						out.println("</select>");
					}

					else if (combinedFeldtypen[j].equals("checkbox")) {
						if (!isReadOnly)
							out
									.println("<input name=\""
											+ combinedFeldnamen[j]
											+ "["
											+ i
											+ "]\""
											+ " type=\"checkbox\""
											+ (repeat
													&& (rs
															.getInt(zielattributArray[j]) == 1) ? " checked"
													: "") + " />");
					}

					else if (combinedFeldtypen[j].startsWith("link")) {
						String[] fields = combinedFeldtypen[j]
								.substring(
										combinedFeldtypen[j]
												.lastIndexOf('(') + 1,
										combinedFeldtypen[j]
												.lastIndexOf(')'))
								.split(",");

						if (repeat) {
							Statement st2 = null;
							ResultSet rs2 = null;
							try {
								st2 = cn.createStatement();
								rs2 = st2.executeQuery("SELECT "
										+ fields[2] + " FROM "
										+ fields[0] + " WHERE ID="
										+ rs.getInt(fields[1]) + ";");
								if (rs2.next()) {
									
									String add = fields[0];
					            	 if(add.equals("mgh_lemma"))add="mghlemma";

									
									out
											.println("<a href=\""
													+ add
													+ "?ID="
													+ rs
															.getInt(fields[1])
													+ "\">");
									out.println( (rs2
															.getString(fields[2]) != null ? DBtoHTML(rs2
															.getString(fields[2]))
															: "Zum Datensatz"));
									out.println( "</a>");
								}
							} catch (Exception e) {
								out.println(e);
							} finally {
								try {
									if (null != rs2)
										rs2.close();
								} catch (Exception ex) {
								}
								try {
									if (null != st2)
										st2.close();
								} catch (Exception ex) {
								}
							}
						}
					}
					else if (combinedFeldtypen[j].startsWith("info")) {
						String[] fields = combinedFeldtypen[j]
								.substring(
										combinedFeldtypen[j]
												.lastIndexOf('(') + 1,
										combinedFeldtypen[j]
												.lastIndexOf(')'))
								.split(",");

						if (repeat) {
							Statement st2 = null;
							ResultSet rs2 = null;
							try {
								st2 = cn.createStatement();
								rs2 = st2.executeQuery("SELECT "
										+ fields[2] + " FROM "
										+ fields[0] + " WHERE ID="
										+ rs.getInt(fields[1]) + ";");
								if (rs2.next()) {
									out.println( (rs2
															.getString(fields[2]) != null ? DBtoHTML(rs2
															.getString(fields[2]))
															: ""));
								}
							} catch (Exception e) {
								out.println(e);
							} finally {
								try {
									if (null != rs2)
										rs2.close();
								} catch (Exception ex) {
								}
								try {
									if (null != st2)
										st2.close();
								} catch (Exception ex) {
								}
							}
						}
					}

	else if (combinedFeldtypen[j].startsWith("list")) {
						String[] fields = combinedFeldtypen[j]
								.substring(
										combinedFeldtypen[j]
												.lastIndexOf('(') + 1,
										combinedFeldtypen[j]
												.lastIndexOf(')'))
								.split(",");

						if (repeat) {
							Statement st2 = null;
							ResultSet rs2 = null;
							try {
								st2 = cn.createStatement();
								rs2 = st2.executeQuery("SELECT Bezeichnung FROM selektion_"+
								            fields[0]+" sel, einzelbeleg_hat"+fields[0]+" zt WHERE zt."+
								            fields[0]+"ID=sel.ID AND zt."+fields[1]+"="
										+ rs.getInt(fields[1]) + ";");
								while (rs2.next()) {
									out.println( (rs2.getString("Bezeichnung") != null ? DBtoHTML(rs2.getString("Bezeichnung"))
															: ""));
									out.println("<br>");
								}
							} catch (Exception e) {
								out.println(e);
							} finally {
								try {
									if (null != rs2)
										rs2.close();
								} catch (Exception ex) {
								}
								try {
									if (null != st2)
										st2.close();
								} catch (Exception ex) {
								}
							}
						}
					}

	else if (combinedFeldtypen[j].startsWith("date(")) {
						String[] fields = combinedFeldtypen[j]
								.substring(
										combinedFeldtypen[j]
												.lastIndexOf('(') + 1,
										combinedFeldtypen[j]
												.lastIndexOf(')'))
								.split(",");

						if (repeat) {
							Statement st2 = null;
							ResultSet rs2 = null;
							try {
								st2 = cn.createStatement();
								rs2 = st2.executeQuery("SELECT VonTag, VonMonat, VonJahr, BisTag, BisMonat,BisJahr FROM "
										+ fields[0] + " WHERE ID="
										+ rs.getInt(fields[1]) + ";");
								if (rs2.next()) {
									out.println( makeDate(rs2.getInt("VonTag"), rs2
									.getInt("VonMonat"), rs2
									.getInt("VonJahr"))
							+ " - "
							+ makeDate(rs2.getInt("BisTag"), rs2
									.getInt("BisMonat"), rs2
									.getInt("BisJahr")));
								}
							} catch (Exception e) {
								out.println(e);
							} finally {
								try {
									if (null != rs2)
										rs2.close();
								} catch (Exception ex) {
								}
								try {
									if (null != st2)
										st2.close();
								} catch (Exception ex) {
								}
							}
						}
					}

					else if (combinedFeldtypen[j].startsWith("search")) {
						String[] fields = combinedFeldtypen[j]
								.substring(
										combinedFeldtypen[j]
												.lastIndexOf('(') + 1,
										combinedFeldtypen[j]
												.lastIndexOf(')'))
								.split(",");
						if (!isReadOnly)
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

					else if (combinedFeldtypen[j].equals("dateinfo")) {
						if (repeat) {
							out.println("<label id=\"quelleDate["
									+ i
									+ "]\">"
									+ rs.getInt(combinedFeldnamen[j]
											+ "VonJahr")
									+ "("
									+ rs.getInt(combinedFeldnamen[j]
											+ "VonJahrhundert")
									+ ". Jhd)-"
									+ rs.getInt(combinedFeldnamen[j]
											+ "BisJahr")
									+ "("
									+ rs.getInt(combinedFeldnamen[j]
											+ "BisJahrhundert")
									+ ". Jhd)</label>");
							out
									.println("<a href=\"javascript:popup('changedate', this, '', 'quelleDate["
											+ i
											+ "]', '"
											+ rs.getInt("ID")
											+ "');\"><img src=\"layout/icons/calendar.gif\" border=0></a>");
						}
					}

					else {
						out.println("folgt!");
					}
					out.println("</td>");
				}
				if (repeat && !isReadOnly) {
					String href = "javascript:deleteEntry('"
							+ zielTabelle + "', '" + rs.getInt("ID")
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
%>
