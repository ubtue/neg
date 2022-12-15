package de.uni_tuebingen.ub.nppm.servlet.backend;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.RequestDispatcher;

public class LogoutServlet extends AbstractBackendServlet {
    @Override
    protected String getTitle() {
        return "logout";
    }

    @Override
    protected void generatePage(HttpServletRequest request, HttpServletResponse response) throws Exception {
        RequestDispatcher rd = request.getRequestDispatcher("logout.jsp");
        rd.include(request, response);
    }
}