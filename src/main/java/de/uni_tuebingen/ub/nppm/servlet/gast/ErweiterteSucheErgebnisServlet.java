package de.uni_tuebingen.ub.nppm.servlet.gast;

import java.util.List;
import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class ErweiterteSucheErgebnisServlet extends AbstractGastServlet  {
    @Override
    protected String getTitle() {
        return "freie_suche"; // "Impressum" does not yet exist in DB
    }

    @Override
    protected void generatePage(HttpServletRequest request, HttpServletResponse response) throws Exception {
        RequestDispatcher rd = request.getRequestDispatcher("suchergebnis.jsp");
        rd.include(request, response);
    } 
    
    @Override
    protected List<String> getAdditionalCss() {
        List<String> css = super.getAdditionalCss();
        css.add("layout/layout.css");
        css.add("layout/fonts/open-sans.css");
        css.add("layout/fonts/alegreya-sans-sc.css");
        css.add("layout/mktree.css");
        return css;
    }

    @Override
    protected List<String> getAdditionalJavaScript() {
        List<String> js = super.getAdditionalJavaScript();
        js.add("../javascript/funktionen.js");
        js.add("../javascript/jquery-1.11.1.min.js");
        js.add("../mktree.js");
        js.add("../javascript/javascript.js");
        return js;
    }
}
