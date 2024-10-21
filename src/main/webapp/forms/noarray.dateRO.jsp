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

        if (row.get("VonTag") == null) {
            row.put("VonTag", 0);
        }

        if (row.get("VonMonat") == null) {
            row.put("VonMonat", 0);
        }

        if (row.get("VonJahr") == null) {
            row.put("VonJahr", 0);
        }

        if (row.get("VonJahrhundert") == null) {
            row.put("VonJahrhundert", "0");
        }

        if (row.get("BisTag") == null) {
            row.put("BisTag", 0);
        }

        if (row.get("BisMonat") == null) {
            row.put("BisMonat", 0);
        }

        if (row.get("BisJahr") == null) {
            row.put("BisJahr", 0);
        }

        if (row.get("BisJahrhundert") == null) {
            row.put("BisJahrhundert", "0");
        }

        if (row.get("QuelleVonTag") == null) {
            row.put("QuelleVonTag", 0);
        }

        if (row.get("QuelleVonMonat") == null) {
            row.put("QuelleVonMonat", 0);
        }

        if (row.get("QuelleVonJahr") == null) {
            row.put("QuelleVonJahr", 0);
        }

        if (row.get("QuelleVonJahrhundert") == null) {
            row.put("QuelleVonJahrhundert", "0");
        }

        if (row.get("QuelleBisTag") == null) {
            row.put("QuelleBisTag", 0);
        }

        if (row.get("QuelleBisMonat") == null) {
            row.put("QuelleBisMonat", 0);
        }

        if (row.get("QuelleBisJahr") == null) {
            row.put("QuelleBisJahr", 0);
        }

        if (row.get("QuelleBisJahrhundert") == null) {
            row.put("QuelleBisJahrhundert", "0");
        }

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
                vonGen = row2.get("Bezeichnung") != null ? String.valueOf(row2.get("Bezeichnung")) : "";
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
                bisGen = row2.get("Bezeichnung") != null ? String.valueOf(row2.get("Bezeichnung")) : "";
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
