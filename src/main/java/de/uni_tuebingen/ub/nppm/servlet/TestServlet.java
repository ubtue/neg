package de.uni_tuebingen.ub.nppm.servlet;


import java.io.IOException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

// Annotations don't seem to work => use WEB-INF/web.xml instead for URL patterns.
public class TestServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html");

        request.setAttribute("text", "TestServlet says hello!");

        RequestDispatcher rd = request.getRequestDispatcher("test/test.jsp");
        rd.forward(request, response);
    }
}
