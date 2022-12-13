package de.uni_tuebingen.ub.nppm.servlet.backend;

import de.uni_tuebingen.ub.nppm.model.Benutzer;
import de.uni_tuebingen.ub.nppm.servlet.AbstractServlet;
import de.uni_tuebingen.ub.nppm.util.AuthHelper;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public abstract class AbstractBackendServlet extends AbstractServlet {

    protected Benutzer benutzer;

    @Override
    protected String getHeaderTemplate() {
        return "servlet/header.jsp";
    }

    @Override
    protected String getFooterTemplate() {
        return "servlet/footer.jsp";
    }

    protected boolean isLoginRequired() {
        return true;
    }

    @Override
    protected void initRequest(HttpServletRequest request) throws Exception {
        super.initRequest(request);
        benutzer = AuthHelper.getBenutzer(request);
        if (isLoginRequired() && benutzer == null || benutzer.isGast()) {
            throw new BenutzerNotSetException();
        }
    }

    @Override
    protected void doHelper(HttpServletRequest request, HttpServletResponse response) throws ServletException {
        try {
            processRequest(request, response);
        } catch (BenutzerNotSetException e) {
            // Show login page
            try {
                RequestDispatcher rd = request.getRequestDispatcher("logout.jsp");
                rd.forward(request, response);
            } catch (Exception ee) {
                throw new ServletException(ee);
            }
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }
}
