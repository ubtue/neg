package de.uni_tuebingen.ub.nppm.servlet.backend;

import java.util.ArrayList;
import java.util.List;
import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class FreieSucheErgebnisServlet extends AbstractBackendServlet {
    @Override
    protected String getTitle() {
        return "suche";
    }

    @Override
    protected void generatePage(HttpServletRequest request, HttpServletResponse response) throws Exception {
        RequestDispatcher rd = request.getRequestDispatcher("suchergebnis.jsp");
        rd.include(request, response);
    }
    
    @Override
    protected List<String> getAdditionalCss() {
        List<String> css = new ArrayList<>();
        css.add("mktree.css");
        return css;
    }

    @Override
    protected List<String> getAdditionalJavaScript() {
        List<String> js = new ArrayList<>();
        js.add("mktree.js");
        return js;
    }
}
