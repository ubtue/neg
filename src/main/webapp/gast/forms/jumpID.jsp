<%@ include file="../../configuration.jsp" %>
<%@ include file="../../functions.jsp" %>

<%
    int id = -1;
    String title = request.getParameter("title");
    if (title.contains("gast_")) {
        title = title.substring(5);
    }

    try {
        id = Integer.parseInt(request.getParameter("ID"));
    } catch (NumberFormatException e) {
    }
%>

<div  style="display: flex; align-items: center; ">
    <span>Springe zu NeG-ID:</span>
    <input class="ut-form__input ut-form__field " id="id_field" type="text" name="jumpValueID" size="5">
    <input type="hidden" name="jumpTable" value="<%= title%>">
    <input type="hidden" name="akt" value="<%= id%>">
    <button class="ut-btn" type="submit" name="jumpID" value="los" aria-label="los">los</button>
</div>


