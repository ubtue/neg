<%
    if (feldtyp.equals("noarray.simple.multiselect") && !array) {
        // Multiselect-Feld mit multiple und [] im Namen
        out.println("<select name=\"" + datenfeld + "[]\" id=\"" + datenfeld + "\" multiple size=\"6\">");

        List<Object[]> rows2 = AbstractBase.getListNative("SELECT ID, Bezeichnung FROM " + auswahlherkunft + " ORDER BY Bezeichnung ASC");
        for (Object[] columns2 : rows2) {
            int value2_id = Integer.parseInt(String.valueOf(columns2[0]));
            String value2_Bezeichnung = Utils.safeToString(columns2[1]);
            out.println("<option value=\"" + value2_id + "\" "+ ">" + value2_Bezeichnung + "</option>");
        }
        out.println("</select>");
    }
%>
