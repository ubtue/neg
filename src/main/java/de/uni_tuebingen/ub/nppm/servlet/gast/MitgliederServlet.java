package de.uni_tuebingen.ub.nppm.servlet.gast;

import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


public class MitgliederServlet extends AbstractGastServlet {

    @Override
    protected String getTitle() {
        return "mitglieder";
    }

    @Override
    protected void generatePage(HttpServletRequest request, HttpServletResponse response) throws Exception {
        RequestDispatcher rd = request.getRequestDispatcher("mitglieder.jsp");
        rd.include(request, response);
    }
}