package de.uni_tuebingen.ub.nppm.servlet.backend;

import java.util.ArrayList;
import java.util.List;
import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class LemmaKorrServlet extends AbstractBackendServlet {
    
    @Override
    protected String getTitle() {
        return "lemmakorr";
    }

    @Override
    protected void generatePage(HttpServletRequest request, HttpServletResponse response) throws Exception {
        RequestDispatcher rd = request.getRequestDispatcher("lemmakorr.jsp");
        rd.include(request, response);
    }

    @Override
    protected List<String> getAdditionalJavaScript() {
        ArrayList<String> list = new ArrayList<String>();
        list.add("javascript/helper.js");
        list.add("javascript/lemmaKorr.js");
        return list;
    }

    @Override
    protected List<String> getAdditionalCss() {
        ArrayList<String> list = new ArrayList<String>();
        list.add("layout/lemmaKorr.css");
        return list;
    }


}
