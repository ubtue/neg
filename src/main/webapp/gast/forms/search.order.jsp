<%@ page import="de.uni_tuebingen.ub.nppm.db.*" isThreadSafe="false" %>

<%@ include file="../../configuration.jsp" %>
<%@ include file="../../functions.jsp" %>

<%
    List<String> rowlist = AbstractBase.getStringListNative("SELECT Textfeld FROM datenbank_texte WHERE Formular='freie_suche' AND Textfeld LIKE \"Order%\" ORDER BY Textfeld");

    String radio = request.getParameter("name") + "ASCDESC";
    String zeitraum = request.getParameter("name") + "zeit";

    out.println("<div style=\"display: flex; align-items: center;\">");
   out.println("<select class=\"ut-form__select ut-form__field\"  id=\"id_field\" style=\"width: 220px;\" name=\"" + request.getParameter("name") + "\">");
    out.println("<option value=\"-1\">--</option>");
    for (String textfeldValue : rowlist) {
%>
<option value="<%=textfeldValue%>">
   <jsp:include page="../../inc.erzeugeBeschriftung.jsp">
        <jsp:param name="Formular" value="freie_suche"/>
        <jsp:param name="Textfeld" value="<%=textfeldValue%>"/>
    </jsp:include>
</option>
<%
    }
    out.println("</select>");
%>
<div style="margin-left: 10px;"></div>

<div class="ut-form__radio  ">
    <label class="" for="radiobox1">
        <input class="" id="radiobox1" type="radio" name="<%= radio%>" value="ASC" checked/>
        <jsp:include page="../../inc.erzeugeBeschriftung.jsp">
            <jsp:param name="Formular" value="freie_suche"/>
            <jsp:param name="Textfeld" value="SortierungASC"/>
        </jsp:include>
    </label>
</div>
&nbsp;
<div class="ut-form__radio  ">
    <label class="" for="radiobox2">
        <input class="" id="radiobox2" type="radio" name="<%= radio%>" value="DESC" />
        <jsp:include page="../../inc.erzeugeBeschriftung.jsp">
            <jsp:param name="Formular" value="freie_suche"/>
            <jsp:param name="Textfeld" value="SortierungDESC"/>
        </jsp:include>
    </label>
</div>

</div>
 <div style="margin-top: 5px; display: flex; align-items: center;">
     <p style="margin-right: 5px;"><% Language.printTextfield(out, session, "gast_freie_suche", "ZeitraumDatierung"); %></p>
     <input class="ut-form__input ut-form__field " id="id_field" type="text" name="<%= zeitraum %>" style="width: 220px;" />
</div>


