package de.uni_tuebingen.ub.nppm.servlet.gast;

import java.util.ArrayList;
import java.util.List;
import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class StatistikServlet extends AbstractGastServlet {

    @Override
    protected String getNavigationTitle() {
        return "stat";
    }

    @Override
    protected String getTitle() {
        return "Statistik";
    }

    @Override
    protected void generatePage(HttpServletRequest request, HttpServletResponse response) throws Exception {
        if(request.getParameter("page") != null && request.getParameter("page").equals("anzahl_belege")) {
            RequestDispatcher rd = request.getRequestDispatcher("stat.jsp");
            rd.include(request, response);
        }else {
            RequestDispatcher rd = request.getRequestDispatcher("stat_overview.jsp");
            rd.include(request, response);
        }
    }
     
    @Override
    protected List<String> getAdditionalCss() {
        List<String> additionalCss = new ArrayList<>();
        return additionalCss;
    }

    @Override
    protected List<String> getAdditionalJavaScript() {
        List<String> additionalJs = new ArrayList<>();
        return additionalJs;
    }
}
