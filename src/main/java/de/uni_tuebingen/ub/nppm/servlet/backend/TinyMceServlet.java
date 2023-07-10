package de.uni_tuebingen.ub.nppm.servlet.backend;

import de.uni_tuebingen.ub.nppm.db.*;
import de.uni_tuebingen.ub.nppm.model.*;
import de.uni_tuebingen.ub.nppm.util.*;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.util.List;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.commons.fileupload.FileItemIterator;
import org.apache.commons.fileupload.FileItemStream;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

public class TinyMceServlet extends HttpServlet {
     protected Benutzer benutzer;

    protected void generatePage(HttpServletRequest request, HttpServletResponse response) throws Exception {
        PrintWriter out = response.getWriter();

        // TinyMCE anzeigen
        if (request.getParameter("loadFile") != null) {
            RequestDispatcher rd = request.getRequestDispatcher("tinyMce.jsp");
            rd.include(request, response);
        } else {
            // Aktionen:
            String fileAccess = request.getParameter("fileAccess");
            if (fileAccess != null) {

                // Aktion (Löschen)
                if (fileAccess.equals("fileDelete")) {
                    if (request.getParameter("id") != null) {
                        deleteFile(request.getParameter("id"));
                    } else {
                        out.println("Datei kann nicht gelöscht werden");
                    }
                    // Aktion (Hochladen ODER ersetzen / updaten)
                } else if (fileAccess.equals("fileUpload")) {
                    uploadFile(request, response);
                }
            }

            // Liste anzeigen (z.B. Hilfe, Namenkommentar)
            // Leere Seite anzeigen
            RequestDispatcher rd = request.getRequestDispatcher("fileManagement.jsp");
            rd.include(request, response);
        }
    }//end function

    public void deleteFile(String fileId) throws IOException, Exception {

        Integer id = Integer.parseInt(fileId);
        TinyMCE_Content content = TinyMCE_ContentDB.getById(id);
        if (content.getContext().equals(TinyMCE_Content.Context.NAMENKOMMENTAR)) {
            List<NamenKommentar> namenkommentarList = NamenKommentarDB.searchByFileName(fileId);
            for (NamenKommentar n : namenkommentarList) {
                n.setDateiname(null);
                NamenKommentarDB.saveOrUpdate(n);
            }
        }
        TinyMCE_ContentDB.deleteById(id);

    }//end function

    public void uploadFile(HttpServletRequest request, HttpServletResponse response) throws IOException, FileUploadException, Exception {
        PrintWriter out = response.getWriter();
        String context = request.getParameter("context");
        TinyMCE_Content.Context contextEnum = TinyMCE_Content.Context.valueOf(context);

        // Create a new file upload handler
        ServletFileUpload upload = new ServletFileUpload();

        // Parse the request
        FileItemIterator iter = upload.getItemIterator(request);

        while (iter.hasNext()) {

            FileItemStream item = iter.next();
            String contentType = item.getContentType();

            if (!item.isFormField()) {

                if (item.getName() == null || item.getName().isEmpty() || item.getName().equals("")) {
                    request.setAttribute("message", "<p>Sie haben keine Datei ausgew&auml;hlt!</p>");
                }
                else if (item.getContentType().startsWith("text/html") || item.getContentType().startsWith("text/plain") || item.getContentType().startsWith("application/vnd.oasis.opendocument.text")
                        || item.getContentType().startsWith("image") || item.getContentType().startsWith("application/vnd.openxmlformats-officedocument.wordprocessingml.document")
                        || item.getContentType().startsWith("application/msword")) {

                    String fileName = item.getName();

                    boolean fileExists = TinyMCE_ContentDB.searchName(fileName);
                    String pathname = writeItemToTempFile(item);

                    if (fileExists == true) {
                        TinyMCE_Content content = TinyMCE_ContentDB.getByName(fileName);
                        byte[] bytes = TinyMCE_ContentDB.readBytesFromFile(pathname);
                        content.setContent(bytes);
                        TinyMCE_ContentDB.saveOrUpdate(content);

                        request.setAttribute("message", "<p>Datei existiert bereits + wurde aktualisiert!</p>");
                    } else {
                        TinyMCE_ContentDB.saveFile(pathname, fileName, contentType, contextEnum);
                        request.setAttribute("message", "<p>Datei erfolgreich hochgeladen!</p>");
                    }

                    //Now delete the temporary file again
                    File myObj = new File(pathname);
                    myObj.delete();
                } else {
                    request.setAttribute("message", "<p>Dateityp nicht erlaubt. Bitte wenden Sie sich an den Administrator</p>");
                }
            }
        }
    }


    protected String writeItemToTempFile(FileItemStream item) throws FileNotFoundException, IOException {
        String tmpDir = System.getProperty("java.io.tmpdir");
        String pathname = tmpDir + "/" + item.getName();

        InputStream stream = item.openStream();
        FileOutputStream file = new FileOutputStream(new File(pathname));
        for (int data = stream.read(); data >= 0; data = stream.read()) {
            file.write(data);
        }
        file.close();

        return pathname;
    }

     protected void initRequest(HttpServletRequest request, HttpServletResponse response) throws Exception {
        Language.setLanguage(request);
         benutzer = AuthHelper.getBenutzer(request);
        if (isLoginRequired() && benutzer == null || benutzer.isGast()) {
             RequestDispatcher rd = request.getRequestDispatcher("logout.jsp");
                rd.forward(request, response);
        }
    }

      protected boolean isLoginRequired() {
        return true;
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response) throws Exception {
        initRequest(request, response);
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