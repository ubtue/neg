package de.uni_tuebingen.ub.nppm.servlet.backend;

import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class ErrorServlet extends AbstractBackendServlet {

    @Override
    protected String getTitle() {
        return "error";
    }

    @Override
    protected void generatePage(HttpServletRequest request, HttpServletResponse response) throws Exception {
        RequestDispatcher rd = request.getRequestDispatcher("error.jsp");
        rd.include(request, response);
    }
}
