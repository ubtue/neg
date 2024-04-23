package de.uni_tuebingen.ub.nppm.servlet.gast;

import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class TagungenServlet extends AbstractGastServlet {

    @Override
    protected String getTitle() {
        return "tagungen";
    }

    @Override
    protected void generatePage(HttpServletRequest request, HttpServletResponse response) throws Exception {
        RequestDispatcher rd = request.getRequestDispatcher("tagungen.jsp");
        rd.include(request, response);
    }
}