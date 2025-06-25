<%
    if (feldtyp.equals("array.simple.multiselect") && !array) {
        out.println("<div id=\"" + datenfeld + "-wrapper\" class=\"select-wrapper\">");

        // Erster Select-Feldblock
        out.println("<div class=\"select-block\">");
        out.println("<select name=\"" + datenfeld + "[]\">");

        List<Object[]> rows2 = AbstractBase.getListNative("SELECT ID, Bezeichnung FROM " + auswahlherkunft + " ORDER BY Bezeichnung ASC");
        for (Object[] columns2 : rows2) {
            int value2_id = Integer.parseInt(String.valueOf(columns2[0]));
            String value2_Bezeichnung = Utils.safeToString(columns2[1]);
            out.println("<option value=\"" + value2_id + "\">" + value2_Bezeichnung + "</option>");
        }

        out.println("</select>");
        out.println("<button type=\"button\" class=\"add-select\">+</button>");
        out.println("<button type=\"button\" class=\"remove-select\">–</button>");
        out.println("</div>"); // .select-block

        out.println("</div>"); // .select-wrapper
        out.println("<script src=\"assets/js/multiselect-dynamic.js\"></script>");
    }
%>
