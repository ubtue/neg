package de.uni_tuebingen.ub.nppm.servlet.gast;

import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import de.uni_tuebingen.ub.nppm.db.EinzelbelegDB;

public class EinzelbelegServlet extends AbstractGastServlet {
    @Override
    protected String getTitle() {
        return "einzelbeleg";
    }

    @Override
    protected String getNavigationTitle() {
        return "einzelbeleg";
    }

    @Override
    protected void generatePage(HttpServletRequest request, HttpServletResponse response) throws Exception {
        if (request.getParameter("ID") == null) {
            response.sendRedirect(request.getContextPath() + "/gast/einzelbeleg?ID=" + EinzelbelegDB.getFirstPublicEinzelbeleg().getId());
        } else {
            RequestDispatcher rd = request.getRequestDispatcher("einzelbeleg.jsp");
            rd.include(request, response);
        }
    }
}
