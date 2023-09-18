<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Hello World!</h1>
    </body>
</html>
<div id="titel">
  <table width="100%" border="0" cellpadding="0" cellspacing="0">
    <tr>
      <td align="left">
        <h1>
          <jsp:include page="../inc.erzeugeBeschriftung.jsp">
            <jsp:param name="Formular" value="navigation"/>
            <jsp:param name="Textfeld" value="InhaltBearbeiten"/>
          </jsp:include>
        </h1>
      </td>
    </tr>
  </table>
</div>