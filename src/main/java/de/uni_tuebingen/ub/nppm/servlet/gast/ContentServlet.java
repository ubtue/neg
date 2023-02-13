package de.uni_tuebingen.ub.nppm.servlet.gast;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import de.uni_tuebingen.ub.nppm.db.*;
import de.uni_tuebingen.ub.nppm.model.*;
import java.io.OutputStream;

public class ContentServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String name = req.getParameter("name");
        try {
            TinyMCE_Content content = TinyMCE_ContentDB.getByName(name);
            resp.setContentType(content.getContent_Type());
            OutputStream os = resp.getOutputStream();
            byte[] photoBytes = content.getContent();
            os.write(photoBytes);
            os.flush();
            os.close();
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }
}