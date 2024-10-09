<%@ page import="de.uni_tuebingen.ub.nppm.db.*" isThreadSafe="false" %>
<%@ page import="java.util.Map" isThreadSafe="false" %>
<%@ page import="java.util.List" isThreadSafe="false" %>

<%
    if (feldtyp.equals("dateRO") && !array) {

        String[] zielattributArray = zielAttribut.split(";");
        for (int i = 0; i < zielattributArray.length; i++) {
            zielattributArray[i] = zielattributArray[i].trim();
        }
        String results[] = new String[zielattributArray.length * 2];

        String zielattribute = "Genauigkeit" + zielattributArray[0]
                + ", " + zielattributArray[0];
        for (int i = 1; i < zielattributArray.length; i++) {
            zielattribute += ", Genauigkeit" + zielattributArray[i]
                    + ", " + zielattributArray[i];
        }

        Map row = AbstractBase.getMappedRow("SELECT " + zielattribute + " FROM "
                + zielTabelle + " WHERE ID ='" + id + "'");

        if (row != null) {

            int resultIndex = 0;
            for (String zielattribut : zielattributArray) {
                String zielattributGen = "Genauigkeit" + zielattribut;
                if (row.get(zielattributGen) != null) {
                    results[resultIndex++] = row.get(zielattributGen).toString();
                }
                if (row.get(zielattribut) != null) {
                    results[resultIndex++] = row.get(zielattribut).toString();
                }
            }
            String von = "";
            String vonGen = "";
            String bis = "";
            String bisGen = "";

            for (int i = 0; i < zielattributArray.length - 1; i++) {
                if (i % 2 == 0) {
                    if (vonGen == null || vonGen.equals("") || vonGen.equals("-1")) {
                        if (results[i] != null) {
                            vonGen = results[i]; 
                        }
                    }
                } else if (results[i] != null
                        && !results[i].equals("")
                        && !results[i].equals("0")) {
                    von += results[i]
                            + (((i % (zielattributArray.length)) < 4) ? "."
                                    : "");
                }
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
                    if (bisGen == null || bisGen.equals("") || bisGen.equals("-1")) {
                        bisGen = results[i];
                    }
                } else if (results[i] != null
                        && !results[i].equals("")
                        && !results[i].equals("0")) {
                    bis += results[i]
                            + (((i % (zielattributArray.length)) < 4) ? "."
                                    : "");
                }
            }

            Map row2 = AbstractBase.getMappedRow("SELECT * FROM selektion_datgenauigkeit WHERE ID=" + vonGen);
            if (row2 != null && !vonGen.equals("-1")) {
                vonGen =  String.valueOf(row2.get("Bezeichnung"));
            } else {
                vonGen = "";
            }

            if (bis.equals("")
                    && results[zielattributArray.length - 1] != null
                    && !results[zielattributArray.length - 1]
                            .equals("0")) {
                if (bisGen == null || bisGen.equals("") || bisGen.equals("-1")) {
                    bisGen = results[zielattributArray.length * 2 - 2];
                }
                bis = results[zielattributArray.length * 2 - 1];
            }

            row2 = AbstractBase.getMappedRow("SELECT * FROM selektion_datgenauigkeit WHERE ID=" + bisGen);
            if (row2 != null && !bisGen.equals("-1")) {
                bisGen = String.valueOf(row2.get("Bezeichnung"));
            } else {
                bisGen = "";
            }

            if (bis != null && von != null && !bis.equals(von) && !bis.equals("")) {
                out.println(vonGen + " " + von + "-" + bisGen + " " + bis);
            } else {
                if (von != null) {
                    out.println(vonGen + " " + von);
                }
            }
        }
    }
%>
