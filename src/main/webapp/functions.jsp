<%@ page import="java.math.BigInteger" isThreadSafe="false" %>
<%@ page import="java.net.URLEncoder" isThreadSafe="false" %>
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
<%@ page import="de.uni_tuebingen.ub.nppm.db.*" isThreadSafe="false"%>
<%@ page import="de.uni_tuebingen.ub.nppm.util.*" isThreadSafe="false"%>

<%!
String chop(String text, int letters) {
    if (text.length() < letters) {
        return text;
    }
    return text.substring(0, letters) + "...";
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
    return Utils.escapeJS(s);
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
    return Utils.escapeHTML(s);
}

String DBtoHTML(Object obj) {
    return DBtoHTML(obj.toString());
}

String HTMLtoDB(String s) {
    return Utils.unescapeHTML(s);
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
    return Utils.urlEncode(s);
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
    return Utils.format(text, feld);
}



String[] getdMGHUrl(String einzelbelegID) throws Exception {
    String dmghUrl = "";
    String linkinfo = "";

    String sql = "select b.editionseite seite, e.bandnummer band, d.bezeichnung url "
            + "from einzelbeleg b, edition e, selektion_dmghband d "
            + "where b.editionid = e.id "
            + "and d.id > 0 "
            + "and e.dmghbandid = d.id "
            + "and b.id = " + einzelbelegID;

    Object[] columns = AbstractBase.getRowNative(sql);
    if (columns != null && columns.length > 0) {
        String seiteZeile = columns[0].toString().trim();
        Pattern p = Pattern.compile("^[^\\d]*(?<seite>\\d+)[^\\d]*(?<zeile>\\d+[^-]*)?(?<rest>.*?)$");
        Matcher m = p.matcher(seiteZeile);
        m.find();
        String seite = m.group("seite").replaceAll("^0+", "");
        String zeile = m.group("zeile").replaceAll("^0+", "");
        String band = columns[1].toString().trim().replace("/", ",").replace("II", "2").replace("I", "1");
        String url = columns[2].toString().trim();
        dmghUrl = String.format("http://www.mgh.de/dmgh/resolving/%s_%s_S._%s",
                url, band, seite);
        linkinfo = String.format("%s %s, S. %s, Zeile %s",
                url.replace("_", " "), band, seite, zeile);
    }

    return new String[]{
        dmghUrl,
        linkinfo
    };
}

String getBelegformLinked(String einzelbelegID, String belegform) throws Exception {
    String[] dmghUrl = getdMGHUrl(einzelbelegID);
    if (dmghUrl[0].isEmpty()) {
        return belegform;
    }
    return String.format("<a href='%s' title='%s'>%s</a>", dmghUrl[0], dmghUrl[1], belegform);
}

%>
