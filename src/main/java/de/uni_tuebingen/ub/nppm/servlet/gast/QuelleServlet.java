package de.uni_tuebingen.ub.nppm.servlet.gast;

import de.uni_tuebingen.ub.nppm.db.QuelleDB;
import de.uni_tuebingen.ub.nppm.db.UrkundeDB;
import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


public class QuelleServlet extends AbstractGastServlet {
    @Override
    protected String getTitle() {
        return "quelle";
    }

    @Override
    protected String getNavigationTitle() {
        return "quelle";
    }

    @Override
    protected void generatePage(HttpServletRequest request, HttpServletResponse response) throws Exception {
        if (request.getParameter("ID") == null) {
         //response.sendRedirect(request.getContextPath() + "/gast/mghlemma?ID=" + MghLemmaDB.getFirstPublicPerson().getId());
          response.sendRedirect(request.getContextPath() + "/gast/quelle?ID=" + QuelleDB.getFirstPublicQuelle(1));
       // response.sendRedirect(request.getContextPath() + "/gast/quelle?ID=" + QuelleDB.getFirstPublicQuelleX(1));

      // response.sendRedirect(request.getContextPath() + "/gast/quelle?ID=" + UrkundeDB.getFirstPublicUrkunde(1).getId());
        } else {
            RequestDispatcher rd = request.getRequestDispatcher("quelle.jsp");
            rd.include(request, response);
        }
    }


}