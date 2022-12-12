<%@ page import="de.uni_tuebingen.ub.nppm.util.Language" isThreadSafe="false" %>

﻿<%
  if (session != null) {
    String sprache = (String) session.getAttribute("Sprache");
    session.invalidate();

    session = request.getSession(true);
    session.setAttribute("Sprache", sprache);

    String ziel = request.getParameter("go"); // "intern" oder "gast"
  %>
    <p>
        <% Language.printTextfield(out,session, "login","ErfolgreichAusgeloggt");%>
    </p>
    
    <% Language.printTextfield(out,session, "all","Startseite");%>
    
    <% if(ziel == null || ziel.equals("intern")) { %>
    	<script>window.location = 'login';</script>
    <% } else { %>
    	<script>window.location = '.';</script>
  	<% }
  }
%>
