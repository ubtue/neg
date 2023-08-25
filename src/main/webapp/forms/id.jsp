<%@ include file="../configuration.jsp" %>

<%
    String id = request.getParameter("ID");
    String title = request.getParameter("title");
    if (title.contains("gast_")) {
        title = title.substring(5);
    }

    out.println("ID: ");
    if (title.toLowerCase().equals("einzelbeleg")) {
        out.print("B");
    } else if (title.toLowerCase().equals("person")) {
        out.print("P");
    } else if (title.toLowerCase().equals("namenkommentar")) {
        out.print("N");
    } else if (title.toLowerCase().equals("quelle")) {
        out.print("Q");
    } else if (title.toLowerCase().equals("edition")) {
        out.print("E");
    } else if (title.toLowerCase().equals("handschrift")) {
        out.print("T");
    } else if (title.toLowerCase().equals("mghlemma")) {
        out.print("M");
    }

    out.println(id);
%>
