package de.uni_tuebingen.ub.nppm.servlet.backend;

import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class AdministrationServlet extends AbstractBackendServlet {

    @Override
    protected String getTitle() {
        return "administration";
    }

   @Override
    protected void generatePage(HttpServletRequest request, HttpServletResponse response) throws Exception {
        //Use isAdminRequired to check if the user is an administrator.
        if (isAdminRequired(request, response)) {
            RequestDispatcher rd = request.getRequestDispatcher("administration.jsp");
            rd.include(request, response);
        } else {
            //If the user is not an administrator, redirect them to logout.jsp.
            RequestDispatcher dispatcher = request.getRequestDispatcher("/logout.jsp");
            dispatcher.forward(request, response);
        }
    }
}
