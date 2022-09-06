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
    
    public static void setFilter(HttpServletRequest request, String form, JspWriter out) {
        HttpSession session = request.getSession(true);
        int filter = 0;
        String filterParameter = "";                
        if (session.getAttribute(form + "filterParameter") == null) {
            session.setAttribute(form + "filterParameter", "");
        }

        try {
            filter = ((Integer) session.getAttribute(form + "filter")).intValue();
            filterParameter = (String) session.getAttribute(form + "filterParameter");
        } catch (Exception e) {
            
        }

        boolean newFilter = false;
        // Wenn neuer Filter per Parameter, dann in Session speichern
        try {
            if (filter != Integer.parseInt(request.getParameter("filter"))) {
                //    out.println(filter + "::" + request.getParameter("filter"));
                filter = Integer.parseInt(request.getParameter("filter"));
                session.setAttribute(form + "filter", new Integer(filter));
                newFilter = true;
            }
            if (filterParameter == null && request.getParameter("filterParameter") != null
                    || filterParameter != null && !filterParameter.equals(request.getParameter("filterParameter"))) {
                //    out.println(filterParameter + "::" + request.getParameter("filterParameter"));
                filterParameter = request.getParameter("filterParameter");
                session.setAttribute(form + "filterParameter", filterParameter);
                newFilter = true;
            }
            if (filter == 0) {
                filterParameter = null;
            }
            session.setAttribute(form + "filterParameter", filterParameter);
            if (newFilter && filter != 0) {
                out.println("<script type=\"text/javascript\">location.replace('" + request.getRequestURL() + "')</script>");
            }

        } catch (Exception e) {
        }
    }
}
