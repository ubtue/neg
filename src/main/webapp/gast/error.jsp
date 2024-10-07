<div>
    Eingabe inkorrekt!
    <br><br>

    <%
        String errorMessage = request.getParameter("errorMessage");

        if (errorMessage != null && errorMessage.equals("wrongIDPrefix")) {
            out.println("ID muss mit B, P, M, N oder Q beginnen und mit einer Nummer enden");
            out.println("<br>");
            out.println("bzw. b, p, m, n oder q");
            out.println("<br>");
            out.println("z.b E125");
            out.println("<br><br>");

            errorMessage = "Wrong ID Prefix";
        }

        if (errorMessage != null) {
            out.println("Genaue Fehler Meldung: " + errorMessage);
            out.println("<br><br>");
        }        
    %>
    
    <a href="javascript:history.back();">Zur&uuml;ck zur vorherigen Seite</a>
</div>
