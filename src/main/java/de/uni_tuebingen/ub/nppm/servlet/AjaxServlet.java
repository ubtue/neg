package de.uni_tuebingen.ub.nppm.servlet;

import de.uni_tuebingen.ub.nppm.db.*;
import org.json.*;
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
                response.setHeader("Content-Type", "application/json;charset=utf-8");

                JSONObject jsonObject = new JSONObject();
                JSONArray jsonArray = new JSONArray();
                List<String> matches = SucheDB.getCountryText(field, form, query);
                for (String match : matches) {
                    jsonArray.put(match);
                }
                jsonObject.put("suggestions", jsonArray);
                response.getWriter().print(jsonObject.toString());
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
