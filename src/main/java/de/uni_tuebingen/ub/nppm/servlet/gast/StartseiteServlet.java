package de.uni_tuebingen.ub.nppm.servlet.gast;

import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class StartseiteServlet extends AbstractGastServlet {

    @Override
    protected String getNavigationTitle() {
        return "startseite";
    }

    @Override
    protected String getTitle() {
        return "startseite";
    }

    @Override
    protected void generatePage(HttpServletRequest request, HttpServletResponse response) throws Exception {
        RequestDispatcher rd = request.getRequestDispatcher("startseite.jsp");
        rd.include(request, response);
    }
}
