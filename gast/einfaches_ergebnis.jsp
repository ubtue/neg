<%@ include file="../configuration.jsp" %>
<%@ include file="../functions.jsp" %>
<%@ include file="../group.jsp" %>

<HTML>
  <HEAD>
    <TITLE>Nomen et Gens - Suchergebnis</TITLE>
    <link rel="icon" href="layout/images/nomen_et_gens_icon.gif" type="image/gif">
    <link rel="stylesheet" href="layout/layout.css" type="text/css">
    <link href='https://fonts.googleapis.com/css?family=Open+Sans:400,300,700' rel='stylesheet' type='text/css'>
    <link href='https://fonts.googleapis.com/css?family=Alegreya+Sans+SC:400,700' rel='stylesheet' type='text/css'>
    <script src="../javascript/jquery-1.11.1.min.js" type="text/javascript"></script>
    <script src="../javascript/javascript.js" type="text/javascript"></script>
    <script src="../javascript/funktionen.js" type="text/javascript"></script>
    <link rel="stylesheet" href="layout/mktree.css" type="text/css">
    <script type="text/javascript" src="../mktree.js"></script>


    <noscript></noscript>
  </HEAD>

  <BODY>
    <form method="post" action="einfaches_ergebnis.jsp">
    <jsp:include page="layout/header.inc.jsp">
      <jsp:param name="current" value="" />
    </jsp:include>

    <div id="content">
      <%
        if (  request.getParameter("form")!=null && request.getParameter("form").equals("einfache_suche") ) {
          %><%@ include file="suche/einfache_suche.jsp" %><%
        }
      %>
    </div>
    <jsp:include page="layout/footer.inc.jsp" />
    </form>
  </BODY>
</HTML>
