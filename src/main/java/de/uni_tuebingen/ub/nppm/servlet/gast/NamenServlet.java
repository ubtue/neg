package de.uni_tuebingen.ub.nppm.servlet.gast;

import de.uni_tuebingen.ub.nppm.db.MghLemmaDB;
import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


public class NamenServlet extends AbstractGastServlet {
    @Override
    protected String getTitle() {
        return "namenkommentar";
    }

    @Override
    protected String getNavigationTitle() {
        return "namenkommentar";
    }

    @Override
    protected void generatePage(HttpServletRequest request, HttpServletResponse response) throws Exception {
        if (request.getParameter("ID") == null) {
            response.sendRedirect(request.getContextPath() + "/gast/mghlemma?ID=" + MghLemmaDB.getFirstPublicPerson().getId());
        } else {
            RequestDispatcher rd = request.getRequestDispatcher("mghlemma.jsp");
            rd.include(request, response);
        }
    }


}