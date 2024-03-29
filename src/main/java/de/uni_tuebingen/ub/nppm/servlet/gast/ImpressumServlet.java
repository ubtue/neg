package de.uni_tuebingen.ub.nppm.servlet.gast;

import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


public class ImpressumServlet extends AbstractGastServlet {
    @Override
    protected String getTitle() {
        return "freie_suche"; // "Impressum" does not yet exist in DB
    }

    @Override
    protected void generatePage(HttpServletRequest request, HttpServletResponse response) throws Exception {
        RequestDispatcher rd = request.getRequestDispatcher("impressum.jsp");
        rd.include(request, response);
    }
}
