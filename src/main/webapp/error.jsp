<div>
    <jsp:include page="layout/titel.error.jsp" />
    <div id="form">
        Eingabe inkorrekt!
        <br><br>

        <%
            String errorSource = request.getParameter("errorSource");
            String errorMessage = request.getParameter("errorMessage");

            if (errorSource != null) {
                out.println(errorSource);
                out.println("<br>");
                out.println("<br>");
            }

            if (errorMessage != null) {
                out.println("Genaue Fehler Meldung: " + errorMessage);
                out.println("<br><br>");
            }

            if (errorMessage != null && errorMessage.equals("wrongIDPrefix")) {
                out.println("ID muss mit B, P, M, N, Q, T, oder E beginnen und mit einer Nummer enden");
                out.println("<br>");
                out.println("bzw. b, p, m, n, q, t oder e");
                out.println("<br>");
                out.println("z.b E125");
            }

        %>

        <br><br>
        <a href="javascript:history.back();">Zur&uuml;ck zur vorherigen Seite</a>

    </div>
</div>
