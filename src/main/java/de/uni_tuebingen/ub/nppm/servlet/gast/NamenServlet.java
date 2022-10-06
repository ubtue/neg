package de.uni_tuebingen.ub.nppm.servlet.gast;

import de.uni_tuebingen.ub.nppm.db.MghLemmaDB;
import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import de.uni_tuebingen.ub.nppm.db.PersonDB;
import de.uni_tuebingen.ub.nppm.model.Einzelbeleg;
import de.uni_tuebingen.ub.nppm.model.Person;
import de.uni_tuebingen.ub.nppm.model.Quelle;
import java.util.ArrayList;
import java.util.List;

public class NamenServlet extends AbstractGastServlet {
    @Override
    protected String getTitle() {
        return "namen";
    }

    @Override
    protected String getNavigationTitle() {
        return "namenkommentar";
    }

    @Override
    protected void generatePage(HttpServletRequest request, HttpServletResponse response) throws Exception {
        if (request.getParameter("ID") == null) {
            response.sendRedirect(request.getContextPath() + "/gast/mghlemma?ID=" + MghLemmaDB.getFirstPublicPerson().getId());
        } else {
            RequestDispatcher rd = request.getRequestDispatcher("mghlemma.jsp");
            rd.include(request, response);
        }
    }

    @Override
     protected List<String> getAdditionalCss(){
        ArrayList<String> list = new ArrayList<>();

        list.add("layout/fonts/open-sans.css");
        list.add("layout/fonts/alegreya-sans-sc.css");

        return list;
    }

    @Override
     protected List<String> getAdditionalJavaScript(){
        ArrayList<String> list = new ArrayList<>();

        list.add("../javascript/jquery-1.11.1.min.js");
        list.add("../javascript/funktionen.js");
        list.add("../javascript/javascript.js");

        return list;
    }


}