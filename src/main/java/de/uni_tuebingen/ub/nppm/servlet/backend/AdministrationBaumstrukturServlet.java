package de.uni_tuebingen.ub.nppm.servlet.backend;

import de.uni_tuebingen.ub.nppm.db.*;
import de.uni_tuebingen.ub.nppm.servlet.*;
import de.uni_tuebingen.ub.nppm.model.*;
import java.io.IOException;

import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
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

        RequestDispatcher rd = request.getRequestDispatcher("admin.baumstruktur.jsp");
        rd.include(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        Integer nodeId = Integer.parseInt(request.getParameter("nodeId")); // Hier die ID des verschobenen Nodes

        Integer newParentId = null;
        String temp = request.getParameter("newParentId");
        if (temp != null && !temp.isEmpty()) {
            newParentId = Integer.parseInt(temp); // Hier die neue Parent-ID
        }

        try {
            SelektionQuellengattungDB.updateParentId(nodeId, newParentId);

        } catch (Exception ex) {
            Logger.getLogger(AdministrationBaumstrukturServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
        try {
            generatePage(request, response);
        } catch (Exception ex) {
            Logger.getLogger(AdministrationBaumstrukturServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
}