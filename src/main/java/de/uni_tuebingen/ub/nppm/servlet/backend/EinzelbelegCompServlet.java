package de.uni_tuebingen.ub.nppm.servlet.backend;

import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class EinzelbelegCompServlet extends AbstractBackendServlet {

    @Override
    protected String getTitle() {
        return "Einzelbeleg";
    }

    @Override
    protected void generatePage(HttpServletRequest request, HttpServletResponse response) throws Exception {
        RequestDispatcher rd = request.getRequestDispatcher("einzelbeleg_comp.jsp");
        rd.include(request, response);
    }
}
