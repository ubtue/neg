<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="###LANGUAGE_CODE###" class="no-js mod_picture mod_localstorage mod_cssremunit mod_placeholder mod_srcset mod_mediaqueries mod_no-touchevents mod_formvalidation mod_flexbox mod_csstransitions js-state__ut-nav-is-closed">
  <head>
    <%
    String fullTitle = "Nomen et Gens";
    String title = (String)request.getAttribute("title");
    if (title != null && !title.isEmpty()) {
        fullTitle += " | " + title;
    }
    %>
    <title><%=fullTitle%></title>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <!-- CSS includes (vendor) -->
    <link rel="stylesheet" type="text/css" href="vendor/ut-typo3/css/merged.css" media="all">
    <link rel="stylesheet" type="text/css" href="vendor/ut-typo3/css/ut.fixes.local.css" media="all">
    <link rel="stylesheet" type="text/css" href="layout/fonts/open-sans.css" >
    <link rel="stylesheet" type="text/css" href="layout/fonts/alegreya-sans-sc.css">
    <link rel="stylesheet" type="text/css" href="../layout/jquery-ui-1.10.3.css">

    <!-- CSS includes (local) -->
    <link rel="icon" href="layout/images/nomen_et_gens_icon.gif" type="image/gif">
    <link rel="stylesheet" href="layout/layout.css" type="text/css">

    <!-- ut dependencies (rest of UT is behind navigation, needs to stay there or navigation cannot be rendered correctly -->
    <script src="vendor/ut-typo3/js/merged_top.js"></script>

    <!-- (these ut-typo3 dependencies are currently not needed and can be added later if necessary) -->
    <!--
    <script src="vendor/modernizr/modernizr.min.js"></script>
    <script src="vendor/popper/popper.js"></script>
    <script src="vendor/yepnope/yepnope-2.0.0.min.js"></script>
    -->

    <!-- other local JS dependencies -->
    <script src="../javascript/jquery-1.11.1.min.js" type="text/javascript"></script>
    <script src="../javascript/jquery-ui-1.10.3.js" type="text/javascript"></script>
    <script src="../javascript/funktionen.js" type="text/javascript"></script>
    <script src="../javascript/javascript.js" type="text/javascript"></script>

    ${additionalCss}

    ${additionalJs}

  </head>
  <body>
    <div class="ut-page">

        <jsp:include page="../layout/header.inc.jsp">
          <jsp:param name="current" value="${navigationTitle}"/>
        </jsp:include>

        <!-- ut => MUST BE BEHIND HEADER, ELSE WE HAVE PROBLEMS RENDERING/EXTENDING THE NAVIGATION -->
        <script src="vendor/ut-typo3/js/merged_bottom.js"></script>

        <div class="ut-page__main">
            <div class="ut-wrapper">
                <div class="container">
