package de.uni_tuebingen.ub.nppm.util;

import java.math.BigInteger;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.jsp.JspWriter;

public class Utils {
    public static boolean isNumeric(String str){
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
    
    public static int determineId(HttpServletRequest request, HttpServletResponse response, String formular, JspWriter out) throws Exception{
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
}
