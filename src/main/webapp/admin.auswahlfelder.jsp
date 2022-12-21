<%@ page import="java.math.BigInteger" isThreadSafe="false" %>
<%@ page import="java.util.*" isThreadSafe="false" %>
<%@ page import="de.uni_tuebingen.ub.nppm.util.AuthHelper" isThreadSafe="false" %>
<%@ page import="de.uni_tuebingen.ub.nppm.db.DatenbankDB" isThreadSafe="false" %>
<%@ include file="configuration.jsp" %>

  <div>
    <jsp:include page="layout/navigation.inc.jsp" />
    <jsp:include page="layout/image.inc.html" />
    <jsp:include page="layout/titel.administration.jsp" />
    <div id="form">

<%
  boolean fehler = false;

  if (request.getParameter("action") == null && request.getParameter("Tabelle") != null && request.getParameter("Formular").equals("bearbeiten")) {
    String tbl = request.getParameter("Tabelle");
    String tblshort = tbl.substring((new String("selektion_")).length());
%>
    <FORM method="POST" action="admin-auswahlfelder">
      <input type="hidden" name="Tabelle" value="<%= tblshort %>">
      <table>
        <tr>
          <th width="200"><%= tbl %></th>
          <td width="450">
            <jsp:include page="administration/select.jsp">
              <jsp:param name="Tabelle" value="<%= tbl %>" />
              <jsp:param name="Feldname" value="<%= tblshort %>" />
            </jsp:include>
          </td>
        </tr>
        <tr>
         <td width="200">Beschriftung</td>
         <td width="450"><input name="<%= tblshort %>_Bezeichnung" size="50" maxlength="255"></td>
        </tr>
      </table>
      <p>
        <input type="reset" value="abbrechen">
        <input type="submit" name="action" value="neu">
        <input type="submit" name="action" value="umbenennen">
      </p>
    </FORM>
<%
  }

  else if (request.getParameter("action") == null && request.getParameter("Tabelle") != null && request.getParameter("Formular").equals("zusammenfuehren")) {
    String tbl = request.getParameter("Tabelle");
%>
    <FORM method="POST" action="admin-auswahlfelder">
      <input type="hidden" name="Tabelle" value="<%= tbl %>">
        <table>
          <tr>
            <th width="200"><%= tbl %></th>
            <td>&nbsp;</td>
          </tr>
          <tr>
            <td width="200">alte Auswahl</td>
            <td width="450">
              <jsp:include page="administration/select.jsp">
                <jsp:param name="Tabelle" value="<%= tbl %>" />
                <jsp:param name="Feldname" value="Feld_alt" />
              </jsp:include>
            </td>
          </tr>
          <tr>
            <td width="200">neue Auswahl</td>
            <td width="450">
              <jsp:include page="administration/select.jsp">
                <jsp:param name="Tabelle" value="<%= tbl %>" />
                <jsp:param name="Feldname" value="Feld_neu" />
              </jsp:include>
            </td>
          </tr>
        </table>
        <p>
         <input type="reset" value="abbrechen">
         <input type="submit" name="action" value="verschieben">
        </p>
      </FORM>
<%
  }
  else if (request.getParameter("action")!=null && request.getParameter("action").equals("neu")) {
    if (request.getParameter(request.getParameter("Tabelle")+"_Bezeichnung").equals("")) {
      out.println("<p><b>Fehler:</b> neue Beschriftung darf nicht leer sein.</p>");
      fehler = true;
    }
    if (fehler) {
      out.println("<a href=\"javascript:history.back()\">zur&uuml;ck</a>");
    }
    else {
        int id = 1;
        List<Object> result = DatenbankDB.getSelektionBezeichnung(request.getParameter("Tabelle"),request.getParameter(request.getParameter("Tabelle")+"_Bezeichnung"));
        if(!result.isEmpty()){
             out.println("<p>Auswahl \""+request.getParameter(request.getParameter("Tabelle")+"_Bezeichnung")+"\"exisitiert bereits und wurde daher nicht angelegt.</p>");
            out.println("<a href=\"administration\">zur&uuml;ck</a>");
           
        }
        else{
          Integer maxId = DatenbankDB.getMaxId(request.getParameter("Tabelle"));
          if (maxId != null) {
            id += maxId;
            DatenbankDB.insertSelektionBezeichnung(request.getParameter("Tabelle"),request.getParameter(request.getParameter("Tabelle")+"_Bezeichnung"),id);
            out.println("<p>Auswahl \""+request.getParameter(request.getParameter("Tabelle")+"_Bezeichnung")+"\"erfolgreich angelegt.</p>");
            out.println("<a href=\"administration\">zur&uuml;ck</a>");
          }
        }
    }
  }

  else if (request.getParameter("action")!=null && request.getParameter("action").equals("umbenennen")) {
    if (request.getParameter(request.getParameter("Tabelle")+"_Bezeichnung").equals("")) {
      out.println("<p><b>Fehler:</b> neue Beschriftung darf nicht leer sein.</p>");
      fehler = true;
    }
    if (fehler) {
      out.println("<a href=\"javascript:history.back()\">zur&uuml;ck</a>");
    }
    else {
        List<Object> result = DatenbankDB.getSelektionBezeichnung(request.getParameter("Tabelle"),request.getParameter(request.getParameter("Tabelle")+"_Bezeichnung"));
        if(!result.isEmpty() && result.get(0).toString().equals(request.getParameter(request.getParameter("Tabelle")+"_Bezeichnung"))){
            out.println("<p>Auswahl \""+request.getParameter(request.getParameter("Tabelle")+"_Bezeichnung")+"\"exisitiert bereits, benutzen Sie bitte die Funktion 'zusammenführen' um beide Auswahl zusammenzuführen.</p>");
            out.println("<a href=\"administration\">zur&uuml;ck</a>");
        }
        else{
            DatenbankDB.updateSelektionBezeichnung(request.getParameter("Tabelle"), 
                request.getParameter(request.getParameter("Tabelle")+"_Bezeichnung"), 
                request.getParameter(request.getParameter("Tabelle"))
            );
            out.println("<p>Auswahl erfolgreich nach"
                        +" \""+request.getParameter(request.getParameter("Tabelle")+"_Bezeichnung")+"\" umbenannt.</p>");
            out.println("<a href=\"administration\">zur&uuml;ck zur Administration</a>");
        }
    }
  }

  else if (request.getParameter("action")!=null && request.getParameter("action").equals("verschieben")) {
    
      if(request.getParameter("Feld_neu").equals(request.getParameter("Feld_alt"))){
        out.println("<p>Auswahl kann nicht mit sich selbst zusammengeführt werden.</p>");
        out.println("<a href=\"administration\">zur&uuml;ck zur Administration</a>");
      }
      else
      {
        DatenbankDB.updateAuswahlfelder(request.getParameter("Tabelle"), request.getParameter("Feld_alt"), request.getParameter("Feld_neu"));
        DatenbankDB.deleteAuswahlfeld(request.getParameter("Tabelle"), request.getParameter("Feld_alt"));
        out.println("<p>Auswahl erfolgreich zusammengef&uuml;hrt.</p>");
        out.println("<a href=\"admin-auswahlfelder?Formular=zusammenfuehren&Tabelle="+request.getParameter("Tabelle")+"\">Weitere Elemente zusammenführen</a>");
        out.println("<a href=\"administration\">zur&uuml;ck zur Administration</a>");
      }
    }
%>

    </div>
  </div>