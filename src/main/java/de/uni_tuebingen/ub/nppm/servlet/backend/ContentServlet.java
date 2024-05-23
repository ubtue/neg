package de.uni_tuebingen.ub.nppm.servlet.backend;

import de.uni_tuebingen.ub.nppm.db.*;
import de.uni_tuebingen.ub.nppm.model.*;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.RequestDispatcher;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.apache.commons.fileupload.FileItemIterator;
import org.apache.commons.fileupload.FileItemStream;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

public class ContentServlet extends AbstractBackendServlet {

    protected Benutzer benutzer;

    @Override
    protected boolean isAdminRequired() {
        return true;
    }

    @Override
    protected void generatePage(HttpServletRequest request, HttpServletResponse response) throws Exception {
        PrintWriter out = response.getWriter();

        // show TinyMCE
        if (request.getParameter("loadFile") != null) {
            RequestDispatcher rd = request.getRequestDispatcher("tinyMce.jsp");
            rd.include(request, response);
        } else if ("HtmlSaveToDatabase".equals(request.getParameter("htmlFileAccess"))) {
            String fileName = request.getParameter("tinyFileName");
            String language = request.getParameter("tinyLanguage");
            String newHtmlContent = request.getParameter("htmlContent");

            try {
                Content content = ContentDB.getByNameAndLanguage(fileName, language);
                if (content != null) {
                    ContentDB.updateHtmlFile(content, newHtmlContent);
                    // Redirect to the tinyMce.jsp page after saving
                    response.sendRedirect("edit?loadFile=" + fileName + "&language=" + language);
                    return;  // Important to return after redirect to stop further execution
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        } else if (request.getParameter("loadFile") == null && !"HtmlSaveToDatabase".equals(request.getParameter("htmlFileAccess"))) {
            //show fileManagement
            out.println("<div id=\"titel\">");
            out.println("  <table width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\">");
            out.println("    <tr>");
            out.println("      <td align=\"left\">");
            out.println("        <h1>Inhalt bearbeiten");
            out.println("        </h1>");
            out.println("      </td>");
            out.println("    </tr>");
            out.println("  </table>");
            out.println("</div>");
            out.println("<div id=\"form\">");
            out.println("<h2>Html Dateien & Bilder verwalten</h2>");
            out.println("<p style=\"line-height: 0.2; color: red;\">Wenn sie eine Datei löschen, dann ist auch jede Verknüpfung im Programm gelöscht, auch wenn Sie </p>");
            out.println("<p style=\"line-height: 0.2; color: red;\">die Datei mit gleichem Namen hochladen. </p>");
            out.println("<p style=\"line-height: 0.2; color: red;\">Wenn sie aber Ersetzen wählen, dann bleiben die Verknüpfungen im Programm bestehen.</p>");
            // Actions:

            String fileAccess = request.getParameter("fileAccess");
            if (fileAccess != null) {

                //Action (Delete)
                if (fileAccess.equals("fileDelete")) {
                    if (request.getParameter("id") != null) {
                        Content content = ContentDB.getById(Integer.parseInt(request.getParameter("id")));

                        if (content.getContext() != null && content.getContent_Type().equals("text/html")) {

                            String selectedLanguage = getCookieLanguage(request, response);

                            String fileName = content.getName();
                            deleteFileByNameAndLanguage(fileName, selectedLanguage);
                            out.println("Datei " + content.getName() + " (" + selectedLanguage + ") wurde gelöscht");

                        } else {
                            deleteFile(request.getParameter("id"));
                            out.println("Datei " + content.getName() + " wurde gelöscht");
                        }

                    } else {
                        out.println("<span style=\" color: red;\" >Error: </span>Datei kann nicht gelöscht werden");
                    }
                    // Action (upload OR replace/update)
                } else if (fileAccess.equals("fileUpload")) {
                    uploadFile(request, response);
                } else if (fileAccess.equals("fileReplace")) {

                    if (request.getParameter("id") != null) {
                        replaceFile(request, response);
                    } else {
                        out.println("<span style=\" color: red;\" >Error: </span>Datei kann nicht ersetzt werden");
                    }
                } else if (fileAccess.equals("HtmlFileCreate")) {
                    String selectedLanguage = getCookieLanguage(request, response);
                    String fileName = request.getParameter("CreateHTMLFileName");
                    String contextParam = request.getParameter("HtmlContext");
                    Content.Context context = Content.Context.valueOf(contextParam);

                    if (fileName != null && context != null && selectedLanguage != null) {
                        ContentDB.createHtmlFile(fileName, context, selectedLanguage);

                        out.println("Datei " + fileName + " (" + selectedLanguage + ") wurde erstellt");

                    }
                }
            }
            // show list (e.g. help, name comment or blank page)
            RequestDispatcher rd = request.getRequestDispatcher("fileManagement.jsp");
            rd.include(request, response);

        }
    }//end function

    public void deleteFile(String fileId) throws IOException, Exception {

        Integer id = Integer.parseInt(fileId);
        Content content = ContentDB.getById(id);
        if (content.getContext().equals(Content.Context.NAMENKOMMENTAR)) {
            List<NamenKommentar> namenkommentarList = NamenKommentarDB.searchByFileName(fileId);
            for (NamenKommentar n : namenkommentarList) {
                n.setDateiname(null);
                NamenKommentarDB.saveOrUpdate(n);
            }
        } else if (content.getContext().equals(Content.Context.QUELLENKOMMENTAR)) {
            List<Quelle> quellenkommtarList = QuelleDB.searchByFileName(fileId, Content.Context.QUELLENKOMMENTAR);
            for (Quelle q : quellenkommtarList) {
                q.setQuellenKommentarDatei(null);
                QuelleDB.saveOrUpdate(q);
            }
        } else if (content.getContext().equals(Content.Context.UEBERLIEFERUNGSKOMMENTAR)) {
            List<Quelle> ueberlieferungskommtarList = QuelleDB.searchByFileName(fileId, Content.Context.UEBERLIEFERUNGSKOMMENTAR);
            for (Quelle q : ueberlieferungskommtarList) {
                q.setUeberlieferungsKommentarDatei(null);
                QuelleDB.saveOrUpdate(q);
            }
        }
        ContentDB.deleteById(id);
    }//end function

    public void deleteFileByNameAndLanguage(String fileName, String selectedLanguage) throws IOException, Exception {

        if (!selectedLanguage.equals("dontDelete")) {

            try {
                Content content = ContentDB.getByNameAndLanguage(fileName, selectedLanguage);
                if (content != null) {
                    ContentDB.deleteByNameAndLanguage(fileName, selectedLanguage);
                }
            } catch (javax.persistence.NoResultException e) {
                // Kein Eintrag gefunden, nichts zu löschen

            }
        }
    }//end function

    public void replaceFile(HttpServletRequest request, HttpServletResponse response) throws IOException, FileUploadException, Exception {

        PrintWriter out = response.getWriter();

        String context = request.getParameter("context");
        Content.Context contextEnum = Content.Context.valueOf(context);

        // Create a new file upload handler
        ServletFileUpload upload = new ServletFileUpload();

        // Parse the request
        FileItemIterator iter = upload.getItemIterator(request);

        while (iter.hasNext()) {

            FileItemStream item = iter.next();
            String contentType = item.getContentType();
            String errorFileName = item.getName();

            if (!item.isFormField()) {

                if (item.getName() == null || item.getName().isEmpty() || item.getName().equals("")) {
                    out.println("<span style=\" color: red;\" >Error: </span>Sie haben keine Datei ausgew&auml;hlt!");
                } else if (item.getContentType().startsWith("text/html") || item.getContentType().startsWith("text/plain") || item.getContentType().startsWith("application/vnd.oasis.opendocument.text")
                        || item.getContentType().startsWith("image") || item.getContentType().startsWith("application/vnd.openxmlformats-officedocument.wordprocessingml.document")
                        || item.getContentType().startsWith("application/msword")) {

                    String fileName = item.getName();

                    boolean fileExists = ContentDB.searchName(fileName);
                    boolean sameFileName = false;
                    Content content = null;
                    String selectedLanguage = getCookieLanguage(request, response);

                    if (contentType.equals("text/html")) {
                        content = ContentDB.getByNameAndLanguage(fileName, selectedLanguage);
                    } else {
                        content = ContentDB.getById(Integer.parseInt(request.getParameter("id")));
                    }

                    if (fileName.equals(content.getName())) //The file name to be uploaded should match the one in the database
                    {
                        sameFileName = true;
                    }

                    String pathname = writeItemToTempFile(item);

                    if (fileExists == true && sameFileName == true) {

                        byte[] bytes = ContentDB.readBytesFromFile(pathname);
                        content.setContent(bytes);
                        ContentDB.saveOrUpdate(content);

                        if (contentType.equals("text/html")) {

                            out.println("Datei " + fileName + " (" + selectedLanguage + ")" + " wurde aktualisiert!");
                        } else {
                            out.println("Datei " + fileName + " wurde aktualisiert!");
                        }

                    } else {
                        out.println("<span style=\" color: red;\" >Error: </span>Datei Namen stimmen nicht überein:  " + content.getName() + " und " + fileName);
                        out.println("<br>");
                    }

                    //Now delete the temporary file again
                    File myObj = new File(pathname);
                    myObj.delete();
                } else {
                    out.println("<span style=\" color: red;\" >Error: </span>Datei " + errorFileName + " Dateityp nicht erlaubt. Bitte wenden Sie sich an den Administrator");
                    out.println("<br>");
                }
            }
        }
    }

    public void uploadFile(HttpServletRequest request, HttpServletResponse response) throws IOException, FileUploadException, Exception {
        PrintWriter out = response.getWriter();
        String context = request.getParameter("context");
        Content.Context contextEnum = Content.Context.valueOf(context);

        String selectedLanguage = getCookieLanguage(request, response);

        // Create a new file upload handler
        ServletFileUpload upload = new ServletFileUpload();

        // Parse the request
        FileItemIterator iter = upload.getItemIterator(request);

        while (iter.hasNext()) {

            FileItemStream item = iter.next();
            String contentType = item.getContentType();
            String errorFileName = item.getName();

            if (!item.isFormField()) {

                if (item.getName() == null || item.getName().isEmpty() || item.getName().equals("")) {
                    out.println("<span style=\" color: red;\" >Error: </span>Sie haben keine Datei ausgew&auml;hlt!");
                } else if (item.getContentType().startsWith("text/html") || item.getContentType().startsWith("text/plain") || item.getContentType().startsWith("application/vnd.oasis.opendocument.text")
                        || item.getContentType().startsWith("image") || item.getContentType().startsWith("application/vnd.openxmlformats-officedocument.wordprocessingml.document")
                        || item.getContentType().startsWith("application/msword")) {

                    String fileName = item.getName();

                    boolean fileExists = true;

                    if (contentType.equals("text/html")) {
                        fileExists = ContentDB.searchNameAndLanguage(fileName, selectedLanguage);
                    } else {
                        fileExists = ContentDB.searchName(fileName);
                    }

                    String pathname = writeItemToTempFile(item);

                    if (fileExists == true) {

                        //search file - Context of existing file
                        String existingFileContext = "";
                        if (contentType.equals("text/html")) {
                            existingFileContext = ContentDB.getByNameAndLanguage(fileName, selectedLanguage).getContext().toString();
                            out.println("<span style=\" color: red;\" >Error: </span>Datei " + fileName + " (" + selectedLanguage + ") existiert bereits im Context: " + existingFileContext);
                        } else {
                            existingFileContext = ContentDB.getByName(fileName).getContext().toString();
                            out.println("<span style=\" color: red;\" >Error: </span>Datei " + fileName + " existiert bereits im Context: " + existingFileContext);
                        }

                        out.println("<br>");

                    } else {

                        if (contentType.equals("text/html")) {
                            ContentDB.saveFile(pathname, fileName, contentType, contextEnum, selectedLanguage);
                            out.println("Datei " + fileName + "(" + selectedLanguage + ")" + " erfolgreich hochgeladen!");
                        } else {
                            ContentDB.saveFile(pathname, fileName, contentType, contextEnum);
                            out.println("Datei " + fileName + " erfolgreich hochgeladen!");
                        }
                        out.println("<br>");
                    }

                    //Now delete the temporary file again
                    File myObj = new File(pathname);
                    myObj.delete();
                } else {
                    out.println("<span style=\" color: red;\" >Error: </span>Datei " + errorFileName + " Dateityp nicht erlaubt. Bitte wenden Sie sich an den Administrator");
                    out.println("<br>");
                }
            }
        }
    }

    protected String writeItemToTempFile(FileItemStream item) throws FileNotFoundException, IOException {
        String tmpDir = System.getProperty("java.io.tmpdir");
        String pathname = tmpDir + "/" + item.getName();

        InputStream stream = item.openStream();
        try ( FileOutputStream file = new FileOutputStream(new File(pathname))) {
            for (int data = stream.read(); data >= 0; data = stream.read()) {
                file.write(data);
            }
        }
        return pathname;
    }

    @Override
    protected String getTitle() {
        return "fileManagement";
    }

    public String getCookieLanguage(HttpServletRequest request, HttpServletResponse response) {
        Cookie[] cookies = request.getCookies();
        String selectedLanguage = "dontDelete";  //Standardwert wenn kein Cookie gesetzt worden ist
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if (cookie.getName().equals("selectedLanguage")) {
                    selectedLanguage = cookie.getValue();
                    break;
                }
            }
        }
        return selectedLanguage;
    }

}//end class
