﻿<%@ page import="java.sql.Connection" isThreadSafe="false" %>
<%@ page import="java.sql.DriverManager" isThreadSafe="false" %>
<%@ page import="java.sql.ResultSet" isThreadSafe="false" %>
<%@ page import="java.sql.SQLException" isThreadSafe="false" %>
<%@ page import="java.sql.Statement" isThreadSafe="false" %>
<%@ page import="de.uni_tuebingen.ub.nppm.controller.BenutzerController" isThreadSafe="false" %>
<%@ page import="de.uni_tuebingen.ub.nppm.model.Benutzer" isThreadSafe="false" %>

<%@ include file="../configuration.jsp" %>
<%@ include file="../functions.jsp" %>

<%!
  void renderTable(JspWriter out, List<Benutzer> liste) throws Exception {
    out.println("<ul><table>");

    out.println("<tr>");
    out.println("<th>ID</th>");
    out.println("<th>Nachname</th>");
    out.println("<th>Vorname</th>");
    out.println("<th>Login</th>");
    out.println("<th>E-Mail</th>");
    out.println("<th>Projektgruppe</th>");
    out.println("<th>Admin.</th>");
    out.println("<th>Sprache</th>");
    out.println("<th>Bearbeiten</th>");
    out.println("</tr>");

    for (Benutzer benutzer : liste){
      out.println("<tr>");
      out.println("<td>" + Integer.toString(benutzer.getID()) + "</td>");
      out.println("<td>" + DBtoHTML(benutzer.getNachname()) + "</td>");
      out.println("<td>" + DBtoHTML(benutzer.getVorname()) + "</td>");
      out.println("<td>" + DBtoHTML(benutzer.getLogin()) + "</td>");
      out.println("<td>" + DBtoHTML(benutzer.getEMail()) + "</td>");
      out.println("<td>" + (benutzer.getGruppe() != null ? DBtoHTML(benutzer.getGruppe().getBezeichnung()) : "&nbsp;") + "</td>");
      out.println("<td>" + (benutzer.isAdmin() ? "JA" : "&nbsp;") +"</td>");
      out.println("<td>" + DBtoHTML(benutzer.getSprache()) + "</td>");
      out.println("<td><a href=\"einstellungen.jsp?ID=" + Integer.toString(benutzer.getID()) +"\">&auml;ndern</a></td>");
      out.println("</tr>");
    }

    out.println("</table></ul>");
  }
%>

<%

  out.println("<ul class=\"mktree\" id=\"complete\">");

  out.println("  <li class=\"liOpen\" style=\"font-size:large\"><b>Aktive Benutzer</b>");
  List listeAktiv = BenutzerController.getListAktiv();
  renderTable(out, listeAktiv);
  out.println("  </li>");

  out.println("  <li class=\"liClosed\"  style=\"font-size:large\"><b>Inaktive Benutzer</b>");
  List listeInaktiv = BenutzerController.getListInaktiv();
  renderTable(out, listeInaktiv);
  out.println("  </li>");

  out.println("</ul>");

%>