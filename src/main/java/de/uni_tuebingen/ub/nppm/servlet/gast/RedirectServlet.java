package de.uni_tuebingen.ub.nppm.servlet.gast;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

// Note: due to the dynamic URL schema configured in web.xml, this may not extend our regular
// abstract servlet classes.
public class RedirectServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String URI = request.getRequestURI();                 // e.g. /neg/id/P7404
        String PID = URI.substring(URI.lastIndexOf("/") + 1); // e.g. P7404
        String type = PID.substring(0,1);                     // e.g. P
        String ID = PID.substring(1);                         // e.g. 7404

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
            throw new ServletException("Invalid ID: " + PID);
        }
    }
}
