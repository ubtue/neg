package de.uni_tuebingen.ub.nppm.servlet;

import de.uni_tuebingen.ub.nppm.db.*;
import de.uni_tuebingen.ub.nppm.util.*;
import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class AjaxServlet extends HttpServlet {
    protected void autocomplete(HttpServletRequest request, HttpServletResponse response) {
        try {
            String query = request.getParameter("query");
            String form = request.getParameter("form");
            String field = request.getParameter("field");

            if (query == null || form == null || field == null) {
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            } else {
                response.setHeader("Content-Type", "application/json");
                String json = "{\"suggestions\": [";
                List<String> matched = SucheDB.getCountryText(field, form, query);
                int i=0;
                for (String match : matched) {
                    if (i > 0) {
                        json += ", ";
                    }
                    json += "\"" + Utils.escapeJS(match) + "\"";
                    ++i;
                }
                json += "]}";
                response.getWriter().print(json);
            }
        } catch (Exception e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        if (action != null) {
            if (action.equals("autocomplete")) {
                autocomplete(request, response);
            } else {
                response.setStatus(HttpServletResponse.SC_NOT_IMPLEMENTED);
            }
            return;
        }

        response.setStatus(HttpServletResponse.SC_NOT_IMPLEMENTED);
    }

}
