package de.uni_tuebingen.ub.nppm.servlet.gast;

import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import de.uni_tuebingen.ub.nppm.db.PersonDB;


public class PersonServlet extends AbstractGastServlet {
    @Override
    protected String getTitle() {
        return "person";
    }

    @Override
    protected String getNavigationTitle() {
        return "person";
    }

    @Override
    protected void generatePage(HttpServletRequest request, HttpServletResponse response) throws Exception {
        if (request.getParameter("ID") == null) {
            response.sendRedirect(request.getContextPath() + "/gast/person?ID=" + PersonDB.getFirstPublicPerson().getId());
        } else {
            RequestDispatcher rd = request.getRequestDispatcher("person.jsp");
            rd.include(request, response);
        }
    }
}
