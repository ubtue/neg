package de.uni_tuebingen.ub.nppm.servlet.gast;

import de.uni_tuebingen.ub.nppm.db.MghLemmaDB;
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


        if(request.getParameter("fromLemma") != null && request.getParameter("fromLemma").equals("MGH-Lemma"))
        {

                if (request.getParameter("ID") == null) {
                    getServletConfig().getServletContext().getRequestDispatcher("/gast/namenkommentar?ID=" + NamenKommentarDB.getFirstPublicNamenlemma().getId()).forward(request, response);
                }
                else {
                    RequestDispatcher rd = request.getRequestDispatcher("namenkommentar.jsp");
                    rd.include(request, response);
                }
        }
        else
        {
            startpage(request, response);
        }
    }

    private void startpage(HttpServletRequest request, HttpServletResponse response) throws Exception
    {
        if (request.getParameter("ID") == null) {
            response.sendRedirect(request.getContextPath() + "/gast/mghlemma?ID=" + MghLemmaDB.getFirstPublicMGHLemma().getId());
        } else {
            RequestDispatcher rd = request.getRequestDispatcher("mghlemma.jsp");
            rd.include(request, response);
        }
    }
}