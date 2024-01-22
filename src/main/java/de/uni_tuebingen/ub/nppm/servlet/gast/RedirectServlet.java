package de.uni_tuebingen.ub.nppm.servlet.gast;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class RedirectServlet extends AbstractGastServlet {
    @Override
    protected String getTitle() {
        return "redirect";
    }

    @Override
    protected void generatePage(HttpServletRequest request, HttpServletResponse response) throws Exception {
        if (request.getParameter("ID") == null) {
            throw new Exception("Missing ID");
        }
        String PID = (String)request.getParameter("ID");
        String type = PID.substring(0,1);
        String ID = PID.substring(1);

        if (type.equals("B")) {
            response.sendRedirect(request.getContextPath() + "/gast/einzelbeleg?ID=" + ID);
        } else if (type.equals("P")) {
            response.sendRedirect(request.getContextPath() + "/gast/person?ID=" + ID);
        } else if (type.equals("N")) {
            response.sendRedirect(request.getContextPath() + "/gast/namenkommentar?ID=" + ID);
        } else if (type.equals("Q")) {
            response.sendRedirect(request.getContextPath() + "/gast/quelle?ID=" + ID);
        } else if (type.equals("E")) {
            response.sendRedirect(request.getContextPath() + "/gast/edition?ID=" + ID);
        } else if (type.equals("T")) {
            response.sendRedirect(request.getContextPath() + "/gast/handschrift?ID=" + ID);
        } else if (type.equals("M")) {
            response.sendRedirect(request.getContextPath() + "/gast/mghlemma?ID=" + ID);
        } else {
            throw new Exception("Invalid ID: " + PID);
        }
    }
}
