<%@page import="java.io.File"%>
<%@page import="java.io.InputStreamReader"%>
<%@page import="java.net.URL"%>
<%@page import="java.io.*"%>
<%@page import="java.nio.*"%>
<%@ page import="org.apache.commons.fileupload.*" isThreadSafe="false" %>
<%@ page import="org.apache.commons.fileupload.disk.*" isThreadSafe="false" %>
<%@ page import="org.apache.commons.fileupload.servlet.*" isThreadSafe="false" %>
<%@ page import="org.apache.commons.fileupload.util.*" isThreadSafe="false" %>


<%@ include file="../configuration.jsp" %>

<%@ include file="../functions.jsp" %>

<%
  if (session.getAttribute("BenutzerID")!=null
      && ((Integer) session.getAttribute("BenutzerID")).intValue() > 0
      && ((Boolean) session.getAttribute("Administrator")).booleanValue()
     ) {
%>

<html>
<head>
<script type="text/javascript" src="../javascript/funktionen.js"></script>

</head>
<body>

<%
        String folder = "gast\\layout";

    if(request.getParameter("filename")!=null){
       String filename = request.getParameter("filename");
      if ((new File(this.getServletContext().getRealPath("/")+path +"\\"+folder+"\\"+filename)).delete()) {
        out.println("<p>Bild "+filename+" erfolgreich gel&ouml;scht!</p>");
      }
   }

out.println("<h2>Bild hochladen</h2>");
    out.println("<form method=\"POST\" enctype=\"multipart/form-data\">");
    out.println("<input type=\"file\" name=\"file\">");
    out.println("<br/><br/>");
    out.println("<input type=\"submit\" value=\"hochladen\">");
    out.println("</form>");


if(ServletFileUpload.isMultipartContent(request)) {
    // Create a new file upload handler
    ServletFileUpload upload = new ServletFileUpload();

    // Parse the request
    FileItemIterator iter = upload.getItemIterator(request);
    out.println("Übertragung gestartet...");

    while (iter.hasNext()) {

      FileItemStream item = iter.next();
      String name = item.getFieldName();
      InputStream stream = item.openStream();
      if (!item.isFormField()) {

        if(item.getContentType().startsWith("image") || item.getName().toLowerCase().endsWith("png")){

        String pathname = this.getServletContext().getRealPath("/")+ path + "\\"+folder+"\\"+item.getName();
        if ((new File(pathname)).exists()) {
          // Datei existiert bereits -> Dateiname tauschen
          out.println("<p>Datei existiert bereits!</p>");
        }
        else {
          // Datei existiert nicht und kann abgespeichert werden

          // Stream in Datei schreiben
          FileOutputStream file = new FileOutputStream(new File(pathname));
          for (int data = stream.read(); data >=0; data = stream.read()) {
            file.write(data);
          }
          file.close();

            out.println("<p>Datei erfolgreich hochgeladen!</p>");
        }
      }
      else{
         out.println("Dateityp nicht erlaubt. Bitte wenden Sie sich an den Administrator");
      }
      // end else
      }
    } // end while
  } // end if

  File[] files = new File(this.getServletContext().getRealPath("/")+ path + "\\"+folder+"\\").listFiles();

  out.println("<table style=\"border-collapse:collapse;\"border=1><tr><th>Pfad</th><th>Abbildung</th><th>&nbsp;</th></tr>");
    for (int i=0; i<files.length; i++) {
        File file = files[i];
        if (!file.isDirectory()) {


       if(file.getName().toLowerCase().endsWith("png")||

file.getName().toLowerCase().endsWith("jpg")||

file.getName().toLowerCase().endsWith("jpeg")||

file.getName().toLowerCase().endsWith("gif")){
               out.println("<tr><td>layout/"+file.getName()+"</td><td><img src=\"layout/"+file.getName()+"\" height=\"256px\"></td>");
               out.println("<td><form><input type=\"hidden\" name=\"filename\" value=\""+file.getName()+"\"><input type=\"submit\" value=\"l&ouml;schen\"></form></td>");
               out.println("</tr>");
       } }
  }
  out.println("</table>");

  %>
</body>
</html>
<%
  }
  else {
  %>
    <p>
      <jsp:include page="../inc.erzeugeBeschriftung.jsp">
        <jsp:param name="Formular" value="error"/>
        <jsp:param name="Textfeld" value="Zugriff"/>
      </jsp:include>
    </p>
    <a href="index.jsp">
      <jsp:include page="../inc.erzeugeBeschriftung.jsp">
        <jsp:param name="Formular" value="all"/>
        <jsp:param name="Textfeld" value="Startseite"/>
      </jsp:include>
    </a>
  <%
  }
%>
