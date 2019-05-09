
<%
	if (feldtyp.equals("dateRO") && !array) {

		String[] zielattributArray = zielAttribut.split(";");
		for (int i = 0; i < zielattributArray.length; i++) {
			zielattributArray[i] = zielattributArray[i].trim();
		}
		String results[] = new String[zielattributArray.length * 2];

		try {
			Class.forName(sqlDriver);
			cn = DriverManager.getConnection(sqlURL, sqlUser,
					sqlPassword);
			st = cn.createStatement();
			String zielattribute = "Genauigkeit" + zielattributArray[0]
					+ ", " + zielattributArray[0];
			for (int i = 1; i < zielattributArray.length; i++) {
				zielattribute += ", Genauigkeit" + zielattributArray[i]
						+ ", " + zielattributArray[i];
			}

			rs = st.executeQuery("SELECT " + zielattribute + " FROM "
					+ zielTabelle + " WHERE ID ='" + id + "'");

			boolean next = false;

			if (rs.next()) {

				for (int i = 0; i < zielattributArray.length * 2; i++) {
					results[i] = rs.getString(i + 1);
				}
				String von = "";
				String vonGen = "";
				String bis = "";
				String bisGen = "";

				for (int i = 0; i < zielattributArray.length - 1; i++) {
					if (i % 2 == 0) {
						if (vonGen.equals("") || vonGen.equals("-1")) {
							vonGen = results[i];
						}
					} else if (results[i] != null
							&& !results[i].equals("")
							&& !results[i].equals("0"))
						von += results[i]
								+ (((i % (zielattributArray.length)) < 4) ? "."
										: "");
				}
				if (von.equals("")
						&& results[zielattributArray.length - 1] != null
						&& !results[zielattributArray.length - 1]
								.equals("0")) {
					if (vonGen.equals("") || vonGen.equals("-1")) {
						vonGen = results[zielattributArray.length - 2];
					}
					von = results[zielattributArray.length - 1];
				}
				for (int i = zielattributArray.length; i < zielattributArray.length * 2 - 1; i++) {
					if (i % 2 == 0) {
						if (bisGen.equals("") || bisGen.equals("-1"))
							bisGen = results[i];
					} else if (results[i] != null
							&& !results[i].equals("")
							&& !results[i].equals("0"))
						bis += results[i]
								+ (((i % (zielattributArray.length)) < 4) ? "."
										: "");
				}

				Statement st2 = cn.createStatement();
				ResultSet rs2 = null;
				rs2 = st2.executeQuery("SELECT * FROM selektion_datgenauigkeit WHERE ID=" + vonGen);
				if(rs2.next() && !vonGen.equals("-1")) vonGen = rs2.getString("Bezeichnung");
				else vonGen = "";
				
				
				if (bis.equals("")
						&& results[zielattributArray.length - 1] != null
						&& !results[zielattributArray.length - 1]
								.equals("0")) {
					if (bisGen.equals("") || bisGen.equals("-1")) {
						bisGen = results[zielattributArray.length * 2 - 2];
					}
					bis = results[zielattributArray.length * 2 - 1];
				}
				rs2 = st2.executeQuery("SELECT * FROM selektion_datgenauigkeit WHERE ID=" + bisGen);
				if(rs2.next() && !bisGen.equals("-1")) bisGen = rs2.getString("Bezeichnung");
				else bisGen = "";

				if (!bis.equals(von) && !bis.equals(""))
					out.println(vonGen +" " + von + "-" + bisGen +" " + bis);
				else
					out.println(vonGen +" " + von);
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
%>
