<%@page import="de.uni_tuebingen.ub.nppm.db.*"%>
<%@page import="de.uni_tuebingen.ub.nppm.model.*"%>
<%@ page import="java.sql.*" isThreadSafe="false"%>
<%@ page import="de.uni_tuebingen.ub.nppm.util.Language" isThreadSafe="false" %>
<%@ include file="../configuration.jsp"%>
<%@ include file="../functions.jsp"%>

<jsp:include page="../dofilter.jsp" />

<%
    int id = 1;
    id = Integer.parseInt(request.getParameter("ID"));
    String formular = "quelle";
    Quelle quelle = QuelleDB.getById(id);
    Urkunde urkunde = quelle.getUrkunde();
%>

<a href="<%=Utils.getBaseUrl(request)%>/gast/stat">
    <jsp:include page="../inc.erzeugeBeschriftung.jsp">
        <jsp:param name="Formular" value="stat"/>
        <jsp:param name="Textfeld" value="Titel"/>
    </jsp:include>
</a>
<br>
<jsp:include page="../dojump.jsp">
  <jsp:param name="form" value="gast_quelle" />
</jsp:include>

 <jsp:include page="layout/titel.inc.jsp">
        <jsp:param name="title" value="Quelle" />
        <jsp:param name="ID" value="<%= id %>" />
        <jsp:param name="size" value="" />
        <jsp:param name="Formular" value="quelle" />
 </jsp:include>

<jsp:include page="../inc.erzeugeFormular.jsp">
        <jsp:param name="ID" value="<%= id %>"/>
        <jsp:param name="Formular" value="quelle"/>
        <jsp:param name="Datenfeld" value="ID"/>
        <jsp:param name="size" value="11"/>
</jsp:include>

<!----------ID---------->
  <div id="id">
    <jsp:include page="../forms/id.jsp">
      <jsp:param name="ID" value="<%=id%>"/>
      <jsp:param name="title" value="gast_quelle"/>
    </jsp:include>
  </div>

<!----------Quelle---------->
  <h3>
    Quelle:
    <jsp:include page="../inc.erzeugeFormular.jsp">
      <jsp:param name="ID" value="<%= id %>"/>
      <jsp:param name="Formular" value="quelle"/>
      <jsp:param name="Datenfeld" value="Bezeichnung"/>
      <jsp:param name="size" value="50"/>
      <jsp:param name="Readonly" value="yes"/>
    </jsp:include>
  </h3>
        <table id="quelle-table" class="content-table">
          <tbody>
            <tr>
                <th><% Language.printTextfield(out, session, "quelle", "Datierung"); %></th>
              <td>
                <jsp:include page="../inc.erzeugeFormular.jsp">
                  <jsp:param name="ID" value="<%= id %>"/>
                  <jsp:param name="Formular" value="gast_quelle"/>
                  <jsp:param name="Datenfeld" value="Datierung"/>
                  <jsp:param name="Readonly" value="yes"/>
                </jsp:include>
              </td>
            </tr>
            <tr>
                <th><% Language.printDatafield(out, session, "quelle", "KommentarDatierung"); %></th>
              <td>
                <jsp:include page="../inc.erzeugeFormular.jsp">
                  <jsp:param name="ID" value="<%= id %>"/>
                  <jsp:param name="Formular" value="quelle"/>
                  <jsp:param name="Datenfeld" value="KommentarDatierung"/>
                  <jsp:param name="cols" value="40"/>
                  <jsp:param name="rows" value="5"/>
                      <jsp:param name="Readonly" value="yes"/>
                </jsp:include>
              </td>
            </tr>
             <tr>
              <td colspan="2">
            <jsp:include page="../inc.modul.jsp">
              <jsp:param name="ID" value="<%= id %>"/>
              <jsp:param name="Formular" value="quelle"/>
              <jsp:param name="Modul" value="edition"/>
            </jsp:include>
              </td>
            </tr>
         </tbody>
        </table>

<!----------Ueberlieferung---------->
<h3><% Language.printTextfield(out, session, "quelle", "TabUeberlieferung"); %></h3>
  <jsp:include page="../inc.modul.jsp">
    <jsp:param name="ID" value="<%= id %>" />
    <jsp:param name="Formular" value="quelle" />
    <jsp:param name="Modul" value="ueberlieferungRO" />
  </jsp:include>

<!----------Bei Urkunden---------->
<% if (urkunde != null) { %>
  <% int urkundeid = urkunde.getId(); %>

  <h3><% Language.printTextfield(out, session, "quelle", "TabUrkunde" ); %></h3>
  <div id="urkunden">
    <table class="content-table">
      <tbody>
          <tr>
              <th><% Language.printDatafield(out, session, "urkunde", "Actumort" ); %></th>
              <td>
                <jsp:include page="../inc.erzeugeFormular.jsp">
                  <jsp:param name="ID" value="<%= urkundeid %>" />
                  <jsp:param name="Formular" value="urkunde" />
                  <jsp:param name="Datenfeld" value="Actumort" />
                  <jsp:param name="size" value="50" />
                  <jsp:param name="Readonly" value="yes" />
               </jsp:include>
              </td>
          </tr>
          <tr>
              <th><% Language.printDatafield(out, session, "urkunde", "Betreff"); %> </th>
              <td>
                <jsp:include page="../inc.erzeugeFormular.jsp">
                  <jsp:param name="ID" value="<%= urkundeid %>" />
                  <jsp:param name="Formular" value="urkunde" />
                  <jsp:param name="Datenfeld" value="Betreff" />
                  <jsp:param name="size" value="50" />
                  <jsp:param name="Readonly" value="yes" />
                </jsp:include>
              </td>
          </tr>
          <tr>
              <th><% Language.printDatafield(out, session, "urkunde", "Aussteller"); %></th>
              <td>
                <jsp:include page="../inc.erzeugeFormular.jsp">
                  <jsp:param name="ID" value="<%= urkundeid %>" />
                  <jsp:param name="Formular" value="urkunde" />
                  <jsp:param name="Datenfeld" value="Aussteller" />
                  <jsp:param name="Readonly" value="yes" />
                </jsp:include>
              </td>
          </tr>
          <tr>
              <th><% Language.printDatafield(out, session, "urkunde" , "Empfaenger"); %></th>
              <td>
                <jsp:include page="../inc.erzeugeFormular.jsp">
                  <jsp:param name="ID" value="<%= urkundeid %>" />
                  <jsp:param name="Formular" value="urkunde" />
                  <jsp:param name="Datenfeld" value="Empfaenger" />
                  <jsp:param name="Readonly" value="yes" />
                </jsp:include>
              </td>
          </tr>
          <tr>
              <th><% Language.printDatafield(out, session, "urkunde", "Dorsalnotiz"); %> </th>
              <td>
                <jsp:include page="../inc.erzeugeFormular.jsp">
                  <jsp:param name="ID" value="<%= urkundeid %>" />
                  <jsp:param name="Formular" value="urkunde" />
                  <jsp:param name="Datenfeld" value="Dorsalnotiz" />
                  <jsp:param name="size" value="50" />
                  <jsp:param name="Readonly" value="yes" />
                </jsp:include>
              </td>
          </tr>
      </tbody>
    </table>
  </div>

<% } %>
