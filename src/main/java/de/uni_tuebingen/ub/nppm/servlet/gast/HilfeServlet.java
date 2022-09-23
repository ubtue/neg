package de.uni_tuebingen.ub.nppm.servlet.gast;


import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class HilfeServlet extends AbstractGastServlet {

    @Override
    protected String getTitle() {
        return "freie_suche";
    }

    @Override
    protected void processRequest(HttpServletRequest request, HttpServletResponse response) throws Exception {
        RequestDispatcher rd = request.getRequestDispatcher("hilfe.jsp");
        rd.include(request, response);
    }
}
