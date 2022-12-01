package de.uni_tuebingen.ub.nppm.servlet.backend;

import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class AdministrationAuswahlServlet extends AbstractBackendServlet { 
    
    @Override
    protected String getTitle() {
        return "administration";
    }

    @Override
    protected void generatePage(HttpServletRequest request, HttpServletResponse response) throws Exception {
        RequestDispatcher rd = request.getRequestDispatcher("admin.auswahlfelder.jsp");
        rd.include(request, response);
    }
}
