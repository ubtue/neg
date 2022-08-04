<%@ page import="java.math.BigInteger" isThreadSafe="false" %>
<%@ page import="java.security.MessageDigest" isThreadSafe="false" %>
<%@ page import="java.sql.Connection" isThreadSafe="false" %>
<%@ page import="java.sql.DriverManager" isThreadSafe="false" %>
<%@ page import="java.sql.ResultSet" isThreadSafe="false" %>
<%@ page import="java.sql.SQLException" isThreadSafe="false" %>
<%@ page import="java.sql.Statement" isThreadSafe="false" %>

<%@ include file="configuration.jsp" %>

<%
  if (session.getAttribute("BenutzerID")!=null
      && ((Integer) session.getAttribute("BenutzerID")).intValue() > 0
      && ((Boolean) session.getAttribute("Administrator")).booleanValue()
     ) {

%>

<HTML>
  <HEAD>
    <TITLE>Nomen et Gens - Administration</TITLE>
    <link rel="stylesheet" href="layout/layout.css" type="text/css">
    <script src="../javascript/funktionen.js" type="text/javascript"></script>
    <noscript></noscript>
  </HEAD>

  <BODY>
    <jsp:include page="layout/navigation.inc.jsp" />
    <jsp:include page="layout/image.inc.jsp" />
    <jsp:include page="layout/titel.administration.jsp" />
    <div id="form">

<%
  Connection cn = null;
  Statement  st = null;
  Statement  st2 = null;
  ResultSet  rs = null;
  boolean fehler = false;

  if (request.getParameter("action") == null && request.getParameter("Tabelle") != null && request.getParameter("Formular").equals("bearbeiten")) {
    String tbl = request.getParameter("Tabelle");
    String tblshort = tbl.substring((new String("selektion_")).length());
%>
    <FORM method="POST" action="admin.auswahlfelder.jsp">
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
    <FORM method="POST" action="admin.auswahlfelder.jsp">
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
      try {
        int id = 1;
        Class.forName( sqlDriver );
        cn = DriverManager.getConnection( sqlURL, sqlUser, sqlPassword );
        st = cn.createStatement();
        rs = st.executeQuery("SELECT * FROM selektion_"+request.getParameter("Tabelle") +" where Bezeichnung='"+request.getParameter(request.getParameter("Tabelle")+"_Bezeichnung")+"'");
        if(rs.next()){
             out.println("<p>Auswahl \""+request.getParameter(request.getParameter("Tabelle")+"_Bezeichnung")+"\"exisitiert bereits und wurde daher nicht angelegt.</p>");
            out.println("<a href=\"administration.jsp\">zur&uuml;ck</a>");
           
        }
        else{
          rs = st.executeQuery("SELECT max(ID) max FROM selektion_"+request.getParameter("Tabelle"));
          
          if (rs.next()) {
            id += rs.getInt("max");
            st.execute("INSERT INTO selektion_"+request.getParameter("Tabelle")+" (ID, Bezeichnung) VALUES ("+id+", \""+request.getParameter(request.getParameter("Tabelle")+"_Bezeichnung")+"\");");
            out.println("<p>Auswahl \""+request.getParameter(request.getParameter("Tabelle")+"_Bezeichnung")+"\"erfolgreich angelegt.</p>");
            out.println("<a href=\"administration.jsp\">zur&uuml;ck</a>");
          }
        }
      }
      catch (SQLException e) {out.println(e);}  
      finally {
        try { if( null != rs ) rs.close(); } catch( Exception ex ) {}
        try { if( null != st ) st.close(); } catch( Exception ex ) {}
        try { if( null != cn ) cn.close(); } catch( Exception ex ) {}
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
      try {
        Class.forName( sqlDriver );
        cn = DriverManager.getConnection( sqlURL, sqlUser, sqlPassword );
        st = cn.createStatement();
        rs = st.executeQuery("SELECT *  FROM selektion_"+request.getParameter("Tabelle") +" where Bezeichnung='"+request.getParameter(request.getParameter("Tabelle")+"_Bezeichnung")+"'");
        if(rs.next() && rs.getString("Bezeichnung").equals(request.getParameter(request.getParameter("Tabelle")+"_Bezeichnung"))){
            out.println("<p>Auswahl \""+request.getParameter(request.getParameter("Tabelle")+"_Bezeichnung")+"\"exisitiert bereits, benutzen Sie bitte die Funktion 'zusammenführen' um beide Auswahl zusammenzuführen.</p>");
            out.println("<a href=\"administration.jsp\">zur&uuml;ck</a>");
        }
        else{
        st.execute("UPDATE selektion_"+request.getParameter("Tabelle")
                        +" SET Bezeichnung=\""+request.getParameter(request.getParameter("Tabelle")+"_Bezeichnung")+"\""
                        +" WHERE ID="+request.getParameter(request.getParameter("Tabelle"))+";");
        out.println("<p>Auswahl erfolgreich nach"
                    +" \""+request.getParameter(request.getParameter("Tabelle")+"_Bezeichnung")+"\" umbenannt.</p>");
        out.println("<a href=\"administration.jsp\">zur&uuml;ck zur Administration</a>");
        }
      }
      catch (SQLException e) {out.println(e);}  
      finally {
        try { if( null != rs ) rs.close(); } catch( Exception ex ) {}
        try { if( null != st ) st.close(); } catch( Exception ex ) {}
        try { if( null != cn ) cn.close(); } catch( Exception ex ) {}
      }
    }
  }

  else if (request.getParameter("action")!=null && request.getParameter("action").equals("verschieben")) {
    try {
      Class.forName( sqlDriver );
      cn = DriverManager.getConnection( sqlURL, sqlUser, sqlPassword );
      st = cn.createStatement();
      st2 = cn.createStatement();
      
      if(request.getParameter("Feld_neu").equals(request.getParameter("Feld_alt"))){
      out.println("<p>Auswahl kann nicht mit sich selbst zusammengeführt werden.</p>");
      out.println("<a href=\"administration.jsp\">zur&uuml;ck zur Administration</a>");
      
      }
      else
      {

      rs = st.executeQuery("SELECT tabelle, spalte FROM datenbank_selektion WHERE selektion ='"+request.getParameter("Tabelle")+"';");
      while (rs.next()) {
        st2.addBatch("UPDATE "+rs.getString("tabelle")+" SET "+rs.getString("spalte")+"="+request.getParameter("Feld_neu")
                     + " WHERE "+rs.getString("spalte")+"="+request.getParameter("Feld_alt")+";");
      }
      st2.addBatch("DELETE FROM "+request.getParameter("Tabelle")
                      + " WHERE ID="+request.getParameter("Feld_alt"));
      st2.executeBatch();
      out.println("<p>Auswahl erfolgreich zusammengef&uuml;hrt.</p>");
      out.println("<a href=\"admin.auswahlfelder.jsp?Formular=zusammenfuehren&Tabelle="+request.getParameter("Tabelle")+"\">Weitere Elemente zusammenführen</a>");
      out.println("<a href=\"administration.jsp\">zur&uuml;ck zur Administration</a>");
      }
    }
    catch (SQLException e) {out.println(e);}  
    finally {
      try { if( null != rs ) rs.close(); } catch( Exception ex ) {}
      try { if( null != st ) st.close(); } catch( Exception ex ) {}
      try { if( null != cn ) cn.close(); } catch( Exception ex ) {}
    }
  }
%>

    </div>
  </BODY>
</HTML>

<%
  }
  else {
  %>
    <p>
      <jsp:include page="inc.erzeugeBeschriftung.jsp">
        <jsp:param name="Formular" value="error"/>
        <jsp:param name="Textfeld" value="Zugriff"/>
      </jsp:include>
    </p>
    <a href="index.jsp">
      <jsp:include page="inc.erzeugeBeschriftung.jsp">
        <jsp:param name="Formular" value="all"/>
        <jsp:param name="Textfeld" value="Startseite"/>
      </jsp:include>
    </a>
  <%
  }
%>

