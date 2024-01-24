<%@ page import="de.uni_tuebingen.ub.nppm.util.Language" isThreadSafe="false" %>
<%@ include file="../configuration.jsp"%>
<%@ include file="../functions.jsp" %>

<jsp:include page="../dofilter.jsp" />

<%
   int id = Integer.parseInt(request.getParameter("ID"));
%>

<jsp:include page="../dojump.jsp">
	<jsp:param name="form" value="gast_person" />
</jsp:include>

<jsp:include page="layout/titel.inc.jsp">
	<jsp:param name="title" value="Person" />
	<jsp:param name="ID" value="<%= id %>" />
	<jsp:param name="size" value="" />
	<jsp:param name="Formular" value="person" />
</jsp:include>

<jsp:include page="../inc.erzeugeFormular.jsp">
	<jsp:param name="ID" value="<%= id %>" />
	<jsp:param name="Formular" value="person" />
	<jsp:param name="Datenfeld" value="ID" />
	<jsp:param name="size" value="11" />
</jsp:include>



<!----------ID---------->
  <div id="id">
    <jsp:include page="../forms/id.jsp">
      <jsp:param name="ID" value="<%=id%>"/>
      <jsp:param name="title" value="gast_person"/>
    </jsp:include>
  </div>

  <!----------Prosopographisches---------->

  <!----------Has to be put inside of database/table: "datenbank_texte" -- (not present till now)---------->
  <h3 class="ut-heading ut-heading--h3"> Prosopographisches </h3>

  <table class="ut-table ut-table--striped ut-table--striped--color-primary-3">

            <thead class="ut-table__header ">

                <tr class="ut-table__row">
                    <th class="ut-table__item ut-table__header__item" scope="col">
                        <% Language.printTextfield(out, session, "person", "Person"); %>
                    </th>
                     <td class="ut-table__item ut-table__header__item" scope="col">
                        <jsp:include page="../inc.erzeugeFormular.jsp">
				<jsp:param name="ID" value="<%= id %>" />
				<jsp:param name="Formular" value="person" />
				<jsp:param name="Datenfeld" value="Standardname" />
				<jsp:param name="size" value="50" />
				<jsp:param name="Readonly" value="yes" />
			</jsp:include>

                    </td>
                </tr>

                <tr class="ut-table__row">
                    <th class="ut-table__item ut-table__header__item" scope="col">
                        <% Language.printDatafield(out, session, "person", "Varianten"); %>
                    </th>
                     <td class="ut-table__item ut-table__header__item" scope="col">
                        <jsp:include page="../inc.erzeugeFormular.jsp">
				<jsp:param name="ID" value="<%= id %>" />
				<jsp:param name="Formular" value="person" />
				<jsp:param name="Datenfeld" value="Varianten" />
				<jsp:param name="size" value="50" />
				<jsp:param name="Readonly" value="yes" />
                        </jsp:include>
                    </td>
                </tr>

                <tr class="ut-table__row">
                    <th class="ut-table__item ut-table__header__item" scope="col">
                        <% Language.printDatafield(out, session, "person", "Geschlecht"); %>
                    </th>
                     <td class="ut-table__item ut-table__header__item" scope="col">
                        <jsp:include page="../inc.erzeugeFormular.jsp">
				<jsp:param name="ID" value="<%= id %>" />
				<jsp:param name="Formular" value="person" />
				<jsp:param name="Datenfeld" value="Geschlecht" />
				<jsp:param name="Readonly" value="yes" />
			 </jsp:include>
                    </td>
                </tr>

                <tr class="ut-table__row">
                    <th class="ut-table__item ut-table__header__item" scope="col">
                        Kommentar
                    </th>
                     <td class="ut-table__item ut-table__header__item" scope="col">
                        <jsp:include page="../inc.erzeugeFormular.jsp">
				<jsp:param name="ID" value="<%= id %>" />
				<jsp:param name="Formular" value="person" />
				<jsp:param name="Datenfeld" value="Identifizierungsproblem" />
				<jsp:param name="cols" value="40" />
				<jsp:param name="rows" value="5" />
				<jsp:param name="Readonly" value="yes" />
			 </jsp:include>
                    </td>
                </tr>

                <tr class="ut-table__row">
                    <th class="ut-table__item ut-table__header__item" scope="col">
                        <% Language.printDatafield(out, session, "person", "Stand"); %>
                    </th>
                     <td class="ut-table__item ut-table__header__item" scope="col">
                        <jsp:include page="../inc.erzeugeFormular.jsp">
				<jsp:param name="ID" value="<%= id %>" />
				<jsp:param name="Formular" value="person" />
				<jsp:param name="Datenfeld" value="Stand" />
				<jsp:param name="Readonly" value="yes" />
			</jsp:include>
                    </td>
                </tr>

                <tr class="ut-table__row">
                    <th class="ut-table__item ut-table__header__item" scope="col">
                        <% Language.printTextfield(out, session, "person", "Aemter"); %>
                    </th>
                     <td class="ut-table__item ut-table__header__item" scope="col">
                        <jsp:include page="../inc.erzeugeFormular.jsp">
				<jsp:param name="ID" value="<%= id %>" />
				<jsp:param name="Formular" value="person" />
				<jsp:param name="Datenfeld" value="AmtWeihe" />
				<jsp:param name="Readonly" value="yes" />
			</jsp:include>
                    </td>
                </tr>

                <tr class="ut-table__row">
                    <th class="ut-table__item ut-table__header__item" scope="col">
                        <% Language.printDatafield(out, session, "person", "Ethnie"); %>
                    </th>
                     <td class="ut-table__item ut-table__header__item" scope="col">
                        <jsp:include page="../inc.erzeugeFormular.jsp">
				<jsp:param name="ID" value="<%= id %>" />
				<jsp:param name="Formular" value="person" />
				<jsp:param name="Datenfeld" value="Ethnie" />
				<jsp:param name="Readonly" value="yes" />
			  </jsp:include>
                    </td>
                </tr>

                <tr class="ut-table__row">
                    <th class="ut-table__item ut-table__header__item" scope="col">
                        <% Language.printTextfield(out, session, "person", "TabVerwandte"); %>
                    </th>
                     <td class="ut-table__item ut-table__header__item" scope="col">
                        <jsp:include page="../inc.modul.jsp">
                            <jsp:param name="ID" value="<%= id %>" />
                            <jsp:param name="Formular" value="person" />
                            <jsp:param name="Modul" value="Verwandte" />
                            <jsp:param name="Readonly" value="yes" />
                        </jsp:include>
                    </td>
                </tr>
            </thead>
  </table>


<!----------Einzelbelege---------->
<h3><% Language.printTextfield(out, session, "person", "TabEinzelbelege"); %></h3>
  <jsp:include page="../inc.modul.jsp">
    <jsp:param name="ID" value="<%= id %>" />
    <jsp:param name="Formular" value="person" />
    <jsp:param name="Modul" value="nachweiseRO" />
  </jsp:include>



