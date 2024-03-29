package de.uni_tuebingen.ub.nppm.servlet.gast;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import de.uni_tuebingen.ub.nppm.db.*;
import de.uni_tuebingen.ub.nppm.model.*;
import java.io.OutputStream;

public class ShowContentServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String name = req.getParameter("name");
        try {
            Content content = ContentDB.getByName(name);
            resp.setContentType(content.getContent_Type());

            if (content.getContent_Type().startsWith("text/plain") || content.getContent_Type().startsWith("application/vnd.oasis.opendocument.text")
                    || content.getContent_Type().startsWith("application/msword")
                    || content.getContent_Type().startsWith("application/vnd.openxmlformats-officedocument.wordprocessingml.document"))  {
                // Set Content-Disposition header to specify the filename
            resp.setHeader("Content-Disposition", "attachment; filename=\"" + name + "\"");
            }

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