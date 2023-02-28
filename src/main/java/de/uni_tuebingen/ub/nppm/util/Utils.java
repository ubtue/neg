package de.uni_tuebingen.ub.nppm.util;

import java.math.BigInteger;
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

    public static String DBtoHTML(String s) {
    return StringEscapeUtils.escapeHtml4(s);
}

     public static String format(String text, String feld){
	if(!feld.endsWith("PLemma") && !feld.endsWith("MGHLemma") && !feld.endsWith("Klarlemma"))
        {
              return text;
        }


	String lemma = text;  //hier ist att-il.an   drin !!!
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
	if(!lemma.equals("-"))lemma = lemma.replace("-", "");
	lemma = lemma.replaceAll("~", "");
	lemma = lemma.replaceAll("\\.", "");


	if(lemma.length()>1)lemma = lemma.substring(0, 1).toUpperCase()
			+ lemma.substring(1);
	else if(lemma.length()>0)lemma = lemma.substring(0, 1).toUpperCase();


	if(lemma.startsWith("&#x01E3;")) lemma = "&#x01E2;"+ lemma.substring(8);
	if(lemma.startsWith("&#x012B;")) lemma = "&#x012A;"+ lemma.substring(8);
	if(lemma.startsWith("&thorn;")) lemma = "&THORN;"+ lemma.substring(7);
	if(lemma.startsWith("&#x0101;")) lemma = "&#x0100;"+ lemma.substring(8);
	if(lemma.startsWith("&#x014D;")) lemma = "&#x014C;"+ lemma.substring(8);
	if(lemma.startsWith("&#x0113;")) lemma = "&#x0112;"+ lemma.substring(8);
	if(lemma.startsWith("&#x016B;")) lemma = "&#x016A;"+ lemma.substring(8);

	return lemma;
}


}
