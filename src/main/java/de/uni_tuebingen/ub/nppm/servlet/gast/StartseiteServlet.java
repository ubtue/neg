package de.uni_tuebingen.ub.nppm.servlet.gast;

import java.util.List;
import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class StartseiteServlet extends AbstractGastServlet {
    @Override
    protected List<String> getAdditionalCss() {
        List<String> css = super.getAdditionalCss();
        css.add("layout/help.css");
        return css;
    }

    @Override
    protected String getTitle() {
        return "Startseite";
    }

    @Override
    protected void processRequest(HttpServletRequest request, HttpServletResponse response) throws Exception {
        RequestDispatcher rd = request.getRequestDispatcher("startseite.jsp");
        rd.include(request, response);
    }
}
