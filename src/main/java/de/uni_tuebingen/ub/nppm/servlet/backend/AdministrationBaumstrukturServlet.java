package de.uni_tuebingen.ub.nppm.servlet.backend;

import de.uni_tuebingen.ub.nppm.db.*;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class AdministrationBaumstrukturServlet extends AbstractBackendServlet {

    @Override
    protected String getTitle() {
        return "administration";
    }

    @Override
    protected void generatePage(HttpServletRequest request, HttpServletResponse response) throws Exception {
         //Use isAdminRequired to check if the user is an administrator.
        if (isAdminRequired(request, response)) {
            RequestDispatcher rd = request.getRequestDispatcher("admin.baumstruktur.jsp");
            rd.include(request, response);
        }else {
            //If the user is not an administrator, redirect them to logout.jsp.
            RequestDispatcher dispatcher = request.getRequestDispatcher("/logout.jsp");
            dispatcher.forward(request, response);
        }
    }


    @Override
    protected List<String> getAdditionalCss() {
        List<String> additionalCss = new ArrayList<>();
        additionalCss.add("webjars/jstree/3.3.15/themes/default/style.min.css");
        return additionalCss;
    }

    @Override
    protected List<String> getAdditionalJavaScript() {
        List<String> additionalJs = new ArrayList<>();
        additionalJs.add("webjars/jstree/3.3.15/jstree.min.js");
        return additionalJs;
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // This method is called via AJAX to change the parent ID.
        Integer id = Integer.parseInt(request.getParameter("id")); // Hier die ID des verschobenen Nodes
        String table = request.getParameter("Tabelle");
        Integer parentId = null;
        String temp = request.getParameter("parentId");
        if (temp != null && !temp.isEmpty()) {
            parentId = Integer.parseInt(temp); // Hier die neue Parent-ID
        }

        try {
            SelektionDB.updateParentId(table, id, parentId);
        } catch (Exception ex) {
            throw new ServletException(ex);
        }
    }
}
