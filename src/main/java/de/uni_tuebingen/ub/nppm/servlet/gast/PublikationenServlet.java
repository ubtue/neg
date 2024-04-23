package de.uni_tuebingen.ub.nppm.servlet.gast;

import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class PublikationenServlet extends AbstractGastServlet {

    @Override
    protected String getTitle() {
        return "publikationen";
    }

    @Override
    protected void generatePage(HttpServletRequest request, HttpServletResponse response) throws Exception {
        RequestDispatcher rd = request.getRequestDispatcher("publikationen.jsp");
        rd.include(request, response);
    }
}