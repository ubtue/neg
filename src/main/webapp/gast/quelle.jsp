<%@page import="de.uni_tuebingen.ub.nppm.db.UrkundeDB"%>
<%@page import="de.uni_tuebingen.ub.nppm.model.Urkunde"%>
<%@page import="de.uni_tuebingen.ub.nppm.db.QuelleDB"%>
﻿<%@ page import="java.sql.*" isThreadSafe="false"%>
<%@ page import="de.uni_tuebingen.ub.nppm.util.Language" isThreadSafe="false" %>
<%@ include file="../configuration.jsp"%>
<%@ include file="../functions.jsp"%>

<jsp:include page="../dofilter.jsp" />

<%

    int id = 1;
    id = Integer.parseInt(request.getParameter("ID"));
    if(request.getParameter("ID") != null)
    {


     %>

     <p>in der if schleiffe: <%= request.getParameter("ID")  %></p>
     <%

    }

    int urkundeid = 1;
    String formular = "quelle";

    urkundeid = QuelleDB.getFirstPublicQuelleTemp(id);




   // urkundeid = QuelleDB.getFirstPublicQuelleX(id).getId();
//int id = 1;
//urkundeid = QuelleDB.getFirstPublicQuelleX(id).getId();
//urkundeid = 1346;

//urkundeid = UrkundeDB.getFirstPublicUrkunde(1346).getId();

    %>

    <h3>urkundeid: <%= urkundeid %></h3>

    <%
    /*
    Urkunde temp = new Urkunde();
    temp= UrkundeDB.getFirstPublicUrkunde(id);
    urkundeid = temp.getId();
    */

%>
<jsp:include page="../dojump.jsp">
  <jsp:param name="form" value="gast_quelle" />
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




