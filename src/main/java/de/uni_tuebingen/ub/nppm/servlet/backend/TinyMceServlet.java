package de.uni_tuebingen.ub.nppm.servlet.backend;

import de.uni_tuebingen.ub.nppm.db.*;
import de.uni_tuebingen.ub.nppm.model.*;
import de.uni_tuebingen.ub.nppm.util.*;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class TinyMceServlet extends HttpServlet {

    protected void generatePage(HttpServletRequest request, HttpServletResponse response) throws Exception {
        PrintWriter out = response.getWriter();
        if (request.getParameter("fileAccess") == null && request.getParameter("loadFile") == null) {
            RequestDispatcher rd = request.getRequestDispatcher("fileManagement.jsp");
            rd.include(request, response);

        } else if (request.getParameter("fileAccess") != null) {
            String temp = request.getParameter("fileAccess");
            if (temp.equals("fileDelete")) {
                if (request.getParameter("filename") != null) {
                    String deleteFile = (String) request.getParameter("filename");
                    TinyMCE_ContentDB.deleteByName(deleteFile);
                } else {
                    out.println("Datei kann nicht gel&ouml;scht werden");
                }
            }
            RequestDispatcher rd = request.getRequestDispatcher("fileManagement.jsp");
            rd.include(request, response);
        } else if (request.getParameter("loadFile") != null) {

            RequestDispatcher rd = request.getRequestDispatcher("tinyMce.jsp");
            rd.include(request, response);
        }

    }//end function

    protected void initRequest(HttpServletRequest request) throws Exception {
        Language.setLanguage(request);
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response) throws Exception {
        initRequest(request);
        response.setContentType("text/html; charset=UTF-8");
        response.setCharacterEncoding("UTF-8");
        generatePage(request, response);

    }

    protected void doHelper(HttpServletRequest request, HttpServletResponse response) throws ServletException {
        try {
            processRequest(request, response);
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doHelper(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doHelper(request, response);
    }

}//end class