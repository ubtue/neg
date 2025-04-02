package de.uni_tuebingen.ub.nppm.servlet.gast;

import de.uni_tuebingen.ub.nppm.db.LemmaDB;
import de.uni_tuebingen.ub.nppm.db.NamenKommentarDB;
import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class NamenServlet extends AbstractGastServlet {

    private int count = 1;

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
            response.sendRedirect(request.getContextPath() + "/gast/lemma?ID=" + LemmaDB.getFirstPublicMGHLemma().getId());
        } else {
            RequestDispatcher rd = request.getRequestDispatcher("lemma.jsp");
            rd.include(request, response);
        }
    }
}
