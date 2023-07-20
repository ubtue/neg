<%@ page import="de.uni_tuebingen.ub.nppm.db.*" isThreadSafe="false" %>
<%@ page import="java.util.Map" isThreadSafe="false" %>

<%
  if (feldtyp.equals("infouser") && !array) {

      Map row = AbstractBase.getMappedRow("SELECT benutzer.Vorname, benutzer.Nachname, benutzer_gruppe.Bezeichnung  FROM "+zielTabelle+", benutzer, benutzer_gruppe WHERE "+zielTabelle+".ID=\""+id+"\" AND "+zielTabelle+"."+zielAttribut+"=benutzer.ID AND benutzer.GruppeID = benutzer_gruppe.ID");
      if (row != null) {
        out.print(
           DBtoHTML(row.get("benutzer.Vorname").toString())
          +" "
          +DBtoHTML(row.get("benutzer.Nachname").toString())
          +" ("
          +DBtoHTML(row.get("benutzer_gruppe.Bezeichnung").toString())
          +")");
      }

  }
%>
