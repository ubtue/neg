package de.uni_tuebingen.ub.nppm.servlet.gast;

import de.uni_tuebingen.ub.nppm.db.*;
import de.uni_tuebingen.ub.nppm.model.*;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class RedirectGndServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String URI = request.getRequestURI();                 // e.g. /neg/gnd/118560034 (equals P7404)
        String GND = URI.substring(URI.lastIndexOf("/") + 1); // e.g. 118560034

        if (GND == null) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "GND Number is missing");
        } else {
            try {
                Person person = PersonDB.getByGndPublic(GND);
                if (person == null) {
                    response.sendError(HttpServletResponse.SC_NOT_FOUND, "GND Number not found");
                } else {
                    response.sendRedirect(request.getContextPath() + "/id/P" + person.getId());
                }
            } catch (Exception e) {
                throw new ServletException(e);
            }
        }
    }
}
