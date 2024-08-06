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
        String requestURI = request.getRequestURI();
        String queryString = request.getQueryString();

        if (requestURI.endsWith("namenkommentar") && queryString != null && queryString.startsWith("ID=")) {
             if (request.getParameter("ID") == null) {
                getServletConfig().getServletContext().getRequestDispatcher("/gast/namenkommentar?ID=" + NamenKommentarDB.getFirstPublicNamenlemma().getId()).forward(request, response);
            } else {
                RequestDispatcher rd = request.getRequestDispatcher("namenkommentar.jsp");
                rd.include(request, response);
            }
        } else if (requestURI.endsWith("lemma") && queryString != null && queryString.startsWith("ID=")) {
            startpage(request, response);
        } else if (request.getParameter("fromLemma") != null && request.getParameter("fromLemma").equals("MGH-Lemma")) {

            if (request.getParameter("ID") == null) {
                getServletConfig().getServletContext().getRequestDispatcher("/gast/namenkommentar?ID=" + NamenKommentarDB.getFirstPublicNamenlemma().getId()).forward(request, response);
            } else {
                RequestDispatcher rd = request.getRequestDispatcher("namenkommentar.jsp");
                rd.include(request, response);
            }
        } else {
            startpage(request, response);
        }
    }

    private void startpage(HttpServletRequest request, HttpServletResponse response) throws Exception {
        if (request.getParameter("ID") == null) {
            response.sendRedirect(request.getContextPath() + "/gast/lemma?ID=" + LemmaDB.getFirstPublicMGHLemma().getId());
        } else {
            RequestDispatcher rd = request.getRequestDispatcher("lemma.jsp");
            rd.include(request, response);
        }
    }
}
