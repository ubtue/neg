<%--
  Comment to this file see:
  http://www.Torsten-Horn.de/techdocs/jsp-upload.htm

  Uses Jason Pell's MultipartRequest to upload a file:
  http://www.geocities.com/jasonpell/programs.html

  Uses Marco Schmidt's ImageInfo to get image file information:
  http://schmidt.devlib.org/image-info
--%>

<%@ page import = "java.io.*, upload.*" %>

<%!
  // Adapt the following string for your upload directory.
  //   Tomcat local     :  sUploadDir = "/upload/";
  //   MyJavaServer.com :  sUploadDir = "/~torstenhorn/upload/";
  final String sUploadDir = "/upload/";
  final String sErrMsg
    = "<h2>Fehler: Keine gültige Bilddatei (JPG, PNG, GIF)!</h2>";

  String readAndShowImage( HttpServletRequest request )
  throws FileNotFoundException, IOException
  {
    String sRet = "";
    // Check for valid parameter data:
    if( !request.getMethod().equals( "POST" ) )
      return "";
    MultipartRequest parser
      = new ServletMultipartRequest( request, 1*1024*1024 );  // < 1 MB
    if( null == parser ||
        null == parser.getFileContents( "myFile" ) )
      return "";
    // Check for valid image file:
    ImageInfo ii = new ImageInfo();
    if( null == ii )
      return "";
    ii.setInput( parser.getFileContents( "myFile" ) ); 
//    if( !ii.check() )
//      return sErrMsg;
    // Note: Parameters are in the parser and not in request:
    String myComment  = parser.getURLParameter( "myComment" );
    String sFileName  = parser.getFileSystemName( "myFile" );
    String sImgFormat = ii.getFormatName().toLowerCase();
    // Show image data:
    if( null == sImgFormat )
      sImgFormat = "Unbekanntes Format";
    if( sImgFormat.equals( "jpeg" ) )
      sImgFormat = "jpg";
    sRet = "<h2>" + sFileName + ":</h2>"
           + sImgFormat.toUpperCase() + ", "
           + ii.getWidth() + " x " + ii.getHeight() + " pixels, "
           + ii.getBitsPerPixel() + " bpp, "
           + parser.getFileSize( "myFile" ) + " Bytes<br>\n";
    // Check if image format is suitable for inserting into HTML page:
    if( !sImgFormat.equals( "jpg" ) &&
        !sImgFormat.equals( "png" ) &&
        !sImgFormat.equals( "gif" ) )
      return sRet + sErrMsg;
    // Generate valid file name. Different operating systems or 
    // browsers may return the file name with or without path 
    // and the path may contain '/' (Unix) or '\' (Windows):
    if( null == sFileName || 0 >= sFileName.length() )
      sFileName = "MyFile";
    char c = sFileName.charAt( sFileName.length() - 1 );
    if( '/' == c || '\\' == c )
      sFileName = sFileName.substring( 0, sFileName.length() - 1 );
    int i;
    if( 0 <= (i = sFileName.lastIndexOf( '/' )) )
      sFileName = sFileName.substring( i + 1 );
    if( 0 <= (i = sFileName.lastIndexOf( '\\' )) )
      sFileName = sFileName.substring( i + 1 );
    if( !sFileName.toLowerCase().endsWith( "." + sImgFormat ) )
      sFileName += "." + sImgFormat;
    // Different file pathes for HTML page and for storing:
    String sFilePathAndNameHtml = sUploadDir + sFileName;
    String sFilePathAndNameStore
      = getServletContext().getRealPath( sFilePathAndNameHtml );
    // Store file:
    BufferedInputStream  is = null;
    BufferedOutputStream os = null;
    long sum=0;
    try {
      is = new BufferedInputStream( parser.getFileContents( "myFile" ) );
      os = new BufferedOutputStream(
           new FileOutputStream( sFilePathAndNameStore ) );
      byte[] buff = new byte[8192];
      int len;
      while( 0 < (len = is.read( buff )) ) {
        os.write( buff, 0, len );
        sum += len;
      }
    } finally {
      if( is != null )
        is.close();
      if( os != null ) {
        os.flush();
        os.close();
      }
    }
    sRet += "Gespeichert: " + sum + " Bytes<br>\n";
    if( null != myComment && 0 < myComment.length() )
      sRet += "Kommentar: " + myComment + "<br>\n";
    sRet += "<br><img src='" + sFilePathAndNameHtml + "'"
          +         " alt='" + sFileName + "'"
          +         " height=" + ii.getHeight()
          +         " width=" + ii.getWidth() + "><br>\n"
          + "<br>\n sFilePathAndNameHtml  = " + sFilePathAndNameHtml
          + "<br>\n sFilePathAndNameStore = " + sFilePathAndNameStore
          + "<br>\n getRealPath(request.getRequestURI()) = "
          +  getServletConfig().getServletContext().
                 getRealPath(request.getRequestURI());
    return sRet;
  }
%>

<html>
<head>
  <title>Bilddatei-Upload</title>
</head>
<body>

<h2>Upload einer Bilddatei vom Client zum Server</h2>

<form action="upload.jsp" enctype="multipart/form-data" method="POST">

<table>
  <tr>
    <td>Kommentar (optional):</td>
    <td><input type="text" name="myComment" size=40 maxlength=255></td>
  </tr>
  <tr>
    <td>Bilddatei (JPG, PNG, GIF):</td>
    <td><input type="file" name="myFile"    size=40 maxlength=255>
        <input type="submit" value="Upload"></td>
  </tr>
</table>

</form>

<br>
<%= readAndShowImage( request ) %>

</body>
</html>
