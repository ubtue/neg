<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<HTML>
  <HEAD>
    <TITLE>Nomen et Gens - ${title}</TITLE>
    <meta http-equiv="Content-Type"
      content="text/html; charset=utf-8">
    <link rel="stylesheet" href="layout/layout.css" type="text/css">

    <script src="javascript/funktionen.js" type="text/javascript"></script>
    <script src="webjars/jquery/3.7.1/jquery.min.js" type="text/javascript"></script>
    <script src="webjars/jQuery-Autocomplete/1.4.11/jquery.autocomplete.min.js" type="text/javascript"></script>

    ${additionalCss}

    ${additionalJs}
    <noscript></noscript>
  </HEAD>

  <BODY>
    <jsp:include page="../layout/navigation.inc.jsp" />
    <jsp:include page="../layout/image.inc.html" />