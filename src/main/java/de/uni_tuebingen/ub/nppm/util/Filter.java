package de.uni_tuebingen.ub.nppm.util;

import de.uni_tuebingen.ub.nppm.db.DatenbankDB;
import java.io.IOException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.servlet.jsp.JspWriter;

public class Filter {
    public static String getFilterSql(HttpServletRequest request, String formular) {
        Integer id = -2;
        Integer filter = 0;
        HttpSession session = request.getSession();
        String filterSql = null;
        //Try to get id from request
        try {
            id = Integer.parseInt(request.getParameter("ID"));
        } catch (Exception e) {
            e.printStackTrace();
        }

        //Try to get filter number from request
        try {
            filter = ((Integer) session.getAttribute(formular + "filter"))
                    .intValue();
        } catch (Exception e) {
            e.printStackTrace();
        }

        filterSql = DatenbankDB.getFilterSql(formular, filter);
        if (filterSql == null) {
            //get result without filter (filter=0)
            filterSql = DatenbankDB.getFilterSql(formular, 0);
        }
        
        //modify sql
        String filterParameter = (String) session.getAttribute(formular + "filterParameter");
        if (filterParameter != null) {
            filterSql = filterSql.replace("###", filterParameter);
        }
        filterSql = filterSql.replace("#userid#", "" + ((Integer) session.getAttribute("BenutzerID")).intValue());
        filterSql = filterSql.replace("#groupid#", "" + ((Integer) session.getAttribute("GruppeID")).intValue());

        return filterSql;
    }
}
