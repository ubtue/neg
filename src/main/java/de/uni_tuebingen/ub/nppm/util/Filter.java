package de.uni_tuebingen.ub.nppm.util;

import de.uni_tuebingen.ub.nppm.db.DatenbankDB;
import java.io.IOException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.servlet.jsp.JspWriter;

public class Filter {
    
    /*
        This function return a Sql String corresponding to the formular and request.
        The Sql String is used to filter entities from the database
    */
    public static String getFilterSql(HttpServletRequest request, String formular) throws Exception {
        Integer id = Constants.UNDEFINED_ID;
        Integer filter = 0;
        HttpSession session = request.getSession();
        String filterSql = null;
        //Try to get id from request
        if(Utils.isNumeric(request.getParameter("ID")))
            id = Integer.parseInt(request.getParameter("ID"));

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
        
        //modify sql string
        String filterParameter = (String) session.getAttribute(formular + "filterParameter");
        if (filterParameter != null) {
            filterSql = filterSql.replace("###", filterParameter);
        }
        filterSql = filterSql.replace("#userid#", "" + ((Integer) session.getAttribute("BenutzerID")).intValue());
        filterSql = filterSql.replace("#groupid#", "" + ((Integer) session.getAttribute("GruppeID")).intValue());

        return filterSql;
    }
    
    /*
        This function is used to store the filter settings from the request in the session
    */
    public static void setFilter(HttpServletRequest request, String form, JspWriter out) {
        HttpSession session = request.getSession(true);
        int filter = 0;
        String filterParameter = "";          
        
        //clear session if no filter is set
        if (session.getAttribute(form + "filterParameter") == null) {
            session.setAttribute(form + "filterParameter", "");
        }

        //get filter setting from the session
        try {
            filter = ((Integer) session.getAttribute(form + "filter")).intValue();
            filterParameter = (String) session.getAttribute(form + "filterParameter");
        } catch (Exception e) {
            
        }

        boolean newFilter = false;
        //store filter settings from the request in the session
        try {
            if (filter != Integer.parseInt(request.getParameter("filter"))) {                
                filter = Integer.parseInt(request.getParameter("filter"));
                session.setAttribute(form + "filter", new Integer(filter));
                newFilter = true;
            }
            if (filterParameter == null && request.getParameter("filterParameter") != null
                    || filterParameter != null && !filterParameter.equals(request.getParameter("filterParameter"))) {                
                filterParameter = request.getParameter("filterParameter");
                session.setAttribute(form + "filterParameter", filterParameter);
                newFilter = true;
            }
            if (filter == 0) {
                filterParameter = null;
            }
            session.setAttribute(form + "filterParameter", filterParameter);
            
            //reload if a new filter was set
            if (newFilter && filter != 0) {
                out.println("<script type=\"text/javascript\">location.replace('" + request.getRequestURL() + "')</script>");
            }

        } catch (Exception e) {
        }
    }
}
