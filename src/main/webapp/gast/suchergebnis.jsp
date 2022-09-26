<%@ include file="../configuration.jsp" %>
<%@ include file="../functions.jsp" %>

<HTML>
  <HEAD>
    <TITLE>Nomen et Gens - Suchergebnis</TITLE>
    <link rel="icon" href="layout/images/nomen_et_gens_icon.gif" type="image/gif">
    <link rel="stylesheet" href="layout/layout.css" type="text/css">
    <link href='layout/fonts/open-sans.css' rel='stylesheet' type='text/css'>
    <link href='layout/fonts/alegreya-sans-sc.css' rel='stylesheet' type='text/css'>
    <script src="../javascript/jquery-1.11.1.min.js" type="text/javascript"></script>
    <script src="../javascript/javascript.js" type="text/javascript"></script>
    <script src="../javascript/funktionen.js" type="text/javascript"></script>
    <link rel="stylesheet" href="layout/mktree.css" type="text/css">
    <script type="text/javascript" src="../mktree.js"></script>


    <noscript></noscript>
  </HEAD>

  <BODY>
    <FORM method="POST" action="einfaches_ergebnis.jsp">
    <jsp:include page="layout/header.inc.jsp">
        <jsp:param name="current" value="" />
    </jsp:include>

    <div id="content">
      <%
        if (  request.getParameter("form")!=null && request.getParameter("form").equals("freie_suche") ) {
          %><%@ include file="suche/freie_suche.jsp" %><%
        }
      %>
    </div>
<jsp:include page="layout/footer.inc.jsp" />
</FORM>
  </BODY>
</HTML>
