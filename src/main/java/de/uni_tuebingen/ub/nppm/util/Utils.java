package de.uni_tuebingen.ub.nppm.util;

import java.io.IOException;
import java.io.PrintWriter;
import java.io.StringWriter;
import java.math.BigInteger;
import java.net.URLEncoder;
import java.util.List;
import java.util.Map;
import java.util.Vector;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.jsp.JspWriter;
import org.apache.commons.lang3.StringEscapeUtils;

public class Utils {

    public static boolean isNumeric(String str) {
        try {
            Integer.parseInt(str);
        } catch (NumberFormatException numberFormatException) {
            return false;
        }
        return true;
    }

    public static String getBaseUrl(HttpServletRequest request) {
        String scheme = request.getScheme();
        String host = request.getServerName();
        int port = request.getServerPort();
        String contextPath = request.getContextPath();

        String baseUrl = scheme + "://" + host + ((("http".equals(scheme) && port == 80) || ("https".equals(scheme) && port == 443)) ? "" : ":" + port) + contextPath;
        return baseUrl;
    }

    public static int determineId(HttpServletRequest request, HttpServletResponse response, String formular, JspWriter out) throws Exception {
        int id = Constants.UNDEFINED_ID;

        String reqID = request.getParameter("ID");
        if (reqID != null && Utils.isNumeric(reqID)) {
            id = Integer.parseInt(reqID);
        }

        String sql = Filter.getFilterSql(request, formular);

        if (id == Constants.UNDEFINED_ID) { //no id is set as parameter
            try {
                //get id from the first result of the filter
                id = Filter.getFirstFilterResult(sql, formular);
            } catch (Exception e) {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, e.getLocalizedMessage());
            }
        } else if (id != Constants.NEW_ITEM) {
            try {
                //count
                BigInteger res = Filter.countFilterItems(sql);
                if (res != null) {
                    if (res.intValue() == 0) {
                        //no items with this filter
                        id = -1;
                    } else {
                        Integer ret = Filter.existIdInFilter(sql, formular, id);
                        if (ret == null) {
                            response.sendError(HttpServletResponse.SC_NOT_FOUND, "ID nicht gefunden");
                        }
                    }
                }
            } catch (Exception e) {
                response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, e.getLocalizedMessage());
            }
        }
        return id;
    }

    public static String escapeJS(String s) {
        return StringEscapeUtils.escapeEcmaScript(s);
    }

    public static String escapeHTML(String s) {
        return StringEscapeUtils.escapeHtml4(s);
    }

    public static String unescapeHTML(String s) {
        return StringEscapeUtils.unescapeHtml4(s);
    }

    public static String urlEncode(String s) {
       return URLEncoder.encode(s);
    }



    public static String format(String text, String feld) {
        if (!feld.endsWith("PLemma") && !feld.endsWith("MGHLemma") && !feld.endsWith("Klarlemma")) {
            return text;
        }

        String lemma = text;
        lemma = lemma.replaceAll("@-e1", "&#x01E3;");
        lemma = lemma.replaceAll("@-E1", "&#x01E2;");
        lemma = lemma.replaceAll("@!d", "&thorn;");
        lemma = lemma.replaceAll("@-I", "&#x012A;");
        lemma = lemma.replaceAll("@-i", "&#x012B;");
        lemma = lemma.replaceAll("@-A", "&#x0100;");
        lemma = lemma.replaceAll("@-a", "&#x0101;");
        lemma = lemma.replaceAll("@-O", "&#x014C;");
        lemma = lemma.replaceAll("@-o", "&#x014D;");
        lemma = lemma.replaceAll("@-E2", "&#x0112;");
        lemma = lemma.replaceAll("@-e2", "&#x0113;");
        lemma = lemma.replaceAll("@-E", "&#x0112;");
        lemma = lemma.replaceAll("@-e", "&#x0113;");
        lemma = lemma.replaceAll("@-U", "&#x016A;");
        lemma = lemma.replaceAll("@-u", "&#x016B;");
        if (!lemma.equals("-")) {
            lemma = lemma.replace("-", "");
        }
        lemma = lemma.replaceAll("~", "");
        lemma = lemma.replaceAll("\\.", "");

        if (lemma.length() > 1) {
            lemma = lemma.substring(0, 1).toUpperCase()
                    + lemma.substring(1);
        } else if (lemma.length() > 0) {
            lemma = lemma.substring(0, 1).toUpperCase();
        }

        if (lemma.startsWith("&#x01E3;")) {
            lemma = "&#x01E2;" + lemma.substring(8);
        }
        if (lemma.startsWith("&#x012B;")) {
            lemma = "&#x012A;" + lemma.substring(8);
        }
        if (lemma.startsWith("&thorn;")) {
            lemma = "&THORN;" + lemma.substring(7);
        }
        if (lemma.startsWith("&#x0101;")) {
            lemma = "&#x0100;" + lemma.substring(8);
        }
        if (lemma.startsWith("&#x014D;")) {
            lemma = "&#x014C;" + lemma.substring(8);
        }
        if (lemma.startsWith("&#x0113;")) {
            lemma = "&#x0112;" + lemma.substring(8);
        }
        if (lemma.startsWith("&#x016B;")) {
            lemma = "&#x016A;" + lemma.substring(8);
        }

        return lemma;
    }

    public static void simpleSearch(JspWriter out, Vector<String> headlines, Vector<String> fieldNames, List<Map> rsMap, String orderV[], String order, String open, boolean countTables) throws IOException {

        int topCount = 0;
        try {
            String header = "";
            int orderSize = orderV.length;
            boolean[] first = {true, true, true, true, true, true, true, true, true, true, true, true, true, true, true};  //kann mann vielleicht löschen ?!
            String oldValue[] = new String[15];
            String export = "browse";
            header += "<tr>";
            for (int i = 0; i < headlines.size(); i++) {
                if (fieldNames.get(i).endsWith("Jahrhundert") || fieldNames.get(i).endsWith("Jahr") || fieldNames.get(i).endsWith("Monat") || fieldNames.get(i).endsWith("Tag") || !order.contains(fieldNames.get(i))) {
                    header += "<th width=\"" + (100 / headlines.size()) + "%\" class=\"resultlist\">";
                    header += headlines.get(i);
                    header += "</th>";
                }
            }
            boolean even = false;
            header += "</tr>";

            if (orderSize == 0) {
                out.print("<table class=\"resultlist\" width=\"100%\">" + header + "<tr>");
            }

            for (Map rs : rsMap) {
                for (int z = 0; z < orderSize; z++) {
                    int jahr = 0;
                    int zeitraum = 0;
                    String jahrV = "";
                    if (rs.get(orderV[z]) == null) {
                        jahrV = "";
                        jahr = 0;
                    } else {
                        jahrV = rs.get(orderV[z]).toString();

                        if (orderV[z].endsWith("Jahr")) {
                            zeitraum = 25;
                            jahr = Integer.parseInt(jahrV);
                            jahr = jahr / zeitraum;
                            jahrV = "" + jahr;
                        }

                    }

                    if (first[z] || rs.get(orderV[z]) != null && !jahrV.equalsIgnoreCase(oldValue[z])) {
                        oldValue[z] = jahrV;
                        if (!first[z]) {
                            out.print("</table>");
                            for (int z2 = z; z2 < orderSize; z2++) {
                                out.print("</ul></li>");
                            }

                        }
                        first[z] = false;
                        for (int z2 = z + 1; z2 < orderSize; z2++) {
                            first[z2] = true;
                        }

                        if (z > 0) {
                            out.print("<li class=\"liClosed\" style=\"font-size:medium\">");
                        } else {
                            out.print("<li class=\"liOpen\" style=\"font-size:large\">");
                        }

                        String text = "";
                        if (rs.get(orderV[z]) == null) {
                            text = "-";
                        } else {
                            text = rs.get(orderV[z]).toString();
                        }

                        if (orderV[z].startsWith("einzelbelegID")) {
                            text = rs.get("Belegform").toString();
                        }

                        String titel = orderV[z];

                        if (orderV[z].startsWith("einzelbelegID")) {
                            titel = "Belegform";
                        }

                        titel = headlines.get(fieldNames.indexOf(titel));

                        out.print(titel + ": ");
                        boolean link = false;

                        if (!text.equals("-")) {
                            if (orderV[z].equals("einzelbelegID") && rs.get("einzelbelegID") != null) {
                                out.print("<a href=\"einzelbeleg?ID=" + (int) rs.get("einzelbelegID") + "\">");
                                link = true;
                            } else if (orderV[z].equals("e2ID") && rs.get("e2ID") != null) {
                                out.print("<a href=\"einzelbeleg?ID=" + (int) rs.get("e2ID") + "\">");
                                link = true;
                            } else if (orderV[z].equals("Standardname") && rs.get("personID") != null) {
                                out.print("<a href=\"person?ID=" + (int) rs.get("personID") + "\">");
                                link = true;
                            } else if (orderV[z].equals("perszuStandardname") && rs.get("perszuID") != null) {
                                out.print("<a href=\"person?ID=" + (int) rs.get("perszuID") + "\">");
                                link = true;
                            } else if (orderV[z].equals("PLemma") && rs.get("namenkommentarID") != null) {
                                out.print("<a href=\"namenkommentar?ID=" + (int) rs.get("namenkommentarID") + "\">");
                                link = true;
                            } else if (orderV[z].equals("MGHLemma") && rs.get("mgh_lemmaID") != null) {
                                out.print("<a href=\"mghlemma?ID=" + (int) rs.get("mgh_lemmaID") + "\">");
                                link = true;
                            } else if (orderV[z].equals("Bezeichnung") && rs.get("quelleID") != null) {                              // ?
                                out.print("<a href=\"quelle?ID=" + (int) rs.get("quelleID") + "\">");
                                link = true;
                            }
                            /* only for Administrator old code maybe for later use
                            else if (orderV[z].equals("editionTitel") && rs.get("editionID") != null) {
                                try {
                                    out.print("<a href=\"edition?ID=" + (int) rs.get("editionID") + "\">");
                                    link = true;
                                } catch (Exception e) {
                                    link = false;
                                }
                            } */

                        }

                        if (orderV[z].startsWith("einzelbelegID")) {
                            out.print(format(escapeHTML(text), "Belegform"));
                        } else if (orderV[z].endsWith("Jahr")) {
                            int ja = Integer.parseInt(oldValue[z]);
                            out.print("" + (ja * zeitraum) + "-" + ((ja + 1) * zeitraum - 1));
                        } else {

                            String format = orderV[z];
                            if (orderV[z].equals("Erstglied") || orderV[z].equals("Zweitglied")) {
                                format = "PLemma";
                            }
                            out.print(format(escapeHTML(text), format));
                        }
                        if (link) {
                            out.print("</a> ");
                        } else {
                            out.print(" ");
                        }

                        if (z == orderSize - 1) {
                            out.print("<ul><table class=\"resultlist\" width=\"100%\">" + header + "<tr>");
                        } else {
                            out.print("<ul>");
                        }

                    }
                }

                out.print("<tr class=\"" + (even ? "" : "un") + "even\">");

                for (int i = 0; i < fieldNames.size(); i++) {
                    if (fieldNames.get(i).endsWith("Jahrhundert") || fieldNames.get(i).endsWith("Jahr") || fieldNames.get(i).endsWith("Monat") || fieldNames.get(i).endsWith("Tag") || !order.contains(fieldNames.get(i))) {
                        out.print("<td class=\"resultlist\" valign=\"top\">");

                        if (rs.get(fieldNames.get(i)) != null && !escapeHTML(rs.get(fieldNames.get(i)).toString()).equals("")) {
                            String cell = escapeHTML(rs.get(fieldNames.get(i)).toString());
                            boolean link = false;

                            if (fieldNames.get(i).contains("Belegform") && rs.get("einzelbelegID") != null) {
                                out.print("<a href=\"einzelbeleg?ID=" + (int) rs.get("einzelbelegID") + "\">");
                                link = true;
                            }
                            if (fieldNames.get(i).contains("Belegform") && rs.get("e2ID") != null) {
                                out.print("<a href=\"einzelbeleg?ID=" + (int) rs.get("e2ID") + "\">");
                                link = true;
                            } else if (fieldNames.get(i).contains("Standardname") && rs.get("personID") != null) {
                                out.print("<a href=\"person?ID=" + (int) rs.get("personID") + "\">");
                                link = true;
                            } else if (fieldNames.get(i).contains("perszuStandardname") && rs.get("perszuID") != null) {
                                out.print("<a href=\"person?ID=" + (int) rs.get("perszuID") + "\">");
                                link = true;
                            } else if (fieldNames.get(i).contains("PLemma") && rs.get("namenkommentarID") != null) {
                                out.print("<a href=\"namenkommentar?ID=" + (int) rs.get("namenkommentarID") + "\">");
                                link = true;
                            } else if (fieldNames.get(i).contains("MGHLemma") && rs.get("mgh_lemmaID") != null) {
                                out.print("<a href=\"mghlemma?ID=" + (int) rs.get("mgh_lemmaID") + "\">");
                                link = true;
                            } else if (fieldNames.get(i).contains("Bezeichnung") && rs.get("quelleID") != null) {        //?
                                out.print("<a href=\"quelle?ID=" + (int) rs.get("quelleID") + "\">");
                                link = true;
                            }
                            /* only for Administrator old code maybe for later use
                            else if (fieldNames.get(i).contains("editionTitel")) { //vielleicht löschen
                                try {
                                    out.print("<a href=\"edition?ID=" + (int) rs.get("editionID") + "\">");
                                    link = true;
                                } catch (Exception e) {
                                    link = false;
                                }
                            }
                             */

                            if (fieldNames.get(i).endsWith("PLemma") || fieldNames.get(i).equals("Erstglied") || fieldNames.get(i).equals("Zweitglied")) {
                                cell = format(cell, "PLemma");
                            }
                            out.print(cell);
                            if (link) {
                                out.print("</a> ");
                            }
                        } else {
                            out.print("&nbsp;");
                        }
                        out.print("</td>");
                    }

                }

                out.print("</tr>");
                even = !even;
            }

            //final closing...
            out.print("</tr>");
            out.print("</table>");

            for (int z = orderSize - 2; z >= 0; z--) {
                out.print("</ul></li>");
            }

            out.print("</ul>");
        } catch (Exception e) {
            StringWriter writer = new StringWriter();
            PrintWriter printWriter = new PrintWriter(writer);
            e.printStackTrace(printWriter);
            printWriter.flush();

            String stackTrace = writer.toString();
            out.println(stackTrace);
        }
    }

}
