package de.uni_tuebingen.ub.nppm.servlet.backend;


import de.uni_tuebingen.ub.nppm.servlet.backend.*;
import de.uni_tuebingen.ub.nppm.db.PersonDB;
import de.uni_tuebingen.ub.nppm.db.TinyMCE_ContentDB;
import de.uni_tuebingen.ub.nppm.util.Language;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Arrays;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class TinyMceServlet extends HttpServlet {

    protected void generatePage(HttpServletRequest request, HttpServletResponse response) throws Exception {
         PrintWriter out = response.getWriter();
        if (request.getParameter("pictureAccess") == null) {
            RequestDispatcher rd = request.getRequestDispatcher("edit.jsp");
            rd.include(request, response);


        } else {
            String temp = request.getParameter("pictureAccess");
            if(temp.equals("pictureDelete"))
            {
               if(request.getParameter("filename") != null)
               {
                    String deletePicture = (String)request.getParameter("filename");
                    TinyMCE_ContentDB.deleteByName(deletePicture);
               }
               else
               {
                   out.println("Datei kann nicht gel&ouml;scht werden");
               }
            }
            RequestDispatcher rd = request.getRequestDispatcher("img.jsp");
            rd.include(request, response);
        }

    }

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
