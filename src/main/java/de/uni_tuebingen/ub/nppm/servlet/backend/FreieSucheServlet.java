package de.uni_tuebingen.ub.nppm.servlet.backend;

import java.util.ArrayList;
import java.util.List;
import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class FreieSucheServlet extends AbstractBackendServlet {
    @Override
    protected String getTitle() {
        return "suche";
    }

    @Override
    protected void generatePage(HttpServletRequest request, HttpServletResponse response) throws Exception {
        RequestDispatcher rd = request.getRequestDispatcher("freie_suche.jsp");
        rd.include(request, response);
    }
    
    @Override
    protected List<String> getAdditionalCss() {
        List<String> css = new ArrayList<>();
        css.add("layout/jquery-ui-1.10.3.css");
        css.add("layout/jquery.autocomplete.css");
        return css;
    }

    @Override
    protected List<String> getAdditionalJavaScript() {
        List<String> js = new ArrayList<>();
        js.add("javascript/jquery-1.11.1.min.js");
        js.add("javascript/jquery-ui-1.10.3.js");
        js.add("javascript/jquery.autocomplete.js");
        return js;
    }
}
