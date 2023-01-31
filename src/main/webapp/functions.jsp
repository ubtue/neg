<%@ page import="java.math.BigInteger" isThreadSafe="false" %>
﻿<%@ page import="java.net.URLEncoder" isThreadSafe="false" %>
<%@ page import="java.security.MessageDigest" isThreadSafe="false" %>
<%@ page import="java.sql.Connection" isThreadSafe="false" %>
<%@ page import="java.sql.Statement" isThreadSafe="false" %>
<%@ page import="java.sql.ResultSet" isThreadSafe="false" %>
<%@ page import="java.util.Vector" isThreadSafe="false" %>
<%@ page import="java.util.ArrayList" isThreadSafe="false"%>
<%@ page import="java.util.List" isThreadSafe="false"%>
<%@ page import="java.util.StringTokenizer" isThreadSafe="false"%>
<%@ page import="java.util.regex.Matcher" isThreadSafe="false"%>
<%@ page import="java.util.regex.Pattern" isThreadSafe="false"%>
<%@ page import="org.apache.commons.text.StringEscapeUtils" isThreadSafe="false"%>
<%@ page import="de.uni_tuebingen.ub.nppm.db.*" isThreadSafe="false"%>

<%!
String chop(String text, int letters) {
    if (text.length() < letters) {
        return text;
    }
    return text.substring(0, letters) + "...";
}

boolean isSet(String zielTabelle, String zielAttribut, int id, Statement st) {
    String sql = "SELECT " + zielAttribut + " FROM " + zielTabelle + " WHERE ID=\"" + id + "\"";

    ResultSet rs = null;
    try {
        rs = st.executeQuery(sql);
        if (rs.next() && rs.getString(zielAttribut) != null && rs.getInt(zielAttribut) == 1) {
            return true;
        }
    } catch (Exception e) {

    }
    return false;
}

String DBtoDB(String s) {
    if (s != null) {
        s = s.replace("\\", "\\\\").
            replace("\'", "\\'").
            replace("\"", "\\\"");
    }
    return s;
}

String DBtoJS(String s) {
    return StringEscapeUtils.escapeEcmaScript(s);
}

Vector calcCenturies(int von, int bis) {
    Vector ret = new Vector();

    int vonCent = von / 100;
    if (!(von % 100 == 0)) {
        vonCent++;
    }

    int bisCent = bis / 100;
    if (!(bis % 100 == 0)) {
        bisCent++;
    }

    for (int i = vonCent; i <= bisCent; i++) {
        ret.add(i + "");
        ret.add(i + "Jh");
        for (int j = 1; j < 2; j++) {
            ret.add(i + "Jh" + j);
        }
    }
    return ret;
}

String DBtoHTML(String s) {
    return StringEscapeUtils.escapeHtml4(s);
}

String DBtoHTML(Object obj) {
    return DBtoHTML(obj.toString());
}

String HTMLtoDB(String s) {
    return StringEscapeUtils.unescapeHtml4(s);
}

String makeDateWrapper(Object tag, Object monat, Object jahr) {
    if (tag != null && monat != null && jahr != null) {
        return makeDate(Integer.valueOf(tag.toString()), Integer.valueOf(monat.toString()), Integer.valueOf(jahr.toString()));
    }
    return "";
}

String makeDate(int tag, int monat, int jahr) {
    String ret = "" + (tag > 0 ? tag : "o") + "." + (monat > 0 ? monat : "o") + "." + (jahr > 0 ? jahr : "o");
    if (!ret.equals("o.o.o")) {
        return ret;
    }
    return "";
}

String numberResize(int value, int positions) {
    String tmp = "" + value;
    while (tmp.length() < positions) {
        tmp = "0" + tmp;
    }
    return tmp;
}

String urlEncode(String s) {
    return URLEncoder.encode(s);
}

String md5(String input) {
    try {
        MessageDigest m = MessageDigest.getInstance("MD5");
        m.update(input.getBytes(), 0, input.length());
        String output = new BigInteger(1, m.digest()).toString(16);
        return output;
    } catch (Exception e) {
    }
    return "";
}

Vector removeDuplicates(Vector vector) {
    for (int i = 0; i < vector.size() - 1; i++) {
        for (int j = i + 1; j < vector.size(); j++) {
            if (vector.get(i).equals(vector.get(j))) {
                vector.removeElementAt(j);
            }
        }
    }
    vector.trimToSize();
    return vector;
}

int min(int a, int b) {
    return (a < b ? a : b);
}

int max(int a, int b) {
    return (a > b ? a : b);
}

String getLabel(String formular, String datenfeld, String textfeld, Statement st, String sprache) throws Exception {
    if (datenfeld == null && textfeld != null) {
        return DatenbankDB.getLabel(sprache, formular, textfeld);
    } else if (datenfeld != null && textfeld == null) {
        return DatenbankDB.getMapping(sprache, formular, datenfeld);
    }

    return "";
}

String format(String text, String feld) {
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

String[] getdMGHUrl(Connection cn, String einzelbelegID) {
    String dmghUrl = "";
    String linkinfo = "";
    Statement st = null;
    ResultSet rs = null;
    try {
        st = cn.createStatement();
        rs = st.executeQuery(
                "select b.editionseite seite, e.bandnummer band, d.bezeichnung url "
                + "from einzelbeleg b, edition e, selektion_dmghband d "
                + "where b.editionid = e.id "
                + "and d.id > 0 "
                + "and e.dmghbandid = d.id "
                + "and b.id = " + einzelbelegID
        );
        if (rs.next()) {
            String seiteZeile = rs.getString("seite").trim();
            Pattern p = Pattern.compile("^[^\\d]*(?<seite>\\d+)[^\\d]*(?<zeile>\\d+[^-]*)?(?<rest>.*?)$");
            Matcher m = p.matcher(seiteZeile);
            m.find();
            String seite = m.group("seite").replaceAll("^0+", "");
            String zeile = m.group("zeile").replaceAll("^0+", "");
            String band = rs.getString("band").trim().replace("/", ",").replace("II", "2").replace("I", "1");
            String url = rs.getString("url");
            dmghUrl = String.format("http://www.mgh.de/dmgh/resolving/%s_%s_S._%s",
                    url, band, seite);
            linkinfo = String.format("%s %s, S. %s, Zeile %s",
                    url.replace("_", " "), band, seite, zeile);
        }
    } catch (Exception e) {
        // fall through
    } finally {
        try {
            if (null != rs) {
                rs.close();
            }
        } catch (Exception ex) {
        }
        try {
            if (null != st) {
                st.close();
            }
        } catch (Exception ex) {
        }
    }
    return new String[]{
        dmghUrl,
        linkinfo
    };
}

String getBelegformLinked(Connection cn, String einzelbelegID, String belegform) {
    String[] dmghUrl = getdMGHUrl(cn, einzelbelegID);
    if (dmghUrl[0].isEmpty()) {
        return belegform;
    }
    return String.format("<a href='%s' title='%s'>%s</a>", dmghUrl[0], dmghUrl[1], belegform);
}
%>
