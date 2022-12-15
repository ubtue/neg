package de.uni_tuebingen.ub.nppm.servlet.backend;

import java.util.Arrays;
import java.util.List;
import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class SucheServlet extends AbstractBackendServlet {
    @Override
    protected String getTitle() {
        return "Suche";
    }

    @Override
    protected void generatePage(HttpServletRequest request, HttpServletResponse response) throws Exception {
        RequestDispatcher rd = request.getRequestDispatcher("suche.jsp");
        rd.include(request, response);
    }
    
    @Override
    protected List<String> getAdditionalCss() {
        return Arrays.asList("mktree.css");
    }

    @Override
    protected List<String> getAdditionalJavaScript() {
        return Arrays.asList("mktree.js");
    }
}
