<%@ page import="de.uni_tuebingen.ub.nppm.db.*" isThreadSafe="false" %>
<%@ page import="java.util.Map" isThreadSafe="false" %>

<%
  if (feldtyp.equals("infouser") && !array) {

      Map row = AbstractBase.getMappedRow("SELECT benutzer.Vorname, benutzer.Nachname, benutzer.Login, benutzer_gruppe.Bezeichnung FROM "+zielTabelle+", benutzer, benutzer_gruppe WHERE "+zielTabelle+".ID=\""+id+"\" AND "+zielTabelle+"."+zielAttribut+"=benutzer.ID AND benutzer.GruppeID = benutzer_gruppe.ID");

     if (row != null) {
        out.print(
           DBtoHTML(String.valueOf(row.get("Vorname")))
          +" "
          +DBtoHTML(String.valueOf(row.get("Nachname")))
          +" ("
          +DBtoHTML(String.valueOf(row.get("Login")))
          +")"
          +" ("
          +DBtoHTML(String.valueOf(row.get("Bezeichnung")))
          +")");
      }
  }
%>
